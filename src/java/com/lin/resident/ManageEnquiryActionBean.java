/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.resident;

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
import net.sourceforge.stripes.controller.FlashScope;
import org.apache.commons.lang3.StringEscapeUtils;

/**
 *
 * @author jonathanseetoh
 */
public class ManageEnquiryActionBean implements ActionBean{
    
     private ActionBeanContext context;
     private ArrayList<Enquiry> enquiryList;
     private ArrayList<Enquiry> userEnquiryList;
     private int id;
     private User user;
     private String userId;
     private Date enquiryTimeStamp;
     private String title;
     private String text;
     private boolean isResolved;
     private Enquiry enquiry;
     private ArrayList<Enquiry> responseList;
     private String replyid;
     private boolean status;

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
    
    public Enquiry getEnquiry(int id){
        EnquiryDAO enDAO = new EnquiryDAO();
        enquiry = enDAO.getEnquiry(id);
        return enquiry;
    }
    
    public void setEnquiry(Enquiry enquiry){
        enquiry = enquiry;
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
        userEnquiryList = enDAO.getUserEnquiries(user.getUserId());
        return userEnquiryList;
    }
    
    public void setEnquiryList(ArrayList<Enquiry> enquiryList) {
        this.enquiryList = enquiryList;
    }

    public ArrayList<Enquiry> getResponseList(int enquiryId) {
        EnquiryDAO enDAO = new EnquiryDAO();
        responseList = enDAO.getResponses(enquiryId);
        return responseList;
    }

    public void setResponseList(ArrayList<Enquiry> responseList) {
        this.responseList = responseList;
    }

    public String getReplyid() {
        return replyid;
    }

    public void setReplyid(String replyid) {
        this.replyid = replyid;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
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
    public Resolution submit() {
        FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true); 
        String result;
        boolean success;
        
        
        isResolved = false;
        
        try {
         
            UserDAO uDAO = new UserDAO();
            User enquiryUser = uDAO.getUser(Integer.parseInt(userId));
            
            EnquiryDAO enDAO = new EnquiryDAO();
            if (text.isEmpty()){
                throw new Exception("empty");
                
            }
            Enquiry enquiry = enDAO.createEnquiry(enquiryUser, title, text);
            result = "Enquiry";
            success = true;
        } catch (Exception e) {
            result = "fail";
            success = false;
        }
        fs.put("SUCCESS","Enquiry successfully uploaded.");
        return new RedirectResolution("/residents/myenquiries.jsp");



    }
    
    public Resolution update() {
        FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true); 
        String result;
        boolean success;
        
        
        isResolved = false;
        
        try {
         
            UserDAO uDAO = new UserDAO();
            User enquiryUser = uDAO.getUser(Integer.parseInt(userId));
            
            EnquiryDAO enDAO = new EnquiryDAO();
            if (text.isEmpty()){
                throw new Exception("empty");
                
            }
            
            int replyId = Integer.parseInt(replyid);
            
            Enquiry enquiry = enDAO.createEnquiry(enquiryUser, title, text, replyId);
            enDAO.updateEnquiry(replyId, status);
            result = "Enquiry";
            success = true;
        } catch (Exception e) {
            result = "fail";
            success = false;
        }
        fs.put("SUCCESS","Enquiry successfully uploaded.");
        return new RedirectResolution("/residents/enquiry.jsp?enquiry="+replyid);



    }
    
    public Resolution adminUpdate() {
        FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true); 
        String result;
        boolean success;
        
        
        isResolved = false;
        
        try {
         
            UserDAO uDAO = new UserDAO();
            User enquiryUser = uDAO.getUser(Integer.parseInt(userId));
            
            EnquiryDAO enDAO = new EnquiryDAO();
            if (text.isEmpty()){
                throw new Exception("empty");
                
            }
            
            int replyId = Integer.parseInt(replyid);
            
            Enquiry enquiry = enDAO.createEnquiry(enquiryUser, title, text, replyId);
            if (status){
                enDAO.updateEnquiry(replyId, status);
            }
            result = "Enquiry";
            success = true;
        } catch (Exception e) {
            result = "fail";
            success = false;
        }
        fs.put("SUCCESS","Enquiry successfully uploaded.");
        return new RedirectResolution("/admin/adminenquiry.jsp?enquiry="+replyid);



    }
    
    public long getNumberOfUnresolvedEnquiries(){
        EnquiryDAO enDAO = new EnquiryDAO();
        return enDAO.getNumberOfUnresolvedEnquiries();
    }

    
}
