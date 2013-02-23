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
    
    public EventComment createEventComment(Event event, User user, String text, Date commentDate, boolean isDeleted){
        EventComment ec = new EventComment( event, user, text, commentDate, isDeleted);
        
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
    
    public EventComment getEvent(int id){
        return (EventComment)session.get(EventComment.class, id);
    }
    
    public ArrayList<EventComment> getAllEvents(){
        openSession();
        ArrayList<EventComment> list = new ArrayList<EventComment>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from EventComment as ec join fetch ec.user join fetch ec.event");
            list = (ArrayList<EventComment>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public ArrayList<EventComment> getAllEventCommentsLazy(){
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
    
    public boolean deleteEventComment(int id){
        openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            EventComment ec = (EventComment)session.get(EventComment.class, id);
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
    //don't think need to update comments right?
//    public Event updateEventComment(Event event, User user, String text, Date commentDate){

//    }
}
