/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.BookingDAO;
import com.lin.entities.Booking;
import com.lin.entities.User;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;

/**
 *
 * @author Yangsta
 */
public class DeleteBookingBean implements ActionBean{
  private ActionBeanContext context;
  private String id;
  private String username;
  

    @DefaultHandler
    public Resolution deleteBooking(){
        BookingDAO dao = new BookingDAO();
        String name = "";
        
            

        try{
            User user = dao.getBooking(Integer.parseInt(id)).getUser();
            name = user.getFirstname() + " " + user.getLastname();
            dao.deleteBooking(Integer.parseInt(id));
            return new RedirectResolution("/admin/manage-bookings.jsp?deletesuccess=true"+"&deletemsg="+name+"\'s booking");
        }
        catch(Exception e){
            e.printStackTrace(); 
        }
        return new RedirectResolution("/admin/manage-bookings.jsp?deletesuccess=false"+"&deletemsg="+name);
        
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
  

}
