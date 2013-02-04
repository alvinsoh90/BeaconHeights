/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.resident;

import com.lin.controllers.FriendshipController;
import com.lin.dao.UserDAO;
import com.lin.dao.EnquiryDAO;
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
