/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Booking;
import com.lin.entities.Facility;
import com.lin.entities.User;
import com.lin.utils.HibernateUtil;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import org.hibernate.Transaction;
import org.hibernate.CacheMode;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author fayannefoo
 */
public class BookingDAO {

    private static ArrayList<Booking> allBookingList = new ArrayList<Booking>(); // stores all bookings
    Session session = null;

    public BookingDAO() {
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
    public ArrayList<Booking> getAllBookings() {
        openSession();
        org.hibernate.Transaction tx;
        
        int id = -1;
        boolean isDel = false;
        
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery("from Booking as booking join fetch booking.facility join fetch booking.facility.facilityType join fetch booking.user");
            //Query q = session.createQuery("from Booking");
            allBookingList = (ArrayList<Booking>) q.list();
            
            Booking b = (Booking)q.list().get(0);
            id = b.getId();
            isDel = b.getIsDeleted();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            System.out.println("Closing Session...");
            session.close();            
            if(id != -1){
                System.out.println("Forcing refresh...");
                forceRefresh(id,isDel);
            }
        }
        return allBookingList;
    }

    // Get bookings made by a specific user
    public ArrayList<Booking> getUserBookings(int userID) {
         openSession();
        
        ArrayList<Booking> result = new ArrayList<Booking>();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery("from Booking as booking join fetch booking.facility join fetch booking.facility.facilityType join fetch booking.user where booking.user.userId = :uId");
            q.setInteger("uId", userID);
            result = (ArrayList<Booking>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null){
                tx.rollback();
            }
        }
        return result;
    }
    
    public ArrayList<Booking> getUnitBookings(int block, int level, int unit) {
         openSession();
        
        ArrayList<Booking> result = new ArrayList<Booking>();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery("from Booking as booking join fetch booking.facility join fetch booking.facility.facilityType join fetch booking.user where booking.user.blockId = :bId and booking.user.unit = :unit and booking.user.level = :level");
            q.setInteger("bId", block);
            q.setInteger("unit", unit);
            q.setInteger("level", level);
            result = (ArrayList<Booking>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null){
                tx.rollback();
            }
        }
        return result;
    }
    
    
    
    public ArrayList<Booking> getShallowUserBookings(int userID) {
         openSession();
        
        ArrayList<Booking> result = new ArrayList<Booking>();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery("from Booking as booking join fetch booking.facility where booking.user.userId = :uId");
            q.setInteger("uId", userID);
            result = (ArrayList<Booking>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null){
                tx.rollback();
            }
        }
        return result;
    }

    public Booking getBooking(int id) {
        openSession();
        System.out.println("Looking for booking..."  + id);
        ArrayList<Booking> result = new ArrayList<Booking>();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery("from Booking as b join fetch b.user where b.id = :bId");
            q.setInteger("bId", id);
            result = (ArrayList<Booking>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null){
                tx.rollback();
            }
        }
        return result.get(0);
    }
    
    public Booking getFullDataBooking(int id){
        openSession();
        System.out.println("Looking for booking..."  + id);
        ArrayList<Booking> result = new ArrayList<Booking>();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery("from Booking as b join fetch b.user join fetch b.facility where b.id = :bId");
            q.setInteger("bId", id);
            result = (ArrayList<Booking>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null){
                tx.rollback();
            }
        }
        return result.get(0);
    }

    //Add bookings
    // Note : In database startDate and endDate are stored as dateTime, but not sure why hibernate convert it to timestamp
    public Booking addBooking(Booking booking) {
        System.out.println("I'm CALLED AT ADDBOOKING!");
        openSession();

        org.hibernate.Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("Booking", booking);
            tx.commit();
            return booking;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        // if txn fails, return null
        return null;
    }

    // Delete Booking
    public boolean deleteBooking(int bookingID) {
        openSession();
        org.hibernate.Transaction tx = null;
        int rowCount = 0;

        try {
            tx = session.beginTransaction();
            String hql = "delete from Booking where id = :id";
            Query query = session.createQuery(hql);
            query.setString("id", bookingID + "");
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

    public Booking updateBooking(int id, Date startDate, Date endDate) {        
        openSession();
        org.hibernate.Transaction tx = null;
        Booking booking = null;
        try {
            tx = session.beginTransaction();
            booking = (Booking) session.get(Booking.class, id);

            booking.setStartDate(startDate);
            booking.setEndDate(endDate);
            
            session.update(booking);
            tx.commit();
            System.out.println("UPDATE COMPLETE");
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
       return booking;
    }

    public void updateBookingPayment(int id, boolean b, String string) {
        openSession();
        org.hibernate.Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Booking booking = (Booking) session.get(Booking.class, id);

            booking.setIsPaid(b);
            booking.setTransactionId(string);

            session.update(booking);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
    }

    public ArrayList<Booking> getUserHistoricalBookings(User u) {
        int userID = u.getUserId();
        ArrayList<Booking> histList = new ArrayList<Booking>();
        try {
            ArrayList<Booking> temp = getUserBookings(userID);
            for (Booking b : temp) {
                if (b.getEndDate().compareTo(new Date()) < 0 && !b.getIsDeleted()) {
                    histList.add(b);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return histList;
    }

    public ArrayList<Booking> getUserCurrentBookings(User u) {
        int userID = u.getUserId();
        ArrayList<Booking> currentList = new ArrayList<Booking>();
        try {
            ArrayList<Booking> temp = getUserBookings(userID);
            for (Booking b : temp) {
                if (b.getEndDate().compareTo(new Date()) > 0) {
                    currentList.add(b);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return currentList;
    }

    public ArrayList<Booking> getAllBookingsByFacilityID(int facilityid) {
        ArrayList<Booking> currentList = new ArrayList<Booking>();
        int id = -1;
        boolean isDel = false;
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Booking as booking join fetch booking.facility join fetch booking.facility.facilityType where facility_id ='" + facilityid + "'");
            currentList = (ArrayList<Booking>) q.list();
            
            Booking b = (Booking)q.list().get(0);
            id = b.getId();
            isDel = b.getIsDeleted();
    
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            System.out.println("Closing Session...");
            session.close();   
            if(id != -1){
                System.out.println("Forcing refresh...");
                forceRefresh(id,isDel);
            }
        }


        return currentList;
    }
    
    public void forceRefresh(int bookingID, boolean isDeleted){
        openSession();
        org.hibernate.Transaction tx = null;
        int rowCount = 0;

        try {            
            tx = session.beginTransaction();
            Booking booking = (Booking) session.get(Booking.class, bookingID);

            booking.setIsDeleted(isDeleted);

            session.update(booking);
            tx.commit();
            
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
    }

    public void switchToDelete(int id) {
        openSession();
        org.hibernate.Transaction tx = null;
        int rowCount = 0;

        try {            
            tx = session.beginTransaction();
            Booking booking = (Booking) session.get(Booking.class, id);

            booking.setIsDeleted(true);

            session.update(booking);
            tx.commit();
            
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
    }
    
    public ArrayList<Booking> getBookingByDateAndFacility(Date start, Facility facility){
        ArrayList<Booking> list = new ArrayList<Booking>();
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Booking b where b.facility = :facility and b.startDate <= :start and b.endDate >= :start");
            q.setParameter("facility",facility);
            q.setParameter("start",start);
            list = (ArrayList<Booking>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public ArrayList<Booking> getBookingByPeriod (Date start, Date end, Facility facility){
        ArrayList<Booking> list = new ArrayList<Booking>();
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Booking b where b.facility = :facility "
                    + "and ((b.startDate <= :start and b.endDate > :start) "
                    + "or (b.startDate  < :end and b.endDate >=:end) "
                    + "or (:start <= b.startDate and :end > b.startDate) "
                    + "or (:start < b.endDate and :end >= b.endDate)) and b.isDeleted is false");
            q.setParameter("facility",facility);
            q.setParameter("start",start);
            q.setParameter("end", end);
            list = (ArrayList<Booking>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
}
