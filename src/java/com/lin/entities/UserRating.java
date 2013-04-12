package com.lin.entities;
// Generated Jan 28, 2013 3:05:34 PM by Hibernate Tools 3.2.1.GA


import java.util.Date;


/**
 * User generated by hbm2java
 */
public class UserRating  implements java.io.Serializable {


     private Integer id;
     private User user;
     private Integer rating;
     private Date timeStamp;

    public UserRating() {
    }

    public UserRating(User user, Integer rating) {
        this.user = user;
        this.rating = rating;
    }

    public UserRating(Integer id, User user, Integer rating, Date timeStamp) {
        this.id = id;
        this.user = user;
        this.rating = rating;
        this.timeStamp = timeStamp;
    }

    public Date getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(Date timeStamp) {
        this.timeStamp = timeStamp;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    

}

