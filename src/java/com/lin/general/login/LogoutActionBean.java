/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.login;
import javax.servlet.http.*;
import net.sourceforge.stripes.action.*;


/**
 *
 * @author fayannefoo
 */

@UrlBinding("/stripes/LogoutActionBean.action")
public class LogoutActionBean extends BaseActionBean implements ActionBean {

   @DefaultHandler @HandlesEvent("Logout")
    public Resolution logout() {
      HttpServletRequest request = getContext().getRequest(); 
      HttpSession session = request.getSession(); 
                  
      session.invalidate();      
      return new RedirectResolution("/login.jsp"); 
   }
}