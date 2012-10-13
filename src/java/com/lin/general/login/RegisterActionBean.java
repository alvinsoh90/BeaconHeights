/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.login;

/**
 *
 * @author Shamus
 */

import com.lin.entities.LoginDAO;
import com.lin.entities.UserDAO;
import com.lin.utils.BCrypt;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;

/**
 * A very simple calculator action.
 * @author Tim Fennell
 */
public class RegisterActionBean extends BaseActionBean {
    private String password;
    private String username;
    private String passwordconfirm;
    private String firstname;
    private String lastname;
    private String block;
    private String level;
    private String unitnumber;

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

    
    @DefaultHandler
    public Resolution registerTempUserAccount() {
        UserDAO uDAO = new UserDAO();
        Boolean userExists;
        Boolean passwordMatch;
        String errMsg;
        String successMsg;
        
        passwordMatch = (password == null ? passwordconfirm == null : password.equals(passwordconfirm));
        userExists = UserDAO.doesUserExist(username);
        if(!passwordMatch){
            //return err message
            errMsg = "Passwords do not match";
            return new RedirectResolution("/register.jsp?success=false&msg="+errMsg);
        }else if(userExists){
            //return err message
            errMsg = "Username already Exists";
            return new RedirectResolution("/register.jsp?success=false&msg="+errMsg);
        }else{
           //Need to handle null for block,level,unitnumber
           UserDAO.addTempUser(username,password,firstname,lastname,block,level,unitnumber);
           successMsg = "Your account has been added!";
           return new RedirectResolution("/register.jsp?success=true&msg="+successMsg);
        }
    }
}