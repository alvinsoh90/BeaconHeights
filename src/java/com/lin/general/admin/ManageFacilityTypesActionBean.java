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
import java.util.Iterator;
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
    private String bookingFees;
    private String bookingDeposit;
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
    private boolean needsPayment;

    public String getBookingDeposit() {
        return bookingDeposit;
    }

    public void setBookingDeposit(String bookingDeposit) {
        this.bookingDeposit = bookingDeposit;
    }

    public String getBookingFees() {
        return bookingFees;
    }

    public void setBookingFees(String bookingFees) {
        this.bookingFees = bookingFees;
    }
    
    
    public int getBookingCloseAdvance() {
        return bookingCloseAdvance;
    }

    public void setBookingCloseAdvance(int bookingCloseAdvance) {
        this.bookingCloseAdvance = bookingCloseAdvance;
    }

    public int getBookingOpenAdvance() {
        return bookingOpenAdvance;
    }

    public void setBookingOpenAdvance(int bookingOpenAdvance) {
        this.bookingOpenAdvance = bookingOpenAdvance;
    }
    
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

    public boolean isNeedsPayment() {
        return needsPayment;
    }

    public void setNeedsPayment(boolean needsPayment) {
        this.needsPayment = needsPayment;
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
            System.out.println("TEST NEEDSPAYMENT: "+needsPayment);

            FacilityType facilityType = new FacilityType(name, description, needsPayment, Double.parseDouble(bookingFees), Double.parseDouble(bookingDeposit));
            
            System.out.println("BOOIKING FEES : "+facilityType.getBookingFees());
            
            //HashSet declarations

            HashSet openRuleSet = new HashSet();
            HashSet closeRuleSet = new HashSet();
            HashSet limitRuleSet = new HashSet();
            HashSet advanceRuleSet = new HashSet();

            //Create open rules and store to DB          
            OpenRule openRule1 = new OpenRule(facilityType, monOne, monTwo, 
                    OpenRule.DAY_OF_WEEK.MONDAY);
            OpenRule openRule2 = new OpenRule(facilityType, tueOne, tueTwo, 
                    OpenRule.DAY_OF_WEEK.TUESDAY);
            OpenRule openRule3 = new OpenRule(facilityType, wedOne, wedTwo, 
                    OpenRule.DAY_OF_WEEK.WEDNESDAY);
            OpenRule openRule4 = new OpenRule(facilityType, thuOne, thuTwo, 
                    OpenRule.DAY_OF_WEEK.THURSDAY);
            OpenRule openRule5 = new OpenRule(facilityType, friOne, friTwo, 
                    OpenRule.DAY_OF_WEEK.FRIDAY);
            OpenRule openRule6 = new OpenRule(facilityType, satOne, satTwo, 
                    OpenRule.DAY_OF_WEEK.SATURDAY);
            OpenRule openRule7 = new OpenRule(facilityType, sunOne, sunTwo, 
                    OpenRule.DAY_OF_WEEK.SUNDAY);
            
            //add these rules to set
            openRuleSet.add(openRule1);
            openRuleSet.add(openRule2);
            openRuleSet.add(openRule3);
            openRuleSet.add(openRule4);
            openRuleSet.add(openRule5);
            openRuleSet.add(openRule6);
            openRuleSet.add(openRule7);
            
            Iterator iter = openRuleSet.iterator();
            while (iter.hasNext()) {
                System.out.println(iter.next());
            }

            //create limit rule
            //evaluate timeframe type entered
            switch(bookingLimitUnit){
                case 'd':
                    LimitRule limitRuleD = new LimitRule(facilityType, bookingSessions, bookingLimitFreq, LimitRule.TimeFrameType.DAY);
                    limitRuleSet.add(limitRuleD);
                    System.out.println(limitRuleD);
                    break;    
                case 'w':
                    LimitRule limitRuleW = new LimitRule(facilityType, bookingSessions, bookingLimitFreq, LimitRule.TimeFrameType.WEEK);
                    limitRuleSet.add(limitRuleW);
                    break;
                case 'm':
                    LimitRule limitRuleM = new LimitRule(facilityType, bookingSessions, bookingLimitFreq, LimitRule.TimeFrameType.MONTH);
                    limitRuleSet.add(limitRuleM);
                    break;
            }
                    
            //limitation on booking in advance            
            AdvanceRule advanceRule = new AdvanceRule(facilityType, bookingOpenAdvance, bookingCloseAdvance);
            advanceRuleSet.add(advanceRule);
            
            System.out.println(advanceRule);
            
            //facilityType(facilityType, openRuleSet, closeRuleSet, limitRuleSet, advanceRuleSet);
            facilityType.setLimitRules(limitRuleSet);
            facilityType.setAdvanceRules(advanceRuleSet);
            facilityType.setCloseRules(closeRuleSet);
            facilityType.setOpenRules(openRuleSet);
          
            
            
            //insert into DB
            if( tDAO.createFacilityType(facilityType) != null ){
                success = true;
                result = name;
                System.out.println("successsssss");
            }
            else{
                result = "fail";
                success = false;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            result = "fail";
            success = false;
        }
        return new RedirectResolution("/admin/manage-facilities.jsp?createFTsuccess=" + success
                + "&createFTmsg=" + result);
    }
    
    public String formatOpenRuleForDisplay(ArrayList<OpenRule> ruleList){
        String openRule ="";
        ArrayList<String> days = new ArrayList<String>();
        days.add("Sunday");
        days.add("Monday");
        days.add("Tuesday");
        days.add("Wednesday");
        days.add("Thursday");
        days.add("Friday");
        days.add("Saturday");
        
        for(String day : days){
            int startTimeH = 24;
            int startTimeM = 24;
            int endTimeH = 0;
            int endTimeM = 0;
            int count = 0;
            for(OpenRule r : ruleList){
                if(r.getDay().equals(day)){
                    count++;
                    if(r.getStartTime().getHours() < startTimeH){
                        startTimeH = r.getStartTime().getHours();
                        startTimeM = r.getStartTime().getMinutes();
                    }
                    if(r.getStartTime().getHours() == startTimeH){
                        if(r.getStartTime().getMinutes() < startTimeM){
                        startTimeH = r.getStartTime().getHours();
                        startTimeM = r.getStartTime().getMinutes();
                        }
                    }    
                    if(r.getEndTime().getHours() > endTimeH){
                        endTimeH = r.getEndTime().getHours();
                        endTimeM = r.getEndTime().getMinutes();
                    }
                    if(r.getEndTime().getHours() == endTimeH){
                        if(r.getEndTime().getMinutes() > endTimeM){
                            endTimeH = r.getEndTime().getHours();
                            endTimeM = r.getEndTime().getMinutes();
                        }
                    }
                }
            }
            
            String startTimeHours = "";
            String startTimeMin = "";
            if( startTimeH < 10){
                startTimeHours = "0" + startTimeH;
            }else{
                startTimeHours = "" + startTimeH;
            }
            
            if( startTimeM < 10){
                startTimeMin = "0" + startTimeM;
            }else{
                startTimeMin = "" + startTimeM;
            }
            
            String endTimeHours = "";
            String endTimeMin = "";
            if( endTimeH < 10){
                endTimeHours = "0" + endTimeH;
            }else{
                endTimeHours = "" + endTimeH;
            }
            if( endTimeM < 10){
                endTimeMin = "0" + endTimeM;
            }else{
                endTimeMin = "" + endTimeM;
            }
            
            openRule += day + ": "+ String.valueOf(count) + " slot";
            if(count>1){
                openRule += "s";
            }
            openRule += " between " + startTimeHours + ":" + startTimeMin + "-" + endTimeHours + ":" + endTimeMin + "</br>";
        }
            
        return openRule;
    }
}