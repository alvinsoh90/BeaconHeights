package com.lin.entities;
// Generated Oct 24, 2012 12:17:41 AM by Hibernate Tools 3.2.1.GA



/**
 * Facility generated by hbm2java
 */
public class Facility  implements java.io.Serializable {


     private Integer id;
     private FacilityType facilityType;
     private int facilityLng;
     private int facilityLat;

    public Facility() {
    }

    public Facility(FacilityType facilityType, int facilityLng, int facilityLat) {
       this.facilityType = facilityType;
       this.facilityLng = facilityLng;
       this.facilityLat = facilityLat;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public FacilityType getFacilityType() {
        return this.facilityType;
    }
    
    public void setFacilityType(FacilityType facilityType) {
        this.facilityType = facilityType;
    }
    public int getFacilityLng() {
        return this.facilityLng;
    }
    
    public void setFacilityLng(int facilityLng) {
        this.facilityLng = facilityLng;
    }
    public int getFacilityLat() {
        return this.facilityLat;
    }
    
    public void setFacilityLat(int facilityLat) {
        this.facilityLat = facilityLat;
    }




}


