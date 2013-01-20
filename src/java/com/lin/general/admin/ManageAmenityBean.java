/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.AmenityDAO;
import com.lin.dao.AmenityCategoryDAO;
import com.lin.entities.Amenity;
import com.lin.entities.AmenityCategory;
import java.util.ArrayList;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;

/**
 *
 * @author fayannefoo
 */
public class ManageAmenityBean implements ActionBean {

    private ActionBeanContext context;
    private int id;
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
    boolean outcome = false;

    @Override
    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    @Override
    public ActionBeanContext getContext() {
        return context;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

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

    public ArrayList<AmenityCategory> getCategoryList() {
        ArrayList<AmenityCategory> catList = new ArrayList<AmenityCategory>();
        AmenityCategoryDAO aCatDAO = new AmenityCategoryDAO();
        categoryList = aCatDAO.retrieveAmenityCategories();
        try {
            for (AmenityCategory a : categoryList) {
                catList.add(a);
                System.out.println(a.getName());
            }
        } catch (NullPointerException e) {
            e.printStackTrace();
        }
        return catList;
    }

    @HandlesEvent("deleteAmenityCategory")
    public Resolution deleteAmenityCategory() {
        System.out.println(getId());
        AmenityCategoryDAO aCatDAO = new AmenityCategoryDAO();
        outcome = aCatDAO.deleteAmenityType(getId());
        return new RedirectResolution("/admin/manage-amenitycategories.jsp?deletesuccess=" +
                outcome +"&createmsg="+getName());
    }

    @HandlesEvent("editAmenityCategory")
    public Resolution editAmenityCategory() {
        AmenityCategoryDAO aCatDAO = new AmenityCategoryDAO();
        outcome = aCatDAO.updateAmenityType(getId(), getName());
        return new RedirectResolution("/admin/manage-amenitycategories.jsp?editsuccess=" +
                outcome +"&createmsg="+getName());
    }

    @DefaultHandler
    public Resolution addAmenityCategory() {
        AmenityCategory aCat = new AmenityCategory(getName());
        AmenityCategoryDAO aCatDAO = new AmenityCategoryDAO();
        outcome = aCatDAO.addAmenityCategory(aCat);
        return new RedirectResolution("/admin/manage-amenitycategories.jsp?createsuccess=" +
                outcome +"&createmsg="+getName());
    }
}
