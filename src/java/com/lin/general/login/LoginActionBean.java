package com.lin.general.login;

import com.lin.dao.LoginDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.User;
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
        UserDAO userDAO = new UserDAO();

        //retrieve hash from DB
        storedHash = userDAO.getUserHash(username);
        //check if hash is same as user input        
        if(plaintext !=null && !storedHash.isEmpty()){
           success = BCrypt.checkpw(plaintext,storedHash);
        }
        else{
           success = false;
        }



        if(success){
            User user = userDAO.getUser(username);
            getContext().setUser(user);
            
            User u2 = getContext().getUser();
            System.out.println("ADDED TO SESSION:" +u2.toString());
            return new RedirectResolution("/admin/manageusers.jsp");
        }else{
            return new RedirectResolution("/login.jsp?err=true&user="+username);
        }
    }
}