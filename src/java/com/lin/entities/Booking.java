package com.lin.entities;
// Generated Feb 8, 2013 1:00:06 AM by Hibernate Tools 3.2.1.GA


import java.util.Date;

/**
 * Booking generated by hbm2java
 */
public class Booking  implements java.io.Serializable {


     private Integer id;
     private User user;
     private Facility facility;
     private Date bookingTimeStamp;
     private Date startDate;
     private Date endDate;
     private boolean isPaid;
     private String transactionId;
     private Date transactionTimeStamp;
     private String title;
     private Boolean isDeleted;
     private String level;
     private String unit;

    public Booking() {
    }

    public Booking(User user, Facility facility, Date bookingTimeStamp, Date startDate,
            Date endDate, String title, boolean isPaid, boolean isDeleted, String level, String unit) {
        this.user = user;
        this.facility = facility;
        this.bookingTimeStamp = bookingTimeStamp;
        this.startDate = startDate;
        this.endDate = endDate;
        this.title = title;
        this.isPaid = isPaid;
        this.isDeleted = isDeleted;
        this.level = level;
        this.unit = unit;
    }
     
    public Booking(User user, Facility facility, Date bookingTimeStamp, Date startDate, Date endDate, boolean isPaid) {
        this.user = user;
        this.facility = facility;
        this.bookingTimeStamp = bookingTimeStamp;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isPaid = isPaid;
    }
    public Booking(User user, Facility facility, Date bookingTimeStamp, Date startDate, Date endDate, boolean isPaid, String transactionId, Date transactionTimeStamp, String title, Boolean isDeleted, String level, String unit) {
       this.user = user;
       this.facility = facility;
       this.bookingTimeStamp = bookingTimeStamp;
       this.startDate = startDate;
       this.endDate = endDate;
       this.isPaid = isPaid;
       this.transactionId = transactionId;
       this.transactionTimeStamp = transactionTimeStamp;
       this.title = title;
       this.isDeleted = isDeleted;
       this.level = level;
       this.unit = unit;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Facility getFacility() {
        return this.facility;
    }
    
    public void setFacility(Facility facility) {
        this.facility = facility;
    }
    public Date getBookingTimeStamp() {
        return this.bookingTimeStamp;
    }
    
    public void setBookingTimeStamp(Date bookingTimeStamp) {
        this.bookingTimeStamp = bookingTimeStamp;
    }
    public Date getStartDate() {
        return this.startDate;
    }
    
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    public Date getEndDate() {
        return this.endDate;
    }
    
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    public boolean isIsPaid() {
        return this.isPaid;
    }
    
    public void setIsPaid(boolean isPaid) {
        this.isPaid = isPaid;
    }
    public String getTransactionId() {
        return this.transactionId;
    }
    
    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }
    public Date getTransactionTimeStamp() {
        return this.transactionTimeStamp;
    }
    
    public void setTransactionTimeStamp(Date transactionTimeStamp) {
        this.transactionTimeStamp = transactionTimeStamp;
    }
    public String getTitle() {
        return this.title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    public Boolean getIsDeleted() {
        return this.isDeleted;
    }
    
    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
    }
    public String getLevel() {
        return this.level;
    }
    
    public void setLevel(String level) {
        this.level = level;
    }
    public String getUnit() {
        return this.unit;
    }
    
    public void setUnit(String unit) {
        this.unit = unit;
    }

    public long getStartTimeInSeconds() {
        return startDate.getTime();
    }
    
    public long setStartTimeInSeconds() {
        return startDate.getTime();
    }
    
    public long getEndTimeInSeconds() {
        return endDate.getTime();
    }
    
    public long setEndTimeInSeconds() {
        return endDate.getTime();
    }

}


