/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.resident;

import com.lin.controllers.EventWallController;
import com.lin.dao.EventDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.Booking;
import com.lin.entities.Comment;
import com.lin.entities.Event;
import com.lin.entities.EventComment;
import com.lin.entities.User;
import com.lin.general.login.BaseActionBean;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.FlashScope;

/**
 *
 * @author fayannefoo
 */
public class ManageEventBean extends BaseActionBean{

    private ActionBeanContext context;
    private Integer id;
    private Date timestamp;
    private String title;
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
    private ArrayList<Event> eventList;
    private boolean outcome;
    private String eventTimeStart;
    private String eventTimeEnd;
    private String eventTaggedFriends;

    public String getEventTaggedFriends() {
        return eventTaggedFriends;
    }

    public void setEventTaggedFriends(String eventTaggedFriends) {
        this.eventTaggedFriends = eventTaggedFriends;
    }
    
    public String getEventTimeEnd() {
        return eventTimeEnd;
    }

    public void setEventTimeEnd(String eventTimeEnd) {
        this.eventTimeEnd = eventTimeEnd;
    }

    public String getEventTimeStart() {
        return eventTimeStart;
    }

    public void setEventTimeStart(String eventTimeStart) {
        this.eventTimeStart = eventTimeStart;
    }
    
    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }


    public Set getEventComments() {
        return eventComments;
    }

    public void setEventComments(Set eventComments) {
        this.eventComments = eventComments;
    }

    public Set getEventInappropriates() {
        return eventInappropriates;
    }

    public void setEventInappropriates(Set eventInappropriates) {
        this.eventInappropriates = eventInappropriates;
    }

    public Set getEventInvites() {
        return eventInvites;
    }

    public void setEventInvites(Set eventInvites) {
        this.eventInvites = eventInvites;
    }

    public Set getEventLikes() {
        return eventLikes;
    }

    public void setEventLikes(Set eventLikes) {
        this.eventLikes = eventLikes;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public boolean isIsAdminEvent() {
        return isAdminEvent;
    }

    public void setIsAdminEvent(boolean isAdminEvent) {
        this.isAdminEvent = isAdminEvent;
    }

    public boolean isIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public boolean isIsPublicEvent() {
        return isPublicEvent;
    }

    public void setIsPublicEvent(boolean isPublicEvent) {
        this.isPublicEvent = isPublicEvent;
    }

    public Set getNotifications() {
        return notifications;
    }

    public void setNotifications(Set notifications) {
        this.notifications = notifications;
    }

    public Set getPosts() {
        return posts;
    }

    public void setPosts(Set posts) {
        this.posts = posts;
    }


    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public ArrayList<Event> getEventList() {
        EventDAO eDAO = new EventDAO();
        eventList = eDAO.getAllEvents();
        System.out.println("eventList size: " + eventList.size());

        EventWallController wallCtrl = new EventWallController();
        //get associated comments
        for (Event e : eventList) {
            ArrayList<EventComment> l = wallCtrl.getCommentsForEventSortedByDate(e.getId());
            Set<EventComment> relatedComments = new HashSet<EventComment>(l);
            e.setEventComments(relatedComments);
        }

        return eventList;
    }
    
        @HandlesEvent("deleteEvent")
    public Resolution deleteEvent() {
        EventDAO eDAO = new EventDAO();
        outcome = eDAO.deleteEvent(id);
        return new RedirectResolution("/resident/eventwall.jsp?deletesuccess="
                + outcome + "&deletemsg=" + getTitle());
    }


    @HandlesEvent("addEvent")
    public Resolution addEvent() {
        
        // get flash scope instance
        FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true); 
        
        EventDAO eDAO = new EventDAO();
        
        Date start = new Date(Long.parseLong(getEventTimeStart()));
        Date end = new Date(Long.parseLong(getEventTimeEnd()));
        
        Event event = new Event(
                getContext().getUser(), 
                getTitle(), 
                start,
                end, 
                getVenue(), 
                getDetails(), 
                isIsPublicEvent());
        
        //Check if any friends invite
        String friendsStr = getEventTaggedFriends();
        String[] friendsArr;
        if(!friendsStr.isEmpty()){
            friendsStr = friendsStr.replace("[", "");
            friendsStr = friendsStr.replace("]", "");
            friendsArr = friendsStr.split(",");
        }
        
        //Check any booking tagged
        

        Event e = eDAO.createEvent(event);
        if(e != null){
            fs.put("SUCCESS","true");
        }
        else{
            fs.put("SUCCESS","false");
        }
        return new RedirectResolution("/residents/eventwall.jsp");
    }
}
