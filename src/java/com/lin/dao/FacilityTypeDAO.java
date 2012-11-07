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
        
        //line that says u put into DATABASE
        return facilityType;

    }

    public boolean deleteFacilityType(String name) {

      //  FacilityType facilityType = typeList.remove(name);
        boolean success = true;

        //line that says u put into Objectify
        return success;

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
}
