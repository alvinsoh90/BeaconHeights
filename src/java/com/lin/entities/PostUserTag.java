package com.lin.entities;
// Generated Feb 24, 2013 5:43:45 PM by Hibernate Tools 3.2.1.GA


import java.util.Date;

/**
 * PostUserTag generated by hbm2java
 */
public class PostUserTag  implements java.io.Serializable {


     private Integer id;
     private Date timestamp;
     private User user;
     private Post post;

    public PostUserTag() {
    }

    public PostUserTag(User user, Post post) {
       this.user = user;
       this.post = post;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public Date getTimestamp() {
        return this.timestamp;
    }
    
    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Post getPost() {
        return this.post;
    }
    
    public void setPost(Post post) {
        this.post = post;
    }




}


