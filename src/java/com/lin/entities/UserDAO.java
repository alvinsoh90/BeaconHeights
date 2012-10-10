/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.entities;

import java.util.HashMap;

/**
 *
 * @author Keffeine
 */
public class UserDAO {

    private static HashMap<String,User> userMap = new HashMap<String,User>();

    public static HashMap<String,User> retrieveAllUsers() {
        return userMap;
    }

    public User createUser(int id, String username, String password, String first_name,
            String last_name, Block block, int level, int unit, Role role) {

        User user = new User(id, username, password, first_name, last_name, block, level, unit, role);

        //add to temporary hashmap
        userMap.put(username, user);

        //line that says u put into Objectify
        return user;

    }

    public User deleteUser(String username) {
        
        User user = userMap.remove(username);


        //line that says u put into Objectify
        return user;

    }
    
    public User updateUser(int id, String username, String password, String first_name,
            String last_name, Block block, int level, int unit, Role role){
        User user = new User(id, username, password, first_name, last_name, block, level, unit, role);
        userMap.put(username, user);
        
        //update user where id = id
        
        return user;
    }
    
    public User getUser(String username){
        return userMap.get(username);
    }
    
}
