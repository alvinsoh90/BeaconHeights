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
import org.hibernate.FetchMode;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.annotations.Fetch;
//import org.hibernate.annotations.FetchMode;

/**
 *
 * @author Keffeine
 */
public class FacilityTypeDAO {

    ArrayList<FacilityType> typeList = null;
    Session session = null;

    public FacilityTypeDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public ArrayList<FacilityType> retrieveAllFacilityTypes() {
        //openSession();
        Session sess = HibernateUtil.getSessionFactory().getCurrentSession();
        
        typeList = new ArrayList<FacilityType>();
        try {
            org.hibernate.Transaction tx = sess.beginTransaction();
            Query q = sess.createQuery("from FacilityType");
            typeList = (ArrayList<FacilityType>) q.list();
            //tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return typeList;
    }

    public FacilityType createFacilityType(String name, String description) {

        FacilityType facilityType = new FacilityType(name, description);
        
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("FacilityType", facilityType);
            tx.commit();

            return facilityType;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        //return null if failed
        return null;
    }
    
    
    public FacilityType createFacilityType(FacilityType ftype) {
        openSession();
  
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("FacilityType", ftype);
            tx.commit();

            return ftype;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        //return null if failed
        return null;

    }
    
    public FacilityType appendRulesToType(FacilityType facilityType, Set openRules, Set closeRules, Set limitRules, Set advanceRules){
        facilityType.setOpenRules(openRules);
        facilityType.setCloseRules(closeRules);
        facilityType.setLimitRules(limitRules);
        facilityType.setAdvanceRules(advanceRules);
        
        
        
        //doesn't appear to be a need to write; could be wrong
        /*
        openSession();
        
        Transaction tx = null;
        
        try {
            tx = session.beginTransaction();
            session.save("FacilityType", facilityType);
            tx.commit();

            return facilityType;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }*/
        //return null if failed
        return null;
        
    }

    public boolean deleteFacilityType(int id) {
        //openSession();
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        int rowCount =0;
        
        try {
            tx = session.beginTransaction();
            
            String hql = "delete from OpenRule where facility_type_id = :id";
            Query query = session.createQuery(hql);
            query.setString("id",id+"");
            rowCount = query.executeUpdate();
            
            hql = "delete from CloseRule where facility_type_id = :id";
            query = session.createQuery(hql);
            query.setString("id",id+"");
            rowCount = query.executeUpdate();
            
            hql = "delete from LimitRule where facility_type_id = :id";
            query = session.createQuery(hql);
            query.setString("id",id+"");
            rowCount = query.executeUpdate();
            
            hql = "delete from AdvanceRule where facility_type_id = :id";
            query = session.createQuery(hql);
            query.setString("id",id+"");
            rowCount = query.executeUpdate();
            
            hql = "delete from FacilityType where id = :id";
            query = session.createQuery(hql);
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
    
    public void deleteFacilityType(FacilityType facilityType) {
        session.delete(facilityType);
    }

    public FacilityType updateFacilityType(String name, String description) {

        FacilityType facilityType = new FacilityType(name, description);
        session.update(facilityType);

        //update user where id = id

        return facilityType;
    }
    
    @Fetch(org.hibernate.annotations.FetchMode.JOIN)
    public FacilityType getFacilityType(String name) {
        openSession();
        ArrayList<FacilityType> typeList = new ArrayList<FacilityType>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from FacilityType where name ='" + name + "'");
            typeList = (ArrayList<FacilityType>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return typeList.get(0);

    }
    
    
    
    @Fetch(org.hibernate.annotations.FetchMode.JOIN)
    public FacilityType getFacilityType(int id) {
        //openSession();
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        ArrayList<FacilityType> typeList = new ArrayList<FacilityType>();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.createCriteria(FacilityType.class).setFetchMode("limitRules", FetchMode.JOIN);
            Query q = session.createQuery("from FacilityType where id ='" + id + "'");
            typeList = (ArrayList<FacilityType>) q.list();
            System.out.println("SUCCESS GET FACILITY");
            FacilityType result = typeList.get(0);
            Hibernate.initialize(result);
            tx.commit();
            
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("FAILLLLL GET FACILITY");
            if(tx!=null){
                tx.rollback();
            }
        }
        return null;

    }
    
    @Fetch(org.hibernate.annotations.FetchMode.JOIN)
    public LimitRule getFacilityTypeLimitRules(int id) {
        //openSession();
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        ArrayList<FacilityType> typeList = new ArrayList<FacilityType>();
        Transaction tx = null;
        FacilityType result;
        LimitRule lRule;
        try {
            tx = session.beginTransaction();
            session.createCriteria(FacilityType.class).setFetchMode("limitRules", FetchMode.JOIN);
            Query q = session.createQuery("from FacilityType where id ='" + id + "'");
            typeList = (ArrayList<FacilityType>) q.list();
            
            result = typeList.get(0);
            lRule = (LimitRule) result.getLimitRules().toArray()[0];
            tx.commit();
            
            return lRule;
        } catch (Exception e) {
            e.printStackTrace();
            
            if(tx!=null){
                tx.rollback();
            }
        }
        return null;

    }
    
    @Fetch(org.hibernate.annotations.FetchMode.JOIN)
    public AdvanceRule getFacilityTypeAdvanceRules(int id) {
        //openSession();
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        ArrayList<FacilityType> typeList = new ArrayList<FacilityType>();
        Transaction tx = null;
        FacilityType result;
        AdvanceRule aRule;
        try {
            tx = session.beginTransaction();
            session.createCriteria(FacilityType.class).setFetchMode("advanceRules", FetchMode.JOIN);
            Query q = session.createQuery("from FacilityType where id ='" + id + "'");
            typeList = (ArrayList<FacilityType>) q.list();
            
            result = typeList.get(0);
            Hibernate.initialize(result);
            aRule = (AdvanceRule) result.getAdvanceRules().toArray()[0];
            tx.commit();
            
            return aRule;
        } catch (Exception e) {
            e.printStackTrace();
            
            if(tx!=null){
                tx.rollback();
            }
        }
        return null;

    }
    
    @Fetch(org.hibernate.annotations.FetchMode.JOIN)
    public ArrayList<OpenRule> getFacilityTypeOpenRules(int id) {
        //openSession();
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        ArrayList<FacilityType> typeList = new ArrayList<FacilityType>();
        Transaction tx = null;
        FacilityType result;
        ArrayList<OpenRule> oRules = new ArrayList<OpenRule>();
        try {
            tx = session.beginTransaction();
            session.createCriteria(FacilityType.class).setFetchMode("openRules", FetchMode.JOIN);
            Query q = session.createQuery("from FacilityType where id ='" + id + "'");
            typeList = (ArrayList<FacilityType>) q.list();
            
            result = typeList.get(0);
            Hibernate.initialize(result.getOpenRules());
            
            for(Object obj : result.getOpenRules().toArray()){
                OpenRule or = (OpenRule)obj;
                oRules.add(or);
            }
            //oRules = (OpenRule[]) result.getOpenRules().toArray();
            tx.commit();
            
            return oRules;
        } catch (Exception e) {
            e.printStackTrace();
            
            if(tx!=null){
                tx.rollback();
            }
        }
        return null;

    }
    
    public FacilityType editFacilityType(FacilityType facilityType) {
        openSession();
        //Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        String name = facilityType.getName();
        String desc = facilityType.getDescription();
        Set ars = facilityType.getAdvanceRules();
        Set crs = facilityType.getCloseRules();
        Set lrs = facilityType.getLimitRules();
        Set ors = facilityType.getOpenRules();
        
        
        
        org.hibernate.Transaction tx = session.beginTransaction();
        FacilityType fT = (FacilityType) session.get(FacilityType.class, facilityType.getId());
        
        fT.setName(name);
        fT.setDescription(desc);
//        fT.setAdvanceRules(ars);
//        fT.setCloseRules(crs);
//        fT.setLimitRules(lrs);
//        fT.setOpenRules(ors);
//        
        tx.commit();
        
//        System.out.println("NEW FT NAME HERE : "+fT.getDescription());
//        System.out.println("OLD FT NAME HERE : "+facilityType.getDescription());
        
       
        
        return fT;
    }

    public FacilityType editFacilityType(int id, FacilityType newFT) {
        openSession();
        ArrayList<FacilityType> typeList = new ArrayList<FacilityType>();
        org.hibernate.Transaction tx = null;
        try {
            tx = session.beginTransaction();
            FacilityType fT = (FacilityType) session.get(FacilityType.class, id);
            fT.setName(newFT.getName());
            fT.setDescription(newFT.getDescription());
            fT.setAdvanceRules(newFT.getAdvanceRules());
            fT.setCloseRules(newFT.getCloseRules());
            fT.setLimitRules(newFT.getLimitRules());
            fT.setOpenRules(newFT.getOpenRules());
            tx.commit();
            
            return fT;
        } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null){
                tx.rollback();
            }
        }
        return null;
    }
    
    
    public FacilityType editFacilityType(int id, String name, String description, Date monOne, Date monTwo, Date tueOne, Date tueTwo, Date wedOne, Date wedTwo, Date thuOne, Date thuTwo, Date friOne, Date friTwo, Date satOne, Date satTwo, Date sunOne, Date sunTwo, int bookingSessions, int bookingLimitFreq, char bookingLimitUnit, int bookingOpenAdvance, int bookingCloseAdvance){
        openSession();
        ArrayList<FacilityType> typeList = new ArrayList<FacilityType>();
        org.hibernate.Transaction tx = null;
        try {
            tx = session.beginTransaction();
            FacilityType fT = (FacilityType) session.get(FacilityType.class, id);
            //HashSet declarations

            HashSet openRuleSet = new HashSet();
            HashSet closeRuleSet = new HashSet();
            HashSet limitRuleSet = new HashSet();
            HashSet advanceRuleSet = new HashSet();

            //Create open rules and store to DB          
            OpenRule openRule1 = new OpenRule(fT, monOne, monTwo, 
                    OpenRule.DAY_OF_WEEK.MONDAY);
            OpenRule openRule2 = new OpenRule(fT, tueOne, tueTwo, 
                    OpenRule.DAY_OF_WEEK.TUESDAY);
            OpenRule openRule3 = new OpenRule(fT, wedOne, wedTwo, 
                    OpenRule.DAY_OF_WEEK.WEDNESDAY);
            OpenRule openRule4 = new OpenRule(fT, thuOne, thuTwo, 
                    OpenRule.DAY_OF_WEEK.THURSDAY);
            OpenRule openRule5 = new OpenRule(fT, friOne, friTwo, 
                    OpenRule.DAY_OF_WEEK.FRIDAY);
            OpenRule openRule6 = new OpenRule(fT, satOne, satTwo, 
                    OpenRule.DAY_OF_WEEK.SATURDAY);
            OpenRule openRule7 = new OpenRule(fT, sunOne, sunTwo, 
                    OpenRule.DAY_OF_WEEK.SUNDAY);
            
            //add these rules to set
            openRuleSet.add(openRule1);
            openRuleSet.add(openRule2);
            openRuleSet.add(openRule3);
            openRuleSet.add(openRule4);
            openRuleSet.add(openRule5);
            openRuleSet.add(openRule6);
            openRuleSet.add(openRule7);
            
//            limitation on booking in advance            
            AdvanceRule advanceRule = new AdvanceRule(fT, bookingOpenAdvance, bookingCloseAdvance);
            advanceRuleSet.add(advanceRule);
            
            //create limit rule
            //evaluate timeframe type entered
            switch(bookingLimitUnit){
                case 'd':
                    LimitRule limitRuleD = new LimitRule(fT, bookingSessions, bookingLimitFreq, LimitRule.TimeFrameType.DAY);
                    limitRuleSet.add(limitRuleD);
                    System.out.println(limitRuleD);
                    break;    
                case 'w':
                    LimitRule limitRuleW = new LimitRule(fT, bookingSessions, bookingLimitFreq, LimitRule.TimeFrameType.WEEK);
                    limitRuleSet.add(limitRuleW);
                    break;
                case 'm':
                    LimitRule limitRuleM = new LimitRule(fT, bookingSessions, bookingLimitFreq, LimitRule.TimeFrameType.MONTH);
                    limitRuleSet.add(limitRuleM);
                    break;
            }
            
            fT.setName(name);
            fT.setDescription(description);
            
            fT.getAdvanceRules().clear();
            fT.getAdvanceRules().addAll(advanceRuleSet);
            fT.getCloseRules().clear();
            fT.getCloseRules().addAll(closeRuleSet);
            fT.getLimitRules().clear();
            fT.getLimitRules().addAll(limitRuleSet);
            fT.getOpenRules().clear();
            fT.getOpenRules().addAll(openRuleSet);
            
            tx.commit();
            
            return fT;
        } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null){
                tx.rollback();
            }
        }
        return null;
    }
    
}
