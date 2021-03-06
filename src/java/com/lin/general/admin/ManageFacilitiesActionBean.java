/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.FacilityDAO;
import com.lin.dao.FacilityTypeDAO;
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
import org.apache.commons.lang3.StringEscapeUtils;

public class ManageFacilitiesActionBean implements ActionBean {

    private ActionBeanContext context;
    private ArrayList<Facility> facilityList;
    private ArrayList<FacilityType> facilityTypeList;
    private Log log = Log.getInstance(ManageFacilitiesActionBean.class);//in attempt to log what went wrong..
    private String type;
    private String name;
    private String id;
    private String description;
    private String latitude;
    private String longitude;
    private String result;
    private String facility_name;
    private boolean success = false;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    
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

    public String getFacility_name() {
        return facility_name;
    }

    public void setFacility_name(String facility_name) {
        this.facility_name = facility_name;
    }

    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public ArrayList<Facility> getFacilityList() {
        FacilityDAO fDAO = new FacilityDAO();
        facilityList = fDAO.retrieveAllFacilities();
        return facilityList;
    }

    public void setFacilityList(ArrayList<Facility> facilityList) {
        this.facilityList = facilityList;
    }

    public ArrayList<FacilityType> getFacilityTypeList() {
        FacilityTypeDAO tDAO = new FacilityTypeDAO();
        facilityTypeList = tDAO.retrieveAllFacilityTypes();
        return facilityTypeList;
    }

    @DefaultHandler
    public Resolution createFacility() {
        try {
            FacilityDAO fDAO = new FacilityDAO();
            FacilityTypeDAO tDAO = new FacilityTypeDAO();
            FacilityType facilityType = tDAO.getFacilityType(Integer.parseInt(getId()));
            //Facility facility = fDAO.createFacility(facilityType, Integer.parseInt(longitude), Integer.parseInt(latitude));
            Facility facility = fDAO.createFacility(facilityType, facility_name, 12345, 12345);
            result = facility.getFacilityType().getName() + " " + facility.getName();
            success = true;
        } catch (Exception e) {
            result = "fail";
            success = false;
            e.printStackTrace();
        }
        return new RedirectResolution("/admin/manage-facilities.jsp?createsuccess=" + success
                + "&createmsg=" + result);



    }
}