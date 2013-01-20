/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.controllers;

import com.lin.dao.BookingDAO;
import com.lin.dao.FacilityDAO;
import com.lin.dao.FacilityTypeDAO;
import com.lin.dao.RuleDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.Set;

/**
 *
 * @author Keffeine
 */
public class RuleController {

    private ArrayList<String> errorMsg;
    private UserDAO uDAO;
    private BookingDAO bDAO;
    private RuleDAO rDAO;
    private FacilityTypeDAO tDAO;
    private FacilityDAO fDAO;

    public ArrayList<String> isFacilityAvailable(int userID, int facilityID, Date startBookingTime, Date endBookingTime) {
        errorMsg = new ArrayList<String>();


        bDAO = new BookingDAO();


        rDAO = new RuleDAO();
        tDAO = new FacilityTypeDAO();
        fDAO = new FacilityDAO();

        Facility facility = fDAO.getFacility(facilityID);
        FacilityType facilityType = facility.getFacilityType();
        int facilityTypeID = facilityType.getId();

        ArrayList<String> openRuleErrors = validateOpenRule(userID, facilityTypeID, startBookingTime, endBookingTime);
        ArrayList<String> closeRuleErrors = validateCloseRule(userID, facilityTypeID, startBookingTime, endBookingTime);
        ArrayList<String> limitRuleErrors = validateLimitRule(userID, facilityTypeID, startBookingTime, endBookingTime);
        ArrayList<String> advanceRuleErrors = validateAdvanceRule(userID, facilityTypeID, startBookingTime, endBookingTime);
        ArrayList<String> clashErrors = validateClash(facility, startBookingTime, endBookingTime);
        
        
        if (!openRuleErrors.isEmpty()){
            errorMsg.addAll(openRuleErrors);
        }
        if (!closeRuleErrors.isEmpty()){
            errorMsg.addAll(closeRuleErrors);
        }
        if (!limitRuleErrors.isEmpty()){
            errorMsg.addAll(limitRuleErrors);
        }
        if (!advanceRuleErrors.isEmpty()){
            errorMsg.addAll(advanceRuleErrors);
        }
        if (!clashErrors.isEmpty()){
            errorMsg.addAll(clashErrors);
        }
       
        
        
        return errorMsg;


    }
    
    private ArrayList<String> validateOpenRule(int userID, int facilityTypeID, Date startBookingTime, Date endBookingTime) {
        ArrayList<String> openRuleErrors = new ArrayList<String>();
        ArrayList<OpenRule> openRuleList = rDAO.getAllOpenRule(facilityTypeID);
        
        boolean bookingValid = false;
        
        for (Object o : openRuleList) {
            OpenRule openRule = (OpenRule) o;
            if (openRule.getDayOfWeek() == startBookingTime.getDay()) {
                Date openStart = openRule.getStartTime();
                Date openEnd = openRule.getEndTime();
                
                boolean startValid = false;
                boolean endValid = false;
                
                if (startBookingTime.getHours() == openStart.getHours() && startBookingTime.getMinutes() == openStart.getMinutes()) {
                    startValid = true;
                }

                if (openEnd.getHours() == endBookingTime.getHours() && endBookingTime.getMinutes() == openEnd.getMinutes()) {
                    endValid = true;
                }
                
                if (startValid && endValid){
                    bookingValid = true;
                    break;
                }
                
            }


        }
        
        if (!bookingValid){
            openRuleErrors.add("Please choose a valid slot!");
        }

        return openRuleErrors;
    }
    
    //used to check if a booking is within the bounds set by the open rule
    private ArrayList<String> withinOpenRule(int userID, int facilityTypeID, Date startBookingTime, Date endBookingTime) {
        ArrayList<String> openRuleErrors = new ArrayList<String>();
        ArrayList<OpenRule> openRuleList = rDAO.getAllOpenRule(facilityTypeID);
        
        boolean bookingValid = false;
        
        for (Object o : openRuleList) {
            OpenRule openRule = (OpenRule) o;
            if (openRule.getDayOfWeek() == startBookingTime.getDay()) {
                Date openStart = openRule.getStartTime();
                Date openEnd = openRule.getEndTime();
                
                boolean startValid = false;
                boolean endValid = false;
                
                if (startBookingTime.getHours() > openStart.getHours()) {
                    startValid = true;
                } else if (openStart.getHours() == startBookingTime.getHours() && startBookingTime.getMinutes() >= openStart.getMinutes()) {
                    startValid = true;
                }

                if (endBookingTime.getHours() < openEnd.getHours()) {
                    endValid = true;
                } else if (openEnd.getHours() == endBookingTime.getHours() && endBookingTime.getMinutes() < openEnd.getMinutes()) {
                    endValid = true;
                }
                
                if (startValid && endValid){
                    bookingValid = true;
                    break;
                }
                
            }


        }
        
        if (!bookingValid){
            openRuleErrors.add("The facility is closed at the time you have selected!");
        }

        return openRuleErrors;
    }
    
    

