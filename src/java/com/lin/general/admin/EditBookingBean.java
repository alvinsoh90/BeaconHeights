/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.BookingDAO;
import com.lin.entities.Booking;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;

/**
 *
 * @author Yangsta
 */
public class EditBookingBean implements ActionBean{
  private ActionBeanContext context;


    public Resolution editBooking(){
        BookingDAO dao = new BookingDAO();

        try{
      
            return new RedirectResolution("/admin/manage-bookings.jsp?deletesuccess=true"+"&deletemsg=");
        }
        catch(Exception e){
            e.printStackTrace(); 
        }
        return new RedirectResolution("/admin/manage-bookings.jsp?deletesuccess=false"+"&deletemsg=");
        
    }



    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }



}
