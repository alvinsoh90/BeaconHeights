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
    private int id;
    private String startDate;
    private String endDate;


    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    
    @DefaultHandler
    public Resolution editBooking() {
        String result;
        boolean success;
        String name = "";
        
        try{
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
            BookingDAO bDAO = new BookingDAO();
            User user = bDAO.getBooking(id).getUser();
            name = user.getFirstname() + " " + user.getLastname();
            
            //Retrieve form variables
            Timestamp bookingTimeStamp = new Timestamp(System.currentTimeMillis());
            Date start = sdf.parse(startDate);
            Date end = sdf.parse(endDate);
            
            System.out.println("THIS IS" + id);
            
            String title = "Resident Booking";

            //Create new booking
            Booking booking = bDAO.updateBooking(id, start, end);

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
