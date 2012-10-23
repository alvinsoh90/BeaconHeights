package com.lin.entities;
// Generated Oct 23, 2012 11:45:56 PM by Hibernate Tools 3.2.1.GA


import java.util.Date;

/**
 * Booking generated by hbm2java
 */
public class Booking  implements java.io.Serializable {


     private Integer id;
     private User user;
     private Date bookingTimeStamp;
     private Date startDate;
     private Date endDate;
     private boolean isPaid;
     private String transactionId;

    public Booking() {
    }

    public Booking(User user, Date bookingTimeStamp, Date startDate, Date endDate, boolean isPaid, String transactionId) {
       this.user = user;
       this.bookingTimeStamp = bookingTimeStamp;
       this.startDate = startDate;
       this.endDate = endDate;
       this.isPaid = isPaid;
       this.transactionId = transactionId;
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




}


