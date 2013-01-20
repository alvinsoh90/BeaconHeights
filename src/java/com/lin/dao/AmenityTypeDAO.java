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

/**
 *
 * @author fayannefoo
 */
public class AmenityTypeDAO {

    ArrayList<AmenityCategory> categoryList = null;
    Session session = null;

    public AmenityTypeDAO() {
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
}
