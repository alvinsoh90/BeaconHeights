/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.BlockDAO;
import com.lin.dao.RoleDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.*;

import com.lin.utils.BCrypt;
import java.util.ArrayList;
import java.util.Date;
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
    private ArrayList<User> userList;
    private ArrayList<Role> roleList;
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
    private boolean success = false;
    private String email;
    private String mobileno;
    private String vehicleNumberPlate;
    private String vehicleType;
    private String currentlyViewUser;
    
    @DefaultHandler
    public Resolution createUserAccount() {
        try {
            UserDAO uDAO = new UserDAO();
            RoleDAO roleDao = new RoleDAO();
            BlockDAO blockDao = new BlockDAO();
            //temp code while we sort out how to insert address info like block, unit etc.
            Role roleObj = roleDao.getRoleByName(role);
            Block blockObj = blockDao.getBlockByName(block);

            int levelInt = Integer.parseInt(level);
            int unitInt = Integer.parseInt(unitnumber);
            Date dob = new Date();

            // salt password here, as uDAO method requires a salted password
            String salt = BCrypt.gensalt();
            String passwordHash = BCrypt.hashpw(password, salt);
            User user1 = uDAO.createUser(roleObj, blockObj, passwordHash, username,
                    firstname, lastname, dob,email,mobileno, levelInt, unitInt, vehicleNumberPlate, vehicleType);

            result = user1.getFirstname();
            success = true;
            System.out.println(user1);
        } catch (Exception e) {
            result = "";
            success = false;
        }
        return new RedirectResolution("/admin/users.jsp?createsuccess=" + success
                + "&createmsg=" + result);

    }

    public String getCurrentlyViewUser() {
        return currentlyViewUser;
    }

    public void setCurrentlyViewUser(String currentlyViewUser) {
        this.currentlyViewUser = currentlyViewUser;
    }

    public boolean deleteUser() {
        UserDAO uDAO = new UserDAO();
        boolean success = uDAO.deleteUser(user.getUserId());

        return success;
    }

    public String getVehicleNumberPlate() {
        return vehicleNumberPlate;
    }

    public void setVehicleNumberPlate(String vehicleNumberPlate) {
        this.vehicleNumberPlate = vehicleNumberPlate;
    }

    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }
    
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
        this.user = user;
    }

    // this method is for debugging to check the size of the userList
    public int getSize() {
        return userList.size();
    }

    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public int getListSize() {
        return userList.size();
    }

    public ArrayList<User> getUserList() {
        UserDAO uDAO = new UserDAO();
        userList = uDAO.retrieveAllUsers();
        return userList;
    }

    public void setUserList(ArrayList<User> userList) {
        this.userList = userList;
    }

    public ArrayList<Role> getRoleList() {
        RoleDAO roleDao = new RoleDAO();
        roleList = roleDao.getAllRoles();
        return roleList;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobileno() {
        return mobileno;
    }

    public void setMobileno(String mobileno) {
        this.mobileno = mobileno;
    }

    
}
