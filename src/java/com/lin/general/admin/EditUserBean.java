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
import com.lin.general.login.BaseActionBean;
import java.util.ArrayList;
import java.util.Date;
import java.text.SimpleDateFormat;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;

/**
 *
 * @author Yangsta
 */
public class EditUserBean extends BaseActionBean{
  private ActionBeanContext context;
  private ArrayList<User> userList;
  private ArrayList<Role> roleList;
  private User user;
  
  private String id;
  private String username;
  private String password;
  private String firstname;
  private String lastname;
  private String block;
  private String email;
  private String mobileno;
  private String level;
  private String unitnumber;
  private String facebookId;
  private String role;
  private String birthday;
  private String birthday_submit;
  private String studiedAt;
  private String worksAt;
  private String aboutMe;
  private String vehicleNumberPlate;
  private String vehicleType;
  
    public Resolution editUser(){
        this.getRoleList();
        UserDAO dao = new UserDAO();
        BlockDAO blockDao = new BlockDAO();
        RoleDAO roleDao = new RoleDAO();
        //System.out.println("ROLE ID "+ role);
        Role roleObj = roleDao.getRoleById(Integer.parseInt(role));
        Block blockObj = blockDao.getBlockByName(block);
        //System.out.println("BLOCK NAME : "+block);
        try{
            dao.updateUser
                    (
                        Integer.parseInt(id),
                        roleObj,
                        blockObj,
                        username,
                        firstname,
                        lastname,
                        email,
                        mobileno,
                        Integer.parseInt(level),
                        Integer.parseInt(unitnumber),
                        vehicleNumberPlate,
                        vehicleType
                    );
            return new RedirectResolution("/admin/users.jsp?editsuccess=true&editmsg="+username);
        }
        catch(Exception e){
            e.printStackTrace(); 
        }
        return new RedirectResolution("/admin/users.jsp?editsuccess=false");
        
    }

    @HandlesEvent("editUserProfile")
    public Resolution editUserProfile(){
        this.getRoleList();
        UserDAO dao = new UserDAO();
        BlockDAO blockDao = new BlockDAO();
        RoleDAO roleDao = new RoleDAO();
        //System.out.println("ROLE ID "+ role);
        Role roleObj = roleDao.getRoleById(Integer.parseInt(role));
        Block blockObj = blockDao.getBlockByName(block);
        //System.out.println("BLOCK NAME : "+block);
        Date bday=null;
        try{
            SimpleDateFormat fmt = new SimpleDateFormat("yyyy-mm-dd");
            bday = (Date) fmt.parse(birthday_submit);
            
        }
        catch(Exception e){
            e.printStackTrace();
        }
        try{
            User u = dao.updateUser
                    (
                        Integer.parseInt(id),
                        roleObj,
                        blockObj,
                        username,
                        firstname,
                        lastname,
                        email,
                        mobileno,
                        Integer.parseInt(level),
                        Integer.parseInt(unitnumber),
                        facebookId,
                        bday,
                        studiedAt,
                        worksAt,
                        aboutMe
                    );
            
            getContext().setUser(u);
            return new RedirectResolution("/residents/profile.jsp?profileid="+id+"&editsuccess=true&editmsg="+username);
            
        }
        catch(Exception e){
            e.printStackTrace(); 
        }
        return new RedirectResolution("/residents/profile.jsp?profileid="+id+"&editsuccess=false");
        
    }
    
    public void setNotFirstLoad(int userId){
        UserDAO uDAO = new UserDAO();
        User u = uDAO.setNotFirstLoad(userId);
        getContext().setUser(u);
    }
    
    public boolean checkAndSetFirstLoad(int userId){
//        System.out.println("USER ID : "+userId);
        UserDAO uDAO = new UserDAO();
        User u = uDAO.checkAndSetFirstLoad(userId);
        if(u!=null){
//            System.out.println("USER STUFF: "+ u.getFirstname());
//            System.out.println("PRINT CONTEXT : "+getContext());
            //getContext().setUser(u);
//            System.out.println("FIRST LOAD");
            return true;
        }else{
//            System.out.println("NOT FIRST LOAD");
            return false;
        }    
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

    public String getBirthday() {
        return birthday;
    }

    public String getBirthday_submit() {
        return birthday_submit;
    }

    public void setBirthday_submit(String birthday_submit) {
        this.birthday_submit = birthday_submit;
    }

    public String getFacebookId() {
        return facebookId;
    }

    public void setFacebookId(String facebookId) {
        this.facebookId = facebookId;
    }
    
    public void setDate(String date) {
        this.birthday = birthday;
    }

    public String getStudiedAt() {
        return studiedAt;
    }

    public void setStudiedAt(String studiedAt) {
        this.studiedAt = studiedAt;
    }

    public String getWorksAt() {
        return worksAt;
    }

    public void setWorksAt(String worksAt) {
        this.worksAt = worksAt;
    }

    public String getAboutMe() {
        return aboutMe;
    }

    public void setAboutMe(String aboutMe) {
        this.aboutMe = aboutMe;
    }
    
    public ArrayList<Role> getRoleList(){
        RoleDAO roleDAO = new RoleDAO(); 
        roleList = roleDAO.getAllRoles();
        return roleList;
    }
    
    public ArrayList<User> getUserList() {
        UserDAO uDAO = new UserDAO();
        userList = uDAO.retrieveAllUsers();
        return userList;
    }

}
