/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.FacilityDAO;
import com.lin.entities.Facility;
import com.lin.entities.FacilityType;
import java.util.ArrayList;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;

/**
 *
 * @author Yangsta
 */
public class DeleteFacilitiesBean implements ActionBean {

    private ActionBeanContext context;
    private ArrayList<Facility> facilityList;
    private ArrayList<FacilityType> facilityTypeList;
    private String id;

    private boolean success = false;
    
    public Resolution deleteFacility() {
        FacilityDAO fdao = new FacilityDAO();
        int fId = Integer.parseInt(id);
        System.out.println(fId);
        Facility facility = fdao.getFacility(fId);
        try {
            fdao.deleteFacility(fId);
            return new RedirectResolution("/admin/manage-facilities.jsp?deletesuccess=true" + "&deletemsg=" + facility.getName());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new RedirectResolution("/admin/manage-facilities.jsp?deletesuccess=false");

    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }
}
