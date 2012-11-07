/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.BlockDAO;
import com.lin.dao.RoleDAO;
import com.lin.entities.User;
import com.lin.dao.UserDAO;
import com.lin.entities.Block;
import com.lin.entities.Role;
import com.lin.entities.UserTemp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;

/**
 *
 * @author Yangsta
 */
public class ApproveUserBean implements ActionBean{
  private ActionBeanContext context;
  private User user;
  private ArrayList<UserTemp> tempUserList;
  private ArrayList<Role> roleList;
  
  private String id;
  private String username;
  private String password;
  private String passwordConfirm;
  private String firstname;
  private String lastname;
  private String block;
  private String level;
  private String unitnumber;
  private String role;
  private String facebookId;
  private Date dob;

  String result;
  boolean success;
  
    public Resolution approveUserAction(){
        UserDAO dao = new UserDAO();
        BlockDAO blockDao = new BlockDAO();
        RoleDAO roleDao = new RoleDAO();
        
        Role roleObj = roleDao.getRoleById(Integer.parseInt(role));
        Block blockObj = blockDao.getBlockByName(block);
        int levelInt = Integer.parseInt(level);
        int unitInt = Integer.parseInt(unitnumber);
        UserTemp tempUser = dao.getUserTemp(Integer.parseInt(id));
        
        try{
            User newUser = dao.createUser(roleObj, blockObj, tempUser.getPassword(), username, firstname, lastname, new Date(), levelInt, unitInt);
            System.out.println(role + " " + block + " " +  tempUser.getPassword() + " " +  username + " " +  firstname + " " +  lastname + " " +  dob + " " +  levelInt + " " +  unitInt);
            System.out.println("THIS IS THE SECOND ID" + id);
            dao.removeTempUser(Integer.parseInt(id));
            result = tempUser.getFirstname();
            success = true;
            //System.out.println(user1);
        
            return new RedirectResolution("/admin/manageusers.jsp?approvesuccess=true&approvemsg="+username);
        }
        catch(Exception e){
            e.printStackTrace(); 
        }
        return new RedirectResolution("/admin/approveaccounts.jsp?approvesuccess=false");
        
    }
    
    public ArrayList<UserTemp> getTempUserList() {
        UserDAO uDAO = new UserDAO();
        tempUserList = uDAO.retrieveAllTempUsers();
        System.out.print("ok!"+tempUserList.get(0));
        return tempUserList;
    }
    
    public int getTempUserListCount() {
        UserDAO uDAO = new UserDAO();
        tempUserList = uDAO.retrieveAllTempUsers();
        System.out.print("ok!"+tempUserList.get(0));
        return tempUserList.size();
    }

    public void setTempUserList(ArrayList<UserTemp> tempUserList) {
        this.tempUserList = tempUserList;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    
    public String getBlock() {
        return block;
    }

    public void setBlock(String block) {
        this.block = block;
    }

    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getUnitnumber() {
        return unitnumber;
    }

    public void setUnitnumber(String unitnumber) {
        this.unitnumber = unitnumber;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
  
    public ArrayList<Role> getRoleList(){
        RoleDAO roleDAO = new RoleDAO(); 
        roleList = roleDAO.getAllRoles();
        return roleList;
  }

}
