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
    
    public ArrayList<Notification> getUnreadNotificationList(User user) {
        return nDAO.retrieveUnreadNotificationByReceivingUserId(user.getUserId());
               
    }

    //OK
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
    
    //LATER FIX
   public void sendEventCommentedNotification(Event event, User commenter){
       
       //all invited users
        for(User user : nDAO.retrieveParticipantsOfEventExcludingAUser(event.getId(),commenter.getUserId())){
            nDAO.createNotification(
                    new Notification(
                    commenter, //sender
                    event, //this event
                    user, // receipient
                    Notification.Type.EVENTCOMMENT,
                    new Date()
            ));            
        }
       
        //send to user who created event, if current commenter is not creator
        System.out.println("Commenter id:" + commenter.getUserId());
        System.out.println("creator id:" + event.getUser().getUserId());
        
        if(commenter.getUserId() != event.getUser().getUserId()){
            System.out.println("not posting t myself");
            nDAO.createNotification(
                    new Notification(
                    commenter, //sender
                    event, //this event
                    event.getUser(), // receipient
                    Notification.Type.EVENTCOMMENT,
                    new Date()
            ));  
        }
                  
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
    
    //OK
    public void sendJoinedEventNotification(User joiner, Event event){
        
        //Send to creator of event
        nDAO.createNotification(
                    new Notification(
                    joiner, //sender
                    event, //this event
                    event.getUser(), // receipient
                    Notification.Type.JOINEDEVENT,
                    new Date()
            ));
        
        //send to all who are invited or joined the event
        //excludes the current user who had just joined
        System.out.println("event: " + event);
        System.out.println("joiner: " + joiner);
        for(User user : 
           nDAO.retrieveParticipantsOfEventExcludingAUser(event.getId(), joiner.getUserId())){
            nDAO.createNotification(
                    new Notification(
                    joiner, //sender
                    event, //this event
                    user, // receipient
                    Notification.Type.JOINEDEVENT,
                    new Date()
            ));
        }
    }
    
    //OK
    public void sendPostCommentedNotification(User commenter, Post post){
        
        //user who created the post, if the creator is not the one posting
        if(commenter.getUserId() != post.getUser().getUserId()){
            System.out.println("Sending to...creator" + post.getUser());
            nDAO.createNotification(
                        new Notification(
                        commenter, //sender
                        post.getUser(), // receipient
                        post,        
                        Notification.Type.POSTCOMMENT,
                        new Date()
            ));
        }
        
        //users who commented on the post, excluding commenter
//        for(User user : nDAO.retrieveCommentersForPostExcludingAUser(post.getPostId(),
//                commenter.getUserId())){
//                System.out.println("Sending to... " + user.getUserId());
//            nDAO.createNotification(
//                    new Notification(
//                    commenter, //sender
//                    user, //receipient 
//                    post,        
//                    Notification.Type.POSTCOMMENT,
//                    new Date()
//            ));            
//        }
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
    
    //OK
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
    
    public ArrayList<Notification> notificationList(User receiver){
        return nDAO.retrieveNotificationByReceivingUserId(receiver.getUserId());
    }
    
}
