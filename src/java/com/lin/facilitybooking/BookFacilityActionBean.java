/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.facilitybooking;

import com.lin.controllers.RuleController;
import com.lin.dao.BookingDAO;
import com.lin.dao.FacilityDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.*;
import com.lin.general.login.BaseActionBean;

import java.sql.Timestamp;
import java.util.ArrayList;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.UrlBinding;
import net.sourceforge.stripes.controller.FlashScope;

/**
 *
 * @author Yangsta
 */
@UrlBinding("/stripes/BookFacilityActionBean.action")
public class BookFacilityActionBean extends BaseActionBean {

    private ActionBeanContext context;
    private String startdatestring;
    private String enddatestring;
    private String transactionDateTimeString;
    private Integer facilityID;
    private String title;
    private String result;
    private boolean success;
    private Integer currentUserID;
    private boolean isPaid;//check if user has paid
    private boolean isDeleted;//check if user has deleted
    private boolean needPayment;//check if facility requires payment
    private String level;
    private String unit;

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Integer getCurrentUserID() {
        return currentUserID;
    }

    public void setCurrentUserID(Integer currentUserID) {
        this.currentUserID = currentUserID;
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
        try {
            BookingDAO bDAO = new BookingDAO();
            FacilityDAO fDAO = new FacilityDAO();
            UserDAO uDAO = new UserDAO();
            RuleController ruleController = new RuleController();

            User user = uDAO.getUser(getCurrentUserID());
            Facility facility = fDAO.getFacility(getFacilityID());

            //Retrieve form variables
            Timestamp bookingTimeStamp = new Timestamp(System.currentTimeMillis());
            Timestamp startDate = new Timestamp(Long.parseLong(getStartDateString()));
            Timestamp endDate = new Timestamp(Long.parseLong(getEndDateString()));

            if (title.equals("Enter an optional event name")) {
                title = "Resident Booking";
            }
            System.out.println("Curr User Id: " + getContext().getUser().getUserId());
            ArrayList<String> errorMsg = ruleController.isFacilityAvailable(getContext().getUser().getUserId(), getFacilityID(), startDate, endDate);

            if (!errorMsg.isEmpty()) {
                for (String msg : errorMsg) {
                    System.out.println("LOOK IS ERROR");
                    System.out.println(msg);

                    // get flash scope instance
                    FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true);
                    // put shit inside       
                    fs.put("FAILURE", true);
                    fs.put("MESSAGES", errorMsg);
                    // redirect as normal        
                    return new RedirectResolution("/residents/index.jsp?fid=" + getFacilityID());
                }
            }

            // check if facility needs payment. if need payment, direct to payment page
            if (facility.getFacilityType().isNeedsPayment()) {
                isPaid = false;
//                isDeleted = false;
//                
//                Booking booking = new Booking(user, facility, bookingTimeStamp,
//                        startDate, endDate, title, isPaid, isDeleted, level, unit);
//                System.out.println("unpaidBooking!" + level + unit);
//                // get flash scope instance
//                FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true);
//                // put shit inside       
//                fs.put("booking", booking);
//               
//                // redirect to payment page        
//                return new RedirectResolution("/residents/bookingpayment.jsp");

            } else {
                isPaid = true;
            }
                isDeleted = false;
                Booking booking = new Booking(user, facility, bookingTimeStamp,
                        startDate, endDate, title, isPaid, isDeleted, level, unit);
                System.out.println("paidBooking!" + level + unit);

                //add booking into DB, returns booking with ID
                booking = bDAO.addBooking(booking);

                result = booking.toString();
                success = true;

                System.out.println(result);

                // get flash scope instance
                FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true);

                // put shit inside       
                fs.put("SUCCESS", "Your booking is confirmed. Booking ID: " + booking.getId());

                // redirect as normal        
                return new RedirectResolution("/residents/index.jsp?fid=" + getFacilityID());
            
        } catch (Exception e) {
            result = "";
            success = false;
            e.printStackTrace();
        }

        return new RedirectResolution("/residents/index.jsp?fid=" + getFacilityID());
    }
}
