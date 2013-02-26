/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.controllers;

import com.lin.dao.EventCommentDAO;
import com.lin.dao.EventDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.Event;
import com.lin.entities.EventComment;
import com.lin.entities.EventInappropriate;
import com.lin.entities.EventLike;
import com.lin.entities.User;
import com.lin.resident.ManageNotificationBean;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;

/**
 *
 * @author fayannefoo
 */
public class EventWallController {

    UserDAO uDAO = new UserDAO();
    EventCommentDAO cDAO = new EventCommentDAO();
    EventDAO eDAO = new EventDAO();

    public void addCommentOnEvent(int eventId, User user, String content) {
        Event event = eDAO.getEventWithUserLoaded(eventId);
        EventComment eComment = new EventComment(
                event,
                user,
                content,
                new Date(),
                false);

        cDAO.createEventComment(eComment); 
        
        //send notifications
        ManageNotificationBean nBean = new ManageNotificationBean();
        nBean.sendEventCommentedNotification(event, user);
    }

    public ArrayList<EventComment> getCommentsForEventSortedByDate(int eventId) {
        ArrayList<EventComment> list = cDAO.getAllCommentsForEvent(eventId);
        //Collections.sort(list);
        return list;  
    }
    
    public boolean likeEvent(int userId, int postId){
        User u = uDAO.getShallowUser(userId);
        Event e = eDAO.getEvent(postId);
        
        EventLike pl = new EventLike(e,u);
        pl.setTimestamp(new Date());
        
        pl = eDAO.likeEvent(pl);
        
        return (pl != null);
    }
    
    public boolean unlikeEvent(int userId, int postId){                
        return eDAO.unlikeEvent(userId,postId);
    }
    
    public boolean flagEventInappropriate(int userId, int postId){
        User u = uDAO.getShallowUser(userId);
        Event e = eDAO.getEvent(postId);
        
        EventInappropriate pl = new EventInappropriate(e,u);
        pl.setTimestamp(new Date());
        
        return eDAO.flagEventInappropriate(pl);
    }
    
    public boolean unFlagEventInappropriate(int userId, int postId){                
        return eDAO.unFlagEventInappropriate(userId,postId);
    }
    
    public boolean hasUserFlaggedInappropriate(int userId, int postId){
        EventInappropriate p = eDAO.getEventInappropriate(userId,postId);
        
        if(p != null){
            return true;
        }
        
        return false;
    }
}
