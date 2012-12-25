/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.FacilityDAO;
import com.lin.dao.FacilityTypeDAO;
import com.lin.dao.RuleDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.util.Log;
import javax.persistence.*;

public class ManageFacilityTypesActionBean implements ActionBean {

    private ActionBeanContext context;
    private ArrayList<FacilityType> facilityTypeList;
    private Log log = Log.getInstance(ManageFacilityTypesActionBean.class);
    private String name;
    private String description;
    private Long mondayOne;
    private Long mondayTwo;
    private Long tuesdayOne;
    private Long tuesdayTwo;
    private Long wednesdayOne;
    private Long wednesdayTwo;
    private Long thursdayOne;
    private Long thursdayTwo;
    private Long fridayOne;
    private Long fridayTwo;
    private Long saturdayOne;
    private Long saturdayTwo;
    private Long sundayOne;
    private Long sundayTwo;
    private int bookingSessions;
    private int bookingLimitFreq;
    private char bookingLimitUnit;
    private int bookingOpenAdvance;
    private int bookingCloseAdvance;

    public int getBookingLimitFreq() {
        return bookingLimitFreq;
    }

    public void setBookingLimitFreq(int bookingLimitFreq) {
        this.bookingLimitFreq = bookingLimitFreq;
    }

    public char getBookingLimitUnit() {
        return bookingLimitUnit;
    }

    public void setBookingLimitUnit(char bookingLimitUnit) {
        this.bookingLimitUnit = bookingLimitUnit;
    }

    public int getBookingSessions() {
        return bookingSessions;
    }

    public void setBookingSessions(int bookingSessions) {
        this.bookingSessions = bookingSessions;
    }
    
    public Long getFridayOne() {
        return fridayOne;
    }

    public void setFridayOne(Long fridayOne) {
        this.fridayOne = fridayOne;
    }

    public Long getFridayTwo() {
        return fridayTwo;
    }

    public void setFridayTwo(Long fridayTwo) {
        this.fridayTwo = fridayTwo;
    }

    public Log getLog() {
        return log;
    }

    public void setLog(Log log) {
        this.log = log;
    }

    public Long getSaturdayOne() {
        return saturdayOne;
    }

    public void setSaturdayOne(Long saturdayOne) {
        this.saturdayOne = saturdayOne;
    }

    public Long getSaturdayTwo() {
        return saturdayTwo;
    }

    public void setSaturdayTwo(Long saturdayTwo) {
        this.saturdayTwo = saturdayTwo;
    }

    public Long getSundayOne() {
        return sundayOne;
    }

    public void setSundayOne(Long sundayOne) {
        this.sundayOne = sundayOne;
    }

    public Long getSundayTwo() {
        return sundayTwo;
    }

    public void setSundayTwo(Long sundayTwo) {
        this.sundayTwo = sundayTwo;
    }

    public Long getThursdayOne() {
        return thursdayOne;
    }

    public void setThursdayOne(Long thursdayOne) {
        this.thursdayOne = thursdayOne;
    }

    public Long getThursdayTwo() {
        return thursdayTwo;
    }

    public void setThursdayTwo(Long thursdayTwo) {
        this.thursdayTwo = thursdayTwo;
    }

    public Long getTuesdayOne() {
        return tuesdayOne;
    }

    public void setTuesdayOne(Long tuesdayOne) {
        this.tuesdayOne = tuesdayOne;
    }

    public Long getTuesdayTwo() {
        return tuesdayTwo;
    }

    public void setTuesdayTwo(Long tuesdayTwo) {
        this.tuesdayTwo = tuesdayTwo;
    }

    public Long getWednesdayOne() {
        return wednesdayOne;
    }

    public void setWednesdayOne(Long wednesdayOne) {
        this.wednesdayOne = wednesdayOne;
    }

    public Long getWednesdayTwo() {
        return wednesdayTwo;
    }

    public void setWednesdayTwo(Long wednesdayTwo) {
        this.wednesdayTwo = wednesdayTwo;
    }
    
    

    public Long getMondayOne() {
        return mondayOne;
    }

    public void setMondayOne(Long mondayOne) {
        this.mondayOne = mondayOne;
    }

