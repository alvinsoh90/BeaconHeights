/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.UserDAO;
import com.lin.dao.EnquiryDAO;
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

/**
 *
 * @author jonathanseetoh
 */
public class ManageEnquiryActionBean implements ActionBean{
    
     private ActionBeanContext context;
     private ArrayList<Enquiry> enquiryList;
     private int id;
     private User user;
     private String user_id;
     private Date enquiryTimeStamp;
     private String title;
     private String text;
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
    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
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
     
    public void setContext(ActionBeanContext context) {
        this.context = context;
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
    public ActionBeanContext getContext() {
        throw new UnsupportedOperationException("Not supported yet.");
    }
    
    @DefaultHandler
    public Resolution submit() {
        String result;
        boolean success;
        
        
        isResolved = false;
        
        try {
         
            UserDAO uDAO = new UserDAO();
            User user = uDAO.getUser(Integer.parseInt(user_id));
            
            EnquiryDAO enDAO = new EnquiryDAO();
            Enquiry en = enDAO.createEnquiry(user, isResolved, title, text);
            result = "enquiry";
            success = true;
        } catch (Exception e) {
            result = "fail";
            success = false;
        }
        return new RedirectResolution("/residents/myenquiries.jsp?createsuccess=" + success
                + "&createmsg=" + result);



    }

    
    
}
