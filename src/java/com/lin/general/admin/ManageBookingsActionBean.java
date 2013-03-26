/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.BlockDAO;
import com.lin.dao.RoleDAO;
import com.lin.dao.UserDAO;
import com.lin.dao.BookingDAO;
import com.lin.dao.FacilityDAO;
import com.lin.dao.FacilityTypeDAO;
import com.lin.entities.*;

import com.lin.general.login.BaseActionBean;
import com.lin.general.login.LoginActionBean;
import com.lin.general.login.MyAppActionBeanContext;
import java.text.DecimalFormat;
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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import net.sourceforge.stripes.action.*;


public class ManageBookingsActionBean extends BaseActionBean {

    private ArrayList<User> userList;
    private ArrayList<FacilityType> facilityTypeList;
    private ArrayList<Booking> bookingList;
    private ArrayList<Booking> bookingListForSingleFacility;
    //private User user;
    private Booking booking;
    private Log log = Log.getInstance(ManageBookingsActionBean.class);//in attempt to log what went wrong..
    private String id;
    private String username;
    private String firstName;
    private String lastName;
    private Facility facility;
    private String facilityType;
    private int facilityId;
    private String startDate;
    private String endDate;
    private String isPaid;
    private String transactionID;
    private boolean success = false;
    private User currentUser;

    public ArrayList<Booking> getBookingListForSingleFacility() {
        bookingListForSingleFacility = getAllBookingsByFacilityID(facilityId);
        System.out.println("size" + bookingListForSingleFacility.size());
        return bookingListForSingleFacility;
    }

    public void setBookingListForSingleFacility(ArrayList<Booking> bookingListForSingleFacility) {
        this.bookingListForSingleFacility = bookingListForSingleFacility;
    }
    
    public ArrayList<OpenRule> getOpenRulesByFacilityID(int fid){
        FacilityDAO fDAO = new FacilityDAO();
        return fDAO.getFacility(fid).getFacilityType().getSortedOpenRules();
    }
    
    
    public Booking getBooking() {
        return booking;
    }

    public String getId() {
        return id;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getFacilityType() {
        return facilityType;
    }

    public int getFacilityId() {
        return facilityId;
    }

    public String getStartDate() {
        return startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public String getIsPaid() {
        return isPaid;
    }

    public String getTransactionID() {
        return transactionID;
    }

    public boolean isSuccess() {
        return success;
    }

    public Log getLog() {
        return log;
    }

    public String getUsername() {
        return username;
    }

    public Facility getFacility() {
        return facility;
    }

    public void setFacility(Facility facility) {
        this.facility = facility;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    public void setLog(Log log) {
        this.log = log;
    }

    public void setId(String id) {
        System.out.println("SETTED");
        this.id = id;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setFacilityType(String facilityType) {
        this.facilityType = facilityType;
    }

    public void setFacilityId(int facilityId) {
        this.facilityId = facilityId;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public void setIsPaid(String isPaid) {
        this.isPaid = isPaid;
    }

    public void setTransactionID(String transactionID) {
        this.transactionID = transactionID;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    // this method is for debugging to check the size of the userList
    public int getSize() {
        return userList.size();
    }

    public User getCurrentUser() {
        /*User u = null;
        try {
        //HttpServletRequest request = super.getContext().getRequest();
        //HttpSession session = request.getSession();
        //System.out.println(session.getId());
        //u = ${LoginActionBean.currentUser};
        //this.getContext();
        //this.getContext().getRequest();
        //this.getContext().getRequest().getSession();
        //HttpSession session = this.getContext().getRequest().getSession();
        MyAppActionBeanContext c = this.getContext();
        if(c == null) System.out.println("CNULL");
        u = c.getUser();
        System.out.println("YAYZERS" + u.toString());
        
        } catch (NullPointerException e) {
        e.printStackTrace();
        System.out.println("user is null");
        
        }*/
        return currentUser;
    }

    public void setCurrentUser(User currentUser) {
        this.currentUser = currentUser;
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

    public ArrayList<FacilityType> getFacilityTypeList() {
        FacilityTypeDAO fDAO = new FacilityTypeDAO();
        facilityTypeList = fDAO.retrieveAllFacilityTypes();
        return facilityTypeList;
    }

    public void setFacilityTypeList(ArrayList<FacilityType> facilityTypeList) {
        this.facilityTypeList = facilityTypeList;
    }

    public ArrayList<Booking> getBookingList() {
        BookingDAO bDAO = new BookingDAO();
        bookingList = bDAO.getAllBookings();
        System.out.println("No of Bookings: " + bookingList.size());
        return bookingList;
    }

    public ArrayList<Booking> getAllBookingsByFacilityID(int id) {
        BookingDAO bDAO = new BookingDAO();
        System.out.println("FACILITY: " + getFacility());
        bookingList = bDAO.getAllBookingsByFacilityID(id);
        System.out.println("No of Bookings by ID: " + bookingList.size());
        return bookingList;
    }

    public ArrayList<Booking> getUserCurrentBookingList() {
        User u = getCurrentUser();
        System.out.println(u.toString());
        BookingDAO bDAO = new BookingDAO();
        bookingList = bDAO.getUserCurrentBookings(u);
        System.out.println("No of Current Bookings: " + bookingList.size());
        return bookingList;
    }

    public ArrayList<Booking> getUserHistoricalBookingList() {
        User u = getCurrentUser();
        System.out.println(u.toString());
        BookingDAO bDAO = new BookingDAO();
        bookingList = bDAO.getUserHistoricalBookings(u);
        System.out.println("No of Historical Bookings: " + bookingList.size());
        return bookingList;
    }

    public void setBookingList(ArrayList<Booking> bookingList) {
        this.bookingList = bookingList;
    }

    /*
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
    
    User user1 = uDAO.createUser(roleObj, blockObj, password, username,
    firstname, lastname, dob, levelInt, unitInt);
    
    result = user1.getFirstname();
    success = true;
    System.out.println(user1);
    } catch (Exception e) {
    result = "";
    success = false;
    }
    return new RedirectResolution("/admin/manageusers.jsp?createsuccess=" + success
    + "&createmsg=" + result);
    }*/
    @HandlesEvent("deleteBooking")
    public Resolution deleteBooking() {
        BookingDAO bDAO = new BookingDAO();
        bDAO.switchToDelete(Integer.parseInt(getId()));
        return new RedirectResolution("/residents/mybookings.jsp");
    }

    @DefaultHandler
    public Resolution setFType() {
        System.out.println("HELLO " + getFacilityType());
        return new RedirectResolution("/residents/index.jsp?ftype=" + getFacilityType());
    }
    public long getNumberOfNewBookingsThisWeek(){
        BookingDAO bDAO = new BookingDAO();
        return bDAO.getNumberOfNewBookingsThisWeek();
    }
    public long getNumberOfNewBookingsLastWeek(){
        BookingDAO bDAO = new BookingDAO();
        return bDAO.getNumberOfNewBookingsLastWeek();
    }
    public double getPercentChange(){
        BookingDAO bDAO = new BookingDAO();
        long thisWeek = bDAO.getNumberOfNewBookingsThisWeek();
        long lastWeek = bDAO.getNumberOfNewBookingsLastWeek();
        long change = thisWeek - lastWeek;
        double percentChange = (double)change/lastWeek*100;
        DecimalFormat df = new DecimalFormat("#.##");
        return Double.parseDouble(df.format(percentChange));
    }
}
