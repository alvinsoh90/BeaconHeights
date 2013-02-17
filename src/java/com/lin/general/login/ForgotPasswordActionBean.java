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
        
        
        
        userVerification = uDAO.resetPwVerification(username,email);
        if (!userVerification){
            errMsg = "Username and email do not match";
            return new RedirectResolution("/forgotpassword.jsp?success=false&msg="+errMsg);
        }
        else{
           //Need to handle null for block,level,unitnumber
           String newPassword = PasswordGeneration.generateRandomPassword();
           int userID = uDAO.getUser(username).getUserId();
           uDAO.changePasword(userID, newPassword);
           successMsg = newPassword;
           return new RedirectResolution("/login.jsp?success=true&msg="+successMsg);
        }
    }
    
    
}