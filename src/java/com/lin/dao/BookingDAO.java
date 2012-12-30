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
import javax.transaction.Transaction;
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
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    // Get all bookings made by all users
    public ArrayList<Booking> getAllBookings() {
        openSession();
        org.hibernate.Transaction tx;
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery("from Booking");
            allBookingList = (ArrayList<Booking>) q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return allBookingList;
    }

    // Get bookings made by a specific user
    public ArrayList<Booking> getUserBookings(int userID) {
        ArrayList<Booking> userBookingList = new ArrayList<Booking>();
        try {
            ArrayList<Booking> tempList = getAllBookings();
            for (Booking b : tempList) {
                if (userID == b.getUser().getUserId()) {
                    userBookingList.add(b);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userBookingList;
    }

    public Booking getBooking(int id) {
        ArrayList<Booking> userBookingList = new ArrayList<Booking>();
        try {
            ArrayList<Booking> tempList = getAllBookings();
            for (Booking b : tempList) {
                if (id == b.getId()) {
                    return b;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //Add bookings
    // Note : In database startDate and endDate are stored as dateTime, but not sure why hibernate convert it to timestamp
    public Booking addBooking(Booking booking) {

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

        Booking booking = (Booking) session.get(Booking.class, id);

        booking.setStartDate(startDate);
        booking.setEndDate(endDate);
 

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
                if (b.getEndDate().compareTo(new Date()) < 0) {
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
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Booking where facility_id ='" + facilityid + "'");
            currentList = (ArrayList<Booking>) q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return currentList;
    }
}
