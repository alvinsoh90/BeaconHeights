/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.*;
import com.lin.entities.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;

/**
 *
 * @author Yangsta
 */
public class EditBookingBean implements ActionBean {

    private ActionBeanContext context;
    private int displayid;
    private Integer startDateTime;
    private Integer endDateTime;


    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public int getDisplayid() {
        return displayid;
    }

    public void setDisplayid(int displayid) {
        this.displayid = displayid;
    }

    

 

    public Integer getEndDateTime() {
        return endDateTime;
    }

    public void setEndDateTime(Integer endDateTime) {
        this.endDateTime = endDateTime;
    }

    public Integer getStartDateTime() {
        return startDateTime;
    }

    public void setStartDateTime(Integer startDateTime) {
        this.startDateTime = startDateTime;
    }

   

    
    @DefaultHandler
    public Resolution editBooking() {
        String result;
        boolean success;
        String name = "";
        
        try{
            BookingDAO bDAO = new BookingDAO();
            System.out.println("Looking for booking [bean]..."  + displayid);
            System.out.println("Display Start Time: " + startDateTime);
            Booking k = bDAO.getBooking(displayid);
            User user = k.getUser();
            name = user.getFirstname() + " " + user.getLastname();
            
            //Retrieve form variables
            Date start = new Date(startDateTime);
            Date end = new Date(endDateTime);
            
            System.out.println("THIS IS" + displayid);
            
            //Create new booking
            Booking booking = bDAO.updateBooking(displayid, start, end);

            result = booking.toString();
            success = true;
            System.out.println(result);

        } catch (Exception e) {
            result = "";
            success = false;
            e.printStackTrace();
        }

        return new RedirectResolution("/admin/manage-bookings.jsp?editsuccess=" + success + "&editmsg="+name + "\'s booking");
    }
}
