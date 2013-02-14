/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.FormTemplateDAO;
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
public class DeleteFormTemplateBean implements ActionBean {

    private ActionBeanContext context;
    private String id;

    private boolean success = false;
    
    public Resolution deleteFormTemplate() {
        FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true); 
        FormTemplateDAO rdao = new FormTemplateDAO();
        int rId = Integer.parseInt(id);
        //Facility facility = fdao.getFacility(fId);
        //System.out.println(fId);
        //Facility facility = fdao.getFacility(fId);
        try {
            rdao.deleteFormTemplate(rId);
            rdao = new FormTemplateDAO();
            fs.put("SUCCESS","Successfully deleted the Form Template.");
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
