/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.BookingDAO;
import com.lin.entities.Booking;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import net.sourceforge.stripes.action.*;
import org.apache.tomcat.util.http.fileupload.IOUtils;

/**
 *
 * @author Yangsta
 */
public class UploadBean implements ActionBean{
    private ActionBeanContext context;
    private FileBean newAttachment;

    public FileBean getNewAttachment() {
        return newAttachment;
    }

    public void setNewAttachment(FileBean newAttachment) {
        this.newAttachment = newAttachment;
    }

    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    @HandlesEvent("upload")
    @DefaultHandler
    public Resolution upload() {
        long dateInt = new Date().getTime();
        String fileName = dateInt+newAttachment.getFileName();
        
        try{
            File location = new File("../webapps/pdf_uploads/"+fileName);
            
//            System.out.println("FILE NAME : "+fileName);
//            System.out.println("TYPE : "+newAttachment.getContentType());
//            System.out.println("DATE TIME NUMBER: "+dateInt);
//            System.out.println("DOES FOLDER EXIST : "+location.getParentFile().exists());
            
            if(!location.getParentFile().exists()){
                location.getParentFile().mkdirs();
                //System.out.println("TRYING TO CREATE PARENT DIR");
            }
//            System.out.println("PARENT LOCATOIN :"+location.getParent());
//            System.out.println("SET WRITABLE SUCCES : "+location.setWritable(true));
            
            newAttachment.save(location);
        
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return new RedirectResolution("/pdf_uploads/"+fileName);
    }
    

}
