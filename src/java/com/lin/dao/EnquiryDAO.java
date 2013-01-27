/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Enquiry;
import com.lin.entities.User;
import com.lin.utils.HibernateUtil;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import javax.transaction.Transaction;
import org.hibernate.CacheMode;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author fayannefoo
 */
public class EnquiryDAO {

    private static ArrayList<Enquiry> enquiryList = new ArrayList<Enquiry>(); // stores all bookings
    Session session = null;

    public EnquiryDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        
        if(session == null){
            System.out.println("Session was null, creating one");
            this.session = HibernateUtil.getSessionFactory().openSession();
        }
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    // Get all bookings made by all users
    public ArrayList<Enquiry> getAllEnquiries() {
        openSession();
        org.hibernate.Transaction tx;
        
        int id = -1;
        boolean isDel = false;
        
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery("from Enquiry as enquiry join fetch enquiry.user");
            //Query q = session.createQuery("from Booking");
            enquiryList = (ArrayList<Enquiry>) q.list();
            
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            System.out.println("Closing Session...");
            session.close();            
        
        }
        return enquiryList;
    }

    // Get bookings made by a specific user
    public ArrayList<Enquiry> getUserEnquiries(int userID) {
        ArrayList<Enquiry> userEnquiryList = new ArrayList<Enquiry>();
        try {
            ArrayList<Enquiry> tempList = getAllEnquiries();
            for (Enquiry e : tempList) {
                if (userID == e.getUser().getUserId()) {
                    userEnquiryList.add(e);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userEnquiryList;
    }

    public Enquiry getEnquiry(int id) {
        ArrayList<Enquiry> userEnquiryList = new ArrayList<Enquiry>();
        try {
            ArrayList<Enquiry> tempList = getAllEnquiries();
            for (Enquiry e : tempList) {
                if (id == e.getId()) {
                    return e;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //Add Enquiry
    // Note : In database startDate and endDate are stored as dateTime, but not sure why hibernate convert it to timestamp
    public Enquiry addEnquiry(Enquiry enquiry) {

        openSession();

        org.hibernate.Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("Enquiry", enquiry);
            tx.commit();
            return enquiry;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        // if txn fails, return null
        return null;
    }
    public Enquiry createEnquiry(User user, boolean isResolved, String title, String text) throws IllegalStateException {
        
        openSession();
        org.hibernate.Transaction tx = null;
        
        Enquiry en = new Enquiry(user, title, text,isResolved);
       
        try {
            tx = session.beginTransaction();
            session.save("Enquiry", en);
            tx.commit();

            return en;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
        return null;
    }
    
    
    

    // Delete Booking
    public boolean deleteEnquiry(int id) {
        openSession();
        org.hibernate.Transaction tx = null;
        int rowCount = 0;

        try {
            tx = session.beginTransaction();
            String hql = "delete from Enquiry where id = :id";
            Query query = session.createQuery(hql);
            query.setString("id", id + "");
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

    public Enquiry updateEnquiry(int id, String title, String text) {        
        openSession();
        org.hibernate.Transaction tx = null;
        Enquiry enquiry = null;
        try {
            tx = session.beginTransaction();
            enquiry = (Enquiry) session.get(Enquiry.class, id);

            enquiry.setTitle(title);
            enquiry.setText(text);

            session.update(enquiry);
            tx.commit();
            
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
       return enquiry;
    }


}
