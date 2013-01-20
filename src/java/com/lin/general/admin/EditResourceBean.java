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
import java.io.File;

import java.util.Date;
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
import net.sourceforge.stripes.action.*;
import org.apache.commons.lang3.StringEscapeUtils;

public class EditResourceBean implements ActionBean {

    private ActionBeanContext context;
    private Log log = Log.getInstance(EditResourceBean.class);//in attempt to log what went wrong..
    private String name;
    private String id;
    private String description;
    private String category;
    private String category_new;
    private FileBean file;
    

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

    public String getCategory_new() {
        return category_new;
    }

    public void setCategory_new(String category_new) {
        this.category_new = category_new;
    }

    public FileBean getFile() {
        return file;
    }

    public void setFile(FileBean file) {
        this.file = file;
    }
    
    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    @DefaultHandler
    public Resolution editResource(){
        String result;
        boolean success = false;
        ResourceDAO rDAO = new ResourceDAO();
        String category_input;
        String fileName = null;
        
        
        
        if(category_new==null){
            category_input=category;
        }else{
            category_input=category_new;
        }
        System.out.println("PRINTING ID : "+id);
        
        if(file!=null){
            fileName = new Date().getTime()+file.getFileName();
            try{
                File location = new File("../webapps/pdf_uploads/"+fileName);
                if(!location.getParentFile().exists()){
                    location.getParentFile().mkdirs();
                }
                file.save(location);
                rDAO.updateResource
                        (
                            Integer.parseInt(id),
                            name,
                            description,
                            category_input,
                            fileName,
                            new Date()
                        );
                return new RedirectResolution("/admin/manage-resource.jsp?editsuccess=true"+"&editmsg="+name);
            }
            catch(Exception e){
                e.printStackTrace(); 
            }
        }else{
            try{
                rDAO.updateResource
                        (
                            Integer.parseInt(id),
                            name,
                            description,
                            category_input,
                            new Date()
                        );
                return new RedirectResolution("/admin/manage-resource.jsp?editsuccess=true"+"&editmsg="+name);
            }
            catch(Exception e){
                e.printStackTrace(); 
            }
        }
        return new RedirectResolution("/admin/manage-resource.jsp?editsuccess=false"+"&editmsg="+name);
        
    }
}