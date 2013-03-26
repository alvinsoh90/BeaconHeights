/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.resident;

import com.lin.controllers.CommunityWallController;
import com.lin.controllers.FacebookController;
import com.lin.dao.PostDAO;
import com.lin.dao.UserDAO;
import com.lin.dao.EventDAO;
import com.lin.entities.Post;
import com.lin.entities.PostUserTag;
import com.lin.entities.User;
import com.lin.entities.Event;
import com.lin.global.GlobalVars;
import com.lin.utils.FacebookFunctions;
import java.util.ArrayList;
import java.util.Date;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.FlashScope;

/**
 *
 * @author Yangsta
 */
public class AddPostActionBean implements ActionBean {

    private ActionBeanContext context;
    private String postContent;
    private String postTitle;
    private int posterId;
    private int eventId;
    private String postCategory;
    private String taggedFriends;  //retrieved as "[id1,id2,id3,...]"
    private int wallId;
    private boolean shareOnFacebook;
    private boolean feature;

    public boolean isFeature() {
        return feature;
    }

    public void setFeature(boolean feature) {
        this.feature = feature;
    }
    

    public boolean isShareOnFacebook() {
        return shareOnFacebook;
    }

    public void setShareOnFacebook(boolean shareOnFacebook) {
        this.shareOnFacebook = shareOnFacebook;
    }

    
    public String getTaggedFriends() {
        return taggedFriends;
    }

    public void setTaggedFriends(String taggedFriends) {
        this.taggedFriends = taggedFriends;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getPostCategory() {
        return postCategory;
    }

    public void setPostCategory(String postCategory) {
        this.postCategory = postCategory;
    }

    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public String getPostContent() {
        return postContent;
    }

    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }

    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    public int getPosterId() {
        return posterId;
    }

    public void setPosterId(int posterId) {
        this.posterId = posterId;
    }

    public int getWallId() {
        return wallId;
    }

    public void setWallId(int wallId) {
        this.wallId = wallId;
    }

    @DefaultHandler
    public Resolution add() {

        // get flash scope instance
        FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true);

        try {
            UserDAO uDAO = new UserDAO();
            PostDAO pDAO = new PostDAO();
            User user = uDAO.getUser(getPosterId());
            EventDAO eDAO = new EventDAO();
            Event event = null;
            if (eventId != -1) {
                System.out.println("BBBBB"+eventId);
                event = eDAO.getEvent(eventId);
            }
            System.out.println("CCCCC"+eventId);
            //Create and save post
            Post aPost = null;
            //System.out.println(getFeaturedPost());
            System.out.append("AAAAA");

            if ("REQUEST".equals(getPostCategory())) {
                aPost = new Post(user, getPostContent(), new Date(), getPostTitle(), Post.Type.REQUEST, event, getWallId(), isFeature());
            } else if ("INVITE".equals(getPostCategory())) {
                aPost = new Post(user, getPostContent(), new Date(), getPostTitle(), Post.Type.INVITE, event, getWallId(),isFeature());
            } else if ("SHOUTOUT".equals(getPostCategory())) {
                aPost = new Post(user, getPostContent(), new Date(), getPostTitle(), Post.Type.SHOUTOUT, event, getWallId(),isFeature());
            } else if ("ANNOUNCEMENT".equals(getPostCategory())) {
                aPost = new Post(user, getPostContent(), new Date(), getPostTitle(), Post.Type.ANNOUNCEMENT, event, getWallId(),isFeature());
            } else {
                System.out.println("\nINVALID POST CATEGORY\n");
                fs.put("SUCCESS", "false");
            }
            System.out.println("Posting...");
            //System.out.println(getFeaturedPost()+"JJjjjjjjjjn ");
            Post posted = pDAO.addPost(aPost);
            System.out.println("Posting result: " + posted.getTitle());
            if (posted != null) {
                if (getTaggedFriends() != null) {
                    //read tagged users ID list
                    System.out.println("friends: " + getTaggedFriends());
                    String taggedIds = getTaggedFriends().replace("[", "");
                    taggedIds = taggedIds.replace("]", "");
                    String[] taggedIdArray = taggedIds.split(",");
                    System.out.println("trimmed: " + taggedIdArray.toString());

                    //Retrieve and save tagged users for this post
                    ArrayList<User> taggedUsers = new ArrayList<User>();
                    for (String uId : taggedIdArray) {

                        User taggedUser = uDAO.getShallowUser(Integer.parseInt(uId));
                        taggedUsers.add(taggedUser);

                        pDAO.addPostUserTag(new PostUserTag(
                                taggedUser,
                                pDAO.getPost(posted.getPostId()),
                                new Date()));
                    }
                    
                    //send notifications
                    ManageNotificationBean nBean = new ManageNotificationBean();
                    nBean.sendTaggedInPostNotification(posted, taggedUsers);                                        

                }
                
                //post to facebook?
                System.out.println("SHARING ON FACEBOOK: " + isShareOnFacebook());
                
                /* Flow for posting to group */
                if (isShareOnFacebook()) {
                    FacebookFunctions fb = new FacebookFunctions();
                    String facebookPostId = null;
                    //get access token from session
                    String currAccessToken = (String) getContext().getRequest().getSession().getAttribute(GlobalVars.SESSION_FB_ACCESS_TOKEN);
                    
                    //post to facebook
                    facebookPostId = fb.postToFacebookGroup(getPostContent(), //message
                            GlobalVars.APP_URL + "residents/communitywall.jsp?postid=" + posted.getPostId(), //link                            
                            currAccessToken);

                    if (facebookPostId != null) {
                        System.out.println("Post to fb successful! id: " + facebookPostId);
                        
                        //Should store facebook post id with post id here...
                        //pDAO.updatePostWithFBPostId(posted, facebookPostId);
                        
                    } else if (facebookPostId == null && currAccessToken != null){
                        //if failed to post, and accessToken appears ok, try refreshing token
                        String newToken = fb.extendFacebookAccessToken(currAccessToken);
                        
                        System.out.println("Trying fb post again with new access token...");
                        
                        //post to facebook with new token
                        facebookPostId = fb.postToFacebookGroup(getPostContent(), //message
                                GlobalVars.APP_URL + "residents/communitywall.jsp?postid=" + posted.getPostId(), //link                            
                                newToken);
                        
                        if (facebookPostId != null) {
                            System.out.println("2nd try Post to fb successful! id: " + facebookPostId);
                            
                            //Should store facebook post id with post id here...
                            //pDAO.updatePostWithFBPostId(posted, facebookPostId);
                            
                            //update session with new access token
                            getContext().getRequest().getSession().setAttribute(GlobalVars.SESSION_FB_ACCESS_TOKEN, newToken);
                        }
                    }                        
                }
                
                /* Flow for sending notifications */
                if(isShareOnFacebook()){
                    FacebookController fb = new FacebookController();
                    fb.sendFacebookNotificationsToAll("just wrote something on the Condo Community Wall! Click here to view it.", 
                            GlobalVars.APP_URL + "residents/communitywall.jsp?postid=" + posted.getPostId(), user);
                }
                
            }
                                
            fs.put("SUCCESS", "true");
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        //if -1, then go wall
        if (getWallId() == -1) {
            return new RedirectResolution("/residents/communitywall.jsp");
        } else {
            return new RedirectResolution("/residents/eventpage.jsp?eventid=" + getWallId());
        }

    }
}
