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
public class PayBookingBean implements ActionBean{
  private ActionBeanContext context;
  private String id;
  private String username;
  private String transactionId;

    public Resolution payBooking(){
        BookingDAO dao = new BookingDAO();
        try{
            Booking b = dao.getBooking(Integer.parseInt(id));
            if(b.isIsPaid()){
                dao.updateBookingPayment(Integer.parseInt(id), false, "");
            }else{
                dao.updateBookingPayment(Integer.parseInt(id), true, transactionId);
            }
            return new RedirectResolution("/admin/managebookings.jsp?paysuccess=true"+"&paymsg="+username);
        }
        catch(Exception e){
            e.printStackTrace(); 
        }
        return new RedirectResolution("/admin/managebookings.jsp?paysuccess=false"+"&paymsg="+username);
        
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

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }
  

}
