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
public class ResourceCategoryDAO {

    ArrayList<ResourceCategory> rCat = null;
    Session session = null;

    public ResourceCategoryDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public ArrayList<ResourceCategory> retrieveAllResourceCategory() {
        openSession();
        Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
        
        rCat = new ArrayList<ResourceCategory>();
        try {
            org.hibernate.Transaction tx = sess.beginTransaction();
            Query q = sess.createQuery("from ResourceCategory");
            rCat = (ArrayList<ResourceCategory>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rCat;
    }

    public ResourceCategory createResourceCategory(String name, String decription) {
System.out.append("db test");
        ResourceCategory rCat = new ResourceCategory( name,  decription);
        
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("ResourceCategory", rCat);
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
    
    
    public void deleteResourceCategory(int id) {

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            ResourceCategory rCat = (ResourceCategory)session.get(ResourceCategory.class, id);
            session.delete(rCat);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
    }
    
        public ResourceCategory updateResourceCategory(int id, String name, String description) {

        Transaction tx = null;
        ResourceCategory rCat = null;
        try {
            tx = session.beginTransaction();
            rCat = (ResourceCategory)session.get(ResourceCategory.class, id);
            rCat.setDescription(description);
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
