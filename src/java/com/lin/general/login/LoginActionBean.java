package com.lin.general.login;

import com.lin.dao.UserDAO;
import com.lin.entities.User;
import com.lin.utils.BCrypt;
import java.io.IOException;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.FlashScope;

/**
 * A very simple calculator action.
 * @author Tim Fennell
 */
public class LoginActionBean extends BaseActionBean {
    private String plaintext;
    private String username;
    private User currentUser;

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
    
    public String getCurrentUser(){
        String username= getContext().getUser().getFirstname();
        return username;
    }
    
    public User getCurrentUserObject(){
        return currentUser;
    }
    
    public void setCurrentUser(User currentUser){
        this.currentUser = currentUser;
    }
        
    @DefaultHandler
    public Resolution login() {
        FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true); 
        boolean success = false;
        String storedHash = "";
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUser(username);
        
        if(user==null){
            fs.put("FAILURE","This value is not used");
            fs.put("MESSAGES","Username or password is entered incorectly.");
            System.out.println("FAIL ONE");
            return new RedirectResolution("/login.jsp");
        }else{ 
            //retrieve hash from DB
            //storedHash = userDAO.getUserHash(username);
            storedHash = user.getPassword();
            //check if hash is same as user input        
            if(plaintext !=null && !storedHash.isEmpty()){
               success = BCrypt.checkpw(plaintext,storedHash);
            }
            else{
               success = false;
            }
        }  
        
        if(success){
            System.out.println(username);
            getContext().setUser(user);
            currentUser= getContext().getUser();
            System.out.println("ADDED TO SESSION:" +currentUser.toString());
            if(user.getRole().isAdmin()){
                return new RedirectResolution("/admin/adminmain.jsp");
            }else{
                return new RedirectResolution("/residents/index.jsp");
            }
            
        }else{
            fs.put("FAILURE","This value is not used");
            fs.put("MESSAGES","Username or password is entered incorectly.");
            System.out.println("FAIL TWO");
            return new RedirectResolution("/login.jsp");
        }
        
    }
    
 
}