/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Block;
import com.lin.entities.Role;
import com.lin.entities.User;
import com.lin.utils.HttpHandler;
import com.lin.global.ApiUriList;
import com.lin.utils.BCrypt;
import com.lin.utils.json.JSONException;
import com.lin.utils.json.JSONObject;
import java.io.IOException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Keffeine
 */
public class UserDAO {

    private static HashMap<String,User> userMap = new HashMap<String,User>();
    
    
    
    public static HashMap<String,User> retrieveAllUsers() {
      Role role1 = new Role(1,"admin","Admin user");
      Block block1 = new Block(1,"blockname",2,3,"Block1");

      User user1 = new User(Long.parseLong("1"),"username1","password1","Jonathan","SEETOH",block1,5,12,role1);
      User user2 = new User(Long.parseLong("2"),"username2","password1","Shamus","MING",block1,5,12,role1);
      userMap.put("username1",user1);
      userMap.put("username2",user2); 
      return userMap;
    }
    
    //Method checks DB if username exists.
    public static Boolean doesUserExist(String username){
        String URL = ApiUriList.getDoesUserExistURI(username);
        boolean userExists;
        String res = null;
        try {
            res = HttpHandler.httpGet(URL);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        if(!res.equals("")){    // TODO: Change response to something like 'true' or 'false'
            userExists=true;
        }else{
            userExists=false;
        }
        return userExists;
        
    }
    
    //Method adds a temp user in user_temp awaiting approval.
    public static void addTempUser(String username, String password, String 
            firstname, String lastname, String block, String level, String unitnumber) {
        String salt = BCrypt.gensalt();
        String URL = ApiUriList.getAddTempUserURI(username,BCrypt.hashpw(password, salt),
                firstname,lastname,block,level,unitnumber);
        try {
            HttpHandler.httpGet(URL);
        } catch (IOException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public User createUser(String username, String password, String first_name,
            String last_name, Block block, int level, int unit, Role role) {

        User user = new User(username, password, first_name, last_name, block, 
                level, unit, role);

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
    
    public User updateUser(long id, String username, String password, String first_name,
            String last_name, Block block, int level, int unit, Role role){
        User user = new User(username, password, first_name, last_name, block, 
                level, unit, role);
        userMap.put(username, user);
        
        //update user where id = id
        
        return user;
    }
    
    public User getUser(String user){   
      return userMap.get(user);
    }
    
}
