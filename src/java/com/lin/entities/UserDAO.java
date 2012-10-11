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
      Role role1 = new Role(1,"admin","Admin user");
      Block block1 = new Block(1,"blockname",2,3,"Block1");

      User user1 = new User(1,"username1","password1","Jonathan","SEETOH",block1,5,12,role1);
      User user2 = new User(1,"username2","password1","Shamus","MING",block1,5,12,role1);
      userMap.put("username1",user1);
      userMap.put("username2",user2); 
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

    public boolean deleteUser(String username) {
        
        User user = userMap.remove(username);
        boolean success = true;

        //line that says u put into Objectify
        return success;

    }
    
    public User updateUser(int id, String username, String password, String first_name,
            String last_name, Block block, int level, int unit, Role role){
        User user = new User(id, username, password, first_name, last_name, block, level, unit, role);
        userMap.put(username, user);
        
        //update user where id = id
        
        return user;
    }
    
    public User getUser(String user){   
      return userMap.get(user);
    }
    
}
