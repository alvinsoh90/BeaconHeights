/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.FacilityType;
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
public class FacilityTypeDAO {

    private static HashMap<String,FacilityType> facilityTypeMap = new HashMap<String,FacilityType>();
    
    
    
    public static HashMap<String,FacilityType> retrieveAllFacilityTypes() {

      return facilityTypeMap;
    }
    
    
    public FacilityType createFacilityType(String name, String description) {

        FacilityType facilityType = new FacilityType(name, description);

        //add to temporary hashmap
        facilityTypeMap.put(facilityType.getName(), facilityType);
        //line that says u put into Objectify
        return facilityType;

    }

    public boolean deleteFacilityType(String name) {
        
        FacilityType facilityType = facilityTypeMap.remove(name);
        boolean success = true;

        //line that says u put into Objectify
        return success;

    }
    
    public FacilityType updateFacilityType(long id, String name, String description){
       
        FacilityType facilityType = new FacilityType(id, name, description);
        facilityTypeMap.put(name, facilityType);
        
        //update user where id = id
        
        return facilityType;
    }
    
    public FacilityType getFacilityType(String name){   
      return facilityTypeMap.get(name);
    }
    
}
