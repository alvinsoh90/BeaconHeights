/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.FacilityDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.*;

import java.util.ArrayList;
import java.util.HashMap;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.util.Log;
import javax.persistence.*;

public class ManageFacilitiesActionBean implements ActionBean {

    private ActionBeanContext context;
    private HashMap<String, Facility> facilityList;
    private Log log = Log.getInstance(ManageFacilitiesActionBean.class);//in attempt to log what went wrong..
    private String type;
    private String name;
    private String description;
    private String latitude;
    private String longitude;
    private String result;
    private boolean success = false;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Log getLog() {
        return log;
    }

    public String getResult() {
        return result;
    }

    public void setLog(Log log) {
        this.log = log;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public HashMap<String, Facility> getFacilityList() {
        FacilityDAO fDAO = new FacilityDAO();
        facilityList = fDAO.retrieveAllFacilities();
        return facilityList;
    }

    public void setFacilityList(HashMap<String, Facility> facilityList) {
        this.facilityList = facilityList;
    }

    @DefaultHandler
    public Resolution createFacility() {
        try {
            //UserDAO uDAO = new UserDAO();

            FacilityType type = new FacilityType(1, "Tennis Court", "Place where you play tennis");

            //Facility = uDAO.createUser(username, password, firstname);

            //result = facility.getFirstName();
            success = true;
            //System.out.println();
        } catch (Exception e) {
            result = "";
            success = false;
        }
        return new RedirectResolution("/admin/manageusers.jsp?createsuccess=" + success
                + "&createmsg=" + result);



    }
}

//need facility dao.
