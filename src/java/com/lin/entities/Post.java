package com.lin.entities;
// Generated Feb 22, 2013 4:39:59 AM by Hibernate Tools 3.2.1.GA


import com.lin.utils.GeneralFunctions;
import java.text.ParseException;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
/**
 * Post generated by hbm2java
 */
public class Post  implements java.io.Serializable {

     public enum Type {
         INVITE,SHOUTOUT,REQUEST,ANNOUNCEMENT;
     } 
    
     private Integer postId;
     private Event event;
     private User user;
     private String message;
     private Date date;
     private String title;
     private String category;
     private boolean isDeleted;
     private int receivingWallId;
     private Set postInappropriates = new HashSet(0);
     private Set postLikes = new HashSet(0);
     private Set notifications = new HashSet(0);
     private Set comments = new HashSet(0);

    public Post() {
    }

	private String getCategoryStringFromType(Type type){
        if(type == type.ANNOUNCEMENT){
            return "ANNOUNCEMENT";
        }
        else if(type == type.INVITE){
            return "INVITE";
        }
        else if(type == type.REQUEST){
            return "REQUEST";
        }
        else if(type == type.SHOUTOUT){
            return "SHOUTOUT";
        }
        return null;
    }
    
    public Post(User user, boolean isDeleted) {
        this.user = user;
        this.isDeleted = isDeleted;
    }
    
    // constr for making a new post on community wall
    public Post(User user, String message, Date date, String title, Type category){
       this.user = user;
       this.message = message;
       this.date = date;
       this.title = title;
       this.category = getCategoryStringFromType(category);
       this.event = null;
       this.comments = null;
       this.isDeleted = false;
       this.receivingWallId = -1;
    }
    
    // constr for making a new post on user's profile wall
    public Post(User user, String message, Date date, String title, Type category, int receivingWallId){
       this.user = user;
       this.message = message;
       this.date = date;
       this.title = title;
       this.category = getCategoryStringFromType(category);
       this.event = null;
       this.comments = null;
       this.isDeleted = false;
       this.receivingWallId = receivingWallId;
    }
    
    public Post(Event event, User user, String message, Date date, String title, String category, boolean isDeleted, int receivingWallId, Set postInappropriates, Set postLikes, Set notifications, Set comments) {
       this.event = event;
       this.user = user;
       this.message = message;
       this.date = date;
       this.title = title;
       this.category = category;
       this.isDeleted = isDeleted;
       this.postInappropriates = postInappropriates;
       this.postLikes = postLikes;
       this.notifications = notifications;
       this.comments = comments;
       this.receivingWallId = receivingWallId;
    }

    public int getReceivingWallId() {
        return receivingWallId;
    }

    public void setReceivingWallId(int receivingWallId) {
        this.receivingWallId = receivingWallId;
    }
   
    public Integer getPostId() {
        return this.postId;
    }
    
    public void setPostId(Integer postId) {
        this.postId = postId;
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
    public String getMessage() {
        return this.message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    public Date getDate() {
        return this.date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    public String getTitle() {
        return this.title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    public String getCategory() {
        return this.category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    public boolean isIsDeleted() {
        return this.isDeleted;
    }
    
    public void setIsDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }
    public Set getPostInappropriates() {
        return this.postInappropriates;
    }
    
    public void setPostInappropriates(Set postInappropriates) {
        this.postInappropriates = postInappropriates;
    }
    public Set getPostLikes() {
        return this.postLikes;
    }
    
    public void setPostLikes(Set postLikes) {
        this.postLikes = postLikes;
    }
    public Set getNotifications() {
        return this.notifications;
    }
    
    public void setNotifications(Set notifications) {
        this.notifications = notifications;
    }
  
    @Fetch(FetchMode.JOIN)
    public Set getComments() {
        return this.comments;
    }
    @Fetch(FetchMode.JOIN)
    public void setComments(Set comments) {
        this.comments = comments;
    }

    public String getTimeSincePost(){
        try {
            return GeneralFunctions.getTimeSinceString(date);
        } catch (ParseException ex) {
            ex.printStackTrace();
        }
        return "moments ago";
    }


}


