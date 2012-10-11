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
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.util.Log;
import javax.persistence.*;

public class ManageUsersActionBean implements ActionBean {

  private ActionBeanContext context;
  private HashMap<String,User> userList;
  private User user;
  private Log log = Log.getInstance(ManageUsersActionBean.class);//in attempt to log what went wrong..
  

  private String username;
  private String password;
  private String passwordConfirm;
  private String firstname;
  private String lastname;
  private String block;
  private String level;
  private String unitnumber;
  private String role;
  private String result;
  private String test = "test";

  public String getBlock() {
    return block;
  }

  public String getFirstname() {
    return firstname;
  }

  public String getLastname() {
    return lastname;
  }

  public String getLevel() {
    return level;
  }

  public Log getLog() {
    return log;
  }

  public String getPassword() {
    return password;
  }

  public String getPasswordConfirm() {
    return passwordConfirm;
  }

  public String getResult() {
    return result;
  }

  public String getRole() {
    return role;
  }

  public String getUnitnumber() {
    return unitnumber;
  }

  public String getUsername() {
    return username;
  }

  public void setBlock(String block) {
    this.block = block;
  }

  public void setFirstname(String firstname) {
    this.firstname = firstname;
  }

  public void setLastname(String lastname) {
    this.lastname = lastname;
  }

  public void setLevel(String level) {
    this.level = level;
  }

  public void setLog(Log log) {
    this.log = log;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public void setPasswordConfirm(String passwordConfirm) {
    this.passwordConfirm = passwordConfirm;
  }

  public void setResult(String result) {
    this.result = result;
  }

  public void setRole(String role) {
    this.role = role;
  }

  public void setTest(String test) {
    this.test = test;
  }

  public void setUnitnumber(String unitnumber) {
    this.unitnumber = unitnumber;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  
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
  
  
  @DefaultHandler
  public Resolution createUserAccount() {

      
      try {
        UserDAO uDAO = new UserDAO();        
      //temp code while we sort out how to insert address info like block, unit etc.
        Role role1 = new Role(1,"admin","Admin user");
        Block block1 = new Block(1,"blockname",2,3,"Block1");
        int userID = 1;
        int levelInt = Integer.parseInt(level);
        int unitInt = Integer.parseInt(unitnumber);
      //int userID = 
        User user1 = uDAO.createUser(userID, username, password, firstname, lastname, block1, levelInt, unitInt, role1);
        result = user1.getFirst_name() + " has been created!";
        
      }catch(Exception e){
          result = e.getMessage();
      }
    return new RedirectResolution("/manageusers.jsp");
  }
  
}
