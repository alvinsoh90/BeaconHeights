/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.entities.*;

import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;

/**
 *
 * @author jonathanseetoh
 */
public class AdminActionBean implements ActionBean {

  private ActionBeanContext context;
  private String username;
  private String result;

  public String getResult() {
    return result;
  }

  public void setResult(String result) {
    this.result = result;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public ActionBeanContext getContext() {
    return context;
  }

  public void setContext(ActionBeanContext context) {
    this.context = context;
  }

  @DefaultHandler
  public Resolution getTheUsername() {
    System.out.println("HELLO");
    UserDAO uDAO = new UserDAO();
    System.out.println("user being retrieved: " + username);
    User user1 = uDAO.getUser(username);

    result = user1.getFirstName();
    //  result ="hello";
    return new ForwardResolution("/adminView.jsp");
  }
}
