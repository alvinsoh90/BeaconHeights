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

    public ArrayList<String> isFacilityAvailable(int userID, int facilityID, Date startBookingTime, Date endBookingTime) {
        ArrayList<String> errorMsg = new ArrayList<String>();

        UserDAO uDAO = new UserDAO();
        User user = uDAO.getUser(userID);
        BookingDAO bDAO = new BookingDAO();
        ArrayList<Booking> userBookingList = bDAO.getUserBookings(userID);


        RuleDAO rDAO = new RuleDAO();
        FacilityTypeDAO tDAO = new FacilityTypeDAO();
        FacilityDAO fDAO = new FacilityDAO();

        Facility facility = fDAO.getFacility(facilityID);
        FacilityType facilityType = facility.getFacilityType();
        int facilityTypeID = facilityType.getId();
        
        
        ArrayList<OpenRule> openRuleList = rDAO.getAllOpenRule(facilityTypeID);
        ArrayList<CloseRule> closeRuleList = rDAO.getAllCloseRule(facilityTypeID);
        ArrayList<LimitRule> limitRuleList = rDAO.getAllLimitRule(facilityTypeID);
        ArrayList<AdvanceRule> advanceRuleList = rDAO.getAllAdvanceRule(facilityTypeID);

        
        
        for (Object o : openRuleList) {
            OpenRule openRule = (OpenRule) o;
            if (openRule.getDayOfWeek() == startBookingTime.getDay()) {
                Date openStart = openRule.getStartTime();
                
                //check
                System.out.println("opentime: "+ openStart.getHours() + "booktime: " + startBookingTime.getHours());
                
                if (openStart.getHours() > startBookingTime.getHours()) {
                    errorMsg.add("Unable to book before facility opens!");
                } else if (openStart.getHours() == startBookingTime.getHours() && openStart.getMinutes() > startBookingTime.getMinutes()) {
                    errorMsg.add("Unable to book before facility opens! Check to the minute.");
                }

                Date openEnd = openRule.getEndTime();
                if (openEnd.getHours() < endBookingTime.getHours()) {
                    errorMsg.add("Unable to book after facility closes!");
                } else if (openEnd.getHours() == endBookingTime.getHours() && openEnd.getMinutes() < endBookingTime.getMinutes()) {
                    errorMsg.add("Unable to book after facility closes! Check to the minute.");
                }

            }


        }

        for (Object o : closeRuleList) {
            CloseRule closeRule = (CloseRule) o;

            //if the start of booking falls between the start of the closed time and end of it
            if (closeRule.getStartDate().before(startBookingTime) && closeRule.getEndDate().after(startBookingTime)) {
                errorMsg.add("Sorry, the facility is closed on that day.");
                //if the end of the booking falls between the start of the closed time and end of it
            } else if (closeRule.getStartDate().before(endBookingTime) && closeRule.getEndDate().after(endBookingTime)) {
                errorMsg.add("Sorry, the facility is closed on that day.");
            }
        }

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
                        if (bookingFacilityType.equals(facilityType)) {
                            count++;
                        }

                    }
                }

            } else if (timeFrametype.equals("MONTH")) {
            } else if (timeFrametype.equals("YEAR")) {
            }

            //basic check booking code without time


        }
        
        for (Object o : advanceRuleList){
            AdvanceRule advanceRule = (AdvanceRule) o;
            Date currentDate = new Date();
            long currentTime = currentDate.getTime();
            long startTime = startBookingTime.getTime();
            long daysBetween = getMillisecondsToDay(startTime-currentTime);
            if (daysBetween > advanceRule.getMinDays()){
                errorMsg.add("Sorry, the facility allows you to book a maximum of " + advanceRule.getMinDays() + " days in advance.");
            } else if (daysBetween < advanceRule.getMaxDays()){
                errorMsg.add("Sorry, you need to book the facility at least "+ advanceRule.getMaxDays() + " days in advance." );
            }
          
            
        }
        
        return errorMsg;


    }
    
    private long getDayToMilliseconds(int i){
        return i*1000*60*60*24;
    }
    
    private long getMillisecondsToDay(long i){
        return i/1000/60/60/24;
    }
}
