/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.resident;

import com.lin.controllers.FriendshipController;
import com.lin.dao.UserDAO;
import com.lin.dao.EnquiryDAO;
import com.lin.dao.FriendshipDAO;
import com.lin.entities.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.util.Log;
import javax.persistence.*;
import net.sourceforge.stripes.action.*;
import org.apache.commons.lang3.StringEscapeUtils;

/**
 *
 * @author jonathanseetoh
 */
public class AddFriendActionBean implements ActionBean {

    private ActionBeanContext context;
    private int userId;
    private int friendId;
    private String relationshipOneTwo;
    private String relationshipTwoOne;

    public int getFriendId() {
        return friendId;
    }

    public void setFriendId(int friendId) {
        this.friendId = friendId;
    }

    public String getRelationshipOneTwo() {
        return relationshipOneTwo;
    }

    public void setRelationshipOneTwo(String relationshipOneTwo) {
        this.relationshipOneTwo = relationshipOneTwo;
    }

    public String getRelationshipTwoOne() {
        return relationshipTwoOne;
    }

    public void setRelationshipTwoOne(String relationshipTwoOne) {
        this.relationshipTwoOne = relationshipTwoOne;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public boolean isFriend(String user, String friend){
        FriendshipDAO fDAO = new FriendshipDAO();
        int userID = Integer.parseInt(user);
        int friendID = Integer.parseInt(friend);
        //User userObj = uDAO.getUser(Integer.parseInt(user));
        //User friendObj = uDAO.getUser(Integer.parseInt(friend));
        System.out.println("USER :"+user + "FRIEND : "+friend);
        Friendship friendship1 = fDAO.getFriendship(userID, friendID);
        System.out.println("FRIEND1 : "+friendship1);
        Friendship friendship2 = fDAO.getFriendship(friendID, userID);
        System.out.println("FRIEND2 : "+friendship2);
        if(friendship1!=null || friendship2!=null){
            return true;
        }else{
            return false;
        }
    }

    @Override
    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    @Override
    public ActionBeanContext getContext() {
        return context;
    }

    @DefaultHandler
    public Resolution add() {
        String result;
        boolean success;
        FriendshipController friendshipController = new FriendshipController();


        try {
            UserDAO uDAO = new UserDAO();
            User user = uDAO.getUser(userId);
            User friend = uDAO.getUser(friendId);
            friendshipController.addFriend(user, friend, "Friend");
            result = "Friendship";
            success = true;
        } catch (Exception e) {
            result = "fail";
            success = false;
        }
        return new RedirectResolution("/residents/profile.jsp?profileid="+friendId+"&createsuccess=" + success
                + "&createmsg=" + result);



    }
}
