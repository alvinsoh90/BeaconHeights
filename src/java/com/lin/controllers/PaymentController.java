/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.controllers;

import com.lin.payment.OpenTrxResponse;
import com.lin.payment.VerifyTrxResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author fayannefoo
 */
@WebServlet(name = "PaymentController", urlPatterns = {"/PaymentController"})
public class PaymentController extends HttpServlet {

    private static final long serialVersionUID = 3570259871387669173L;
    private static final Logger logger = Logger.getLogger(PaymentController.class.getName());
    private static final String THANK_YOU_PAGE = "/index.jsp/success=true"; //need to add transaction ID!
    private static final String FAILED_PAGE = "/index.jsp/success=false";
    //Unique ID as registered on the ZooZ developer portal
    private String bundleId = "com.livingnet";
    //The app key for this registered app
    private String appKey = "cbc76f1b-1be8-4389-8840-244c15b21db3";
    private String zoozServer;
    private boolean isSandbox = true;

    @Override
    public void init(ServletConfig servletConfig) throws ServletException {
        super.init(servletConfig);
        logger.fine("SampleServlet-init");

        if (isSandbox) {
            zoozServer = "https://sandbox.zooz.co";
        } else {
            zoozServer = "https://app.zooz.com";
        }

    }

   
	private void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String cmd = request.getParameter("cmd");

		try {

			if (cmd.equals("openTrx")){
				response.setContentType("text/json");
				
				// parameters from the client
				String currencyCode = "USD";
				String amount = "0.99";

				// prepare transaction data
				StringBuilder trxData = new StringBuilder();

				// mandatory parameters
				trxData.append("&cmd=openTrx");
				trxData.append("&amount=").append(amount);
				trxData.append("&currencyCode=").append(currencyCode);
				
				// additional parameters for example
				trxData.append("&invoice.number=12358FF");
				trxData.append("&invoice.items(0).name=Mushroom");
				trxData.append("&invoice.items(0).price=0.35");
				trxData.append("&invoice.items(0).quantity=2");
				trxData.append("&invoice.items(0).id=asd-34s2");
				trxData.append("&invoice.additionalDetails=Hello world");
				trxData.append("&user.firstName=John");
				trxData.append("&user.lastName=Doe");
				trxData.append("&user.phone.countryCode=1");
				trxData.append("&user.phone.phoneNumber=7188785775");
				trxData.append("&user.email=test@zooz.com");
				
				
				// 1. send transaction data to ZooZ secured server
				String responseStr = postToServer(trxData.toString());
				
				OpenTrxResponse openTrxResponse = OpenTrxResponse.create(responseStr);
				
				if (openTrxResponse.getStatusCode() == 0){

					String sessionToken = openTrxResponse.getSessionToken();
					
					// Add token to the client response for transaction initialization
					String responseToClient = "var data = {'token' : '" + sessionToken + "'}";

					// 2. send response back to page
					response.getWriter().print(responseToClient);
				}
				else if (openTrxResponse.getStatusCode() != 0 && openTrxResponse.getErrorMessage() != null){
					response.getWriter().println("Error to open transaction to ZooZ server. " + openTrxResponse.getErrorMessage());
				}			
			
			} else if (cmd.equals("verifyTrx")){

				String transactionID = request.getParameter("transactionID");
				
				String transactionDisplayID = request.getParameter("transactionDisplayID");

				// Verify transaction with the payment ID specified
				if (transactionID != null){
					String requestStr = "&cmd=verifyTrx&trxId=" + transactionID;
					String responseStr = postToServer(requestStr);

					VerifyTrxResponse verifyTrxResponse = VerifyTrxResponse.create(responseStr);

					if (verifyTrxResponse.getStatusCode() == 0){
						//You can use the value of sessionToken to check if it equals the sessionToken you recieved in openTrx
						String sessionToken = request.getParameter("sessionToken");
						
						logger.log(Level.INFO, "Payment " + transactionID + " was confirmed. Display ID: " + transactionDisplayID);
						getServletContext().getRequestDispatcher(THANK_YOU_PAGE).forward(request, response);
						return;
					}
					else {
						logger.log(Level.WARNING, "Error to confirm payment. " + verifyTrxResponse.getErrorMessage());
						getServletContext().getRequestDispatcher(FAILED_PAGE).forward(request, response);
					}
				}
				
			}
		} catch (Exception ex) {
			logger.log(Level.SEVERE, "General error when processing request.", ex);
			response.getWriter().println("Error " + ex.getMessage());
		}
	}

	/**
	 * Post the request to the ZooZ server.
	 * @param data input data for the request.
	 * @return response from server.
	 * @throws IOException if failed to send request or read the response.
	 */
	private String postToServer(String data) throws IOException {

		Writer writer = null;
		BufferedReader reader = null;
		StringBuilder resultSB = new StringBuilder();
		HttpURLConnection conn;
		try {
			conn = (HttpURLConnection) new URL(zoozServer + "/mobile/SecuredWebServlet")
			.openConnection();
			conn.setDoOutput(true);

			// set bundleId and appKey for authentication to ZooZ secured server
			conn.setRequestProperty("ZooZUniqueID", bundleId);
			conn.setRequestProperty("ZooZAppKey", appKey);
			conn.setRequestProperty("ZooZResponseType", "NVP");

			// Send data
			writer = new OutputStreamWriter(conn.getOutputStream());
			writer.write(data);
			writer.flush();

			// Get the response
			reader = new BufferedReader(new InputStreamReader(
					conn.getInputStream()));
			String line;
			while ((line = reader.readLine()) != null) {
				resultSB.append(line);
			}

		} catch (IOException ex) {
			logger.log(Level.WARNING, "Error to read/write from zooz server."
					+ ex.getMessage(), ex);
			throw ex;
		} finally {
			try {
				if (writer != null)
					writer.close();
				if (reader != null)
					reader.close();
			} catch (IOException ex) {
				logger.log(Level.WARNING, "Error to close reader/writer.", ex);
			}
		}

		return resultSB.toString();
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
}
