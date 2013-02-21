package com.lin.entities;
// Generated Feb 22, 2013 4:39:59 AM by Hibernate Tools 3.2.1.GA


import java.util.Date;

/**
 * EventComment generated by hbm2java
 */
public class EventComment  implements java.io.Serializable {


     private Integer commentId;
     private Event event;
     private User user;
     private String text;
     private Date commentDate;
     private boolean isDeleted;

    public EventComment() {
    }

	
    public EventComment(Event event, User user, Date commentDate, boolean isDeleted) {
        this.event = event;
        this.user = user;
        this.commentDate = commentDate;
        this.isDeleted = isDeleted;
    }
    public EventComment(Event event, User user, String text, Date commentDate, boolean isDeleted) {
       this.event = event;
       this.user = user;
       this.text = text;
       this.commentDate = commentDate;
       this.isDeleted = isDeleted;
    }
   
    public Integer getCommentId() {
        return this.commentId;
    }
    
    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
    }
    public Event getEvent() {
        return this.event;
    }
    
    public void setEvent(Event event) {
        this.event = event;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public String getText() {
        return this.text;
    }
    
    public void setText(String text) {
        this.text = text;
    }
    public Date getCommentDate() {
        return this.commentDate;
    }
    
    public void setCommentDate(Date commentDate) {
        this.commentDate = commentDate;
    }
    public boolean isIsDeleted() {
        return this.isDeleted;
    }
    
    public void setIsDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }




}


