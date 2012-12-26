/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.controllers;

import com.lin.dao.FacilityDAO;
import com.lin.dao.FacilityTypeDAO;
import com.lin.dao.RuleDAO;
import com.lin.entities.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.Set;

/**
 *
 * @author Keffeine
 */
public class RuleController {

    public ArrayList<String> isFacilityAvailable(int userID, int facilityID, Date startBookingTime, Date endBookingTime){
        ArrayList<String> errorMsg = new ArrayList<String>();
        
        RuleDAO rDAO = new RuleDAO();
        FacilityTypeDAO tDAO = new FacilityTypeDAO();
        FacilityDAO fDAO = new FacilityDAO();
        
        Facility facility = fDAO.getFacility(facilityID);
        FacilityType facilityType = facility.getFacilityType();
        
        Set openRuleSet = facilityType.getOpenRules();
        Set closeRuleSet = facilityType.getCloseRules();
        Set limitRuleSet = facilityType.getLimitRules();
        Set advanceRuleSet = facilityType.getAdvanceRules();
        
        for(Object o : openRuleSet){
            OpenRule openRule = (OpenRule) o;
            if (openRule.getDayOfWeek()==startBookingTime.getDay()){
                Date openStart = openRule.getStartTime();
                if (openStart.getHours()>startBookingTime.getHours()){
                    errorMsg.add("Unable to book before facility opens!");
                } else if (openStart.getMinutes()> startBookingTime.getMinutes()){
                    errorMsg.add("Unable to book before facility opens! Check to the minute.");
                }
                
                Date openEnd = openRule.getEndTime();
                if (openEnd.getHours()< endBookingTime.getHours()){
                    errorMsg.add("Unable to book after facility closes!");
                } else if (openEnd.getMinutes()< endBookingTime.getMinutes()){
                    errorMsg.add("Unable to book after facility closes! Check to the minute.");
                }
                
            }
            
            
        }
        
        for (Object o : closeRuleSet){
            CloseRule closeRule = (CloseRule) o;
            
            //if the start of booking falls between the start of the closed time and end of it
            if (closeRule.getStartDate().before(startBookingTime) && closeRule.getEndDate().after(startBookingTime)){
                errorMsg.add("Sorry, the facility is closed on that day.");
            //if the end of the booking falls between the start of the closed time and end of it
            } else if (closeRule.getStartDate().before(endBookingTime) && closeRule.getEndDate().after(endBookingTime)){
                errorMsg.add("Sorry, the facility is closed on that day.");
            }
        }
        
        return errorMsg;
               
        
    }

}
