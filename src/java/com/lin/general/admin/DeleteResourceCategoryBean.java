/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.ResourceCategoryDAO;
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
public class DeleteResourceCategoryBean implements ActionBean {

    private ActionBeanContext context;
    private String id;

    private boolean success = false;
    
    public Resolution deleteResourceCategory() {
        ResourceCategoryDAO rcdao = new ResourceCategoryDAO();
        int rcId = Integer.parseInt(id);
        //Facility facility = fdao.getFacility(fId);
        //System.out.println(fId);
        //Facility facility = fdao.getFacility(fId);
        try {
            rcdao.deleteResourceCategory(rcId);
            rcdao = new ResourceCategoryDAO();
            return new RedirectResolution("/admin/manage-resourcecategories.jsp?deletesuccess=true&deletemsg=the resource category");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new RedirectResolution("/admin/manage-resourcecategories.jsp?deletesuccess=false");

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
