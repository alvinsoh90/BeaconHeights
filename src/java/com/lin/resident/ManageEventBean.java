/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.resident;

import com.lin.controllers.EventWallController;
import com.lin.dao.BookingDAO;
import com.lin.dao.EventCommentDAO;
import com.lin.dao.EventDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.Booking;
import com.lin.entities.Comment;
import com.lin.entities.Event;
import com.lin.entities.EventComment;
import com.lin.entities.EventInvite;
import com.lin.entities.EventLike;
import com.lin.entities.User;
import com.lin.general.login.BaseActionBean;
import com.lin.global.GlobalVars;
import com.lin.utils.FacebookFunctions;
import java.text.DecimalFormat;
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
public class ManageEventBean extends BaseActionBean {

    private ActionBeanContext context;
    private Integer id;
    private Integer commentId;
    private Date timestamp;
    private String title;
    private String venue;
    private String details;
    private boolean isPublicEvent;
    private boolean shareOnFacebook;
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
    private String bookingId;
    private EventDAO eDAO = new EventDAO();
    private EventCommentDAO ecDAO = new EventCommentDAO();

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getEventTaggedFriends() {
        return eventTaggedFriends;
    }

    public void setEventTaggedFriends(String eventTaggedFriends) {
        this.eventTaggedFriends = eventTaggedFriends;
    }

    public String getEventTimeEnd() {
        return eventTimeEnd;
    }

    public boolean isShareOnFacebook() {
        return shareOnFacebook;
    }

    public void setShareOnFacebook(boolean shareOnFacebook) {
        this.shareOnFacebook = shareOnFacebook;
    }

    public Integer getCommentId() {
        return commentId;
    }

    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
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

    public Event getEvent(Integer id) {
        EventDAO eDAO = new EventDAO();
        BookingDAO bDAO = new BookingDAO();
        Event event = eDAO.getEventWithUserLoaded(id);
        //comments
        event.setEventCommentsList(ecDAO.getAllCommentsForEvent(event.getId()));
        //booking
        if (event.getBooking() != null) {

            event.setBooking(bDAO.getFullDataBooking(event.getBooking().getId()));
        }

        return event;

    }

    public ArrayList<Event> getEventListWithNoComments() {
        ArrayList<Event> eventList = eDAO.getYtdToFutureEvents();
        System.out.println("eventList size: " + eventList.size());

        return eventList;
    }

