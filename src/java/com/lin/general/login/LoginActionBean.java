package com.lin.general.login;

import com.lin.entities.LoginDAO;
import com.lin.utils.BCrypt;
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
        String storedHash;
        LoginDAO loginDAO = new LoginDAO();
        storedHash = loginDAO.getHash(username);
        success = BCrypt.checkpw(plaintext,storedHash);
        if(success){
            return new RedirectResolution("/index.jsp");
        }else{
            return new RedirectResolution("/loginFailure.jsp");
        }
    }
}