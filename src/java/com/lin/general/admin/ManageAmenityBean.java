/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.AmenityDAO;
import com.lin.dao.AmenityTypeDAO;
import com.lin.entities.Amenity;
import com.lin.entities.AmenityCategory;
import java.util.ArrayList;

/**
 *
 * @author fayannefoo
 */
public class ManageAmenityBean {

    private String name;
    private String description;
    private String address;
    private int postalCode;
    private String contactNo;
    private int lat;
    private int lng;
    private String category;
    private ArrayList<Amenity> amenityList;
    private ArrayList<AmenityCategory> categoryList;

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getLat() {
        return lat;
    }

    public void setLat(int lat) {
        this.lat = lat;
    }

    public int getLng() {
        return lng;
    }

    public void setLng(int lng) {
        this.lng = lng;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(int postalCode) {
        this.postalCode = postalCode;
    }

    public ArrayList<Amenity> getAmenityList() {
        AmenityDAO aDAO = new AmenityDAO();
        amenityList = aDAO.retrieveAllAmenities();
        return amenityList;
    }

    public ArrayList<Amenity> getAmenityListByCategory(String category) {
        AmenityDAO aDAO = new AmenityDAO();
        amenityList = aDAO.retrieveAmenitiesByCategory(category);
        return amenityList;
    }

    public ArrayList<String> getCategoryList() {
        ArrayList<String> catList = new ArrayList<String>();
        AmenityTypeDAO aTypeDAO = new AmenityTypeDAO();
        categoryList = aTypeDAO.retrieveAmenityCategories();
        try {
            for (AmenityCategory a : categoryList) {
                catList.add(a.getName());
                System.out.println(a.getName());
            }
        } catch (NullPointerException e) {
            e.printStackTrace();
        }
        return catList;
    }
    
    
}
