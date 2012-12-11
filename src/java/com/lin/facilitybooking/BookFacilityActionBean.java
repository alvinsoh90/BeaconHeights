/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.facilitybooking;

import com.lin.dao.BookingDAO;
import com.lin.dao.FacilityDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.*;

import java.sql.Timestamp;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.RedirectResolution;
/**
 *
 * @author Yangsta
 */
public class BookFacilityActionBean implements ActionBean{
    
    private ActionBeanContext context;
    private String startdatestring;
    private String enddatestring;
    private String facilityID;
    private String title;
    private String result;
    private boolean success;

    public ActionBeanContext getContext() {
    return context;
  }

  public void setContext(ActionBeanContext context) {
    this.context = context;
  }

    public String getEndDateString() {
        return enddatestring;
    }

    public void setEndDateString(String endDateString) {
        this.enddatestring = endDateString;
    }

    public String getFacilityID() {
        return facilityID;
    }

    public void setFacilityID(String facilityID) {
        this.facilityID = facilityID;
    }

    public String getStartDateString() {
        return startdatestring;
    }

    public void setStartDateString(String startDateString) {
        this.startdatestring = startDateString;
    }
    
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
  
  
  
  @DefaultHandler
  public Resolution placeBooking() {
    try{
        BookingDAO bDAO = new BookingDAO();
        FacilityDAO fDAO = new FacilityDAO();
        UserDAO uDAO = new UserDAO();
        
        //Retrieve form variables
        //Hardcode: take user from db first, later must take from session
        //Hardcode: facilityID
        User user = uDAO.getUser(52);
        Facility facility = fDAO.getFacility(2);
        Timestamp bookingTimeStamp = new Timestamp
                (System.currentTimeMillis());
        Timestamp startDate = new Timestamp
                (Long.parseLong(getStartDateString()));
        Timestamp endDate = new Timestamp
                (Long.parseLong(getEndDateString()));
        boolean isPaid = false;
        String transactionId =  "010101";
        String title = "MY AWESOME BOOKING";
        
        //Add booking into DB
        Booking booking = bDAO.addBooking(user, facility,bookingTimeStamp,
                startDate,endDate,isPaid,transactionId,title);
        result = booking.toString();
        success = true;
        System.out.println(result);
    }catch(Exception e) {
        result = "";
        success = false;
        e.printStackTrace();
    }
    System.out.println("HELLO " + getEndDateString());
    return new RedirectResolution("/residents/index.jsp");
  }
    
}
