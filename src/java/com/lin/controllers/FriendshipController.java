/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.controllers;

import com.lin.dao.FriendshipDAO;
import com.lin.entities.Friendship;
import com.lin.entities.User;
import java.util.ArrayList;

/**
 *
 * @author Keffeine
 */
public class FriendshipController {
    
    private FriendshipDAO fDAO;
    
    public Friendship addFriend(User userOne, User userTwo, String relationshipOneTwo){
        fDAO = new FriendshipDAO();
        Friendship friendship = fDAO.createFriendship(userOne, userTwo, relationshipOneTwo, relationshipOneTwo);
        
        return friendship;
        
    }
    
    public boolean isFriend(User userOne, User userTwo){
        fDAO = new FriendshipDAO();
        try {
            Friendship f = fDAO.getFriendship(userOne, userTwo);
            if (f != null){
                return true;
            }
        } catch (Exception e){
            return false;
        }
        return false;
    }
    
    
    
    
}
