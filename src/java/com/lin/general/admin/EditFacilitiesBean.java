/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.BlockDAO;
import com.lin.dao.FacilityDAO;
import com.lin.dao.FacilityTypeDAO;
import com.lin.dao.RoleDAO;
import com.lin.entities.User;
import com.lin.dao.UserDAO;
import com.lin.entities.Block;
import com.lin.entities.Facility;
import com.lin.entities.FacilityType;
import com.lin.entities.Role;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;

/**
 *
 * @author Yangsta
 */
public class EditFacilitiesBean implements ActionBean{
  private ActionBeanContext context;
  private Facility facility;
  
  private String id;
  private Integer type;
  private String latitude;
  private String longitude;
  private String facility_name;


    public Resolution editFacility(){
        FacilityDAO fDAO = new FacilityDAO();
        FacilityTypeDAO tDAO = new FacilityTypeDAO();
        
        FacilityType facilityType = tDAO.getFacilityType(type);
        
        try{
            System.out.println("F-ID: " + id);
            fDAO.updateFacility
                    (
                        Integer.parseInt(id),
                        facilityType,
                        123456,
                        123456,
                        facility_name
//                        Integer.parseInt(longitude),
//                        Integer.parseInt(latitude)
                    );
            return new RedirectResolution("/admin/manage-facilities.jsp?editsuccess=true"+"&editmsg="+type+"%20"+facility_name);
        }
        catch(Exception e){
            e.printStackTrace(); 
        }
        return new RedirectResolution("/admin/manage-facilities.jsp?editsuccess=false"+"&editmsg="+type+"%20"+facility_name);
        
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Facility getFacility() {
        return facility;
    }

    public void setFacility(Facility facility) {
        this.facility = facility;
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

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
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

}
