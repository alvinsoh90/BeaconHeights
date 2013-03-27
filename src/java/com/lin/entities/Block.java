package com.lin.entities;
// Generated Dec 30, 2012 4:03:04 PM by Hibernate Tools 3.2.1.GA


import java.util.HashSet;
import java.util.Set;

/**
 * Block generated by hbm2java
 */
public class Block  implements java.io.Serializable {


     private Integer id;
     private String blockName;
     private int blockLng;
     private int blockLat;
     private String blockDescription;
     private Integer levels;
     private Integer unitsPerFloor;
     private Set userTemps = new HashSet(0);
     private Set users = new HashSet(0);

    public Block() {
    }

	
    public Block(String blockName, int blockLng, int blockLat, String blockDescription) {
        this.blockName = blockName;
        this.blockLng = blockLng;
        this.blockLat = blockLat;
        this.blockDescription = blockDescription;
    }
    public Block(String blockName, int blockLng, int blockLat, String blockDescription, Integer levels, Integer unitsPerFloor, Set userTemps, Set users) {
       this.blockName = blockName;
       this.blockLng = blockLng;
       this.blockLat = blockLat;
       this.blockDescription = blockDescription;
       this.levels = levels;
       this.unitsPerFloor = unitsPerFloor;
       this.userTemps = userTemps;
       this.users = users;
    }
    
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public String getBlockName() {
        return this.blockName;
    }
    
    public void setBlockName(String blockName) {
        this.blockName = blockName;
    }
    public int getBlockLng() {
        return this.blockLng;
    }
    
    public void setBlockLng(int blockLng) {
        this.blockLng = blockLng;
    }
    public int getBlockLat() {
        return this.blockLat;
    }
    
    public void setBlockLat(int blockLat) {
        this.blockLat = blockLat;
    }
    public String getBlockDescription() {
        return this.blockDescription;
    }
    
    public void setBlockDescription(String blockDescription) {
        this.blockDescription = blockDescription;
    }
    public Integer getLevels() {
        return this.levels;
    }
    
    public void setLevels(Integer levels) {
        this.levels = levels;
    }
    public Integer getUnitsPerFloor() {
        return this.unitsPerFloor;
    }
    
    public void setUnitsPerFloor(Integer unitsPerFloor) {
        this.unitsPerFloor = unitsPerFloor;
    }
    public Set getUserTemps() {
        return this.userTemps;
    }
    
    public void setUserTemps(Set userTemps) {
        this.userTemps = userTemps;
    }
    public Set getUsers() {
        return this.users;
    }
    
    public void setUsers(Set users) {
        this.users = users;
    }




}


