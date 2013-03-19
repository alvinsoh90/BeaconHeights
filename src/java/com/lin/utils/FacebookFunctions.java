/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.utils;
import com.lin.utils.json.JSONObject;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
/**
 *
 * @author Yangsta
 */
/** Facebook API Methods **/
public class FacebookFunctions {
       
    private final String FACEBOOK_APP_ID = "497424670319131";
    private final String FACEBOOK_APP_SECRET = "93bf5d76cf0109e251cf5e8d3bb2a931";
    
    private final String FACEBOOK_GROUP_ID = "582475795096626";  //LivingNet @ Beacon Heights Group ID

    public String extendFacebookAccessToken(String currAccessToken) {

        String baseURL = "https://graph.facebook.com/oauth/access_token";


        try {
            String urlParameters =
                    "client_id=" + FACEBOOK_APP_ID
                    + "&client_secret=" + FACEBOOK_APP_SECRET
                    + "&grant_type=" + "fb_exchange_token"
                    + "&fb_exchange_token=" + currAccessToken;
            System.out.println("urlParamsSentFB:" + urlParameters);

            //URL url = new URL("http://requestb.in/12bpxi71");
            URL url = new URL(baseURL);
            URLConnection conn = url.openConnection();

            conn.setDoOutput(true);

            OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());

            writer.write(urlParameters);
            writer.flush();

            String line;
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String response = null;
            while ((line = reader.readLine()) != null) {
                //System.out.println(line);
                response = line;
            }


            if (conn instanceof HttpURLConnection) {
                HttpURLConnection httpConnection = (HttpURLConnection) conn;
                int code = httpConnection.getResponseCode();
                if (code == 200) {
                    return response.substring(response.indexOf("n=")+2,response.indexOf("&e"));
                }
            } else {
                System.out.println("Unable to cast urlConnection to get status code");
            }

            writer.close();
            reader.close();
        } catch (Exception ex) {
            System.out.println("[DOFBPOST] Exception caught:\n" + ex.toString());
        }

        return null;
    }
    
    public String postToFacebookGroup(String message, String link, String accessToken) {

        String baseURL = "https://graph.facebook.com/" + FACEBOOK_GROUP_ID + "/feed";


        try {
            String urlParameters =
                    "access_token=" + accessToken
                    + "&link=" + link
                    + "&message=" + "message";
            
            System.out.println("urlParamsSentFB:" + urlParameters);

            URL url = new URL(baseURL);
            URLConnection conn = url.openConnection();

            conn.setDoOutput(true);

            OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());

            writer.write(urlParameters);
            writer.flush();

            String line;
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            JSONObject response = null;
            while ((line = reader.readLine()) != null) {
                //System.out.println(line);
                response = new JSONObject(line);
            }


            if (conn instanceof HttpURLConnection) {
                HttpURLConnection httpConnection = (HttpURLConnection) conn;
                int code = httpConnection.getResponseCode();
                if (code == 200) {
                   System.out.println("Posted to facebook. FB_POST_ID: " + response.getString("id"));
                   return response.getString("id");
                }
            } else {
                System.out.println("Unable to cast urlConnection to get status code");
            }

            writer.close();
            reader.close();
        } catch (Exception ex) {
            System.out.println("[DOFBPOST] Exception caught:\n" + ex.toString());
        }

        return null;
    }
}
