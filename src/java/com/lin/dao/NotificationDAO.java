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
public class NotificationDAO {

    Session session = null;

    public NotificationDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }
    
    public Notification createNotification(Notification n) {
        openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("Notification", n);
            tx.commit();
            return n;
        } catch (Exception ex) {
            ex.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        //return null if failed
        return null;
    }

    public Notification getNotification(int id) {        
        openSession();
        Event ev = null;
        Notification n = new Notification();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Notification as n where n.id = :id");
            q.setInteger("id",id);
            n = (Notification) q.uniqueResult();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return n;
    }

    public ArrayList<Notification> getAllNotifications() {
        openSession();
        ArrayList<Notification> list = new ArrayList<Notification>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Notification as n join fetch n.event join fetch n.userBySenderId join fetch n.post join fetch n.userByReceiverId order by n.id DESC");
            list = (ArrayList<Notification>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public ArrayList<Notification> getAllNotificationsLazy() {
        openSession();
        ArrayList<Notification> list = new ArrayList<Notification>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Notification order by id DESC");
            list = (ArrayList<Notification>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    
    public ArrayList<Notification> retrieveNotificationByReceivingUserId(int user_id) {
        openSession();
        ArrayList<Notification> list = new ArrayList<Notification>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Notification as n where n.userByReceiverId.id = :id");
            q.setString("id", user_id + "");
            list = (ArrayList<Notification>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteNotification(int id) {
        openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            String hql = "delete from Notification where id = :id";
            Query query = session.createQuery(hql);
            query.setString("id", id + "");
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

    public boolean markAsRead(int id){
        openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            Notification n = (Notification)session.get(Notification.class, id);
            n.setHasBeenViewed(true);
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
    
    public boolean markAsAttending(int id){
        openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Notification n = (Notification)session.get(Notification.class, id);
            Query q = session.createQuery("from EventInvite as e where e.event.id = :eid and e.user.userId = :uid");
            q.setString("eid", ""+n.getEvent().getId());
            q.setString("uid", ""+n.getUserByReceiverId().getUserId());
            EventInvite ei = (EventInvite) q.uniqueResult();
            ei.setInviteStatus(ei.getTypeStringFromEnum(EventInvite.Type.ACCEPTED));
            
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
    
    public boolean markAsRejected(int id){
        openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Notification n = (Notification)session.get(Notification.class, id);
            Query q = session.createQuery("from EventInvite as e where e.event.id = :eid and e.user.userId = :uid");
            q.setString("eid", ""+n.getEvent().getId());
            q.setString("uid", ""+n.getUserByReceiverId().getUserId());
            EventInvite ei = (EventInvite) q.uniqueResult();
            ei.setInviteStatus(ei.getTypeStringFromEnum(EventInvite.Type.REJECTED));
            
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
}
