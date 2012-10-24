/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.entities;

/**
 *
 * @author Keffeine
 */
public class FacilityType {
    private long id;
    private String name;
    private String description;

    public FacilityType(String name, String description) {
        this.name = name;
        this.description = description;
    }
    
    public FacilityType (long id, String name, String description){
        this.id = id;
        this.name = name;
        this.description = description;
    }
    
        public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "FacilityType{" + "id=" + id + ", name=" + name + ", description=" + description + '}';
    }
    
    
}
