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
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;

/**
 *
 * @author Yangsta
 */
public class EditUserBean implements ActionBean{
  private ActionBeanContext context;
  private User user;
  
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

    public Resolution editUser(){
        UserDAO dao = new UserDAO();
        BlockDAO blockDao = new BlockDAO();
        RoleDAO roleDao = new RoleDAO();
        
        Role roleObj = roleDao.getRoleByName(role);
        Block blockObj = blockDao.getBlockByName(block);
        
        try{
            dao.updateUser
                    (
                        Long.parseLong(id),
                        username,
                        password,
                        firstname,
                        lastname,
                        blockObj,
                        Integer.parseInt(level),
                        Integer.parseInt(unitnumber),
                        roleObj
                    );
            return new RedirectResolution("/admin/manageusers.jsp?editsuccess=true");
        }
        catch(Exception e){
            e.printStackTrace(); 
        }
        return new RedirectResolution("/admin/manageusers.jsp?editsuccess=false");
        
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
  

}
