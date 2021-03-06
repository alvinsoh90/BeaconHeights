/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.login;

import com.lin.dao.UserDAO;
import com.lin.entities.User;
import com.lin.entities.UserTemp;
import java.util.ArrayList;
import com.lin.controllers.*;
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
        boolean exists = false;
        User user = null;



        userVerification = uDAO.resetPwVerification(username, email);
        if(username==null && email==null){
            errMsg = "You forgot to enter something.";
            return new RedirectResolution("/forgotpassword.jsp?success=false&msg=" + errMsg);
        } else {
            if(username!=null){
                exists = uDAO.doesUserExist(username);
                if(exists){
                    user = uDAO.getUser(username);
                }
            }else{
                exists = uDAO.doesUserEmailExist(email);
                if(exists){
                    user = uDAO.getUserByEmail(email);
                }
            }
            
            if(exists){
                String newPassword = PasswordGeneration.generateRandomPassword();
                //System.out.println("NEW PASSWORD : "+ newPassword);
                uDAO.changePasword(user.getUserId(), newPassword);

                //sending email part
    //            MailController mc = new MailController();
    //            String emailText = "This is your new password:" + newPassword;
    //            mc.sendEmail(email, emailText);



                //sending email part 2

                String host = "mail.beaconheights.com.sg";
                String from = "helpdesk@beaconheights.com.sg";
                String to = user.getEmail();
                String userFirstName = user.getFirstname();
                String userUserName = user.getUserName();
                String newLine = System.getProperty("line.separator");

                // Set properties
                Properties props = new Properties();
                props.setProperty("mail.transport.protocol", "smtp");
                props.setProperty("mail.smtp.auth", "true");
                props.put("mail.smtp.host", host);
                props.put("mail.debug", "true");
                props.setProperty("mail.user", "helpdesk@beaconheights.com.sg");
                props.setProperty("mail.password", "Charisfyp!");

                // Get session
                //Session session = Session.getInstance(props);

                Session session = Session.getDefaultInstance(props, new Authenticator(){
                    public PasswordAuthentication getPasswordAuthentication() {
                        String username = "helpdesk@beaconheights.com.sg";
                        String password = "Charisfyp!";
                        return new PasswordAuthentication(username, password);
                    }
                });

                try {
                    // Instantiate a message
                    Message msg = new MimeMessage(session);

                    // Set the FROM message
                    msg.setFrom(new InternetAddress(from));

                    // The recipients can be more than one so we use an array but you can
                    // use 'new InternetAddress(to)' for only one address.
                    InternetAddress[] address = {new InternetAddress(to)};
                    msg.setRecipients(Message.RecipientType.TO, address);

                    // Set the message subject and date we sent it.
                    msg.setSubject("[Beacon Heights] LIN Password Reset");
                    msg.setSentDate(new Date());

                    // Set message content
                    msg.setText("Dear " + userFirstName + "," + newLine + newLine + "Your username is: " + userUserName + newLine  + "Your new password is: " + newPassword + newLine + newLine + "Please login to http://livingnet.beaconheights.com.sg with your new password and remember to change your password after logging in." + newLine + newLine + "Thanks,"+newLine+"The Beacon Heights Helpdesk Team");

                    // Send the message
                    Transport.send(msg);
                } catch (MessagingException mex) {
                }
            }else{
                errMsg = "No such User.";
                return new RedirectResolution("/forgotpassword.jsp?success=false&msg=" + errMsg);
            }


            successMsg = "Your password has been successfully reset! Please check your email for your new password.";
            return new RedirectResolution("/login.jsp?success=true&msg=" + successMsg);
        }
    }
}
