/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.general.admin.*;
import com.lin.dao.ResourceDAO;
import com.lin.dao.SubmittedFormDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.*;
import com.lin.utils.BCrypt;
import java.io.File;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.util.Log;
import javax.persistence.*;
import net.sourceforge.stripes.action.*;
import org.apache.commons.lang3.StringEscapeUtils;

public class ChangePasswordActionBean implements ActionBean {

    private ActionBeanContext context;
    private Log log = Log.getInstance(ChangePasswordActionBean.class);//in attempt to log what went wrong..
    private String user_id;
    private String oldpassword;
    private String newpassword;
    private String newpassword2;

    @DefaultHandler
    public Resolution changepassword() {
        UserDAO uDAO = new UserDAO();
        User user = uDAO.getUser(Integer.parseInt(user_id));
        boolean success = false;
        String storedHash = "";
        
        if(user==null){
            return new RedirectResolution("/residents/index.jsp?success=" + success);
        }else{ 
            //retrieve hash from DB
            //storedHash = userDAO.getUserHash(username);
            storedHash = user.getPassword();
            //check if hash is same as user input        
            if(oldpassword !=null && !storedHash.isEmpty()){
               success = BCrypt.checkpw(oldpassword,storedHash);
            }
            else{
               success = false;
            }
        }  
        
        if(success){
            try {
                success = uDAO.changePasword(Integer.parseInt(user_id), newpassword2);
            } catch (Exception e) {
                success = false;
                return new RedirectResolution("/residents/index.jsp?success=" + success);
            }
        }
        return new RedirectResolution("/residents/index.jsp?success=" + success);

    }
    
    @HandlesEvent("admin_change_password")
    public Resolution changeAdminpassword() {
        UserDAO uDAO = new UserDAO();
        User user = uDAO.getUser(Integer.parseInt(user_id));
        boolean success = false;
        String storedHash = "";
        
        if(user==null){
            return new RedirectResolution("/residents/index.jsp?success=" + success);
        }else{ 
            //retrieve hash from DB
            //storedHash = userDAO.getUserHash(username);
            storedHash = user.getPassword();
            //check if hash is same as user input        
            if(oldpassword !=null && !storedHash.isEmpty()){
               success = BCrypt.checkpw(oldpassword,storedHash);
            }
            else{
               success = false;
            }
        }  
        
        if(success){
            try {
                success = uDAO.changePasword(Integer.parseInt(user_id), newpassword2);
            } catch (Exception e) {
                success = false;
                return new RedirectResolution("/admin/adminmain.jsp?success=" + success);
            }
        }
        return new RedirectResolution("/admin/adminmain.jsp?success=" + success);

    }
    
    

    public String getNewpassword() {
        return newpassword;
    }

    public void setNewpassword(String newpassword) {
        this.newpassword = newpassword;
    }

    public String getNewpassword2() {
        return newpassword2;
    }

    public void setNewpassword2(String newpassword2) {
        this.newpassword2 = newpassword2;
    }

    public String getOldpassword() {
        return oldpassword;
    }

    public void setOldpassword(String oldpassword) {
        this.oldpassword = oldpassword;
    }

    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }
    
}