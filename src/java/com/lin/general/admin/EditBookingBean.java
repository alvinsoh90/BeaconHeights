/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.*;
import com.lin.entities.*;
import java.sql.Timestamp;
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

    public Resolution editBooking() {
        BookingDAO dao = new BookingDAO();

        try {

            return new RedirectResolution("/admin/manage-bookings.jsp?deletesuccess=true" + "&deletemsg=");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new RedirectResolution("/admin/manage-bookings.jsp?deletesuccess=false" + "&deletemsg=");

    }

    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    @DefaultHandler
    public Resolution placeBooking() {
        /*try {
            BookingDAO bDAO = new BookingDAO();
            FacilityDAO fDAO = new FacilityDAO();
            UserDAO uDAO = new UserDAO();


            User user = uDAO.getUser();
            Facility facility = fDAO.getFacility();

            //Retrieve form variables
            Timestamp bookingTimeStamp = new Timestamp(System.currentTimeMillis());
            Timestamp startDate = new Timestamp(Long.parseLong(getStartDateString()));
            Timestamp endDate = new Timestamp(Long.parseLong(getEndDateString()));

            String title = "Resident Booking";

            //Create new booking
            Booking booking = new Booking(user, facility, bookingTimeStamp,
                    startDate, endDate, title);
            //add booking into DB, returns booking with ID
            booking = bDAO.addBooking(booking);

            result = booking.toString();
            success = true;
            System.out.println(result);

        } catch (Exception e) {
            result = "";
            success = false;
            e.printStackTrace();
        }*/

        return new RedirectResolution("/residents/index.jsp");
    }
}
