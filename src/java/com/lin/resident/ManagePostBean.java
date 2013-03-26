/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.resident;

import com.lin.controllers.CommunityWallController;
import com.lin.dao.CommunityWallCommentDAO;
import com.lin.dao.EventDAO;
import com.lin.dao.PostDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.Comment;
import com.lin.entities.Event;
import com.lin.entities.Post;
import com.lin.entities.PostLike;
import com.lin.entities.PostUserTag;
import com.lin.entities.User;
import com.lin.general.login.BaseActionBean;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;

/**
 *
 * @author fayannefoo
 */
public class ManagePostBean extends BaseActionBean {

    private int id;
    private int postId;
    private Integer commentId;
    private int userId;
    private String message;
    private Date date;
    private Integer replyTo;
    private Integer noOfLikes;
    private ArrayList<Post> postList;
    private ArrayList<Post> flaggedPostList;
    private ArrayList<Post> featuredPostList;
    private boolean outcome;
    PostDAO pDAO = new PostDAO();


    public Date getDate() {
        return date;
    }
    public Integer getCommentId() {
        return commentId;
    }

    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
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
        //postList = pDAO.retrievePostsWithLimitWithEvent(10);
        postList = pDAO.retrievePostsWithLimit(10);
        System.out.println("postList size: "+postList.size());
        
        CommunityWallController wallCtrl = new CommunityWallController();
        //get associated comments
        for(Post p : postList){
            ArrayList<Comment> l = wallCtrl.getCommentsForPost(p.getPostId());
            Set<Comment> relatedComments = new HashSet<Comment>(l);
            p.setComments(relatedComments);
            
            //get associated event
            p.setEvent(pDAO.getEventOfPost(p.getPostId()));
        }
        
        
        
        return postList;
    }
    
    public ArrayList<Post> getWallPostList(int wallId){
        System.out.println("I MANAGED TO GET HEREHEREHERE" + wallId);
        postList = pDAO.retrievePostsWithLimitByWall(100, wallId);
        System.out.println("postList size: "+postList.size());
        
        CommunityWallController wallCtrl = new CommunityWallController();
        //get associated comments
        for(Post p : postList){
            ArrayList<Comment> l = wallCtrl.getCommentsForPost(p.getPostId());
            Set<Comment> relatedComments = new HashSet<Comment>(l);
            p.setComments(relatedComments);
            
            //get associated event
            p.setEvent(pDAO.getEventOfPost(p.getPostId()));
        }
        
        
        
        return postList;
        
    }
    
    
    public ArrayList<Post> getFlaggedPostList() {
        flaggedPostList = pDAO.getAllPostInappropriate();
        System.out.println("postList size: "+flaggedPostList.size());
        
        CommunityWallController wallCtrl = new CommunityWallController();
        //get associated comments
        for(Post p : flaggedPostList){
            ArrayList<Comment> l = wallCtrl.getCommentsForPost(p.getPostId());
            Set<Comment> relatedComments = new HashSet<Comment>(l);
            p.setComments(relatedComments);
        }
        
        return flaggedPostList;
    }
    
     public ArrayList<Post> getFeaturedPostList() {
        featuredPostList = pDAO.retrieveAllFeaturedPosts();
        System.out.println("featuredList size: "+featuredPostList.size());
        return featuredPostList;
    }
    
    @HandlesEvent("deletePost")
    public Resolution deletePost() {
        outcome = pDAO.deletePost(id);
        return new RedirectResolution("/resident/eventwall.jsp?deletesuccess="
                + outcome + "&deletemsg=" + "Deleted");
    }

    @HandlesEvent("adminDeletePost")
    public Resolution adminDeletePost() {
        System.out.println(postId+"deletePostId");
        outcome = pDAO.deletePost(postId);
        return new RedirectResolution("/admin/manage-posts.jsp?deletesuccess="
                + outcome);
    }
    
    
    @HandlesEvent("adminUnFlagPostInappropriate")
    public Resolution adminUnflagPost(){
        outcome = pDAO.adminUnFlagPostInappropriate(postId);
        return new RedirectResolution("/admin/manage-flaggedposts.jsp?deletesuccess="
                + outcome);
    }
    
    @HandlesEvent("adminUnfeaturePost")
    public Resolution adminUnfeaturePost() {
        System.out.println(postId+"unfeaturedPostID");
        outcome = pDAO.removeFeaturedPost(postId);
        return new RedirectResolution("/admin/manage-posts.jsp?unfeaturesuccess="
                + outcome);
    }
    
    @HandlesEvent("adminFeaturePost")
    public Resolution adminFeaturePost() {
        System.out.println(postId+"featuredPostID");
        outcome = pDAO.featurePost(postId);
        return new RedirectResolution("/admin/manage-posts.jsp?featuresuccess="
                + outcome);
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
        
        if(likeList.size() > limit && limit != -1) fetchSize = limit;
        
        //retrieve users
        UserDAO uDAO = new UserDAO();
        for(int i = 0 ; i < fetchSize ; i++){
            PostLike pl = likeList.get(i);
            list.add(uDAO.getShallowUser(pl.getUser().getUserId()));           
        }
        
        return list;
    }
    
    public ArrayList<User> getTaggedUsers(int postId, int limit){ //-1 for no limit
        ArrayList<User> list = new ArrayList<User>();
        ArrayList<PostUserTag> tagList =  pDAO.getPostUserTagsByPostId(postId);
        int fetchSize = tagList.size();
        
        if(tagList.size() > limit && limit != -1) fetchSize = limit;
        
        //retrieve users
        UserDAO uDAO = new UserDAO();
        for(int i = 0 ; i < fetchSize ; i++){
            PostUserTag pl = tagList.get(i);
            list.add(uDAO.getShallowUser(pl.getUser().getUserId()));           
        }
        
        return list;
    }
    
    public Event getTaggedEvent(int postId){ 
        return pDAO.getEventOfPost(postId);       

    }
    
    public long getNumberOfFlaggedPosts(){
        return pDAO.getNumberOfFlaggedPosts();
    }
    public long getNumberOfNewPostsThisWeek(){
        return pDAO.getNumberOfNewPostsThisWeek();
    }
}
