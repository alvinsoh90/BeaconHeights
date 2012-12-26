/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Facility;
import com.lin.entities.FacilityType;
import com.lin.utils.HttpHandler;
import com.lin.global.ApiUriList;
import com.lin.utils.BCrypt;
import com.lin.utils.HibernateUtil;
import com.lin.utils.json.JSONException;
import com.lin.utils.json.JSONObject;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

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
        openSession();
        typeList = new ArrayList<FacilityType>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from FacilityType");
            typeList = (ArrayList<FacilityType>) q.list();
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
        openSession();
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

    public FacilityType getFacilityType(String name) {
        openSession();
        ArrayList<FacilityType> typeList = new ArrayList<FacilityType>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from FacilityType where name ='" + name + "'");
            typeList = (ArrayList<FacilityType>) q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return typeList.get(0);

    }
    
    public FacilityType getFacilityType(int id) {
        openSession();
        ArrayList<FacilityType> typeList = new ArrayList<FacilityType>();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from FacilityType where id ='" + id + "'");
            typeList = (ArrayList<FacilityType>) q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return typeList.get(0);

    }

    public FacilityType editFacilityType(FacilityType facilityType) {
        openSession();
        FacilityType fT = (FacilityType) session.get(FacilityType.class, facilityType.getId());
        System.out.println("FT NAME HERE : "+fT.getName());
        fT.setName(facilityType.getName());
        fT.setDescription(facilityType.getDescription());
        fT.setAdvanceRules(facilityType.getAdvanceRules());
        fT.setCloseRules(facilityType.getCloseRules());
        fT.setLimitRules(facilityType.getLimitRules());
        fT.setOpenRules(facilityType.getOpenRules());
        
        return fT;
    }
    
    
}
