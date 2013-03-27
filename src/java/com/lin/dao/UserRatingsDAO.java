/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.User;
import com.lin.entities.UserRating;
import com.lin.utils.HibernateUtil;
import java.util.ArrayList;
import java.util.Date;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Keffeine
 */
public class UserRatingsDAO {

    Session session = null;

    public UserRatingsDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }
    
    public void addUserRating(int userId, int rating){
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            User u = (User) session.get(User.class, userId);
            UserRating ur = new UserRating(u,rating);
            session.save(ur);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
}
