/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.resident;

import com.lin.controllers.CommunityWallController;
import com.lin.dao.PostDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.Post;
import com.lin.entities.User;
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
public class AddPostActionBean implements ActionBean{
    private ActionBeanContext context;
    private String postContent;
    private String postTitle;
    private int posterId;
    private String postCategory;

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
    
    @DefaultHandler
    public Resolution add() {
        
        // get flash scope instance
        FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true); 
   
        try {
            UserDAO uDAO = new UserDAO();
            PostDAO pDAO = new PostDAO();
            User user = uDAO.getUser(getPosterId());
            
            Post aPost = null;
            
            if("REQUEST".equals(getPostCategory())){
                aPost = new Post(user,getPostContent(),new Date(),getPostTitle(),Post.Type.REQUEST);
            }
            else if("INVITE".equals(getPostCategory())){
                aPost = new Post(user,getPostContent(),new Date(),getPostTitle(),Post.Type.INVITE);
            }
            else if("SHOUTOUT".equals(getPostCategory())){
                aPost = new Post(user,getPostContent(),new Date(),getPostTitle(),Post.Type.SHOUTOUT);
            }
            else if("ANNOUNCEMENT".equals(getPostCategory())){
                aPost = new Post(user,getPostContent(),new Date(),getPostTitle(),Post.Type.ANNOUNCEMENT);
            }
            else{
                System.out.println("\nINVALID POST CATEGORY\n");
                fs.put("SUCCESS","false");
            }      
            
            if(pDAO.addPost(aPost) != null){               
                fs.put("SUCCESS","true");
                
            }
            
        } catch (Exception e) {
            e.printStackTrace();            
        }
        
        return new RedirectResolution("/residents/communitywall.jsp");
        
    }

}
