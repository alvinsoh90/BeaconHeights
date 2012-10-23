/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.FacilityType;
import com.lin.entities.Facility;
import com.lin.utils.HttpHandler;
import com.lin.global.ApiUriList;
import com.lin.utils.BCrypt;
import com.lin.utils.json.JSONException;
import com.lin.utils.json.JSONObject;
import java.io.IOException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Keffeine
 */
public class FacilityDAO {

    private static HashMap<String,Facility> facilityMap = new HashMap<String,Facility>();
    
    
    
    public static HashMap<String,Facility> retrieveAllFacilities() {
      FacilityType type1 = new FacilityType(1, "Tennis Court", "Place where you play tennis.");
      FacilityType type2 = new FacilityType(2, "Barbeque Pit", "Place where you barbeque shit.");
      
      Facility facility1 = new Facility(1, 125, 110, type1);
      Facility facility2 = new Facility(2, 332, 539, type2);
      
      facilityMap.put("facility1",facility1);
      facilityMap.put("facility2",facility2); 
      return facilityMap;
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
    
    
    public Facility createFacility(double longitude, double latitude, FacilityType type) {

        Facility facility = new Facility(longitude, latitude, type);

        //add to temporary hashmap
        facilityMap.put("facility"+facility.getId(), facility);
        //line that says u put into Objectify
        return facility;

    }

    public boolean deleteFacility(long id) {
        
        Facility facility = facilityMap.remove("facility"+id);
        boolean success = true;

        //line that says u put into Objectify
        return success;

    }
    
    public Facility updateFacility(long id, double longitude, double latitude, FacilityType type){
       
        Facility facility = new Facility(id, longitude, latitude, type);
        facilityMap.put("facility"+id, facility);
        
        //update user where id = id
        
        return facility;
    }
    
    public Facility getFacility(long id){   
      return facilityMap.get("facility"+id);
    }
    
}
