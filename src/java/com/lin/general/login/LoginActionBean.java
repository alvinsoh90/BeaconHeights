package com.lin.general.login;

import com.lin.entities.LoginDAO;
import com.lin.utils.BCrypt;
import java.io.IOException;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;

/**
 * A very simple calculator action.
 * @author Tim Fennell
 */
public class LoginActionBean extends BaseActionBean {
    private String plaintext;
    private String username;
    private boolean success;
//    private String result;
//
//    public String getResult() {
//        return result;
//    }
//
//    public void setResult(String result) {
//        this.result = result;
//    }

    public String getPlaintext() {
        return plaintext;
    }

    public void setPlaintext(String plaintext) {
        this.plaintext = plaintext;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
        
    @DefaultHandler
    public Resolution login() {
        String storedHash = "";
        LoginDAO loginDAO = new LoginDAO();
        try {
            //retrieve hash from DB
            storedHash = loginDAO.getHash(username);
            //check if hash is same as user input        
            if(plaintext !=null && !storedHash.isEmpty()){
               success = BCrypt.checkpw(plaintext,storedHash);
            }
            else{
                success = false;
            }
            
        } catch (IOException ex) {
            ex.printStackTrace();
            success = false;  //if fail to retrieve, default to success = false
        }
        
        if(success){
            return new RedirectResolution("/manageusers.jsp");
        }else{
            return new RedirectResolution("/login.jsp?err=true&user="+username);
        }
    }
}