package com.lin.entities;
// Generated Jan 20, 2013 12:52:18 PM by Hibernate Tools 3.2.1.GA


import java.util.Date;

/**
 * FormTemplate generated by hbm2java
 */
public class FormTemplate  implements java.io.Serializable {


     private Integer id;
     private String name;
     private String description;
     private String category;
     private String fileName;
     private Date timeModified;

    public FormTemplate() {
    }

    public FormTemplate(String name, String description, String category, String fileName, Date timeModified) {
       this.name = name;
       this.description = description;
       this.category = category;
       this.fileName = fileName;
       this.timeModified = timeModified;
    }
    
    public FormTemplate(String name, String description, String category, String fileName) {
       this.name = name;
       this.description = description;
       this.category = category;
       this.fileName = fileName;
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
    public String getCategory() {
        return this.category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    public String getFileName() {
        return this.fileName;
    }
    
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    public Date getTimeModified() {
        return this.timeModified;
    }
    
    public void settimeModified(Date timeModified) {
        this.timeModified = timeModified;
    }




}

