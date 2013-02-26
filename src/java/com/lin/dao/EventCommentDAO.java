/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Booking;
import com.lin.entities.Event;
import com.lin.entities.EventComment;
import com.lin.entities.User;
import com.lin.utils.HibernateUtil;
import java.util.ArrayList;
import java.util.Date;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Shamus
 */
public class EventCommentDAO {

    Session session = null;

    public EventCommentDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public EventComment createEventComment(EventComment ec) {
        openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("EventComment", ec);
            tx.commit();
            return ec;
        } catch (Exception ex) {
            ex.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        //return null if failed
        return null;
    }

    public EventComment getEventComment(int id) {
        return (EventComment) session.get(EventComment.class, id);
    }

    public ArrayList<EventComment> getAllCommentsForEvent(int eventId) {
        openSession();
        ArrayList<EventComment> list = new ArrayList<EventComment>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from EventComment as ec join fetch "
                    + "ec.user join fetch ec.event where ec.event.id = :id "
                    + "order by ec.commentId DESC");
            q.setString("id", eventId + "");
            list = (ArrayList<EventComment>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public ArrayList<EventComment> getAllEventCommentsLazy() {
        openSession();
        ArrayList<EventComment> list = new ArrayList<EventComment>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from EventComment");
            list = (ArrayList<EventComment>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public ArrayList<EventComment> retrieveCommentsForPost(int eId) {
        openSession();
        ArrayList<EventComment> commentList = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from EventComment as c join fetch c.user where c.event.id = :id");
            q.setInteger("id", eId);
            
            commentList = (ArrayList<EventComment>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return commentList;
    }
    

    public boolean deleteEventComment(int id) {
        openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            EventComment ec = (EventComment) session.get(EventComment.class, id);
            ec.setIsDeleted(true);
            tx.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
            return false;
        }
    }
    
    public ArrayList<EventComment> retrieveCommentsForEvent(int eventId) {
        openSession();
        ArrayList<EventComment> commentList = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from EventComment as c join fetch c.user where c.event.id = :id");
            q.setInteger("id", eventId);
            
            commentList = (ArrayList<EventComment>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return commentList;
    }
    
    //don't think need to update comments right?
//    public Event updateEventComment(Event event, User user, String text, Date commentDate){
//    }
}
