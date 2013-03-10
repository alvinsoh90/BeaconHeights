package com.lin.entities;
// Generated Feb 22, 2013 4:39:59 AM by Hibernate Tools 3.2.1.GA


import com.lin.utils.GeneralFunctions;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import org.apache.commons.lang3.StringEscapeUtils;

/**
 * Event generated by hbm2java
 */
public class Event  implements java.io.Serializable {


     private Integer id;
     private Date timestamp;
     private User user;
     private Booking booking;
     private String title;
     private Date startTime;
     private Date endTime;
     private String venue;
     private String details;
     private boolean isPublicEvent;
     private boolean isAdminEvent;
     private boolean isDeleted;
     private Set eventLikes = new HashSet(0);
     private Set posts = new HashSet(0);
     private Set eventInvites = new HashSet(0);
     private Set notifications = new HashSet(0);
     private Set eventInappropriates = new HashSet(0);
     private Set eventComments = new HashSet(0);
     private ArrayList<EventComment> eventCommentsList;

    public Event() {
    }

	
    public Event(User user, String title, Date startTime, Date endTime, boolean isPublicEvent, boolean isAdminEvent, boolean isDeleted) {
        this.user = user;
        this.title = title;
        this.startTime = startTime;
        this.endTime = endTime;
        this.isPublicEvent = isPublicEvent;
        this.isAdminEvent = isAdminEvent;
        this.isDeleted = isDeleted;
    }
    
    //For creating normal, resident event
    public Event(User user, String title, Date startTime, Date endTime, String venue, String details, boolean isPublicEvent) {
        this.user = user;
        this.title = title;
        this.startTime = startTime;
        this.endTime = endTime;
        this.isPublicEvent = isPublicEvent;
        this.details = details;
        this.venue = venue;
        this.isAdminEvent = false;
        this.isDeleted = false;
    }
    
    public Event(User user, Booking booking, String title, Date startTime, Date endTime, String venue, String details, boolean isPublicEvent, boolean isAdminEvent) {
        this.user = user;
        this.booking = booking;
        this.title = title;
        this.startTime = startTime;
        this.endTime = endTime;
        this.venue = venue;
        this.details = details;
        this.isPublicEvent = isPublicEvent;
        this.isAdminEvent = isAdminEvent;
        this.isDeleted = false;
    }
    public Event(User user, Booking booking, String title, Date startTime, Date endTime, String venue, String details, boolean isPublicEvent, boolean isAdminEvent, boolean isDeleted, Set eventLikes, Set posts, Set eventInvites, Set notifications, Set eventInappropriates, Set eventComments) {
       this.user = user;
       this.booking = booking;
       this.title = title;
       this.startTime = startTime;
       this.endTime = endTime;
       this.venue = venue;
       this.details = details;
       this.isPublicEvent = isPublicEvent;
       this.isAdminEvent = isAdminEvent;
       this.isDeleted = isDeleted;
       this.eventLikes = eventLikes;
       this.posts = posts;
       this.eventInvites = eventInvites;
       this.notifications = notifications;
       this.eventInappropriates = eventInappropriates;
       this.eventComments = eventComments;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public Date getTimestamp() {
        return this.timestamp;
    }
    
    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Booking getBooking() {
        return this.booking;
    }
    
    public void setBooking(Booking booking) {
        this.booking = booking;
    }
    public String getTitle() {
        return this.title;
    }
    
     public String getEscapedTitle() {
        return StringEscapeUtils.escapeEcmaScript(this.title);
    }

    public void setTitle(String title) {
        this.title = title;
    }
    public Date getStartTime() {
        return this.startTime;
    }
    
    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }
    public Date getEndTime() {
        return this.endTime;
    }
    
    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }
    public String getVenue() {
        return this.venue;
    }
    
    public void setVenue(String venue) {
        this.venue = venue;
    }
    public String getDetails() {
        return this.details;
    }
    
    public String getEscapedDetails() {
        return StringEscapeUtils.escapeEcmaScript(this.details);
    }

    public void setDetails(String details) {
        this.details = details;
    }
    public boolean isIsPublicEvent() {
        return this.isPublicEvent;
    }
    
    public void setIsPublicEvent(boolean isPublicEvent) {
        this.isPublicEvent = isPublicEvent;
    }
    public boolean isIsAdminEvent() {
        return this.isAdminEvent;
    }
    
    public void setIsAdminEvent(boolean isAdminEvent) {
        this.isAdminEvent = isAdminEvent;
    }
    public boolean isIsDeleted() {
        return this.isDeleted;
    }
    
    public void setIsDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }
    public Set getEventLikes() {
        return this.eventLikes;
    }
    
    public void setEventLikes(Set eventLikes) {
        this.eventLikes = eventLikes;
    }
    public Set getPosts() {
        return this.posts;
    }
    
    public void setPosts(Set posts) {
        this.posts = posts;
    }
    public Set getEventInvites() {
        return this.eventInvites;
    }
    
    public void setEventInvites(Set eventInvites) {
        this.eventInvites = eventInvites;
    }
    public Set getNotifications() {
        return this.notifications;
    }
    
    public void setNotifications(Set notifications) {
        this.notifications = notifications;
    }
    public Set getEventInappropriates() {
        return this.eventInappropriates;
    }
    
    public void setEventInappropriates(Set eventInappropriates) {
        this.eventInappropriates = eventInappropriates;
    }
    public Set getEventComments() {
        return this.eventComments;
    }
    
    public void setEventComments(Set eventComments) {
        this.eventComments = eventComments;
    }

    public String getTimeSincePost(){
        try {
            return GeneralFunctions.getTimeSinceString(timestamp);
        } catch (ParseException ex) {
            ex.printStackTrace();
        }
        return "moments ago";
    }
    
    public String getFormattedEventTime(){
        String buffer = "";
        SimpleDateFormat dfDate = new SimpleDateFormat("dd MMM yy @ ");
        SimpleDateFormat dfTime = new SimpleDateFormat("K:mma");
        
        buffer = dfDate.format(startTime); //gets date
        buffer += dfTime.format(startTime).toLowerCase(); //gets start time hrs
        buffer += " - ";
        buffer += dfTime.format(endTime).toLowerCase(); //gets end time hrs
        
        return buffer;
    }

    public ArrayList<EventComment> getEventCommentsList() {
        return eventCommentsList;
    }

    public void setEventCommentsList(ArrayList<EventComment> eventCommentsList) {
        this.eventCommentsList = eventCommentsList;
    }


}


