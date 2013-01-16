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
//        String filename = newAttachment.getFileName();
//        InputStream input = null;
//        OutputStream output = null;
//        try {
//            input = newAttachment.getInputStream();
//            output = new FileOutputStream(new File("/", filename));
//            IOUtils.copy(input, output);
//        } catch(Exception e){
//            e.printStackTrace();
//        }finally {
//            IOUtils.closeQuietly(input);
//            //IOUtils.closeQuietly(output);
//        }
        
        try{
            
            File location = new File("../webapps/pdf_uploads/"+newAttachment.getFileName());
            System.out.println("DOES FOLDER EXIST : "+location.getParentFile().exists());
            
            if(!location.getParentFile().exists()){
                location.getParentFile().mkdirs();
                System.out.println("TRYING TO CREATE PARENT DIR");
            }
            System.out.println("PARENT LOCATOIN :"+location.getParent());
            System.out.println("SET WRITABLE SUCCES : "+location.setWritable(true));
            
            newAttachment.save(location);
        
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return new RedirectResolution("/pdf_uploads/"+newAttachment.getFileName());
    }
    

}
