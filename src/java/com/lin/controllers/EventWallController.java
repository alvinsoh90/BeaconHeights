/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.controllers;

import com.lin.dao.EventDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.Comment;
import java.util.ArrayList;
import java.util.Collections;

/**
 *
 * @author fayannefoo
 */
public class EventWallController {
    
    UserDAO uDAO = new UserDAO();
    //EventCommentDAO cDAO = new EventCommentDAO();
    EventDAO eDAO = new EventDAO();
    
    public void addCommentOnEvent(int posterId, int postId, String content){

    }
    
    public ArrayList<Comment> getCommentsForEventSortedByDate(int postId){
        //ArrayList<Comment> list = cDAO.retrieveCommentsForPost(postId);
        //Collections.sort(list);
        //return list;  
        return null;
    }
    
}
