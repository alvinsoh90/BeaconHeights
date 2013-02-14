/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Amenity;
import com.lin.entities.AmenityCategory;
import com.lin.utils.HibernateUtil;
import java.util.ArrayList;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author fayannefoo
 */
public class AmenityDAO {

    ArrayList<Amenity> amenityList = null;
    Session session = null;

    public AmenityDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public ArrayList<Amenity> retrieveAllAmenities() {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Amenity");
            amenityList = (ArrayList<Amenity>) q.list();
            //tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return amenityList;
    }

    public ArrayList<Amenity> retrieveAmenitiesByCategory(String category) {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Amenity where category = :cat");
            q.setString("cat", category);
            amenityList = (ArrayList<Amenity>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return amenityList;
    }
    

    public boolean addAmenity(Amenity amenity) {
        openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("Amenity", amenity);
            tx.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return false;
    }

    public boolean deleteAmenity(int amenityId) {
        openSession();
        Transaction tx = null;
        int rowCount = 0;

        try {
            tx = session.beginTransaction();
            String hql = "delete from Amenity where id = :id";
            Query query = session.createQuery(hql);
            query.setString("id", amenityId + "");
            rowCount = query.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        System.out.println("Amenity - Rows affected: " + rowCount);
        if (rowCount > 0) {
            return true;
        } else {
            return false;
        }
    }

    public Amenity getAmenity(int amenityId) {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Amenity where amenityId = :id");
            q.setString("id", amenityId + "");
            amenityList = (ArrayList<Amenity>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Amenity:" + amenityList.get(0));
        return amenityList.get(0);
    }

    public boolean updateAmenity(int amenityId, String name, String description,
            String postalCode, String contactNo, int category_id, String unitNo, String streetName) {
        openSession();
        Transaction tx = null;
       
        try {
            tx = session.beginTransaction();
            AmenityCategory ac = (AmenityCategory)session.get(AmenityCategory.class, category_id);
            Amenity a = (Amenity) session.get(Amenity.class, amenityId);
            a.setName(name);
            a.setDescription(description);
            a.setUnitNo(unitNo);
            a.setStreetName(streetName);
            a.setPostalCode(postalCode);
            a.setContactNo(contactNo);
            a.setAmenityCategory(ac);
            session.update(a);
            tx.commit();
        return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return false;
        
    }
}
