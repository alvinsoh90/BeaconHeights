/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Block;
import com.lin.entities.Event;
import com.lin.entities.Role;
import com.lin.entities.User;
import com.lin.entities.UserTemp;
import com.lin.utils.HttpHandler;
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

    public UserDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public String getUserHash(String username) {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from User where userName = :username");
            q.setString("username", username);
            userList = (ArrayList<User>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        //System.out.println("TEMPUSER:"+userTempList.get(0));
        return userList.get(0).getPassword();
    }

    public ArrayList<User> retrieveAllUsers() {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from User as u join fetch u.role join fetch u.block");
            userList = (ArrayList<User>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return userList;
    }
    
    public ArrayList<User> retrieveAllFacebookConnectedUsers() {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from User as u where u.facebookId IS NOT NULL");
            userList = (ArrayList<User>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return userList;
    }
    
    public ArrayList<User> retrieveAllShallowUsersExceptCurrentUser(int currentUserId){
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from User as u where u.userId <> :uid");
            q.setInteger("uid", currentUserId);
            userList = (ArrayList<User>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return userList;
    }

    public ArrayList<UserTemp> retrieveAllTempUsers() {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from UserTemp as u join fetch u.role join fetch u.block");
            userTempList = (ArrayList<UserTemp>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        //System.out.println("TEMPUSER:"+userTempList.get(0));
        return userTempList;
    }

    //Method checks DB if username exists.
    public Boolean doesUserExist(String username) {

        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            String hql = "from User where userName = :username";
            Query q = session.createQuery(hql);
            q.setString("username", username + "");
            userList = (ArrayList<User>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(userList.isEmpty()){
            return false;
        }else{
            return true;
        }
    }
    
    //Method checks DB if username exists.
    public Boolean doesUserExistInTemp(String username) {

        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            String hql = "from UserTemp where userName = :username";
            Query q = session.createQuery(hql);
            q.setString("username", username + "");
            userList = (ArrayList<User>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(userList.isEmpty()){
            return false;
        }else{
            return true;
        }
    }
    
    //Method checks DB if username exists.
    public Boolean doesUserEmailExist(String email) {

        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            String hql = "from User where email = :email";
            Query q = session.createQuery(hql);
            q.setString("email", email + "");
            userList = (ArrayList<User>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(userList.isEmpty()){
            return false;
        }else{
            return true;
        }
    }
    
    //Method checks DB if username exists excluding current user's username
    public Boolean doesUsernameExistsExcludingCurrentUsername(String username, String currentUsername) {
        ArrayList<User> userList = new ArrayList<User>();
        ArrayList<UserTemp> userTempList = new ArrayList<UserTemp>();
        
        if(username.equalsIgnoreCase(currentUsername)){
            return false;
        }
        
        //check if user exists
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            String hql = "from User where userName = :username";
            Query q = session.createQuery(hql);
            q.setString("username", username + "");
            userList = (ArrayList<User>) q.list();
            hql = "from UserTemp where userName = :username";
            q = session.createQuery(hql);
            q.setString("username", username + "");
            userTempList = (ArrayList<UserTemp>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(userList.isEmpty() && userTempList.isEmpty()){
            return false;
        }else{
            return true;
        }
    }
    
    public Boolean resetPwVerification(String username, String email){
        retrieveAllUsers();
        for(User u : userList){
            if(u.getUserName().equals(username) && u.getEmail().equals(email)){
                
                    return true;
                
                
                
            }
        }
        return false;
    }

    //Method adds a temp user in user_temp awaiting approval.
    public UserTemp addTempUser(String username, String password, String firstname, String lastname, String mobileno,String email, String block, int level, int unitnumber) {
        openSession();
        String salt = BCrypt.gensalt();
        String passwordHash = BCrypt.hashpw(password, salt);

        RoleDAO rDao = new RoleDAO();
        BlockDAO bDao = new BlockDAO();
        Role defaultRole = rDao.getRoleByName("User");  //default is User role
        Block blockObj = bDao.getBlockByName(block);
        Date date = new Date(); //temporary

        UserTemp temp = new UserTemp(defaultRole, blockObj, passwordHash,
                username, firstname, lastname, date,mobileno,email, level, unitnumber);

        Transaction tx = null;
        try {
            openSession();
            tx = session.beginTransaction();
            System.out.println("tempUser : " + temp);
            session.save("UserTemp", temp);
            tx.commit();
            return temp;

        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        //return null if failed
        return null;
    }

    public boolean createUser(User user) {
        openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("User", user);
            tx.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return false;
    }

    public User createUser(Role role, Block block, String password, String userName, String firstname, String lastname, Date dob,String mobileno,String email,  Integer level, Integer unit) {
        openSession();

        //String salt = BCrypt.gensalt();
        //String passwordHash = BCrypt.hashpw(password, salt);
        User user = new User(role, block, password, userName, firstname, lastname,dob,mobileno,email,level, unit);

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("User", user);
            tx.commit();
            return user;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        //return null if failed
        return null;
    }
    
    public User createUser(Role role, Block block, String password, String userName, String firstname, String lastname, Date dob,String mobileno,String email,  Integer level, Integer unit, String profilePicFilename) {
        openSession();

        //String salt = BCrypt.gensalt();
        //String passwordHash = BCrypt.hashpw(password, salt);
        User user = new User(role, block, password, userName, firstname, lastname,dob,mobileno,email,level, unit, profilePicFilename);

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("User", user);
            tx.commit();
            return user;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        //return null if failed
        return null;
    }
    
    public User createUser(Role role, Block block, String password, String userName, String firstname, String lastname, Date dob,String mobileno,String email,  Integer level, Integer unit, String vehicleNumberPlate, String vehicleType) {
        openSession();

        //String salt = BCrypt.gensalt();
        //String passwordHash = BCrypt.hashpw(password, salt);
        User user = new User(role, block, password, userName, firstname, lastname,dob,mobileno,email,level, unit, vehicleNumberPlate, vehicleType);

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("User", user);
            tx.commit();
            return user;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        //return null if failed
        return null;
    }

    public boolean deleteUser(int userId) {
        openSession();
        Transaction tx = null;
        int rowCount = 0;

        try {
            tx = session.beginTransaction();
            String hql = "delete from User where userId = :id";
            Query query = session.createQuery(hql);
            query.setString("id", userId + "");
            rowCount = query.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        System.out.println("Rows affected: " + rowCount);
        if (rowCount > 0) {
            return true;
        } else {
            return false;
        }
    }

    public User getUser(int userId) {
        openSession();
        User u = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from User as u join fetch u.role join fetch u.block where u.userId = :id");
            q.setString("id", userId + "");
            u = (User) q.uniqueResult();
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }
    
        public User getShallowUser(int userId) {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from User as u where u.userId = :id");
            q.setString("id", userId + "");
            userList = (ArrayList<User>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList.get(0);
    }

    public UserTemp getUserTemp(int userId) {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from UserTemp where userId = :id");
            q.setString("id", userId + "");
            userTempList = (ArrayList<UserTemp>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        //System.out.println("TEMPUSER:"+userTempList.get(0));
        return userTempList.get(0);
    }

    public boolean removeTempUser(int userId) {
        openSession();
        Transaction tx = null;
        int rowCount = 0;
        UserTemp userTemp = this.getUserTemp(userId);
        //System.out.println("THIS IS THE ID"+ userTemp.getUserId());
        openSession();
        try {
            tx = session.beginTransaction();
            String hql = "DELETE UserTemp uT WHERE uT.userId = :id";

            Query query = session.createQuery(hql);
            query.setString("id", userId + "");
            rowCount = query.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        System.out.println("Rows affected: " + rowCount);
        if (rowCount > 0) {
            return true;
        } else {
            return false;
        }
    }

    public User updateUser(int userId, Role role, Block block, String userName, String firstname, String lastname,String email,String mobileNo, Integer level, Integer unit) {
        openSession();
        Transaction tx = null;
        //User user = new User(userId,role, block, userName, firstname, lastname, level, unit);
        System.out.println("USER INFO : " + userId + " " + role + " " + block + " " + userName + " " + firstname + " " + lastname + " " + level + " " + unit);
        //session.update("User",user);
        User u = null;
        try {
        tx = session.beginTransaction();
        u = (User) session.get(User.class, userId);
        u.setRole(role);
        u.setBlock(block);
        u.setUserName(userName);
        u.setFirstname(firstname);
        u.setLastname(lastname);
        u.setEmail(email);
        u.setMobileNo(mobileNo);
        u.setLevel(level);
        u.setUnit(unit);
        tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        System.out.println("PRINTING CONENTS OF USER FROM DAO : "+u);
        return u;
    }
    
    public User updateUser(int userId, Role role, Block block, String userName, String firstname, String lastname,String email,String mobileNo, Integer level, Integer unit, String vehicleNumberPlate, String vehicleType) {
        openSession();
        Transaction tx = null;
        //User user = new User(userId,role, block, userName, firstname, lastname, level, unit);
        System.out.println("USER INFO : " + userId + " " + role + " " + block + " " + userName + " " + firstname + " " + lastname + " " + level + " " + unit);
        //session.update("User",user);
        User u = null;
        try {
        tx = session.beginTransaction();
        u = (User) session.get(User.class, userId);
        u.setRole(role);
        u.setBlock(block);
        u.setUserName(userName);
        u.setFirstname(firstname);
        u.setLastname(lastname);
        u.setEmail(email);
        u.setMobileNo(mobileNo);
        u.setLevel(level);
        u.setUnit(unit);
        u.setVehicleNumberPlate(vehicleNumberPlate);
        u.setVehicleType(vehicleType);
        tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        System.out.println("PRINTING CONENTS OF USER FROM DAO : "+u);
        return u;
    }
    
     public boolean updateFacebookId(User currUser, String fbId) {
         System.out.println("Setting fbId: " + fbId);
        openSession();
        Transaction tx = null;
        User u = null;
        try {
            tx = session.beginTransaction();
            u = (User) session.get(User.class, currUser.getUserId());
            u.setFacebookId(fbId);
            System.out.println("Setting done");
            tx.commit();
            return true;
            
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
        return false;
    }
    
    
        public User updateUser(int userId, Role role, Block block, String userName, String firstname, String lastname,String email,String mobileNo, Integer level, Integer unit, String facebookId, Date birthday, String studiedAt, String worksAt, String aboutMe) {
        openSession();
        Transaction tx = null;
        //User user = new User(userId,role, block, userName, firstname, lastname, level, unit);
        System.out.println("USER INFO : " + userId + " " + role + " " + block + " " + userName + " " + firstname + " " + lastname + " " + level + " " + unit);
        //session.update("User",user);
        User u = null;
        try {
            tx = session.beginTransaction();
            u = (User) session.get(User.class, userId);
            u.setRole(role);
            u.setBlock(block);
            u.setUserName(userName);
            u.setFirstname(firstname);
            u.setLastname(lastname);
            u.setEmail(email);
            u.setMobileNo(mobileNo);
            u.setLevel(level);
            u.setUnit(unit);
            u.setFacebookId(facebookId);
            u.setBirthday(birthday);
            u.setStudiedAt(studiedAt);
            u.setWorksAt(worksAt);
            u.setAboutMe(aboutMe);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return u;
    }

     public User updateUser(int userId, Role role, Block block, String userName, String firstname, String lastname,String email,String mobileNo, Integer level, Integer unit, String facebookId, Date birthday, String studiedAt, String worksAt, String aboutMe, String vehicleNumberPlate, String vehicleType) {
        openSession();
        Transaction tx = null;
        //User user = new User(userId,role, block, userName, firstname, lastname, level, unit);
        //System.out.println("USER INFO : " + userId + " " + role + " " + block + " " + userName + " " + firstname + " " + lastname + " " + level + " " + unit);
        //session.update("User",user);
        User u = null;
        try {
            tx = session.beginTransaction();
            u = (User) session.get(User.class, userId);
            u.setRole(role);
            u.setBlock(block);
            u.setUserName(userName);
            u.setFirstname(firstname);
            u.setLastname(lastname);
            u.setEmail(email);
            u.setMobileNo(mobileNo);
            u.setLevel(level);
            u.setUnit(unit);
            u.setFacebookId(facebookId);
            u.setBirthday(birthday);
            u.setStudiedAt(studiedAt);
            u.setWorksAt(worksAt);
            u.setAboutMe(aboutMe);
            u.setVehicleNumberPlate(vehicleNumberPlate);
            u.setVehicleType(vehicleType);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return u;
    }
        
    public User getUser(String username) {
        openSession();
        User result = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            result = (User) session.createQuery("from User as u join fetch u.role join fetch u.block where u.userName = :username").setString("username", username + "").uniqueResult();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("RETRIEVED USER:" + result);
        return result;
    }
    
    public User getUserByEmail(String email) {
        openSession();
        User result = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            result = (User) session.createQuery("from User as u join fetch u.role join fetch u.block where u.email = :email").setString("email", email + "").uniqueResult();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("RETRIEVED USER:" + result);
        return result;
    }

    public User uploadProfilePic(int user_id, String fileName) {
        openSession();
        Transaction tx = null;
        User u = null;
        try {
            tx = session.beginTransaction();
            u = (User) session.createQuery("from User as u join fetch u.role join fetch u.block where u.userId = :id").setString("id", user_id + "").uniqueResult();
            u.setProfilePicFilename(fileName);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return u;
    }

    public boolean changePasword(int user_id, String newpassword2) {
        openSession();
        Transaction tx = null;
        User u = null;
        String salt = BCrypt.gensalt();
        String newHash = BCrypt.hashpw(newpassword2, salt);
        try {
            tx = session.beginTransaction();
            u = (User) session.get(User.class, user_id);
            u.setPassword(newHash);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
            return false;
        }
        return true;
    }
    
    public String getUsername(int id){
        openSession();
        String result = "";
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            result = session.createQuery("select userName from User where userId = :id").setString("id", id + "").uniqueResult().toString();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("RETRIEVED USER:" + result);
        return result;
    }

    public String getFirstname(int id) {
        openSession();
        String result = "";
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            result = session.createQuery("select firstname from User where userId = :id").setString("id", id + "").uniqueResult().toString();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("RETRIEVED USER:" + result);
        return result;
    }

    public User chooseUsername(int id, String username, String newpassword) {
        openSession();
        Transaction tx = null;
        User u = null;
        String salt = BCrypt.gensalt();
        String newHash = BCrypt.hashpw(newpassword, salt);
        try {
            tx = session.beginTransaction();
            u = (User)session.createQuery("from User as u join fetch u.role where u.userId = :id").setString("id", id + "").uniqueResult();
            u.setPassword(newHash);
            u.setUserName(username);
            u.setForceChooseUsername(false);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
            return null;
        }
        return u;
        
    }

    
    public Boolean canChoose(int id) {
        openSession();
        boolean result = false;
        Transaction tx = null;
        User u = null;
        try {
            tx = session.beginTransaction();
            u = (User) session.get(User.class, id);
            result = u.isForceChooseUsername();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
            return result;
        }
        return result;
    }

    public User setNotFirstLoad(int id) {
        openSession();
        Transaction tx = null;
        User u = null;
        try {
            tx = session.beginTransaction();
            u = (User) session.get(User.class, id);
            u.setIsFirstLoad(false);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
            return null;
        }
        return u;
    }
    
    //this method will retrieve first load status and set it to false 
    //IF it is true for use everytime user logs in.
    public User checkAndSetFirstLoad(int id) {
        openSession();
        Transaction tx = null;
        User u = null;
        try {
            tx = session.beginTransaction();
            u = (User) session.get(User.class, id);
            if(u.isIsFirstLoad()){
                u.setIsFirstLoad(false);
                tx.commit();
                //System.out.println("IS FIRST LOAD SETING TO FALSE NOW");
            }else{
                tx.commit();
                //System.out.println("IS NOT FIRST LOAD");
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
            return null;
        }
        //System.out.println("RETURNING USER NOW.");
        return u;
    }
    
}
