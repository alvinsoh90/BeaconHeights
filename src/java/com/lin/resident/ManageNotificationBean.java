/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.resident;

import com.lin.dao.CommunityWallCommentDAO;
import com.lin.dao.EventDAO;
import com.lin.dao.NotificationDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.Comment;
import com.lin.entities.Event;
import com.lin.entities.Notification;
import com.lin.entities.Post;
import com.lin.entities.User;
import com.lin.general.login.BaseActionBean;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Yangsta
 */
public class ManageNotificationBean extends BaseActionBean{
    
    NotificationDAO nDAO = new NotificationDAO();    
    EventDAO eDAO = new EventDAO();
    UserDAO uDAO = new UserDAO();

    
    public User getCurrentUser(){
        return getContext().getUser();
    }
    
    public ArrayList<Notification> getUnreadNotificationList() {
        return nDAO.retrieveUnreadNotificationByReceivingUserId(
                getContext().getUser().getUserId());
    }

    public void sendEventCreatedNotification(Event newEvent, User currentUser){
       UserDAO uDAO = new UserDAO();       
        //event created is sent to all users except current user
        for(User user : uDAO.retrieveAllShallowUsersExceptCurrentUser(currentUser.getUserId())){
            nDAO.createNotification(
                    new Notification(
                    currentUser, //sender
                    newEvent, //this event
                    user, // receipient
                    Notification.Type.EVENTCREATED,
                    new Date()
            ));            
        }
    }
    
   public void sendEventCommentedNotification(Event event, User commenter){
       ManageEventBean manageEventBean = new ManageEventBean();
       
       //all invited users
        for(User user : manageEventBean.getInvitedUsers(event.getId(),-1)){
            nDAO.createNotification(
                    new Notification(
                    commenter, //sender
                    event, //this event
                    user, // receipient
                    Notification.Type.EVENTCOMMENT,
                    new Date()
            ));            
        }
       
        //user who created the event
        nDAO.createNotification(
                    new Notification(
                    commenter, //sender
                    event, //this event
                    event.getUser(), // receipient
                    Notification.Type.EVENTCOMMENT,
                    new Date()
            ));            
    }
    
    public void sendFriendRequestNotification(User sender, User receipient){
        nDAO.createNotification(
                    new Notification(
                    sender, //sender
                    receipient, //this event
                    Notification.Type.FRIENDREQUEST,
                    new Date()
            ));
    }
    
    public void sendJoinedEventNotification(User joiner, Event event){
        nDAO.createNotification(
                    new Notification(
                    joiner, //sender
                    event, //this event
                    event.getUser(), // receipient
                    Notification.Type.JOINEDEVENT,
                    new Date()
            )); 
    }
    
    public void sendPostCommentedNotification(User commenter, Post post){
        //user who created the post        
        nDAO.createNotification(
                    new Notification(
                    commenter, //sender
                    post.getUser(), // receipient
                    post,        
                    Notification.Type.EVENTCOMMENT,
                    new Date()
            ));
        
        
        //users who commented on the post
        for(User user : nDAO.retrieveCommentersForPostExcludingAUser(post.getPostId(),
                post.getUser().getUserId())){
            
            nDAO.createNotification(
                    new Notification(
                    commenter, //sender
                    user, //this event
                    Notification.Type.EVENTCOMMENT,
                    new Date()
            ));            
        }
    }
    
    public void sendEventInviteNotification(Event event, ArrayList<User> receivers){
        
        //users who are tagged in post
        for(User user : receivers){            
            nDAO.createNotification(
                    new Notification(
                    event.getUser(), //sender
                    event, //this event
                    user, // receipient
                    Notification.Type.EVENTINVITE,
                    new Date()
            ));            
        }
    }
    
    public void sendTaggedInPostNotification(Post post, ArrayList<User> taggedUsers){
        
        //users who are tagged in post
        for(User user : taggedUsers){            
            nDAO.createNotification(
                    new Notification(
                    post.getUser(), //sender
                    user, //this event
                    post,        
                    Notification.Type.TAGGEDINPOST,
                    new Date()
            ));            
        }
    }
    
}
