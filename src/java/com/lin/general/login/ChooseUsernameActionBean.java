/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.login;

import com.lin.dao.UserDAO;
import com.lin.entities.User;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.FlashScope;

/**
 *
 * @author Shamus
 */



/**
 * A very simple calculator action.
 * @author Tim Fennell
 */
public class ChooseUsernameActionBean extends BaseActionBean {
    private String username;
    private String newpassword;
    private String newpasswordconfirm;
    private String success;
    private String userId;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getNewpassword() {
        return newpassword;
    }

    public void setNewpassword(String newpassword) {
        this.newpassword = newpassword;
    }

    public String getNewpasswordconfirm() {
        return newpasswordconfirm;
    }

    public void setNewpasswordconfirm(String newpasswordconfirm) {
        this.newpasswordconfirm = newpasswordconfirm;
    }

    public String getSuccess() {
        return success;
    }

    public void setSuccess(String success) {
        this.success = success;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    
    
    @DefaultHandler
    public Resolution chooseUsername() {
        FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true); 
        UserDAO uDAO = new UserDAO();
        Boolean userExists;
        Boolean passwordMatch;
        Boolean canChoose;
        String errMsg;
        String successMsg;
        
        passwordMatch = (newpassword == null ? newpasswordconfirm == null : newpassword.equals(newpasswordconfirm));
        userExists = uDAO.doesUsernameExistsExcludingCurrentUsername(username,getContext().getUser().getUserName());
        canChoose = uDAO.canChoose(Integer.parseInt(userId));
        if(!canChoose){
            //return err message
            fs.put("FAILURE","this message is not used");
            fs.put("MESSAGES","You don't have permission Unlock your account.");
            return new RedirectResolution("/chooseusername.jsp");
        }else if(!passwordMatch){
            //return err message
            fs.put("FAILURE","this message is not used.");
            fs.put("MESSAGES","Passwords do not match");
            return new RedirectResolution("/chooseusername.jsp");
        }
        else if(userExists){
            //return err message
            fs.put("FAILURE","this message is not used.");
            fs.put("MESSAGES","Username already Exists");
            return new RedirectResolution("/chooseusername.jsp");
        }
        else{
           //Need to handle null for block,level,unitnumber
           User u = uDAO.chooseUsername(Integer.parseInt(userId),username,newpassword);
           getContext().setUser(u);
           if(u!=null){
               fs.put("SUCCESS","Username successfully changed.");
               return new RedirectResolution("/residents/index.jsp");
           }else{
               fs.put("FAILURE","this message is not used");
               fs.put("MESSAGES","Failed to change username.");
               return new RedirectResolution("/chooseusername.jsp");
           }
        }
    }
    
}