    public ArrayList<Event> getEventList() {
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

    public ArrayList<Event> getFlaggedList() {
        EventWallController wallCtrl = new EventWallController();
        EventCommentDAO ecDAO = new EventCommentDAO();
        BookingDAO bDAO = new BookingDAO();
        eventList = eDAO.getAllInappropriate();


        for (Event e : eventList) {
            //comments
            e.setEventCommentsList(ecDAO.getAllCommentsForEvent(e.getId()));
            //booking
            if (e.getBooking() != null) {
                System.out.println("bId: "
                        + e.getBooking().getId());
                e.setBooking(bDAO.getFullDataBooking(e.getBooking().getId()));
            }
        }
        return eventList;
    }

    @HandlesEvent("adminUnflag")
    public Resolution admingUnflag() {
        outcome = eDAO.adminUnflag(id);
        return new RedirectResolution("/admin/manage-events.jsp?deletesuccess="
                + outcome + "&deletemsg=" + getTitle());
    }

    @HandlesEvent("deleteEvent")
    public Resolution deleteEvent() {
        outcome = eDAO.deleteEvent(id);
        return new RedirectResolution("/resident/eventwall.jsp?deletesuccess="
                + outcome + "&deletemsg=" + getTitle());
    }

    @HandlesEvent("deleteEventAllEventTab")
    public Resolution deleteEventAllEventTab() {
        System.out.println("EVENT ID " + id);
        outcome = eDAO.deleteEvent(id);
        return new RedirectResolution("/admin/manage-allevents.jsp");
    }

    @HandlesEvent("featureEvent")
    public Resolution featureEvent() {
        System.out.println("EVENT ID " + id);
        outcome = eDAO.featureEvent(id);
        return new RedirectResolution("/admin/manage-allevents.jsp");
    }

    @HandlesEvent("adminDeleteEvent")
    public Resolution adminDeleteEvent() {
        System.out.println("EVENT ID " + id);
        outcome = eDAO.deleteEvent(id);
        return new RedirectResolution("/admin/manage-events.jsp?deletesuccess="
                + outcome + "&deletemsg=" + getTitle());
    }

    @HandlesEvent("adminDeleteComment")
    public Resolution adminDeleteComment() {
        System.out.println(commentId);
        outcome = ecDAO.deleteEventComment(commentId);
        return new RedirectResolution("/admin/manage-events.jsp?deletesuccess="
                + outcome + "&deletemsg=Comment");
    }

    @HandlesEvent("addEvent")
    public Resolution addEvent() {

        // get flash scope instance
        FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true);

        Date start = new Date(Long.parseLong(getEventTimeStart()));
        Date end = new Date(Long.parseLong(getEventTimeEnd()));
        System.out.println("venue: " + getVenue());
        Event event = new Event(
                getContext().getUser(),
                getTitle(),
                start,
                end,
                getVenue(),
                getDetails(),
                isIsPublicEvent());

        //Check any booking tagged
        if (Integer.parseInt(getBookingId()) != -1) {
            BookingDAO bDAO = new BookingDAO();
            Booking b = bDAO.getBooking(Integer.parseInt(getBookingId()));
            event.setBooking(b);
        }

        Event e = eDAO.createEvent(event);
        if (e != null) {
            //Check if any friends invite
            String friendsStr = getEventTaggedFriends();
            String[] friendsArr;
            if (friendsStr != null) {
                friendsStr = friendsStr.replace("[", "");
                friendsStr = friendsStr.replace("]", "");
                friendsArr = friendsStr.split(",");

                //create invites and store in DB
                UserDAO uDAO = new UserDAO();
                for (String userId : friendsArr) {
                    User u = uDAO.getShallowUser(Integer.parseInt(userId));
                    EventInvite ei = new EventInvite(e, u, EventInvite.Type.PENDING);
                    eDAO.addEventInvite(ei);
                }
            }

            //Create notifications if public event
            if (isIsPublicEvent()) {
                ManageNotificationBean nBean = new ManageNotificationBean();
                //nBean.sendEventCreatedNotification(e, getContext().getUser());

                //post to facebook?
                System.out.println("SHARING ON FACEBOOK: " + isShareOnFacebook());
                if (isShareOnFacebook()) {
                    FacebookFunctions fb = new FacebookFunctions();
                    String facebookPostId = null;
                    //get access token from session
                    String currAccessToken = (String) getContext().getRequest().getSession().getAttribute(GlobalVars.SESSION_FB_ACCESS_TOKEN);

                    //post to facebook
                    facebookPostId = fb.createEventInGroup(getTitle(), //event name
                            start,
                            end,
                            getDetails(), //+ " More info here: " + GlobalVars.APP_URL + "residents/eventwall.jsp?postid=" + e.getId(), //link 
                            getVenue(),
                            currAccessToken);

                    if (facebookPostId != null) {
                        System.out.println("Post to fb successful! id: " + facebookPostId);

                        //Should store facebook post id with post id here...
                        //eDAO.updateEventWithFBPostId(e, facebookPostId);

                    } else if (facebookPostId == null && currAccessToken != null) {
                        //if failed to post, and accessToken appears ok, try refreshing token
                        String newToken = fb.extendFacebookAccessToken(currAccessToken);

                        System.out.println("Trying fb post again with new access token...");

                        //post to facebook with new token
                        facebookPostId = fb.createEventInGroup(getTitle(), //event name
                                start,
                                end,
                                getDetails() + " More info here: " + GlobalVars.APP_URL + "residents/eventwall.jsp?postid=" + e.getId(), //link 
                                getVenue(),
                                currAccessToken);

                        if (facebookPostId != null) {
                            System.out.println("2nd try Post to fb successful! id: " + facebookPostId);

                            //Should store facebook post id with post id here...
                            //eDAO.updateEventtWithFBPostId(e, facebookPostId);

                            //update session with new access token
                            getContext().getRequest().getSession().setAttribute(GlobalVars.SESSION_FB_ACCESS_TOKEN, newToken);
                        }
                    }
                }
            }


            fs.put("SUCCESS", "true");
        } else {
            fs.put("SUCCESS", "false");
        }
        return new RedirectResolution("/residents/eventwall.jsp");
    }

