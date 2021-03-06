/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.controllers;

import com.lin.dao.CommunityWallCommentDAO;
import com.lin.dao.FriendshipDAO;
import com.lin.dao.PostDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.Comment;
import com.lin.entities.Friendship;
import com.lin.entities.Post;
import com.lin.entities.PostInappropriate;
import com.lin.entities.PostLike;
import com.lin.entities.User;
import com.lin.resident.ManageNotificationBean;
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
        User poster = uDAO.getUser(posterId);
        Post post = pDAO.getPostWithUserLoaded(postId);
        
        Comment comment = new Comment(
                poster,
                post,
                content,
                new Date(),false);
        
        cDAO.addComment(comment);
        
        //send Notifications
        ManageNotificationBean nBean = new ManageNotificationBean();
        nBean.sendPostCommentedNotification(poster, post);
    }
    
    public ArrayList<Comment> getCommentsForPostSortedByDate(int postId){
        ArrayList<Comment> list = cDAO.retrieveCommentsForPost(postId);
        Collections.sort(list);
        return list;        
    }
    
     public ArrayList<Comment> getCommentsForPost(int postId){
        ArrayList<Comment> list = cDAO.retrieveCommentsForPost(postId);
        return list;        
    }
    
    public ArrayList<User> getAllPostersFriendsWithSimilarName(int userId, String name){
        FriendshipDAO fDAO = new FriendshipDAO();
        ArrayList<User> friendList = new ArrayList<User>();
        ArrayList<Friendship> fsList = fDAO.getAllFriendsOfUserBySimilarName(userId, name);
        
        for(Friendship f : fsList){
            if(f.getUserByUserIdOne().getUserId() != userId){
                friendList.add(f.getUserByUserIdOne());
            }
            else{
                friendList.add(f.getUserByUserIdTwo());
            }
        }
        
        return friendList;
    }
    
    public boolean likePost(int userId, int postId){
        User u = uDAO.getShallowUser(userId);
        Post p = pDAO.getPost(postId);
        
        PostLike pl = new PostLike(u,p);
        pl.setTimestamp(new Date());
        
        pl = pDAO.likePost(pl);
        
        return (pl != null);
    }
    
    public boolean unlikePost(int userId, int postId){                
        return pDAO.unlikePost(userId,postId);
    }
    
    public boolean flagPostInappropriate(int userId, int postId){
        User u = uDAO.getShallowUser(userId);
        Post p = pDAO.getPost(postId);
        
        PostInappropriate pl = new PostInappropriate(u,p);
        pl.setTimestamp(new Date());
        
        return pDAO.flagPostInappropriate(pl);
    }
    
    public boolean unFlagPostInappropriate(int userId, int postId){                
        return pDAO.unFlagPostInappropriate(userId,postId);
    }
    
    public boolean hasUserFlaggedInappropriate(int userId, int postId){
        PostInappropriate p = pDAO.getPostInappropriate(userId,postId);
        
        if(p != null){
            return true;
        }
        
        return false;
    }
    
}
