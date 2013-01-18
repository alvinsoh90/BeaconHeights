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
import java.util.Date;


/**
 *
 * @author Keffeine
 */
public class ResourceDAO {

    ArrayList<Resource> resource = null;
    Session session = null;

    public ResourceDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public ArrayList<Resource> retrieveAllResource() {
        openSession();
        Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
        
        resource = new ArrayList<Resource>();
        try {
            org.hibernate.Transaction tx = sess.beginTransaction();
            Query q = sess.createQuery("from Resource");
            resource = (ArrayList<Resource>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resource;
    }

    public Resource createResource(String name, String decription, String category, String fileName) {

        Resource resource = new Resource( name,  decription, category, fileName);
        
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("Resource", resource);
            tx.commit();

            return resource;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
        return null;
    }
    
    
    public void deleteResource(int id) {

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Resource resource = (Resource)session.get(Resource.class, id);
            session.delete(resource);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
    }
    
    public Resource updateResource(int id, String name, String description, String category, String fileName, Date timeCreated) {

        Transaction tx = null;
        Resource resource = null;
        try {
            tx = session.beginTransaction();
            resource = (Resource)session.get(Resource.class, id);
            resource.setDescription(description);
            resource.setName(name);
            resource.setCategory(category);
            resource.setFileName(fileName);
            resource.setTimeCreated(timeCreated);
            tx.commit();
            
            return resource;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
        return resource;
    }

    public ArrayList<String> getUniqueCategories() {
        openSession();
        Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
        
        ArrayList<String> catList = new ArrayList<String>();
        try {
            org.hibernate.Transaction tx = sess.beginTransaction();
            Query q = sess.createQuery("select distinct category from Resource");
            catList = (ArrayList<String>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return catList;
    }
    
}
