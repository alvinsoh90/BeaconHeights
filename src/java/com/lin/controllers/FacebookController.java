/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.controllers;

import com.lin.dao.UserDAO;
import com.lin.entities.User;
import com.lin.utils.FacebookFunctions;
import java.util.ArrayList;

/**
 *
 * @author Yangsta
 */
public class FacebookController {
    
    UserDAO uDAO = new UserDAO();
    FacebookFunctions fbFunctions = new FacebookFunctions();
    
    public void sendFacebookNotificationsToAll(String message, String link, User sender){
        
        //get access token once
        String currAccessToken = fbFunctions.getApplicationAccessToken();
        
        //loop through all fb users and send notfications to them
        for(User u : uDAO.retrieveAllFacebookConnectedUsers()){
            fbFunctions.postToUserNotifications(
                    currAccessToken,
                    u.getFacebookId(),    
                      message   
                    , link
                    , sender.getFacebookId()
           );
        }
        
       
    }
    
}
