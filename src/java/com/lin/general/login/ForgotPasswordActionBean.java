/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.login;

import com.lin.dao.UserDAO;
import com.lin.entities.User;
import com.lin.entities.UserTemp;
import java.util.ArrayList;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import java.security.SecureRandom;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

/**
 *
 * @author jonathanseetoh
 */
public class ForgotPasswordActionBean extends BaseActionBean {

    private String password;
    private String username;
    private String passwordconfirm;
    private String firstname;
    private String lastname;
    private String mobileno;
    private String email;
    private String block;
    private String level;
    private String unitnumber;
    private SecureRandom random = new SecureRandom();

    public String getBlock() {
        return block;
    }

    public void setBlock(String block) {
        this.block = block;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordconfirm() {
        return passwordconfirm;
    }

    public void setPasswordconfirm(String passwordconfirm) {
        this.passwordconfirm = passwordconfirm;
    }

    public String getUnitnumber() {
        return unitnumber;
    }

    public void setUnitnumber(String unitnumber) {
        this.unitnumber = unitnumber;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobileno() {
        return mobileno;
    }

    public void setMobileno(String mobileno) {
        this.mobileno = mobileno;
    }

    @DefaultHandler
    public Resolution forgotPassword() {
        UserDAO uDAO = new UserDAO();

        Boolean userVerification;

        String errMsg;
        String successMsg;



        userVerification = uDAO.resetPwVerification(username, email);
        if (!userVerification) {
            errMsg = "Username and email do not match";
            return new RedirectResolution("/forgotpassword.jsp?success=false&msg=" + errMsg);
        } else {


            String newPassword = PasswordGeneration.generateRandomPassword();
            int userID = uDAO.getUser(username).getUserId();
            uDAO.changePasword(userID, newPassword);


            //sending email part
            String to = email;
            String from = "helpdesk@beaconheights.com.sg";
            String host = "localhost";
           
            boolean debug = Boolean.valueOf(false).booleanValue();
            String msgText1 = "Sending password " + newPassword;
            String subject = "Sending a file";

            // create some properties and get the default Session  
            Properties props = System.getProperties();
            props.put("mail.smtp.host", host);
            props.setProperty("mail.user", "helpdesk@beaconheights.com.sg");
            props.setProperty("mail.password", "Charisfyp!");

            Session session = Session.getInstance(props, null);
            session.setDebug(debug);

            try {
                // create a message  
                MimeMessage msg = new MimeMessage(session);
                msg.setFrom(new InternetAddress(from));
                InternetAddress[] address = {new InternetAddress(to)};
                msg.setRecipients(Message.RecipientType.TO, address);
                msg.setSubject(subject);

                // create and fill the first message part  
                MimeBodyPart mbp1 = new MimeBodyPart();
                mbp1.setText(msgText1);

                // create the second message part  
                MimeBodyPart mbp2 = new MimeBodyPart();

             
                // create the Multipart and add its parts to it  
                Multipart mp = new MimeMultipart();
                mp.addBodyPart(mbp1);
                mp.addBodyPart(mbp2);

                // add the Multipart to the message  
                msg.setContent(mp);

                // set the Date: header  
                msg.setSentDate(new Date());

                // send the message  
                Transport.send(msg);

            } catch (MessagingException mex) {
                mex.printStackTrace();
                Exception ex = null;
                if ((ex = mex.getNextException()) != null) {
                    ex.printStackTrace();
                }
            } 
        

        successMsg = newPassword;
        return new RedirectResolution("/login.jsp?success=true&msg=" + successMsg);
    }
}
}
