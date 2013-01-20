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
public class FormTemplateDAO {

    ArrayList<FormTemplate> FormTemplate = null;
    Session session = null;

    public FormTemplateDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public ArrayList<FormTemplate> retrieveAllFormTemplate() {
        openSession();
        Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
        
        FormTemplate = new ArrayList<FormTemplate>();
        try {
            org.hibernate.Transaction tx = sess.beginTransaction();
            Query q = sess.createQuery("from FormTemplate");
            FormTemplate = (ArrayList<FormTemplate>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return FormTemplate;
    }

    public FormTemplate createFormTemplate(String name, String decription, String category, String fileName) {

        FormTemplate FormTemplate = new FormTemplate( name,  decription, category, fileName);
        
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("FormTemplate", FormTemplate);
            tx.commit();

            return FormTemplate;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
        return null;
    }
    
    
    public void deleteFormTemplate(int id) {

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            FormTemplate FormTemplate = (FormTemplate)session.get(FormTemplate.class, id);
            session.delete(FormTemplate);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
    }
    
    public FormTemplate updateFormTemplate(int id, String name, String description, String category, String fileName, Date timeModified) {

        Transaction tx = null;
        FormTemplate FormTemplate = null;
        try {
            tx = session.beginTransaction();
            FormTemplate = (FormTemplate)session.get(FormTemplate.class, id);
            FormTemplate.setDescription(description);
            FormTemplate.setName(name);
            FormTemplate.setCategory(category);
            FormTemplate.setFileName(fileName);
            FormTemplate.settimeModified(timeModified);
            tx.commit();
            
            return FormTemplate;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
        return FormTemplate;
    }

    public ArrayList<String> getUniqueCategories() {
        openSession();
        Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
        
        ArrayList<String> catList = new ArrayList<String>();
        try {
            org.hibernate.Transaction tx = sess.beginTransaction();
            Query q = sess.createQuery("select distinct category from FormTemplate");
            catList = (ArrayList<String>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return catList;
    }

    public FormTemplate updateFormTemplate(int id, String name, String description, String category_input, Date date) {
        Transaction tx = null;
        FormTemplate FormTemplate = null;
        try {
            tx = session.beginTransaction();
            FormTemplate = (FormTemplate)session.get(FormTemplate.class, id);
            FormTemplate.setDescription(description);
            FormTemplate.setName(name);
            FormTemplate.setCategory(category_input);
            FormTemplate.settimeModified(date);
            tx.commit();
            
            return FormTemplate;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
        return FormTemplate;
    }
    
}
