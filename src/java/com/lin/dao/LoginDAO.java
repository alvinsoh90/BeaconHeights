/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.utils.HttpHandler;
import com.lin.global.ApiUriList;
import com.lin.utils.json.JSONException;
import com.lin.utils.json.JSONObject;
import java.io.IOException;

/**
 *
 * @author Shamus
 */
public class LoginDAO {
    
    
    //String salt = BCrypt.gensalt();
    
    public String getHash(String username) throws IOException{
        String URL = ApiUriList.getCheckLoginHashURI(username);
        //String hash = BCrypt.hashpw("hash",salt);
        String hash = null;
      
        //retrieve from server - may throw IOException here
        hash = HttpHandler.httpGet(URL);
        
        try {
            //if retrieval is successful, parse JSON response and take out hash
            JSONObject jOb = new JSONObject(hash);
            hash = jOb.getString("password");
        } catch (JSONException ex) {
            ex.printStackTrace();
        }
        return hash;
    }
}
