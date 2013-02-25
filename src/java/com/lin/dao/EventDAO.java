/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.*;
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

    public Event createEvent(User user, Booking booking, String title, Date startTime, Date endTime, String venue, String details, boolean isPublicEvent, boolean isAdminEvent) {
        Event e = new Event(user, booking, title, startTime, endTime, venue, details, isPublicEvent, isAdminEvent);

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
    
    public Event createEvent(Event e) {
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

    public Event getEvent(int id) {
        return (Event) session.get(Event.class, id);
    }

    public ArrayList<Event> getAllEvents() {
        openSession();
        ArrayList<Event> list = new ArrayList<Event>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Event as e join fetch e.user join fetch e.booking order by e.id DESC");
            list = (ArrayList<Event>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public ArrayList<Event> getAllEventsLazy() {
        openSession();
        ArrayList<Event> list = new ArrayList<Event>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Event order by e.id DESC");
            list = (ArrayList<Event>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public ArrayList<Event> retrieveEventsWithLimit(int limit) {
        openSession();
        ArrayList<Event> list = new ArrayList<Event>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Event as e join fetch e.user join fetch e.booking order by e.id DESC")
                    .setMaxResults(limit);
            
            list = (ArrayList<Event>) q.list();
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public ArrayList<Event> retrieveEventsWithOffset(int offsetSize, int nextChunkSize) {
        openSession();
        ArrayList<Event> list = new ArrayList<Event>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Event as e join fetch e.user join fetch e.booking order by e.id DESC");
            
            q.setFirstResult(offsetSize);
            q.setMaxResults(nextChunkSize);
            
            list = (ArrayList<Event>) q.list();
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public ArrayList<Event> retrieveEventByUserId(int user_id) {
        openSession();
        ArrayList<Event> list = new ArrayList<Event>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Event where id = :id");
            q.setString("id", user_id + "");
            list = (ArrayList<Event>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteEvent(int id) {
        openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            Event e = (Event)session.get(Event.class, id);
            e.setIsDeleted(true);
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

    public boolean updateEvent(int id, User user, Booking booking, String title, Date startTime, Date endTime, String venue, String details, boolean isPublicEvent) {
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
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return false;
    }
    
    public EventLike likeEvent(EventLike eventLike){
        openSession();
        Transaction tx = null;
        
        try {
            tx = session.beginTransaction();
            session.save("EventLike", eventLike);
            session.flush();
            
            tx.commit();
            return eventLike;
            
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return null;
    }
    
    public EventLike getEventLike(int id){        
        EventLike el = new EventLike();
        openSession();
        
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from EventLike where id = :id");
            q.setInteger("id", id);
            el = (EventLike) q.uniqueResult();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return el;
    }
    
    public boolean unlikeEvent(int userId, int eventId) {
        openSession();
        Transaction tx = null;
        int rowCount = 0;
        
        try {
            tx = session.beginTransaction();
            String hql = "delete from EventLike as el "
                    + "where el.event.eventId = :eid "
                    + "and el.user.userId = :uid";
            Query query = session.createQuery(hql);
            query.setInteger("eid", eventId);
            query.setInteger("uid", userId);
            rowCount = query.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
        if (rowCount > 0) {
            return true;
        } else {
            return false;
        }   
    }
    
    public boolean hasUserLikedEvent(int eventId, int userId){
        
        ArrayList<EventLike> eventLikeList = new ArrayList<EventLike>();
        
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from EventLike as el "
                    + "where el.event.eventId = :id "
                    + "and el.user.userId = :uid");
            q.setInteger("id", eventId);
            q.setInteger("uid", userId);
            
            eventLikeList = (ArrayList<EventLike>) q.list();
            tx.commit();
            
            return !eventLikeList.isEmpty();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    public ArrayList<EventLike> getEventLikesByEventId(int eventId) {
        openSession();
        ArrayList<EventLike> eventLikeList = new ArrayList<EventLike>();
        
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from EventLike as el "
                    + "where el.event.eventId = :id");
            
            q.setInteger("id", eventId);
            eventLikeList = (ArrayList<EventLike>) q.list();
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return eventLikeList;
    }
    
    public boolean flagEventInappropriate(EventInappropriate ei) {
        openSession();
        Transaction tx = null;
        
        try {
            tx = session.beginTransaction();
            session.save("EventInappropriate", ei);
            session.flush();
            
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
    
    public boolean unFlagEventInappropriate(int userId, int eventId) {
        openSession();
        Transaction tx = null;
        int rowCount = 0;
        
        try {
            tx = session.beginTransaction();
            String hql = "delete from EventInappropriate as e "
                    + "where e.event.eventId = :eid "
                    + "and e.user.userId = :uid";
            Query query = session.createQuery(hql);
            query.setInteger("eid", eventId);
            query.setInteger("uid", userId);
            rowCount = query.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
        if (rowCount > 0) {
            return true;
        } else {
            return false;
        }   
    }
    
    public EventInappropriate getEventInappropriate(int userId, int eventId){
        openSession();
        EventInappropriate ei = new EventInappropriate();
        
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from EventInappropriate as e "
                    + "where e.event.eventId = :eid "
                    + "and e.user.userId = :uid");
            
            q.setInteger("pid", eventId);
            q.setInteger("uid", userId);
            ei = (EventInappropriate) q.uniqueResult();
            
            tx.commit();
            return ei;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public boolean addEventInvite(EventInvite eventInvite) {
        openSession();
        Transaction tx = null;
        
        try {
            tx = session.beginTransaction();
            session.save("EventInvite", eventInvite);
            session.flush();
            
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
    
    public ArrayList<EventInvite> getEventInvitesByEventId(int eventId) {
        openSession();
        ArrayList<EventInvite> eventInviteList = new ArrayList<EventInvite>();
        
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from EventInvite as ei "
                    + "where ei.event.evenId = :id");
            
            q.setInteger("id", eventId);
            eventInviteList = (ArrayList<EventInvite>) q.list();
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return eventInviteList;
    }
}