    //Used in viewmyevents and eventwall.jsp to output user's future events for tagging purposes
    public ArrayList<Booking> getUserFutureBookings(int userId) {
        ArrayList<Booking> bList = new ArrayList<Booking>();
        BookingDAO bDAO = new BookingDAO();
        bList = bDAO.getUserYtdToFutureBookings(userId);
        return bList;
    }

    public ArrayList<Event> getAllPublicAndFriendEvents(int limit) {
        ArrayList<Event> list = eDAO.getAllPublicEventsWithLimit(limit);
        EventCommentDAO ecDAO = new EventCommentDAO();
        BookingDAO bDAO = new BookingDAO();

        //get relevant comments and attach bookings if present
        for (Event e : list) {
            //comments
            e.setEventCommentsList(ecDAO.getAllCommentsForEvent(e.getId()));
            //booking
            if (e.getBooking() != null) {
                System.out.println("bId: "
                        + e.getBooking().getId());
                e.setBooking(bDAO.getFullDataBooking(e.getBooking().getId()));
            }
        }

        System.out.println("found events ::" + list.size());
        return list;
    }

    public ArrayList<User> getInvitedUsers(int eventId, int limit) { //-1 for no limit
        ArrayList<User> list = new ArrayList<User>();
        ArrayList<EventInvite> tagList = eDAO.getEventInvitesByEventId(eventId);
        int fetchSize = tagList.size();

        if (tagList.size() > limit && limit != -1) {
            fetchSize = limit;
        }

        //retrieve users
        UserDAO uDAO = new UserDAO();
        for (int i = 0; i < fetchSize; i++) {
            EventInvite invite = tagList.get(i);
            list.add(uDAO.getShallowUser(invite.getUser().getUserId()));
        }

        return list;
    }

    public ArrayList<User> getPendingInvites(int eventId, int limit) { //-1 for no limit
        ArrayList<User> list = new ArrayList<User>();
        ArrayList<EventInvite> tagList = eDAO.getPendingEventInvitesByEventId(eventId);
        int fetchSize = tagList.size();

        if (tagList.size() > limit && limit != -1) {
            fetchSize = limit;
        }

        //retrieve users
        UserDAO uDAO = new UserDAO();
        for (int i = 0; i < fetchSize; i++) {
            EventInvite invite = tagList.get(i);
            list.add(uDAO.getShallowUser(invite.getUser().getUserId()));
        }

        return list;
    }

    public boolean hasUserLikedEvent(int postId, int userId) {
        return eDAO.hasUserLikedEvent(postId, userId);
    }

    public boolean hasUserJoinedEvent(int postId, int userId) {
        return eDAO.hasUserJoinedEvent(postId, userId);
    }

    public int getNumEventLikes(int postId) {
        return eDAO.getEventLikesByEventId(postId).size();
    }

    public ArrayList<User> getLikersOfEvent(int postId, int limit) { //-1 for no limit
        ArrayList<User> list = new ArrayList<User>();
        ArrayList<EventLike> likeList = eDAO.getEventLikesByEventId(postId);
        int fetchSize = likeList.size();

        if (likeList.size() > limit && limit != -1) {
            fetchSize = limit;
        }

        //retrieve users
        UserDAO uDAO = new UserDAO();
        for (int i = 0; i < fetchSize; i++) {
            EventLike pl = likeList.get(i);
            list.add(uDAO.getShallowUser(pl.getUser().getUserId()));
        }

        return list;
    }

    public ArrayList<User> getTaggedUsers(int postId, int limit) { //-1 for no limit
        ArrayList<User> list = new ArrayList<User>();
        ArrayList<EventInvite> tagList = eDAO.getEventInvitesByEventId(postId);
        int fetchSize = tagList.size();

        if (tagList.size() > limit && limit != -1) {
            fetchSize = limit;
        }

        //retrieve users
        UserDAO uDAO = new UserDAO();
        for (int i = 0; i < fetchSize; i++) {
            EventInvite pl = tagList.get(i);
            list.add(uDAO.getShallowUser(pl.getUser().getUserId()));
        }

        return list;
    }

