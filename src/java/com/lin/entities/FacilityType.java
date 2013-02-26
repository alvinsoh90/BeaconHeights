package com.lin.entities;
// Generated Dec 12, 2012 6:43:41 PM by Hibernate Tools 3.2.1.GA


import com.lin.comparators.SortOpenRuleByDayOfWeekComparator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import org.apache.commons.lang3.StringEscapeUtils;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

/**
 * FacilityType generated by hbm2java
 */
public class FacilityType  implements java.io.Serializable {


     private Integer id;
     private String name;
     private String description;
     private boolean needsPayment;
     private Double bookingFees;
     private Double bookingDeposit;
     private Set limitRules = new HashSet(0);
     private Set advanceRules = new HashSet(0);
     private Set facilities = new HashSet(0);
     private Set openRules = new HashSet(0);
     private Set closeRules = new HashSet(0);
     

    public FacilityType() {
    }
    
    public FacilityType(String name, String description, boolean needsPayment) {
        this.name = name;
        this.description = description;
        this.needsPayment = needsPayment;
    }
	
    public FacilityType(String name, String description, boolean needsPayment, Double bookingFees, Double bookingDeposit) {
        this.name = name;
        this.description = description;
        this.needsPayment = needsPayment;
        this.bookingFees = bookingFees;
        this.bookingDeposit = bookingDeposit;
    }
    public FacilityType(String name, String description, boolean needsPayment, Set limitRules, Set advanceRules, Set facilities, Set openRules, Set closeRules) {
       this.name = name;
       this.description = description;
       this.limitRules = limitRules;
       this.advanceRules = advanceRules;
       this.facilities = facilities;
       this.openRules = openRules;
       this.closeRules = closeRules;
    }
    
     public FacilityType(String name, String description, boolean needsPayment, Set limitRules, Set advanceRules, Set openRules, Set closeRules) {
       this.name = name;
       this.description = description;
       this.limitRules = limitRules;
       this.advanceRules = advanceRules;
       this.openRules = openRules;
       this.closeRules = closeRules;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
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

    public boolean isNeedsPayment() {
        return needsPayment;
    }

    public void setNeedsPayment(boolean needsPayment) {
        this.needsPayment = needsPayment;
    }

    public Double getBookingDeposit() {
        return bookingDeposit;
    }

    public void setBookingDeposit(Double bookingDeposit) {
        this.bookingDeposit = bookingDeposit;
    }

    public Double getBookingFees() {
        return bookingFees;
    }

    public void setBookingFees(Double bookingFees) {
        this.bookingFees = bookingFees;
    }
    
    @Fetch(FetchMode.JOIN)
    public Set getLimitRules() {
        return this.limitRules;
    }
    @Fetch(FetchMode.JOIN)
    public void setLimitRules(Set limitRules) {
        this.limitRules = limitRules;
    }
    @Fetch(FetchMode.JOIN)
    public Set getAdvanceRules() {
        return this.advanceRules;
    }
    
    public ArrayList<OpenRule> getSortedOpenRules(){ 
        //starts with sunday and ends with sat
        ArrayList<OpenRule> l = new ArrayList<OpenRule>();
        l.addAll(getOpenRules());
        Collections.sort(l,new SortOpenRuleByDayOfWeekComparator());
        return l;
    }
    
    @Fetch(FetchMode.JOIN)
    public void setAdvanceRules(Set advanceRules) {
        this.advanceRules = advanceRules;
    }
    
    public Set getFacilities() {
        return this.facilities;
    }
    
    public void setFacilities(Set facilities) {
        this.facilities = facilities;
    }
    @Fetch(FetchMode.JOIN)
    public Set getOpenRules() {
        return this.openRules;
    }
    @Fetch(FetchMode.JOIN)
    public void setOpenRules(Set openRules) {
        this.openRules = openRules;
    }
    @Fetch(FetchMode.JOIN)
    public Set getCloseRules() {
        return this.closeRules;
    }
    @Fetch(FetchMode.JOIN)
    public void setCloseRules(Set closeRules) {
        this.closeRules = closeRules;
    }

    public String getNeedsPaymentString(){
        if(needsPayment){
            return "Yes";
        }else{
            return "No";
        }
    }
    
    public String getEscapedName() {
        return StringEscapeUtils.escapeEcmaScript(name);
    }


}


