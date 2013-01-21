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
    private String id;
    private String name;
    private String description;
    private String postalCode;
    private String contactNo;
    private String category;
    private String unitNo;
    private String streetName;
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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUnitNo() {
        return unitNo;
    }

    public void setUnitNo(String unitNo) {
        this.unitNo = unitNo;
    }

    public String getStreetName() {
        return streetName;
    }

    public void setStreetName(String streetName) {
        this.streetName = streetName;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
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
        outcome = aCatDAO.deleteAmenityType(Integer.parseInt(id));
        return new RedirectResolution("/admin/manage-amenitycategories.jsp?deletesuccess=" +
                outcome +"&createmsg="+getName());
    }

    @HandlesEvent("editAmenityCategory")
    public Resolution editAmenityCategory() {
        AmenityCategoryDAO aCatDAO = new AmenityCategoryDAO();
        outcome = aCatDAO.updateAmenityType(Integer.parseInt(id), getName());
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
    
    @HandlesEvent("deleteAmenity")
    public Resolution deleteAmenity() {
        System.out.println(getId());
        AmenityDAO aDAO = new AmenityDAO();
        outcome = aDAO.deleteAmenity(Integer.parseInt(id));
        return new RedirectResolution("/admin/manage-amenities.jsp?deletesuccess=" +
                outcome +"&createmsg="+getName());
    }

    @HandlesEvent("editAmenity")
    public Resolution editAmenity() {
        AmenityDAO aDAO = new AmenityDAO();
        outcome = aDAO.updateAmenity(Integer.parseInt(id), name, description,
                Integer.parseInt(postalCode),contactNo, Integer.parseInt(category), unitNo, streetName);
        return new RedirectResolution("/admin/manage-amenities.jsp?editsuccess=" +
                outcome +"&createmsg="+getName());
    }

    @HandlesEvent("addAmenity")
    public Resolution addAmenity() {
        AmenityCategoryDAO acDAO = new AmenityCategoryDAO();
        AmenityCategory ac = acDAO.getAmenityCategory(Integer.parseInt(category));
        Amenity a = new Amenity(ac, name, description, Integer.parseInt(postalCode), contactNo, unitNo, streetName);
        AmenityDAO aDAO = new AmenityDAO();
        outcome = aDAO.addAmenity(a);
        return new RedirectResolution("/admin/manage-amenities.jsp?createsuccess=" +
                outcome +"&createmsg="+getName());
    }
}
