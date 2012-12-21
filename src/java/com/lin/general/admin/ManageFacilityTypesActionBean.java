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
    private Log log = Log.getInstance(ManageFacilityTypesActionBean.class);//in attempt to log what went wrong..
    private String name;
    private String description;
    private String monOpen;
    private String tueOpen;
    private String wedOpen;
    private String thuOpen;
    private String friOpen;
    private String satOpen;
    private String sunOpen;
    private String monClose;
    private String tueClose;
    private String wedClose;
    private String thuClose;
    private String friClose;
    private String satClose;
    private String sunClose;
    private String sessions;
    private String numberOfTimeframe;
    private String timeframeType;
    private String minDays;
    private String maxDays;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getFriClose() {
        return friClose;
    }

    public void setFriClose(String friClose) {
        this.friClose = friClose;
    }

    public String getFriOpen() {
        return friOpen;
    }

    public void setFriOpen(String friOpen) {
        this.friOpen = friOpen;
    }

    public String getMaxDays() {
        return maxDays;
    }

    public void setMaxDays(String maxDays) {
        this.maxDays = maxDays;
    }

    public String getMinDays() {
        return minDays;
    }

    public void setMinDays(String minDays) {
        this.minDays = minDays;
    }

    public String getMonClose() {
        return monClose;
    }

    public void setMonClose(String monClose) {
        this.monClose = monClose;
    }

    public String getMonOpen() {
        return monOpen;
    }

    public void setMonOpen(String monOpen) {
        this.monOpen = monOpen;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNumberOfTimeframe() {
        return numberOfTimeframe;
    }

    public void setNumberOfTimeframe(String numberOfTimeframe) {
        this.numberOfTimeframe = numberOfTimeframe;
    }

    public String getSatClose() {
        return satClose;
    }

    public void setSatClose(String satClose) {
        this.satClose = satClose;
    }

    public String getSatOpen() {
        return satOpen;
    }

    public void setSatOpen(String satOpen) {
        this.satOpen = satOpen;
    }

    public String getSessions() {
        return sessions;
    }

    public void setSessions(String sessions) {
        this.sessions = sessions;
    }

    public String getSunClose() {
        return sunClose;
    }

    public void setSunClose(String sunClose) {
        this.sunClose = sunClose;
    }

    public String getSunOpen() {
        return sunOpen;
    }

    public void setSunOpen(String sunOpen) {
        this.sunOpen = sunOpen;
    }

    public String getThuClose() {
        return thuClose;
    }

    public void setThuClose(String thuClose) {
        this.thuClose = thuClose;
    }

    public String getThuOpen() {
        return thuOpen;
    }

    public void setThuOpen(String thuOpen) {
        this.thuOpen = thuOpen;
    }

    public String getTimeframeType() {
        return timeframeType;
    }

    public void setTimeframeType(String timeframeType) {
        this.timeframeType = timeframeType;
    }

    public String getTueClose() {
        return tueClose;
    }

    public void setTueClose(String tueClose) {
        this.tueClose = tueClose;
    }

    public String getTueOpen() {
        return tueOpen;
    }

    public void setTueOpen(String tueOpen) {
        this.tueOpen = tueOpen;
    }

    public String getWedClose() {
        return wedClose;
    }

    public void setWedClose(String wedClose) {
        this.wedClose = wedClose;
    }

    public String getWedOpen() {
        return wedOpen;
    }

    public void setWedOpen(String wedOpen) {
        this.wedOpen = wedOpen;
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

            FacilityTypeDAO tDAO = new FacilityTypeDAO();
            RuleDAO rDAO = new RuleDAO();

            FacilityType facilityType = tDAO.createFacilityType(name, description);

            //HashSet declarations

            HashSet openRuleSet = new HashSet();
            HashSet closeRuleSet = new HashSet();
            HashSet limitRuleSet = new HashSet();
            HashSet advanceRuleSet = new HashSet();


            //BADLY HARDCODED INELEGANT CODE
            OpenRule openRule1 = rDAO.createOpenRule(facilityType, 1, Integer.parseInt(monOpen), Integer.parseInt(monClose));
            OpenRule openRule2 = rDAO.createOpenRule(facilityType, 2, Integer.parseInt(tueOpen), Integer.parseInt(tueClose));
            OpenRule openRule3 = rDAO.createOpenRule(facilityType, 3, Integer.parseInt(wedOpen), Integer.parseInt(wedClose));
            OpenRule openRule4 = rDAO.createOpenRule(facilityType, 4, Integer.parseInt(thuOpen), Integer.parseInt(thuClose));
            OpenRule openRule5 = rDAO.createOpenRule(facilityType, 5, Integer.parseInt(friOpen), Integer.parseInt(friClose));
            OpenRule openRule6 = rDAO.createOpenRule(facilityType, 6, Integer.parseInt(satOpen), Integer.parseInt(satClose));
            OpenRule openRule7 = rDAO.createOpenRule(facilityType, 7, Integer.parseInt(sunOpen), Integer.parseInt(sunClose));

            openRuleSet.add(openRule1);
            openRuleSet.add(openRule2);
            openRuleSet.add(openRule3);
            openRuleSet.add(openRule4);
            openRuleSet.add(openRule5);
            openRuleSet.add(openRule6);
            openRuleSet.add(openRule7);

            LimitRule limitRule = rDAO.createLimitRule(facilityType, Integer.parseInt(sessions), Integer.parseInt(numberOfTimeframe), timeframeType);

            limitRuleSet.add(limitRule);

            AdvanceRule advanceRule = rDAO.createAdvanceRule(facilityType, Integer.parseInt(minDays), Integer.parseInt(maxDays));

            advanceRuleSet.add(advanceRule);
            
            facilityType = tDAO.appendRulesToType(facilityType, openRuleSet, closeRuleSet, limitRuleSet, advanceRuleSet);
          
            success = true;
            result = name;
        } catch (Exception e) {
            result = "fail";
            success = false;
        }
        return new RedirectResolution("/admin/managefacilitytypes.jsp?createsuccess=" + success
                + "&createmsg=" + result);



    }
}