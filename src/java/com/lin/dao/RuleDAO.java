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
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Keffeine
 */
public class RuleDAO {

    Session session = null;

    public RuleDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public ArrayList<LimitRule> getAllLimitRule(int facilityTypeId){
        openSession();
        ArrayList<LimitRule> list = new ArrayList<LimitRule>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from LimitRule WHERE FacilityType id = :id");
            q.setString("id", facilityTypeId + "");
            list = (ArrayList<LimitRule>) q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public ArrayList<OpenRule> getAllOpenRule(int facilityTypeId){
        openSession();
        ArrayList<OpenRule> list = new ArrayList<OpenRule>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from OpenRule WHERE FacilityType id = :id");
            q.setString("id", facilityTypeId + "");
            list = (ArrayList<OpenRule>) q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public ArrayList<CloseRule> getAllCloseRule(int facilityTypeId){
        openSession();
        ArrayList<CloseRule> list = new ArrayList<CloseRule>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from CloseRule WHERE FacilityType id = :id");
            q.setString("id", facilityTypeId + "");
            list = (ArrayList<CloseRule>) q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public ArrayList<AdvanceRule> getAllAdvanceRule(int facilityTypeId){
        openSession();
        ArrayList<AdvanceRule> list = new ArrayList<AdvanceRule>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from AdvanceRule WHERE FacilityType id = :id");
            q.setString("id", facilityTypeId + "");
            list = (ArrayList<AdvanceRule>) q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public LimitRule createLimitRule(int id, FacilityType facilityType, int sessions, int numberOfTimeframe, String timeframeType){
        openSession();
        LimitRule lRule = new LimitRule( id, facilityType, sessions, numberOfTimeframe, timeframeType);
        
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("LimitRule",lRule);
            tx.commit();
            return lRule;
        } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null) tx.rollback();
        }
        //return null if failed
        return null;
    }
    
    public CloseRule createCloseRule(int id, FacilityType facilityType, Date startDate, Date endDate){
        openSession();
        CloseRule cRule = new CloseRule( id, facilityType, startDate, endDate);
        
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("CloseRule",cRule);
            tx.commit();
            return cRule;
        } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null) tx.rollback();
        }
        //return null if failed
        return null;
    }
    
    public OpenRule createOpenRule(int id, FacilityType facilityType, int dayOfWeek, int startTime, int endTime){
        openSession();
        OpenRule oRule = new OpenRule( id, facilityType, dayOfWeek, startTime, endTime);
        
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("OpenRule",oRule);
            tx.commit();
            return oRule;
        } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null) tx.rollback();
        }
        //return null if failed
        return null;
    }
    
    public AdvanceRule createAdvanceRule(int id, FacilityType facilityType, int minDays, int maxDays){
        openSession();
        AdvanceRule aRule = new AdvanceRule( id, facilityType, minDays, maxDays);
        
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("AdvanceRule",aRule);
            tx.commit();
            return aRule;
        } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null) tx.rollback();
        }
        //return null if failed
        return null;
    }
    
}
