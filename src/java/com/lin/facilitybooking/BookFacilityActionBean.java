/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.facilitybooking;

import com.lin.dao.UserDAO;
import com.lin.entities.*;

import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.RedirectResolution;
/**
 *
 * @author Yangsta
 */
public class BookFacilityActionBean implements ActionBean{
    
    private ActionBeanContext context;
    private String startdatestring;
    private String enddatestring;
    private String facilityID;

    public ActionBeanContext getContext() {
    return context;
  }

  public void setContext(ActionBeanContext context) {
    this.context = context;
  }

    public String getEndDateString() {
        return enddatestring;
    }

    public void setEndDateString(String endDateString) {
        this.enddatestring = endDateString;
    }

    public String getFacilityID() {
        return facilityID;
    }

    public void setFacilityID(String facilityID) {
        this.facilityID = facilityID;
    }

    public String getStartDateString() {
        return startdatestring;
    }

    public void setStartDateString(String startDateString) {
        this.startdatestring = startDateString;
    }
  
  
  
  @DefaultHandler
  public Resolution placeBooking() {
    System.out.println("HELLO " + getEndDateString());
    return new RedirectResolution("/residents/index.jsp");
  }
    
}
