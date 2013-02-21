package com.lin.entities;
// Generated Feb 22, 2013 4:39:59 AM by Hibernate Tools 3.2.1.GA


import java.util.Date;

/**
 * PostLike generated by hbm2java
 */
public class PostLike  implements java.io.Serializable {


     private Integer id;
     private Date timestamp;
     private User user;
     private Post post;

    public PostLike() {
    }

    public PostLike(User user, Post post) {
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


