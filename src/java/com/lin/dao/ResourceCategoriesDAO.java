/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.*;
import com.lin.utils.HttpHandler;
import com.lin.global.ApiUriList;
import com.lin.utils.BCrypt;
import com.lin.utils.HibernateUtil;
import com.lin.utils.json.JSONException;
import com.lin.utils.json.JSONObject;
import java.io.IOException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;


/**
 *
 * @author Keffeine
 */
public class ResourceCategoriesDAO {

    ArrayList<ResourceCategories> rCat = null;
    Session session = null;

    public ResourceCategoriesDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public ArrayList<ResourceCategories> retrieveAllResourceCategories() {
        openSession();
        Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
        
        rCat = new ArrayList<ResourceCategories>();
        try {
            org.hibernate.Transaction tx = sess.beginTransaction();
            Query q = sess.createQuery("from ResourceCategories");
            rCat = (ArrayList<ResourceCategories>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rCat;
    }

    public ResourceCategories createResourceCategories(String name, String decription) {
System.out.append("db test");
        ResourceCategories rCat = new ResourceCategories( name,  decription);
        
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("ResourceCategories", rCat);
            tx.commit();

            return rCat;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
        return null;
    }
    
    
    public void deleteResourceCategories(int id) {

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            ResourceCategories rCat = (ResourceCategories)session.get(ResourceCategories.class, id);
            session.delete(rCat);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
    }
    
        public ResourceCategories updateResourceCategories(int id, String name, String decription) {

        Transaction tx = null;
        ResourceCategories rCat = null;
        try {
            tx = session.beginTransaction();
            rCat = (ResourceCategories)session.get(ResourceCategories.class, id);
            rCat.setDecription(decription);
            rCat.setName(name);
            tx.commit();
            
            return rCat;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
        return rCat;
    }
    
}
