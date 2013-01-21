/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

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
public class AmenityCategoryDAO {

    ArrayList<AmenityCategory> categoryList = null;
    Session session = null;

    public AmenityCategoryDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public ArrayList<AmenityCategory> retrieveAmenityCategories() {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from AmenityCategory");
            categoryList = (ArrayList<AmenityCategory>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categoryList;
    }
    
    public AmenityCategory getAmenityCategory(int id) {
        openSession();
        AmenityCategory result = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            result = (AmenityCategory) session.createQuery("from AmenityCategory where id = :id").setString("id", id + "").uniqueResult();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean addAmenityCategory(AmenityCategory amenityCategory) {
        openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("AmenityCategory", amenityCategory);
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

    public boolean deleteAmenityType(int id) {
        openSession();
        Transaction tx = null;
        int rowCount = 0;

        try {
            tx = session.beginTransaction();
            String hql = "delete from AmenityCategory where id = :id";
            Query query = session.createQuery(hql);
            query.setString("id", id + "");
            rowCount = query.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        System.out.println("AmenityCategory - Rows affected: " + rowCount);
        if (rowCount > 0) {
            return true;
        } else {
            return false;
        }
    }

    public boolean updateAmenityType(int id, String name) {
        openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            AmenityCategory a = (AmenityCategory) session.get(AmenityCategory.class, id);
            a.setName(name);
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
