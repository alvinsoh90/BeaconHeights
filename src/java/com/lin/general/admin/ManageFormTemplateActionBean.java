/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.FacilityDAO;
import com.lin.dao.FacilityTypeDAO;
import com.lin.dao.FormTemplateDAO;;
import com.lin.entities.*;
import java.io.File;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.util.Log;
import javax.persistence.*;
import net.sourceforge.stripes.action.*;
import org.apache.commons.lang3.StringEscapeUtils;

public class ManageFormTemplateActionBean implements ActionBean {

    private ActionBeanContext context;
    private ArrayList<FormTemplate> FormTemplateList;
    private Log log = Log.getInstance(ManageFormTemplateActionBean.class);//in attempt to log what went wrong..
    private String name;
    private String description;
    private String category;
    private String category_new;
    private FileBean file;
    

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

    public FileBean getFile() {
        return file;
    }

    public void setFile(FileBean file) {
        this.file = file;
    }

    public String getCategory_new() {
        return category_new;
    }

    public void setCategory_new(String category_new) {
        this.category_new = category_new;
    }

    
    
    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public ArrayList<FormTemplate> getFormTemplateList() {
        FormTemplateDAO ftDAO = new FormTemplateDAO();
        FormTemplateList = ftDAO.retrieveAllFormTemplate();
        return FormTemplateList;
    }

    public void setFormTemplateList(ArrayList<FormTemplate> FormTemplateList) {
        this.FormTemplateList = FormTemplateList;
    }
    
    public ArrayList<String> getUniqueCategories(){
        FormTemplateDAO ftDAO = new FormTemplateDAO();
        ArrayList<String> result = ftDAO.getUniqueCategories();
        
        return result;
    }

    @DefaultHandler
    public Resolution createFormTemplate() {
        String result;
        boolean success;
        String fileName = new Date().getTime()+file.getFileName();
        String category_input;
        
        if(category_new==null){
            category_input=category;
        }else{
            category_input=category_new;
        }
        
        try {
            File location = new File("../webapps/uploads/form_templates/"+fileName);
            if(!location.getParentFile().exists()){
                location.getParentFile().mkdirs();
            }
            file.save(location);
            
            FormTemplateDAO ftDAO = new FormTemplateDAO();
            FormTemplate rc = ftDAO.createFormTemplate(name, description, category_input, fileName);
            result = rc.getName();
            success = true;
        } catch (Exception e) {
            result = "fail";
            success = false;
        }
        return new RedirectResolution("/admin/manage-onlineform.jsp?createsuccess=" + success
                + "&createmsg=" + result);



    }
    
    
}