/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.controllers;

import java.io.*;
import java.util.Properties;
import java.util.Date;

import javax.mail.*;
import javax.mail.internet.*;

/**
 *
 * @author Keffeine
 */
public class MailController {

    /*-----------------------------------------------------------------------
     * Parameters
     *----------------------------------------------------------------------*/
    String serverUrl = "helpdesk@beaconheights.com.sg";
    String userName = "helpdesk@beaconheights.com.sg";
    String password = "Charisfyp!";
    /*-----------------------------------------------------------------------
     * Variables
     *----------------------------------------------------------------------*/
    static Properties fMailServerConfig = new Properties();


    public void sendEmail(String userEmail, String emailText) {
        fetchConfig();
        String fromEmail = userName;
        String toEmail = userEmail;
        String subject = "[LivingNet] Password Reset";
        String body = emailText;
        
        //Here, no Authenticator argument is used (it is null).
        //Authenticators are used to prompt the user for user
        //name and password.
        javax.mail.Session mailSession = javax.mail.Session.getDefaultInstance(fMailServerConfig, null);
        MimeMessage message = new MimeMessage(mailSession);
        try {
            //the "from" address may be set in code, or set in the
            //config file under "mail.from" ; here, the latter style is used
            message.setFrom(new InternetAddress(fromEmail));
            message.addRecipient(
                    javax.mail.Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject(subject);
            message.setText(body);
            Transport.send(message);
        } catch (MessagingException ex) {
            System.err.println("Cannot send email. " + ex);
        }
    }

    /**
     * Allows the config to be refreshed at runtime, instead of
     * requiring a restart.
     */
    public static void refreshConfig() {
        fMailServerConfig.clear();
        fetchConfig();
    }

    static {
        fetchConfig();
    }

    private static void fetchConfig() {
        InputStream input = null;
        try {
            //If possible, one should try to avoid hard-coding a path in this
            //manner; in a web application, one should place such a file in
            //WEB-INF, and access it using ServletContext.getResourceAsStream.
            //Another alternative is Class.getResourceAsStream.
            //This file contains the javax.mail config properties mentioned above.
            input = new FileInputStream("/src/conf/mailconfig.txt");
            fMailServerConfig.load(input);
        } catch (IOException ex) {
            System.err.println("Cannot open and load mail server properties file.");
        } finally {
            try {
                if (input != null) {
                    input.close();
                }
            } catch (IOException ex) {
                System.err.println("Cannot close mail server properties file.");
            }
        }
    }
}
