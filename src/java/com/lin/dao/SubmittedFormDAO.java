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


public class SubmittedFormDAO {

    ArrayList<SubmittedForm> sForms = null;
    Session session = null;

    public SubmittedFormDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public ArrayList<SubmittedForm> retrieveAllSubmittedForm() {
        openSession();
        Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
        
        sForms = new ArrayList<SubmittedForm>();
        try {
            org.hibernate.Transaction tx = sess.beginTransaction();
            Query q = sess.createQuery("from SubmittedForm");
            sForms = (ArrayList<SubmittedForm>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sForms;
    }

    public SubmittedForm createSubmittedForm(User user, String fileName, boolean processed) {

        SubmittedForm sForm = new SubmittedForm(user, fileName,  processed);
        
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("SubmittedForm", sForm);
            tx.commit();

            return sForm;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
        return null;
    }
    
    
    public void deleteSubmittedForm(int id) {

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            SubmittedForm sForm = (SubmittedForm)session.get(SubmittedForm.class, id);
            session.delete(sForm);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
    }
    
        public SubmittedForm updateSubmittedForm(int id, User user, String fileName, boolean processed) {

        Transaction tx = null;
        SubmittedForm sForm = null;
        try {
            tx = session.beginTransaction();
            sForm = (SubmittedForm)session.get(SubmittedForm.class, id);
            sForm.setUser(user);
            sForm.setFileName(fileName);
            sForm.setProcessed(processed);
            tx.commit();
            
            return sForm;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
        return sForm;
    }
    
}
