/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.ResourceDAO;
import com.lin.dao.SubmittedFormDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.*;
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

public class ManageSubmittedFormsActionBean implements ActionBean {

    private ActionBeanContext context;
    private ArrayList<SubmittedForm> sfList;
    private Log log = Log.getInstance(ManageSubmittedFormsActionBean.class);//in attempt to log what went wrong..
    private String id;
    private String user;
    private String timeSubmitted;
    private String fileName;
    private String processed;
    private String comments;

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

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String isProcessed() {
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
    
    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public ArrayList<SubmittedForm> getSfList() {
        SubmittedFormDAO sfDAO = new SubmittedFormDAO();
        sfList = sfDAO.retrieveAllSubmittedForm();
        return sfList;
    }

    public void setSfList(ArrayList<SubmittedForm> sfList) {
        this.sfList = sfList;
    }
    
    public ArrayList<String> getUniqueCategories(){
        ResourceDAO rDAO = new ResourceDAO();
        ArrayList<String> result = rDAO.getUniqueCategories();
        
        return result;
    }
/*
    @DefaultHandler
    public Resolution createResource() {
        String result;
        boolean success;
        String fileName = new Date().getTime()+file.getFileName();
        String category_input;
        
        if(category_new==null){
            category_input=category;
        }else{
            category_input=category_new;
        }
        
        try {
            File location = new File("../webapps/pdf_uploads/"+fileName);
            if(!location.getParentFile().exists()){
                location.getParentFile().mkdirs();
            }
            file.save(location);
            
            ResourceDAO rDAO = new ResourceDAO();
            Resource rc = rDAO.createResource(name, description, category_input, fileName);
            result = rc.getName();
            success = true;
        } catch (Exception e) {
            result = "fail";
            success = false;
        }
        return new RedirectResolution("/admin/manage-resource.jsp?createsuccess=" + success
                + "&createmsg=" + result);



    }*/
}