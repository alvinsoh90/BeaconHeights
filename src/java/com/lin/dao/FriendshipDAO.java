/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Friendship;
import com.lin.entities.User;
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
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Keffeine
 */
public class FriendshipDAO {

    ArrayList<Friendship> friendshipList = null;
    Session session = null;

    public FriendshipDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public Friendship createFriendship(User userOne, User userTwo, String relationshipOneTwo, String relationshipTwoOne) {
        Friendship friendship = new Friendship(userOne, userTwo, new Date(), relationshipOneTwo, relationshipTwoOne,false);

        openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("Friendship", friendship);
            tx.commit();
            return friendship;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return null;
    }

    public boolean deleteFriendship(User userOne, User userTwo) {
        openSession();
        Transaction tx = null;
        int rowCount = 0;
        
        int userIdOne = userOne.getUserId();
        int userIdTwo = userTwo.getUserId();

        try {
            tx = session.beginTransaction();
            String hql = "delete from Friendship where user_id_one = :idone and user_id_two = :idtwo";
            Query query = session.createQuery(hql);
            query.setString("idone", userIdOne + "");
            query.setString("idtwo", userIdTwo + "");
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

    public Friendship getFriendship(User userOne, User userTwo) {
        openSession();
        
        int userIdOne = userOne.getUserId();
        int userIdTwo = userTwo.getUserId();
        Friendship friendship=null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            friendship = (Friendship)session.createQuery("from Friendship where user_id_one = :idOne and user_id_two = :idTwo").setString("idOne", userIdOne + "").setString("idTwo", userIdTwo + "").uniqueResult();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return friendship;
    }
    
    public Friendship getFriendship(int userOne, int userTwo) {
        openSession();
             
        Friendship friendship=null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            friendship = (Friendship)session.createQuery("from Friendship where user_id_one = :idOne and user_id_two = :idTwo").setString("idOne", userOne + "").setString("idTwo", userTwo + "").uniqueResult();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return friendship;
    }
    //for acceptance
    public Friendship updateFriendship(int friendshipId, User userOne, User userTwo, boolean hasAccepted) {
        openSession();
        Transaction tx = null;
        Friendship f = null;
        try {
            tx = session.beginTransaction();
            f = (Friendship) session.get(Friendship.class, friendshipId);
            f.setUserByUserIdOne(userOne);
            f.setUserByUserIdTwo(userTwo);
            f.setHasAccepted(hasAccepted);
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return f;
    }
    
    public Friendship updateFriendship(int friendshipId, User userOne, User userTwo, String relationshipOneTwo, String relationshipTwoOne, boolean hasAccepted) {
        openSession();
        Transaction tx = null;
        Friendship f = null;
        try {
            tx = session.beginTransaction();
            f = (Friendship) session.get(Friendship.class, friendshipId);
            f.setUserByUserIdOne(userOne);
            f.setUserByUserIdTwo(userTwo);
            f.setRelationshipOneTwo(relationshipOneTwo);
            f.setRelationshipTwoOne(relationshipTwoOne);
            f.setHasAccepted(hasAccepted);
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return f;
    }
    
    public ArrayList<User> getAllFriendsByUser(int userId){
        openSession();
        ArrayList<User> friendList = new ArrayList<User>(); 
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("FROM Friendship AS f JOIN FETCH f.userByUserIdOne JOIN FETCH f.userByUserIdTwo WHERE f.userByUserIdOne = :id OR f.userByUserIdTwo = :id ORDER BY f.date DESC");
            q.setInteger("id", userId);
            
            friendList = (ArrayList<User>) q.list();            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return friendList;
    }
    
    public ArrayList<Friendship> getAllFriendsOfUserBySimilarName(int userId, String name){
        openSession();
        ArrayList<Friendship> friendList = new ArrayList<Friendship>(); 
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("FROM Friendship AS f "
                    + "JOIN FETCH f.userByUserIdOne "
                    + "JOIN FETCH f.userByUserIdTwo "
                    + "WHERE f.userByUserIdOne = :id "
                    + "AND CONCAT(f.userByUserIdTwo.firstname,' ',f.userByUserIdTwo.lastname) LIKE :name "
                    + "ORDER BY f.date DESC");
            q.setInteger("id", userId);
            q.setString("name", "%"+name+"%");
            
            
            friendList = (ArrayList<Friendship>) q.list();
            
            /** Uncomment when we need to iterate twice through **/
//            Query q2 = session.createQuery("FROM Friendship AS f JOIN FETCH f.userByUserIdOne JOIN FETCH f.userByUserIdTwo WHERE f.userByUserIdTwo = :id AND f.userByUserIdOne.userName LIKE :name ORDER BY f.date DESC");
//            q2.setInteger("id", userId);
//            q2.setString("name", "%"+name+"%");
//            
//            friendList.addAll(q2.list());
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return friendList;
    }
    
}
