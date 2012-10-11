/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.entities.*;

import java.util.ArrayList;
import java.util.HashMap;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.util.Log;


public class ManageUsersActionBean implements ActionBean {

  private ActionBeanContext context;
  private HashMap<String,User> userList;
  private User user;
  private Log log = Log.getInstance(ManageUsersActionBean.class);//in attempt to log what went wrong..
  private String test = "test";
  
  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user=user;
  }
  

  // this method is for debugging to check the size of the userList
  public int getSize() {
    return userList.size();
  }

  public String getTest() {
        return test;
    }
  
  
  public void setUserList(HashMap<String, User> userList) {
        this.userList = userList;
  }
  
  public String getHigh() {
    return "highhhh...";
  }

  public ActionBeanContext getContext() {
    return context;
  }

  public void setContext(ActionBeanContext context) {
    this.context = context;
  }
  
  public HashMap<String,User> getUserList() {
    UserDAO uDAO = new UserDAO();
    userList= uDAO.retrieveAllUsers();
    return userList;
  }
  
  public int getListSize(){
    return userList.size();
  }
  
   public boolean deleteUser() {
    UserDAO uDAO = new UserDAO();
    boolean success = uDAO.deleteUser(user.getUsername());

    return success;
  }
  
}
