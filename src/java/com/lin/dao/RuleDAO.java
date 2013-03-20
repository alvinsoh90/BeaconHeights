/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.*;
import com.lin.utils.HttpHandler;
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
            Query q = session.createQuery("from LimitRule WHERE facility_type_id = :id");
            q.setString("id", facilityTypeId + "");
            list = (ArrayList<LimitRule>) q.list();
            tx.commit();
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
            Query q = session.createQuery("from OpenRule WHERE facility_type_id = :id");
            q.setString("id", facilityTypeId + "");
            list = (ArrayList<OpenRule>) q.list();
            tx.commit();
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
            Query q = session.createQuery("from CloseRule WHERE facility_type_id = :id");
            q.setString("id", facilityTypeId + "");
            list = (ArrayList<CloseRule>) q.list();
            tx.commit();
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
            Query q = session.createQuery("from AdvanceRule WHERE facility_type_id = :id");
            q.setString("id", facilityTypeId + "");
            list = (ArrayList<AdvanceRule>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public LimitRule createLimitRule(FacilityType facilityType, int sessions, int numberOfTimeframe, LimitRule.TimeFrameType timeframeType){
        openSession();
        LimitRule lRule = new LimitRule(facilityType, sessions, numberOfTimeframe, timeframeType);
        
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
    
    public CloseRule createCloseRule(FacilityType facilityType, Date startDate, Date endDate, boolean repeatedAnnually){
        openSession();
        CloseRule cRule = new CloseRule(facilityType, startDate, endDate, repeatedAnnually);
        
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
    
//    public OpenRule createOpenRule(FacilityType facilityType, Date startTime, Date endTime){
//        openSession();
//        OpenRule oRule = new OpenRule(facilityType, startTime, endTime);
//        
//        Transaction tx = null;
//        try {
//            tx = session.beginTransaction();
//            session.save("OpenRule",oRule);
//            tx.commit();
//            return oRule;
//        } catch (Exception e) {
//            e.printStackTrace();
//            if(tx!=null) tx.rollback();
//        }
//        //return null if failed
//        return null;
//    }
    
    public AdvanceRule createAdvanceRule(FacilityType facilityType, int minDays, int maxDays){
        openSession();
        AdvanceRule aRule = new AdvanceRule(facilityType, minDays, maxDays);
        
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
    
    public LimitRule updateLimitRule(int id, FacilityType facilityType, int sessions, int numberOfTimeframe, String timeframeType){
        openSession();
        LimitRule lRule = (LimitRule)session.get(LimitRule.class, id);
        
        lRule.setFacilityType(facilityType);
        lRule.setNumberOfTimeframe(numberOfTimeframe);
        lRule.setSessions(sessions);
        lRule.setTimeframeType(timeframeType);
        
        return lRule;
    }
    
    public CloseRule updateCloseRule(int id, FacilityType facilityType, Date startDate, Date endDate){
        openSession();
        CloseRule cRule = (CloseRule)session.get(CloseRule.class, id);
        
        cRule.setEndDate(endDate);
        cRule.setFacilityType(facilityType);
        cRule.setStartDate(startDate);
        
        return cRule;
    }
    
    public OpenRule updateOpenRule(int id, FacilityType facilityType, int dayOfWeek, Date startTime, Date endTime){
        openSession();
        OpenRule oRule = (OpenRule)session.get(OpenRule.class, id);
        
        oRule.setEndTime(endTime);
        oRule.setFacilityType(facilityType);
        oRule.setStartTime(startTime);
        
        return oRule;
    }
    
    public AdvanceRule updateAdvanceRule(int id, FacilityType facilityType, int minDays, int maxDays){
        openSession();
        AdvanceRule aRule = (AdvanceRule)session.get(AdvanceRule.class, id);
        
        aRule.setFacilityType(facilityType);
        aRule.setMaxDays(maxDays);
        aRule.setMinDays(minDays);
        
        return aRule;
    }
    
    public boolean deleteLimitRule(int id) {
        openSession();
        Transaction tx = null;
        int rowCount =0;
        
        try {
            tx = session.beginTransaction();
            String hql = "delete from LimitRule where id = :id";
            Query query = session.createQuery(hql);
            query.setString("id",id+"");
            rowCount = query.executeUpdate();
            tx.commit();
            } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null) tx.rollback();
        }
            System.out.println("Rows affected: " + rowCount);
            if(rowCount>0){
                return true;
            }else{
                return false;
            }
    }
    
    public boolean deleteOpenRule(int id) {
        openSession();
        Transaction tx = null;
        int rowCount =0;
        
        try {
            tx = session.beginTransaction();
            String hql = "delete from OpenRule where id = :id";
            Query query = session.createQuery(hql);
            query.setString("id",id+"");
            rowCount = query.executeUpdate();
            tx.commit();
            } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null) tx.rollback();
        }
            System.out.println("Rows affected: " + rowCount);
            if(rowCount>0){
                return true;
            }else{
                return false;
            }
    }
    
    public boolean deleteCloseRule(int id) {
        openSession();
        Transaction tx = null;
        int rowCount =0;
        
        try {
            tx = session.beginTransaction();
            String hql = "delete from CloseRule where id = :id";
            Query query = session.createQuery(hql);
            query.setString("id",id+"");
            rowCount = query.executeUpdate();
            tx.commit();
            } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null) tx.rollback();
        }
            System.out.println("Rows affected: " + rowCount);
            if(rowCount>0){
                return true;
            }else{
                return false;
            }
    }
    
    public boolean deleteAdvanceRule(int id) {
        openSession();
        Transaction tx = null;
        int rowCount =0;
        
        try {
            tx = session.beginTransaction();
            String hql = "delete from AdvanceRule where id = :id";
            Query query = session.createQuery(hql);
            query.setString("id",id+"");
            rowCount = query.executeUpdate();
            tx.commit();
            } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null) tx.rollback();
        }
            System.out.println("Rows affected: " + rowCount);
            if(rowCount>0){
                return true;
            }else{
                return false;
            }
    }
}
