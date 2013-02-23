/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Booking;
import com.lin.entities.Event;
import com.lin.entities.EventLike;
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
public class EventLikeDAO {
    Session session = null;
    
    public EventLikeDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }
    
    public EventLike createEventLike(Event event, User user){
        EventLike el = new EventLike(event,user);
        
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("EventLike", el);
            tx.commit();
            return el;
        } catch (Exception ex) {
            ex.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        //return null if failed
        return null;
    }
    
    public EventLike getEventLike(int id){
        return (EventLike)session.get(EventLike.class, id);
    }
    
    public ArrayList<EventLike> getAllEventLikes(){
        openSession();
        ArrayList<EventLike> list = new ArrayList<EventLike>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from EventLike as el join fetch e.user join fetch e.event");
            list = (ArrayList<EventLike>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean deleteEventLike(int id){
        openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            String hql = "delete from EventLike where id = :id";
            Query query = session.createQuery(hql);
            query.setString("id", id + "");
            query.executeUpdate();
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
    
    public int getEventNumberOfLikes(int eventId){
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            String hql = "select count(*) FROM EventLike el join fetch el.event where event.id = :id";
            Query query = session.createQuery(hql);
            query.setString("id", eventId + "");
            int result = (Integer)query.uniqueResult();
            tx.commit();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }
    
    public ArrayList<Event> getAllUserLikeEvent(int eventId){
        openSession();
        ArrayList<Event> list = new ArrayList<Event>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            String hql = "select count(*) FROM EventLike el join fetch el.event where event.id = :id";
            Query query = session.createQuery(hql);
            query.setString("id", eventId + "");
            list = (ArrayList<Event>) query.list();
            tx.commit();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return list;
        }
    }
    //don't need EventLike
//    public Event updateEventLike(int id, User user, Booking booking, String title, Date startTime, Date endTime, String venue, String details, boolean isPublicEvent){
//        openSession();
//        Transaction tx = null;
//        Event e = null;
//        try {
//        tx = session.beginTransaction();
//        e = (Event) session.get(Event.class, id);
//        
//        e.setUser(user);
//        e.setBooking(booking);
//        e.setTitle(title);
//        e.setStartTime(startTime);
//        e.setEndTime(endTime);
//        e.setVenue(venue);
//        e.setDetails(details);
//        e.setIsPublicEvent(isPublicEvent);
//        
//        tx.commit();
//        } catch (Exception ex) {
//            ex.printStackTrace();
//            if (tx != null) {
//                tx.rollback();
//            }
//        }
//        return e;
//    }
}
