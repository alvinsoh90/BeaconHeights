/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.UserDAO;
import com.lin.dao.EnquiryDAO;
import com.lin.entities.*;

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

/**
 *
 * @author jonathanseetoh
 */
public class EditEnquiryAdminActionBean implements ActionBean{
    
     private ActionBeanContext context;
     private ArrayList<Enquiry> enquiryList;
     private ArrayList<Enquiry> userEnquiryList;
     private int id;
     private User user;
     private String userId;
     private Date enquiryTimeStamp;
     private String title;
     private String text;
     private User responder;
     private String responderId;
     private String response;

    public User getResponder() {
        return responder;
    }

    public void setResponder(User responder) {
        this.responder = responder;
    }

    public String getResponderId() {
        return responderId;
    }

    public void setResponderId(String responderId) {
        this.responderId = responderId;
    }

    public String getResponse() {
        return response;
    }

    public void setResponse(String response) {
        this.response = response;
    }
     private boolean isResolved;

    public int getId() {
        return this.id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    
    
    public Date getEnquiryTimeStamp() {
        return this.enquiryTimeStamp;
    }
    
    public void setEnquiryTimeStamp(Date enquiryTimeStamp) {
        this.enquiryTimeStamp = enquiryTimeStamp;
    }
    public String getTitle() {
        return this.title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    public String getText() {
        return this.text;
    }
    
    public void setText(String text) {
        this.text = text;
    }
    public boolean isIsResolved() {
        return this.isResolved;
    }
    
    public void setIsResolved(boolean isResolved) {
        this.isResolved = isResolved;
    }
    
    
    public ArrayList<Enquiry> getEnquiryList() {
        EnquiryDAO enDAO = new EnquiryDAO();
        enquiryList = enDAO.getAllEnquiries();
        return enquiryList;
    }
    
    public ArrayList<Enquiry> getUserEnquiryList() {
        EnquiryDAO enDAO = new EnquiryDAO();
        enquiryList = enDAO.getUserEnquiries(user.getUserId());
        return enquiryList;
    }
    
    public void setEnquiryList(ArrayList<Enquiry> enquiryList) {
        this.enquiryList = enquiryList;
    }
    
    
    @Override
    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    @Override
        public ActionBeanContext getContext() {
        return context;
    }
    
    
    @DefaultHandler
    public Resolution edit() {
        String result;
        boolean success = false;
        EnquiryDAO eDAO = new EnquiryDAO();
        UserDAO uDAO = new UserDAO();
        
            try{
                eDAO.updateEnquiry
                        (
                            id,
                            title,
                            text
                        );
                return new RedirectResolution("/admin/manage-enquiries.jsp?editsuccess=true"+"&editmsg=Your enquiry");
            }
            catch(Exception e){
                e.printStackTrace(); 
            }
        
        return new RedirectResolution("/admin/manage-enquiries.jsp?editsuccess=false"+"&editmsg=Your enquiry");
    }

    
}
