/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.SubmittedFormDAO;
import com.lin.entities.Facility;
import com.lin.entities.FacilityType;
import java.util.ArrayList;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.FlashScope;

/**
 *
 * @author Yangsta
 */
public class DeleteSubmittedFormBean implements ActionBean {

    private ActionBeanContext context;
    private String id;

    private boolean success = false;
    
    public Resolution deleteSubmittedForm() {
        FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true); 
        SubmittedFormDAO dao = new SubmittedFormDAO();
        int rId = Integer.parseInt(id);
        //Facility facility = fdao.getFacility(fId);
        //System.out.println(fId);
        //Facility facility = fdao.getFacility(fId);
        try {
            dao.deleteSubmittedForm(rId);
            dao = new SubmittedFormDAO();
            fs.put("SUCCESS","Successfully deleted the User Submitted Form.");
            return new RedirectResolution("/admin/manage-onlineform.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
        fs.put("FAILURE","This value is not used");
        return new RedirectResolution("/admin/manage-onlineform.jsp");

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