    private ArrayList<String> validateCloseRule(int userID, int facilityTypeID, Date startBookingTime, Date endBookingTime) {
        ArrayList<String> closeRuleErrors = new ArrayList<String>();
        ArrayList<CloseRule> closeRuleList = rDAO.getAllCloseRule(facilityTypeID);

        for (Object o : closeRuleList) {
            CloseRule closeRule = (CloseRule) o;

            //if the start of booking falls between the start of the closed time and end of it
            if (closeRule.getStartDate().before(startBookingTime) && closeRule.getEndDate().after(startBookingTime)) {
                closeRuleErrors.add("Sorry, the facility is closed on that day.");
                //if the end of the booking falls between the start of the closed time and end of it
            } else if (closeRule.getStartDate().before(endBookingTime) && closeRule.getEndDate().after(endBookingTime)) {
                closeRuleErrors.add("Sorry, the facility is closed on that day.");
            }
        }

        return closeRuleErrors;

    }

    private ArrayList<String> validateLimitRule(int userID, int facilityTypeID, Date startBookingTime, Date endBookingTime) {
        ArrayList<String> limitRuleErrors = new ArrayList<String>();
        ArrayList<LimitRule> limitRuleList = rDAO.getAllLimitRule(facilityTypeID);
        ArrayList<Booking> userBookingList = bDAO.getUserBookings(userID);

        for (Object o : limitRuleList) {
            LimitRule limitRule = (LimitRule) o;
            String timeFrametype = limitRule.getTimeframeType();
            int numberOfTimeframe = limitRule.getNumberOfTimeframe();
            int count = 0;
            if (timeFrametype.equals("DAY")) {
                for (Booking booking : userBookingList) {
                    Date bookingDate = booking.getStartDate();
                    if (bookingDate.getYear() == startBookingTime.getYear()) {

                        Facility bookingFacility = booking.getFacility();
                        FacilityType bookingFacilityType = bookingFacility.getFacilityType();
                        if (bookingFacilityType.getId() == facilityTypeID) {
                            count++;
                        }

                    }
                }

            } else if (timeFrametype.equals("MONTH")) {
            } else if (timeFrametype.equals("YEAR")) {
            }

            //basic check booking code without time


        }

        return limitRuleErrors;

    }

    private ArrayList<String> validateAdvanceRule(int userID, int facilityTypeID, Date startBookingTime, Date endBookingTime) {

        ArrayList<String> advanceRuleErrors = new ArrayList<String>();
        ArrayList<AdvanceRule> advanceRuleList = rDAO.getAllAdvanceRule(facilityTypeID);


        for (Object o : advanceRuleList) {
            AdvanceRule advanceRule = (AdvanceRule) o;
            Date currentDate = new Date();
            long currentTime = currentDate.getTime();
            long startTime = startBookingTime.getTime();
            long daysBetween = getMillisecondsToDay(startTime - currentTime);
            if (daysBetween > advanceRule.getMinDays()) {
                advanceRuleErrors.add("Sorry, the facility allows you to book a maximum of " + advanceRule.getMinDays() + " days in advance.");
            } else if (daysBetween < advanceRule.getMaxDays()) {
                advanceRuleErrors.add("Sorry, you need to book the facility at least " + advanceRule.getMaxDays() + " days in advance.");
            }


        }

        return advanceRuleErrors;

    }
    
    private ArrayList<String> validateClash(Facility facility, Date startBookingTime, Date endBookingTime){
        ArrayList<String> clashErrors = new ArrayList<String>();
        ArrayList<Booking>bookings = bDAO.getBookingByPeriod(startBookingTime, endBookingTime, facility);
        
        if (!bookings.isEmpty()){
            clashErrors.add("Your booking clashes with another booking. Please try again.");
        }
               
        
        return clashErrors;
        
    }
    

    
    private long getDayToMilliseconds(int i) {
        return i * 1000 * 60 * 60 * 24;
    }

    private long getMillisecondsToDay(long i) {
        return i / 1000 / 60 / 60 / 24;
    }
}
