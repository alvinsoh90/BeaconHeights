/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.entities;
//import javax.persistence.*;

/**
 *
 * @author Keffeine
 */
public class User {
    private long id;
    private String username;
    private String password;
    private String first_name;
    private String last_name;
    private Block block;
    private int level;
    private int unit;
    private Role role;

    public User(long id, String username, String password, String first_name, 
            String last_name, Block block, int level, int unit, Role role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.first_name = first_name;
        this.last_name = last_name;
        this.block = block;
        this.level = level;
        this.unit = unit;
        this.role = role;
    }

    public Block getBlock() {
        return block;
    }

    public void setBlock(Block block) {
        this.block = block;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public int getUnit() {
        return unit;
    }

    public void setUnit(int unit) {
        this.unit = unit;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    
    
}
