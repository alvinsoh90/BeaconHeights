/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.utils;

import java.util.Date;
import net.sourceforge.stripes.action.FileBean;

/**
 *
 * @author Shamus
 */
public class FileUploadUtils {
    public static String getExtension(FileBean fileBean){
        String fileName = fileBean.getFileName();
        int index = fileName.lastIndexOf(".");
        String extension = fileName.substring(index+1);
        
        return extension;
    }
    
}