    public ArrayList<User> getAttendingUsers(int postId, int limit) { //-1 for no limit
        ArrayList<User> list = new ArrayList<User>();
        ArrayList<EventInvite> tagList = eDAO.getAttendingEventInvitesByEventId(postId);
        int fetchSize = tagList.size();

        if (tagList.size() > limit && limit != -1) {
            fetchSize = limit;
        }

        //retrieve users
        UserDAO uDAO = new UserDAO();
        for (int i = 0; i < fetchSize; i++) {
            EventInvite pl = tagList.get(i);
            list.add(uDAO.getShallowUser(pl.getUser().getUserId()));
        }

        return list;
    }

    public boolean editEventAndSendNotifications(Event newEvent, String[] friendsArr) {

        Event e = eDAO.updateEvent(newEvent);
        //create invites and store in DB
        UserDAO uDAO = new UserDAO();

        try {
            for (String userId : friendsArr) {
                User u = uDAO.getShallowUser(Integer.parseInt(userId));
                System.out.println("Sent invite to: " + u.getUserName());
                EventInvite ei = new EventInvite(e, u, EventInvite.Type.PENDING);
                eDAO.addEventInvite(ei);
            }
        } catch (NumberFormatException nfe) {
            nfe.printStackTrace();
        }

        return true;

    }

    public boolean getIsInvited(int eventid, int limit, int userId) {
        ArrayList<User> invitedUsers = getInvitedUsers(eventid, limit);
        for (User user : invitedUsers) {
            if (user.getUserId() == userId) {
                return true;
            }
        }
        return false;
    }

    public boolean getIsEventViewable(int eventid, int userId) {
        ArrayList<User> invitedUsers = getInvitedUsers(eventid, -1);
        Event event = eDAO.getEvent(eventid);
        User eventUser = event.getUser();
        if (eventUser.getUserId() == userId) {
            return true;
        }

        for (User user : invitedUsers) {
            if (user.getUserId() == userId) {
                return true;
            }
        }
        return false;
    }

    public ArrayList<Event> getAllFutureEventsForUser(User user) {
        ArrayList<Event> list = eDAO.getAllFutureEventsForUser(user);
        EventCommentDAO ecDAO = new EventCommentDAO();
        BookingDAO bDAO = new BookingDAO();

        //get relevant comments and attach bookings if present
        for (Event e : list) {
            //comments
            e.setEventCommentsList(ecDAO.getAllCommentsForEvent(e.getId()));
            //booking
            if (e.getBooking() != null) {
                System.out.println("bId: "
                        + e.getBooking().getId());
                e.setBooking(bDAO.getFullDataBooking(e.getBooking().getId()));
            }
        }

        System.out.println("found events ::" + list.size());
        return list;

    }
    
    
    //============================================ Analytics SPECIFIC FUNCTIONS====================================
    public long getNumberOfFlaggedEvents(){
        return eDAO.getNumberOfFlaggedEvents();
    }
    
    public long getNumberOfEventsCreatedThisWeek(){
        return eDAO.getNumberOfEventsCreatedThisWeek();
    }
    public long getNumberOfEventsCreatedLastWeek(){
        return eDAO.getNumberOfEventsCreatedLastWeek();
    }
    public double getPercentChange(){
        long thisWeek = eDAO.getNumberOfEventsCreatedThisWeek();
        long lastWeek = eDAO.getNumberOfEventsCreatedLastWeek();
        long change = thisWeek - lastWeek;
        double percentChange = (double)change/lastWeek*100;
        DecimalFormat df = new DecimalFormat("#.##");
        if(thisWeek==0 && lastWeek==0){
            return Double.parseDouble(df.format(0));
        }else if(lastWeek==0){
            return Double.parseDouble(df.format(999999));
        }else{
            return Double.parseDouble(df.format(percentChange));
        }
    }
}
