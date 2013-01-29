package com.lin.entities;
// Generated Jan 28, 2013 3:05:34 PM by Hibernate Tools 3.2.1.GA


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * User generated by hbm2java
 */
public class User  implements java.io.Serializable {


     private Integer userId;
     private Role role;
     private Block block;
     private String password;
     private String userName;
     private String firstname;
     private String lastname;
     private Date dob;
     private Integer level;
     private Integer unit;
     private String facebookId;
     private String mobileNo;
     private String email;
     private Date birthday;
     private String studiedAt;
     private String worksAt;
     private String aboutMe;
     private String vehicleNumberPlate;
     private String vehicleType;
     private String profilePicFilename;
     private Set submittedForms = new HashSet(0);
     private Set posts = new HashSet(0);
     private Set bookings = new HashSet(0);

    public User() {
    }

	
    public User(Role role, String password, String userName, String firstname, String lastname, Date dob) {
        this.role = role;
        this.password = password;
        this.userName = userName;
        this.firstname = firstname;
        this.lastname = lastname;
        this.dob = dob;
    }
    
    public User(Role role, Block block, String password, String userName,
            String firstname, String lastname, Date dob, String email,
            String mobileNo, Integer level, Integer unit) {
        this.role = role;
        this.block = block;
        this.password = password;
        this.userName = userName;
        this.firstname = firstname;
        this.lastname = lastname;
        this.dob = dob;
        this.email = email;
        this.mobileNo = mobileNo;
        this.level = level;
        this.unit = unit;
    }
    
    public User(Role role, Block block, String password, String userName,
            String firstname, String lastname, Date dob, String email,
            String mobileNo, Integer level, Integer unit, String profilePicFilename) {
        this.role = role;
        this.block = block;
        this.password = password;
        this.userName = userName;
        this.firstname = firstname;
        this.lastname = lastname;
        this.dob = dob;
        this.email = email;
        this.mobileNo = mobileNo;
        this.level = level;
        this.unit = unit;
        this.profilePicFilename = profilePicFilename;
    }
    
    public User(Role role, Block block, String password, String userName,
            String firstname, String lastname, Date dob, String email,
            String mobileNo, Integer level, Integer unit, String vehicleNumberPlate, String vehicleType) {
        this.role = role;
        this.block = block;
        this.password = password;
        this.userName = userName;
        this.firstname = firstname;
        this.lastname = lastname;
        this.dob = dob;
        this.email = email;
        this.mobileNo = mobileNo;
        this.level = level;
        this.unit = unit;
        this.vehicleNumberPlate = vehicleNumberPlate;
        this.vehicleType = vehicleType;
    }
    
    public User(Role role, Block block, String password, String userName, String firstname, String lastname, Date dob, Integer level, Integer unit, String facebookId, String mobileNo, String email, Date birthday, String studiedAt, String worksAt, String aboutMe, String vehicleNumberPlate, String vehicleType, String profilePicFilename, Set submittedForms, Set posts, Set bookings) {
       this.role = role;
       this.block = block;
       this.password = password;
       this.userName = userName;
       this.firstname = firstname;
       this.lastname = lastname;
       this.dob = dob;
       this.level = level;
       this.unit = unit;
       this.facebookId = facebookId;
       this.mobileNo = mobileNo;
       this.email = email;
       this.birthday = birthday;
       this.studiedAt = studiedAt;
       this.worksAt = worksAt;
       this.aboutMe = aboutMe;
       this.vehicleNumberPlate = vehicleNumberPlate;
       this.vehicleType = vehicleType;
       this.profilePicFilename = profilePicFilename;
       this.submittedForms = submittedForms;
       this.posts = posts;
       this.bookings = bookings;
    }

    public String getProfilePicFilename() {
        return profilePicFilename;
    }

    public void setProfilePicFilename(String profilePicFilename) {
        this.profilePicFilename = profilePicFilename;
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
   
    public Integer getUserId() {
        return this.userId;
    }
    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    public Role getRole() {
        return this.role;
    }
    
    public void setRole(Role role) {
        this.role = role;
    }
    public Block getBlock() {
        return this.block;
    }
    
    public void setBlock(Block block) {
        this.block = block;
    }
    public String getPassword() {
        return this.password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    public String getUserName() {
        return this.userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getFirstname() {
        return this.firstname;
    }
    
    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }
    public String getLastname() {
        return this.lastname;
    }
    
    public void setLastname(String lastname) {
        this.lastname = lastname;
    }
    public Date getDob() {
        return this.dob;
    }
    
    public void setDob(Date dob) {
        this.dob = dob;
    }
    public Integer getLevel() {
        return this.level;
    }
    
    public void setLevel(Integer level) {
        this.level = level;
    }
    public Integer getUnit() {
        return this.unit;
    }
    
    public void setUnit(Integer unit) {
        this.unit = unit;
    }
    public String getFacebookId() {
        return this.facebookId;
    }
    
    public void setFacebookId(String facebookId) {
        this.facebookId = facebookId;
    }
    public String getMobileNo() {
        return this.mobileNo;
    }
    
    public void setMobileNo(String mobileNo) {
        this.mobileNo = mobileNo;
    }
    public String getEmail() {
        return this.email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    public Date getBirthday() {
        return this.birthday;
    }
    
    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }
    public String getStudiedAt() {
        return this.studiedAt;
    }
    
    public void setStudiedAt(String studiedAt) {
        this.studiedAt = studiedAt;
    }
    public String getWorksAt() {
        return this.worksAt;
    }
    
    public void setWorksAt(String worksAt) {
        this.worksAt = worksAt;
    }
    public String getAboutMe() {
        return this.aboutMe;
    }
    
    public void setAboutMe(String aboutMe) {
        this.aboutMe = aboutMe;
    }
    public Set getSubmittedForms() {
        return this.submittedForms;
    }
    
    public void setSubmittedForms(Set submittedForms) {
        this.submittedForms = submittedForms;
    }
    public Set getPosts() {
        return this.posts;
    }
    
    public void setPosts(Set posts) {
        this.posts = posts;
    }
    public Set getBookings() {
        return this.bookings;
    }
    
    public void setBookings(Set bookings) {
        this.bookings = bookings;
    }




}


