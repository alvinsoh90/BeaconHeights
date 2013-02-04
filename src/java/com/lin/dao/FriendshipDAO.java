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
        Friendship friendship = new Friendship(userOne, userTwo, new Date(), relationshipOneTwo, relationshipTwoOne);

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
        
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Friendship where userIdOne = :idOne and userIdTwo = :idTwo");
            q.setString("idOne", userIdOne + "");
            q.setString("idTwo", userIdTwo + "");
            friendshipList = (ArrayList<Friendship>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return friendshipList.get(0);
    }

    public Friendship updateFriendship(int friendshipId, User userOne, User userTwo, String relationshipOneTwo, String relationshipTwoOne) {
        openSession();
        Transaction tx = null;
        Friendship f = null;
        try {
            tx = session.beginTransaction();
            f = (Friendship) session.get(User.class, friendshipId);
            f.setUserByUserIdOne(userOne);
            f.setUserByUserIdTwo(userTwo);
            f.setRelationshipOneTwo(relationshipOneTwo);
            f.setRelationshipTwoOne(relationshipTwoOne);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return f;
    }
}
