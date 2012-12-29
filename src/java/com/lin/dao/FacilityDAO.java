/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.FacilityType;
import com.lin.entities.Facility;
import com.lin.entities.UserTemp;
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
public class FacilityDAO {

    ArrayList<Facility> facilityList = null;
    Session session = null;

    public FacilityDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public ArrayList<Facility> retrieveAllFacilities() {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Facility");
            facilityList = (ArrayList<Facility>) q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return facilityList;
    }

    //Method checks DB if facility exists.
    /*public static Boolean doesUserExist(String username){
    String URL = ApiUriList.getDoesUserExistURI(username);
    boolean userExists = true; //defaults to preventing users from creating account.
    String res = null;
    try {
    res = HttpHandler.httpGet(URL);
    JSONObject resObj = new JSONObject(res);
    userExists=resObj.getBoolean("userExists");
    } catch (IOException ex) {
    ex.printStackTrace();
    } catch (JSONException ex) {
    ex.printStackTrace();
    }
    return userExists;
    
    }
    
    //Method adds a temp user in user_temp awaiting approval.
    public static void addTempUser(String username, String password, String 
    firstname, String lastname, String block, String level, String unitnumber) {
    String salt = BCrypt.gensalt();
    String URL = ApiUriList.getAddTempUserURI(username,BCrypt.hashpw(password, salt),
    firstname,lastname,block,level,unitnumber);
    try {
    HttpHandler.httpGet(URL);
    } catch (IOException ex) {
    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
    }
    }
     */
    public Facility createFacility(FacilityType facilityType, int facilityLng, int facilityLat) {
        openSession();
        // Shamus, I Added facilityType.getName() here - Fay
        Facility facility = new Facility(facilityType,facilityType.getName(), facilityLng, facilityLat);
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("Facility", facility);
            tx.commit();

            return facility;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        //return null if failed
        return null;
    }

    public boolean deleteFacility(long id) {
        openSession();
        Transaction tx = null;
        int rowCount = 0;

        try {
            tx = session.beginTransaction();
            String hql = "delete from Facility where id = :fId";
            Query query = session.createQuery(hql);
            query.setString("fId", id + "");
            rowCount = query.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        System.out.println("Rows affected: " + rowCount);
        if (rowCount > 0) {
            return true;
        } else {
            return false;
        }

    }

    public Facility updateFacility(int id, FacilityType facilityType, int facilityLng, int facilityLat) {
        
        openSession();
        //User user = new User(userId,role, block, userName, firstname, lastname, level, unit);
        //session.update("User",user);
        //Session session = HibernateUtil.getSessionFactory().getCurrentSession();        
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Facility facility = (Facility) session.get(Facility.class, id);
            facility.setFacilityType(facilityType);
            facility.setFacilityLng(facilityLng);
            facility.setFacilityLat(facilityLat);
            session.update(facility);
            tx.commit();

            return facility;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
        
        

        return null;

    }

    public Facility getFacility(int id) {
        openSession();
        
        ArrayList<Facility> result = new ArrayList<Facility>();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery("from Facility where id = :fId");
            q.setInteger("fId", id);
            result = (ArrayList<Facility>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if(tx!=null){
                tx.rollback();
            }
        }
        System.out.println("RETRIEVEDFACILITY:"+result.get(0));
        return result.get(0);
    }
}