    public Long getMondayTwo() {
        return mondayTwo;
    }

    public void setMondayTwo(Long mondayTwo) {
        this.mondayTwo = mondayTwo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

 

    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public ArrayList<FacilityType> getFacilityTypeList() {
        FacilityTypeDAO tDAO = new FacilityTypeDAO();
        facilityTypeList = tDAO.retrieveAllFacilityTypes();
        return facilityTypeList;
    }

    @DefaultHandler
    public Resolution createFacility() {
        boolean success;
        String result;
        try {
            Date monOne = new Date(mondayOne);
            Date monTwo = new Date(mondayTwo);
            Date tueOne = new Date(tuesdayOne);
            Date tueTwo = new Date(tuesdayTwo);
            Date wedOne = new Date(wednesdayOne);
            Date wedTwo = new Date(wednesdayTwo);
            Date thuOne = new Date(thursdayOne);
            Date thuTwo = new Date(thursdayTwo);
            Date friOne = new Date(fridayOne);
            Date friTwo = new Date(fridayTwo);
            Date satOne = new Date(saturdayOne);
            Date satTwo = new Date(saturdayTwo);
            Date sunOne = new Date(sundayOne);
            Date sunTwo = new Date(sundayTwo);
            
            FacilityTypeDAO tDAO = new FacilityTypeDAO();
            RuleDAO rDAO = new RuleDAO();

            FacilityType facilityType = tDAO.createFacilityType(name, description);

            //HashSet declarations

            HashSet openRuleSet = new HashSet();
            HashSet closeRuleSet = new HashSet();
            HashSet limitRuleSet = new HashSet();
            HashSet advanceRuleSet = new HashSet();

            //Create open rules and store to DB          
            OpenRule openRule1 = rDAO.createOpenRule(facilityType, monOne, monTwo);
            OpenRule openRule2 = rDAO.createOpenRule(facilityType, tueOne, tueTwo);
            OpenRule openRule3 = rDAO.createOpenRule(facilityType, wedOne, wedTwo);
            OpenRule openRule4 = rDAO.createOpenRule(facilityType, thuOne, thuTwo);
            OpenRule openRule5 = rDAO.createOpenRule(facilityType, friOne, friTwo);
            OpenRule openRule6 = rDAO.createOpenRule(facilityType, satOne, satTwo);
            OpenRule openRule7 = rDAO.createOpenRule(facilityType, sunOne, sunTwo);
            
            //add these rules to set
            openRuleSet.add(openRule1);
            openRuleSet.add(openRule2);
            openRuleSet.add(openRule3);
            openRuleSet.add(openRule4);
            openRuleSet.add(openRule5);
            openRuleSet.add(openRule6);
            openRuleSet.add(openRule7);

            //create limit rule
            //evaluate timeframe type entered
            switch(bookingLimitUnit){
                case 'd':
                    LimitRule limitRuleD = rDAO.createLimitRule(facilityType, bookingSessions, bookingLimitFreq, LimitRule.TimeFrameType.DAY);
                    limitRuleSet.add(limitRuleD);
                    break;    
                case 'w':
                    LimitRule limitRuleW = rDAO.createLimitRule(facilityType, bookingSessions, bookingLimitFreq, LimitRule.TimeFrameType.WEEK);
                    limitRuleSet.add(limitRuleW);
                    break;
                case 'm':
                    LimitRule limitRuleM = rDAO.createLimitRule(facilityType, bookingSessions, bookingLimitFreq, LimitRule.TimeFrameType.MONTH);
                    limitRuleSet.add(limitRuleM);
                    break;
            }
                    
            //limitation on booking in advance            
            AdvanceRule advanceRule = rDAO.createAdvanceRule(facilityType, bookingOpenAdvance, bookingCloseAdvance);
            advanceRuleSet.add(advanceRule);
            
            facilityType = tDAO.appendRulesToType(facilityType, openRuleSet, closeRuleSet, limitRuleSet, advanceRuleSet);
          
            success = true;
            result = name;
        } catch (Exception e) {
            result = "fail";
            success = false;
        }
        return new RedirectResolution("/admin/manage-facilitytypes.jsp?createsuccess=" + success
                + "&createmsg=" + result);



    }
}