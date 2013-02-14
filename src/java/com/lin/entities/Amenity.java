package com.lin.entities;
// Generated Feb 15, 2013 4:09:17 AM by Hibernate Tools 3.2.1.GA

import org.apache.commons.lang3.StringEscapeUtils;




/**
 * Amenity generated by hbm2java
 */
public class Amenity  implements java.io.Serializable {


     private Integer id;
     private AmenityCategory amenityCategory;
     private String name;
     private String description;
     private String postalCode;
     private String contactNo;
     private String unitNo;
     private String streetName;

    public Amenity() {
    }

	
    public Amenity(AmenityCategory amenityCategory, String name, String postalCode) {
        this.amenityCategory = amenityCategory;
        this.name = name;
        this.postalCode = postalCode;
    }
    public Amenity(AmenityCategory amenityCategory, String name, String description, String postalCode, String contactNo, String unitNo, String streetName) {
       this.amenityCategory = amenityCategory;
       this.name = name;
       this.description = description;
       this.postalCode = postalCode;
       this.contactNo = contactNo;
       this.unitNo = unitNo;
       this.streetName = streetName;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public AmenityCategory getAmenityCategory() {
        return this.amenityCategory;
    }
    
    public void setAmenityCategory(AmenityCategory amenityCategory) {
        this.amenityCategory = amenityCategory;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public String getPostalCode() {
        return this.postalCode;
    }
    
    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }
    public String getContactNo() {
        return this.contactNo;
    }
    
    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }
    public String getUnitNo() {
        return this.unitNo;
    }
    
    public void setUnitNo(String unitNo) {
        this.unitNo = unitNo;
    }
    public String getStreetName() {
        return this.streetName;
    }
    
    public void setStreetName(String streetName) {
        this.streetName = streetName;
    }

     public String getEscapedName() {
        return StringEscapeUtils.escapeEcmaScript(name);
    }
     
     public String getEscapedDescription() {
        return StringEscapeUtils.escapeEcmaScript(description);
    }    

     public String getUnescapedName() {
        return StringEscapeUtils.unescapeEcmaScript(name);
    }
     
     public String getUnescapedDescription() {
        return StringEscapeUtils.unescapeEcmaScript(description);
    }    

}


