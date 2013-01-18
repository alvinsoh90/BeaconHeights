/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.FacilityDAO;
import com.lin.dao.FacilityTypeDAO;
import com.lin.dao.ResourceDAO;
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

public class ManageResourceActionBean implements ActionBean {

    private ActionBeanContext context;
    private ArrayList<Resource> resourceList;
    private Log log = Log.getInstance(ManageResourceActionBean.class);//in attempt to log what went wrong..
    private String name;
    private String description;
    private String category;
    private String fileName;
    private String result;
    private boolean success = false;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    
    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public ArrayList<Resource> getResourceList() {
        ResourceDAO rDAO = new ResourceDAO();
        resourceList = rDAO.retrieveAllResource();
        return resourceList;
    }

    public void setResourceList(ArrayList<Resource> resourceList) {
        this.resourceList = resourceList;
    }

    @DefaultHandler
    public Resolution createResource() {
        try {
            ResourceDAO rDAO = new ResourceDAO();
            //System.out.append(name + "" +description);
            Resource rc = rDAO.createResource(name, description, category, fileName);
            result = rc.getName();
            success = true;
        } catch (Exception e) {
            result = "fail";
            success = false;
        }
        return new RedirectResolution("/admin/manage-resource.jsp?createsuccess=" + success
                + "&createmsg=" + result);



    }
}