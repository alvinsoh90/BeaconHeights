/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.controllers;

import com.lin.dao.EventCommentDAO;
import com.lin.dao.EventDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.EventComment;
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

    public void addCommentOnEvent(int eventId, int posterId, String content) {
        
        EventComment eComment = new EventComment(
                eDAO.getEvent(eventId),
                uDAO.getUser(posterId),
                content,
                new Date(),
                false);

        cDAO.createEventComment(eComment);
    }

    public ArrayList<EventComment> getCommentsForEventSortedByDate(int eventId) {
        ArrayList<EventComment> list = cDAO.getAllCommentsForEvent(eventId);
        //Collections.sort(list);
        return list;  
    }
}
