/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.controllers;

import com.lin.dao.CommunityWallCommentDAO;
import com.lin.dao.PostDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.Comment;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;

/**
 *
 * @author Yangsta
 */
public class CommunityWallController {
    
    UserDAO uDAO = new UserDAO();
    CommunityWallCommentDAO cDAO = new CommunityWallCommentDAO();
    PostDAO pDAO = new PostDAO();
    
    public void addCommentOnPost(int posterId, int postId, String content){
        
        Comment comment = new Comment(
                uDAO.getUser(posterId),
                pDAO.getPost(postId),
                content,
                new Date(),false);
        
        cDAO.addComment(comment);
    }
    
    public ArrayList<Comment> getCommentsForPostSortedByDate(int postId){
        ArrayList<Comment> list = cDAO.retrieveCommentsForPost(postId);
        Collections.sort(list);
        return list;        
    }
    
}
