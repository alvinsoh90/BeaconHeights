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
import net.sourceforge.stripes.controller.FlashScope;
import org.apache.commons.lang3.StringEscapeUtils;

public class ManageSubmittedFormsActionBean implements ActionBean {

    private ActionBeanContext context;
    private ArrayList<SubmittedForm> sfList;
    private Log log = Log.getInstance(ManageSubmittedFormsActionBean.class);//in attempt to log what went wrong..
    private String title;
    private String user_id;
    private String comments;
    private boolean agree;
    private FileBean file;

    public boolean isAgree() {
        return agree;
    }

    public void setAgree(boolean agree) {
        this.agree = agree;
    }
    
    public FileBean getFile() {
        return file;
    }

    public void setFile(FileBean file) {
        this.file = file;
    }
    
    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }
    
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
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
    
    public ArrayList<SubmittedForm> getUserSfList() {
        SubmittedFormDAO sfDAO = new SubmittedFormDAO();
        sfList = sfDAO.retrieveAllSubmittedFormPlusUser();
        return sfList;
    }

    public void setSfList(ArrayList<SubmittedForm> sfList) {
        this.sfList = sfList;
    }
    

    @DefaultHandler
    public Resolution submit() {
        if(file==null){
            FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true); 

            // put shit inside       
            fs.put("FAILURE","this message is not used");
            fs.put("MESSAGES","You forgot to attach a file.");

            // redirect as normal        

            return new RedirectResolution("/residents/submitonlineforms.jsp");
        }
        if(!agree){
             // get flash scope instance
            FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true); 

            // put shit inside       
            fs.put("FAILURE","You must agree to the terms and conditions.");
            fs.put("MESSAGES","You must agree to the terms and conditions.");

            // redirect as normal        

            return new RedirectResolution("/residents/submitonlineforms.jsp");
        
        }
        
        String result;
        boolean success;
        String fileName = new Date().getTime()+file.getFileName();
        String category_input;
        boolean processed = false;
        
        
        
        
        
        try {
            File location = new File("../webapps/uploads/submitted_forms/"+fileName);
            if(!location.getParentFile().exists()){
                location.getParentFile().mkdirs();
            }
            file.save(location);
            UserDAO uDAO = new UserDAO();
            User user = uDAO.getUser(Integer.parseInt(user_id));
            SubmittedFormDAO sfDAO = new SubmittedFormDAO();
            SubmittedForm sf = sfDAO.createSubmittedForm( user, fileName, processed, comments, title);
            result = file.getFileName();
            success = true;
        } catch (Exception e) {
            result = file.getFileName();
            success = false;
        }
        FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true); 

        // put shit inside       
        fs.put("SUCCESS","You must agree to the terms and conditions.");
        //fs.put("MESSAGES","You must agree to the terms and conditions.");
        
        return new RedirectResolution("/residents/submitonlineforms.jsp");



    }
}