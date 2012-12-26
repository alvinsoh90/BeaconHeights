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
    private String transactionDateTimeString;
    private Integer facilityID;
    private String title;
    private String result;
    private boolean success;
    private Integer currentUserID;

    public Integer getCurrentUserID() {
        return currentUserID;
    }

    public void setCurrentUserID(Integer currentUserID) {
        this.currentUserID = currentUserID;
    }

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

    public Integer getFacilityID() {
        return facilityID;
    }

    public void setFacilityID(Integer facilityID) {
        this.facilityID = facilityID;
    }

    public String getStartDateString() {
        return startdatestring;
    }

    public void setStartDateString(String startDateString) {
        this.startdatestring = startDateString;
    }
    
    public String getTransactionDateTimeString() {
        return transactionDateTimeString;
    }

    public void getTransactionDateTimeString(String getTransactionDateTimeString) {
        this.transactionDateTimeString = getTransactionDateTimeString;
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
        
        
        User user = uDAO.getUser(getCurrentUserID());       
        Facility facility = fDAO.getFacility(getFacilityID());
        
        //Retrieve form variables
        Timestamp bookingTimeStamp = new Timestamp
                (System.currentTimeMillis());
        Timestamp startDate = new Timestamp
                (Long.parseLong(getStartDateString()));
        Timestamp endDate = new Timestamp
                (Long.parseLong(getEndDateString()));

        String title = "Resident Booking";
        
        //Create new booking
        Booking booking = new Booking(user, facility,bookingTimeStamp,
                startDate,endDate,title);
        //add booking into DB, returns booking with ID
        booking = bDAO.addBooking(booking);
        
        result = booking.toString();
        success = true;
        System.out.println(result);
        
    }catch(Exception e) {
        result = "";
        success = false;
        e.printStackTrace();
    }
    
    return new RedirectResolution("/residents/index.jsp");
  }
    
}
