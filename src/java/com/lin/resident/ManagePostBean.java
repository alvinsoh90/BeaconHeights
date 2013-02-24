/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.resident;

import com.lin.controllers.CommunityWallController;
import com.lin.dao.CommunityWallCommentDAO;
import com.lin.dao.PostDAO;
import com.lin.entities.Comment;
import com.lin.entities.Post;
import java.util.ArrayList;
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
        PostDAO pDAO = new PostDAO();
        postList = pDAO.retrievePostsWithLimit(10);
        System.out.println("postList size: "+postList.size());
        
        CommunityWallController wallCtrl = new CommunityWallController();
        //get associated comments
        for(Post p : postList){
            ArrayList<Comment> l = wallCtrl.getCommentsForPostSortedByDate(p.getPostId());
            Set<Comment> relatedComments = new HashSet<Comment>(l);
            p.setComments(relatedComments);
        }
        
        return postList;
    }
}
