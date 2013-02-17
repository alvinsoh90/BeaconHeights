/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.general.admin.*;
import com.lin.dao.ResourceDAO;
import com.lin.dao.SubmittedFormDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.*;
import com.lin.utils.FileUploadUtils;
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
import net.sourceforge.stripes.controller.FlashScope;
import org.apache.commons.lang3.StringEscapeUtils;

public class UploadProfilePicActionBean implements ActionBean {

    private ActionBeanContext context;
    private ArrayList<SubmittedForm> sfList;
    private Log log = Log.getInstance(UploadProfilePicActionBean.class);//in attempt to log what went wrong..
    private String user_id;
    private FileBean file;

    public FileBean getFile() {
        return file;
    }

    public void setFile(FileBean file) {
        this.file = file;
    }
    
    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }
    
    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    @DefaultHandler
    public Resolution upload() {
        FlashScope fs = FlashScope.getCurrent(getContext().getRequest(), true); 
        //check if file is null
        if(file==null){
            

            // put shit inside       
            fs.put("FAILURE","This value is not used");
            fs.put("MESSAGES","You forgot to attach a file.");

            // redirect as normal        

            return new RedirectResolution("/residents/profile.jsp?profileid="+user_id+"");
        }else{
            ArrayList<String> list = new ArrayList<String>();
            list.add("png");
            list.add("jpg");
            list.add("jpeg");
            list.add("pdf");
            list.add("gif");
            list.add("tif");
            list.add("tiff");
            String extension = FileUploadUtils.getExtension(file);
            System.out.println("EXTENSION : "+extension);
            if(!list.contains(extension.toLowerCase())){
                fs.put("FAILURE","This value is not used");
                fs.put("MESSAGES","Sorry you have uploaded an invalid file type, We only accept .png .jpg .jpeg .gif .tif .tiff");
                return new RedirectResolution("/residents/profile.jsp?profileid="+user_id+"");
            }
//            System.out.println("FILE SIZE! : "+file.getSize());
//            if(file.getSize()>5000000){
//                fs.put("FAILURE","This value is not used");
//                fs.put("MESSAGES","Sorry you file is too big please limit your picture to <5mb.");
//                return new RedirectResolution("/residents/profile.jsp?profileid="+user_id+"");
//            }
        }
        
        String result;
        boolean success;
        String fileName = new Date().getTime()+user_id+"."+FileUploadUtils.getExtension(file);
        boolean processed = false;
        
        try {
            File location = new File("../webapps/uploads/profile_pics/"+fileName);
            if(!location.getParentFile().exists()){
                location.getParentFile().mkdirs();
            }
            file.save(location);
            UserDAO uDAO = new UserDAO();
            uDAO.uploadProfilePic(Integer.parseInt(user_id),fileName);
            success = true;
        } catch (Exception e) {
            result = file.getFileName();
            success = false;
        }
        fs.put("SUCCESS","Your profile pic has be successfully updated!");
        return new RedirectResolution("/residents/profile.jsp?profileid="+user_id);

    }
}