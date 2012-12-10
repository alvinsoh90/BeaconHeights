/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.utils;

import com.lin.dao.BookingDAO;
import com.lin.dao.FacilityDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.Booking;
import com.lin.entities.Facility;
import com.lin.entities.User;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author fayannefoo
 */
public class testDB {
    public static void main (String[] args){
        UserDAO userDB = new UserDAO();
        User user = userDB.getUser(52);
        System.out.println(user.toString());
        
        FacilityDAO facilityDB = new FacilityDAO();
        Facility facility = facilityDB.getFacility(2);
        System.out.println(facility.toString());
        
        Timestamp ts = new Timestamp(System.currentTimeMillis());
        BookingDAO bookingDB = new BookingDAO();
        bookingDB.addBooking(user, facility, ts, ts, ts, true, "12345");
    }
}
