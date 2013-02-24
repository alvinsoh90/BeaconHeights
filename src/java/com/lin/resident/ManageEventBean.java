/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.resident;

import com.lin.controllers.EventWallController;
import com.lin.dao.EventDAO;
import com.lin.entities.Booking;
import com.lin.entities.Comment;
import com.lin.entities.Event;
import com.lin.entities.EventComment;
import com.lin.entities.User;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;

/**
 *
 * @author fayannefoo
 */
public class ManageEventBean implements ActionBean {

    private ActionBeanContext context;
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
    private ArrayList<Event> eventList;
    private boolean outcome;

    @Override
    public void setContext(ActionBeanContext abc) {
        this.context = context;
    }

    @Override
    public ActionBeanContext getContext() {
        return context;
    }

    public Booking getBooking() {
        return booking;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
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

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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

    @HandlesEvent("editEvent")
    public Resolution editEvent() {
        EventDAO eDAO = new EventDAO();
        outcome = eDAO.updateEvent(id, user, booking,
                title, startTime, endTime, venue, details,isPublicEvent);
        return new RedirectResolution("/resident/eventwall.jsp?editsuccess="
                + outcome + "&editmsg=" + getTitle());
    }

    @HandlesEvent("addEvent")
    public Resolution addEvent() {
        EventDAO eDAO = new EventDAO();
        Event e = eDAO.createEvent(user, booking, title, startTime, endTime, venue, 
                details,isPublicEvent,isAdminEvent);
        if(e != null){
            outcome = true;
        }
        return new RedirectResolution("/resident/eventwall.jsp?createsuccess="
                + outcome + "&createmsg=" + getTitle());
    }
}
