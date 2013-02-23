/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Booking;
import com.lin.entities.Event;
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
public class EventDAO {
    Session session = null;
    
    public EventDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }
    
    public Event createEvent(User user, Booking booking, String title, Date startTime, Date endTime, String venue, String details, boolean isPublicEvent, boolean isAdminEvent){
        Event e = new Event(user,booking,title,startTime,endTime,venue,details,isPublicEvent,isAdminEvent);
        
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("Event", e);
            tx.commit();
            return e;
        } catch (Exception ex) {
            ex.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        //return null if failed
        return null;
    }
    
    public Event getEvent(int id){
        return (Event)session.get(Event.class, id);
    }
    
    public ArrayList<Event> getAllEvents(){
        openSession();
        ArrayList<Event> list = new ArrayList<Event>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Event as e join fetch e.user join fetch e.booking");
            list = (ArrayList<Event>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public ArrayList<Event> getAllEventsLazy(){
        openSession();
        ArrayList<Event> list = new ArrayList<Event>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Event");
            list = (ArrayList<Event>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public void deleteEvent(int id){
        openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Event e = (Event)session.get(Event.class, id);
            e.setIsDeleted(true);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
    }
    
    public Event updateEvent(int id, User user, Booking booking, String title, Date startTime, Date endTime, String venue, String details, boolean isPublicEvent){
        openSession();
        Transaction tx = null;
        Event e = null;
        try {
        tx = session.beginTransaction();
        e = (Event) session.get(Event.class, id);
        
        e.setUser(user);
        e.setBooking(booking);
        e.setTitle(title);
        e.setStartTime(startTime);
        e.setEndTime(endTime);
        e.setVenue(venue);
        e.setDetails(details);
        e.setIsPublicEvent(isPublicEvent);
        
        tx.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return e;
    }
}
