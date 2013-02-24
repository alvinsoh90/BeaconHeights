/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.resident;

import com.lin.controllers.CommunityWallController;
import com.lin.dao.CommunityWallCommentDAO;
import com.lin.dao.PostDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.Comment;
import com.lin.entities.Post;
import com.lin.entities.PostLike;
import com.lin.entities.User;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;

/**
 *
 * @author fayannefoo
 */
public class ManagePostBean implements ActionBean {

    private ActionBeanContext context;
    private int postId;
    private int userId;
    private String message;
    private Date date;
    private Integer replyTo;
    private Integer noOfLikes;
    private ArrayList<Post> postList;
    PostDAO pDAO = new PostDAO();


    @Override
    public void setContext(ActionBeanContext abc) {
        this.context = context;
    }

    @Override
    public ActionBeanContext getContext() {
        return context;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Integer getNoOfLikes() {
        return noOfLikes;
    }

    public void setNoOfLikes(Integer noOfLikes) {
        this.noOfLikes = noOfLikes;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public Integer getReplyTo() {
        return replyTo;
    }

    public void setReplyTo(Integer replyTo) {
        this.replyTo = replyTo;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public ArrayList<Post> getPostList() {
        postList = pDAO.retrievePostsWithLimit(10);
        System.out.println("postList size: "+postList.size());
        
        CommunityWallController wallCtrl = new CommunityWallController();
        //get associated comments
        for(Post p : postList){
            ArrayList<Comment> l = wallCtrl.getCommentsForPost(p.getPostId());
            Set<Comment> relatedComments = new HashSet<Comment>(l);
            p.setComments(relatedComments);
        }
        
        return postList;
    }
    
    public ArrayList<Comment> sortCommentsByDate(HashSet<Comment> l){
        ArrayList<Comment> cList = new ArrayList<Comment>(l);
        Collections.sort(cList);
        return cList;
    }
    
    public boolean hasUserLikedPost(int postId, int userId){        
        return pDAO.hasUserLikedPost(postId, userId);
    }
    
    public int getNumPostLikes(int postId){
        return pDAO.getPostLikesByPostId(postId).size();
    }
    
    public ArrayList<User> getLikersOfPost(int postId, int limit){ //-1 for no limit
        ArrayList<User> list = new ArrayList<User>();
        ArrayList<PostLike> likeList=  pDAO.getPostLikesByPostId(postId);
        int fetchSize = likeList.size();
        
        if(likeList.size() > limit) fetchSize = limit;
        
        //retrieve users
        UserDAO uDAO = new UserDAO();
        for(int i = 0 ; i < fetchSize ; i++){
            PostLike pl = likeList.get(i);
            list.add(uDAO.getShallowUser(pl.getUser().getUserId()));           
        }
        
        return list;
    }
}
