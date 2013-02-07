package com.lin.entities;
// Generated Jan 20, 2013 12:52:18 PM by Hibernate Tools 3.2.1.GA


import java.util.Date;
import org.apache.commons.lang3.StringEscapeUtils;

/**
 * SubmittedForm generated by hbm2java
 */
public class SubmittedForm  implements java.io.Serializable {


     private Integer id;
     private User user;
     private Date timeSubmitted;
     private String fileName;
     private boolean processed;
     private String comments;
     private String title;

    public SubmittedForm() {
    }

	
    public SubmittedForm(User user, Date timeSubmitted, String fileName, boolean processed, String title) {
        this.user = user;
        this.timeSubmitted = timeSubmitted;
        this.fileName = fileName;
        this.processed = processed;
        this.title = title;
    }
    public SubmittedForm(User user, Date timeSubmitted, String fileName, boolean processed, String comments, String title) {
       this.user = user;
       this.timeSubmitted = timeSubmitted;
       this.fileName = fileName;
       this.processed = processed;
       this.comments = comments;
       this.title = title;
    }
    
    public SubmittedForm(User user, String fileName, boolean processed, String comments, String title) {
        this.user = user;
        this.comments = comments;
        this.fileName = fileName;
        this.processed = processed;
        this.title = title;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Date getTimeSubmitted() {
        return this.timeSubmitted;
    }
    
    public void setTimeSubmitted(Date timeSubmitted) {
        this.timeSubmitted = timeSubmitted;
    }
    public String getFileName() {
        return this.fileName;
    }
    
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    public boolean isProcessed() {
        return this.processed;
    }
    
    public void setProcessed(boolean processed) {
        this.processed = processed;
    }
    public String getComments() {
        return this.comments;
    }
    
    public void setComments(String comments) {
        this.comments = comments;
    }
    public String getTitle() {
        return this.title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }

     public String getEscapedTitle() {
        title = StringEscapeUtils.escapeEcmaScript(title);
        return this.title;
    }    

     public String getEscapedComments() {
        comments = StringEscapeUtils.escapeEcmaScript(comments);
        return this.comments;
    }   
     
     public String getEscapedFileName() {
        fileName = StringEscapeUtils.escapeEcmaScript(fileName);
        return this.fileName;
    }  


}


