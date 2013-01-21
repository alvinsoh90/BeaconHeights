/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.FacilityDAO;
import com.lin.dao.FacilityTypeDAO;
import com.lin.dao.ResourceDAO;
import com.lin.dao.SubmittedFormDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.*;

import java.util.Date;
import java.util.ArrayList;
import java.util.HashMap;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.util.Log;
import javax.persistence.*;
import org.apache.commons.lang3.StringEscapeUtils;

public class EditSubmittedFormsBean implements ActionBean {

    private ActionBeanContext context;
    private Log log = Log.getInstance(EditSubmittedFormsBean.class);//in attempt to log what went wrong..
    private String id;
    private String user;
    private String timeSubmitted;
    private String fileName;
    private String processed;
    private String comments;
    private boolean success = false;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getTimeSubmitted() {
        return timeSubmitted;
    }

    public void setTimeSubmitted(String timeSubmitted) {
        this.timeSubmitted = timeSubmitted;
    }

    public String getProcessed() {
        return processed;
    }

    public void setProcessed(String processed) {
        this.processed = processed;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }
 
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    
    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    @DefaultHandler
    public Resolution editResource(){
        SubmittedFormDAO sfDAO = new SubmittedFormDAO();
        
        UserDAO uDAO = new UserDAO();
        
        User u = uDAO.getUser(user);
        
        boolean bProcessed = false;
        
        if(processed.equals("true")){
            bProcessed = true;
        }
        
        try{
            sfDAO.updateSubmittedForm
                    (
                        Integer.parseInt(id),
                        u,
                        fileName,
                        bProcessed
                    );
            return new RedirectResolution("/admin/manage-onlineform.jsp?editsuccess=true"+"&editmsg="+user + "'s " + fileName);
        }
        catch(Exception e){
            e.printStackTrace(); 
        }
        return new RedirectResolution("/admin/manage-onlineform.jsp?editsuccess=false"+"&editmsg="+user + "'s " + fileName);
        
    }
}