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

    public boolean isFriend(String userString, String friendString) {
        FriendshipController friendshipController = new FriendshipController();
        FriendshipDAO fDAO = new FriendshipDAO();
        int userParseID = Integer.parseInt(userString);
        int friendParseID = Integer.parseInt(friendString);
        UserDAO uDAO = new UserDAO();
        User user = uDAO.getUser(userParseID);
        User friend = uDAO.getUser(friendParseID);

        if (friendshipController.isFriend(user, friend)) {
            return true;
        } else {
            return false;
        }
    }

    
    public boolean isPending(String userString, String friendString){
        FriendshipController friendshipController = new FriendshipController();
        FriendshipDAO fDAO = new FriendshipDAO();
        int userParseID = Integer.parseInt(userString);
        int friendParseID = Integer.parseInt(friendString);
        UserDAO uDAO = new UserDAO();
        User user = uDAO.getUser(userParseID);
        User friend = uDAO.getUser(friendParseID);

        if (friendshipController.isPending(user, friend)) {
            return true;
        } else {
            return false;
        }
    }
    
    
    public boolean isPendingRequester(String userString, String friendString){
        FriendshipController friendshipController = new FriendshipController();
        FriendshipDAO fDAO = new FriendshipDAO();
        int userParseID = Integer.parseInt(userString);
        int friendParseID = Integer.parseInt(friendString);
        UserDAO uDAO = new UserDAO();
        User user = uDAO.getUser(userParseID);
        User friend = uDAO.getUser(friendParseID);

        if (friendshipController.isPendingRequest(user, friend)) {
            return true;
        } else {
            return false;
        }
    }
    
    public boolean isPendingReceiver(String userString, String friendString){
        FriendshipController friendshipController = new FriendshipController();
        FriendshipDAO fDAO = new FriendshipDAO();
        int userParseID = Integer.parseInt(userString);
        int friendParseID = Integer.parseInt(friendString);
        UserDAO uDAO = new UserDAO();
        User user = uDAO.getUser(userParseID);
        User friend = uDAO.getUser(friendParseID);

        if (friendshipController.isPendingAccept(user, friend)) {
            return true;
        } else {
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
            FriendshipDAO fDAO = new FriendshipDAO();
            Friendship friendship = fDAO.getFriendship(friendId, userId);

            //to accept
            if (friendship != null) {
                friendshipController.acceptFriend(friend, user);
            } else {
                friendship = fDAO.getFriendship(userId, friendId);
                if (friendship == null){
                    friendshipController.addFriend(user, friend, "Friend");
                }else {
                    fDAO.deleteFriendship(user, friend);
                }
            }
            result = "Friendship";
            success = true;
        } catch (Exception e) {
            result = "fail";
            success = false;
        }
        return new RedirectResolution("/residents/profile.jsp?profileid=" + friendId + "&createsuccess=" + success
                + "&createmsg=" + result);



    }
}
