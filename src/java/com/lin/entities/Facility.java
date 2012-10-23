/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.entities;

/**
 *
 * @author Keffeine
 */
public class Facility {
    private long id;
    private double latitude;
    private double longitude;
    private FacilityType type;

    public Facility(long id, double latitude, double longitude, FacilityType type) {
        this.id = id;
        this.latitude = latitude;
        this.longitude = longitude;
        this.type = type;
    }

    public Facility(double latitude, double longitude, FacilityType type) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.type = type;
    }

    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public FacilityType getType() {
        return type;
    }

    public void setType(FacilityType type) {
        this.type = type;
    }
    

    @Override
    public String toString() {
        return "Facility{" + "id=" + id + ", latitude=" + latitude + ", longitude=" + longitude + '}';
    }

    
    
}
