/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.controllers;

import com.lin.dao.FriendshipDAO;
import com.lin.entities.Friendship;
import com.lin.entities.User;

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
    
    
    
}
