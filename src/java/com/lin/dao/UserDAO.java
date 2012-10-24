/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Block;
import com.lin.entities.Role;
import com.lin.entities.User;
import com.lin.entities.UserTemp;
import com.lin.utils.HttpHandler;
import com.lin.global.ApiUriList;
import com.lin.utils.BCrypt;
import com.lin.utils.HibernateUtil;
import com.lin.utils.json.JSONException;
import com.lin.utils.json.JSONObject;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Keffeine
 */
public class UserDAO {
    
    ArrayList<User> userList = null;
    ArrayList<UserTemp> userTempList = null;
    
    Session session = null;
    public UserDAO(){
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public ArrayList<User> retrieveAllUsers() {
       
       try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery ("from User");
            userList = (ArrayList<User>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
       
      return userList;
    }
    
    public ArrayList<UserTemp> retrieveAllTempUsers() {
       
       try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery ("from UserTemp");
            userTempList = (ArrayList<UserTemp>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
       System.out.println("TEMPUSER:"+userTempList.get(0));
      return userTempList;
    }    
    
    //Method checks DB if username exists.
    public Boolean doesUserExist(String username){
        
        //retieve all users first
        retrieveAllUsers();
        
        //check if user exists
        for(User u : userList){
            if(u.getUserName().equals(username)){
                return true;
            }
        }
        return false;
    }
    
    //Method adds a temp user in user_temp awaiting approval.
    public UserTemp addTempUser(String username, String password, String 
            firstname, String lastname, String block, int level, int unitnumber) {
        String salt = BCrypt.gensalt();
        String passwordHash = BCrypt.hashpw(password, salt);
        
        RoleDAO rDao = new RoleDAO();
        BlockDAO bDao = new BlockDAO();
        Role defaultRole = rDao.getRoleByName("User");  //default is User role
        Block blockObj = bDao.getBlockByName(block);
        Date date = new Date(); //temporary
        
        UserTemp temp = new UserTemp(defaultRole,blockObj,passwordHash,
                username,firstname,lastname,date,level,unitnumber);
        
        Transaction tx = null;
        try {
             tx = session.beginTransaction();
            session.save("UserTemp",temp);
            tx.commit();
            return temp;
            
        } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null) tx.rollback();
        }
        //return null if failed
        return null;
    }
    
    

    public User createUser(Role role, Block block, String password, String userName, String firstname, String lastname, Date dob, Integer level, Integer unit) {
        User user = new User(role, block, password, userName, firstname, lastname, dob, level, unit);
        
        Transaction tx = null;
        try {
             tx = session.beginTransaction();
            session.save("User",user);
            tx.commit();
            System.out.println("added new user: " + user);
            return user;
        } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null) tx.rollback();
        }
        //return null if failed
        return null;
    }

    public boolean deleteUser(int userId) {
        Transaction tx = null;
        int rowCount =0;
        
        try {
            tx = session.beginTransaction();
            String hql = "delete from User where userId = :id";
            Query query = session.createQuery(hql);
            query.setString("id",userId+"");
            rowCount = query.executeUpdate();
            tx.commit();
            } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null) tx.rollback();
        }
            System.out.println("Rows affected: " + rowCount);
            if(rowCount>0){
                return true;
            }else{
                return false;
            }
    }
    
    public User updateUser(Role role, Block block, String password, String userName, String firstname, String lastname, Date dob, Integer level, Integer unit) {
        User user = new User(role, block, password, userName, firstname, lastname, dob, level, unit);

        session.update(user);

        return user;
    }
    
    public User getUser(String username){   
        retrieveAllUsers();
        
        for(User u : userList){
            if(u.getUserName().equals(username)){
                return u;
            }
        }
        return null;
    }
    
}
