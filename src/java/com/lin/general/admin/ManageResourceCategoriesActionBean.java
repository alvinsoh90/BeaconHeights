/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.FacilityDAO;
import com.lin.dao.FacilityTypeDAO;
import com.lin.dao.ResourceCategoriesDAO;
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

public class ManageResourceCategoriesActionBean implements ActionBean {

    private ActionBeanContext context;
    private ArrayList<ResourceCategories> resourceCategoryList;
    private Log log = Log.getInstance(ManageResourceCategoriesActionBean.class);//in attempt to log what went wrong..
    private String name;
    private String description;
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

    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public ArrayList<ResourceCategories> getResourceCategoryList() {
        ResourceCategoriesDAO rcDAO = new ResourceCategoriesDAO();
        resourceCategoryList = rcDAO.retrieveAllResourceCategories();
        return resourceCategoryList;
    }

    public void setResourceCategoryList(ArrayList<ResourceCategories> resourceCategoryList) {
        this.resourceCategoryList = resourceCategoryList;
    }

    @DefaultHandler
    public Resolution createResourceCategory() {
        try {
            ResourceCategoriesDAO rcDAO = new ResourceCategoriesDAO();
            System.out.append(name + "" +description);
            ResourceCategories rc = rcDAO.createResourceCategories(name, description);
            result = rc.getName();
            success = true;
        } catch (Exception e) {
            result = "fail";
            success = false;
        }
        return new RedirectResolution("/admin/manage-resourcecategories.jsp?createsuccess=" + success
                + "&createmsg=" + result);



    }
}