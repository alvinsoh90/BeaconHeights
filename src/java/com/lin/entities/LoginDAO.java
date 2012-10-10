/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.entities;

import com.lin.global.ApiUriList;
import com.lin.utils.BCrypt;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Shamus
 */
public class LoginDAO {
    
    
    //String salt = BCrypt.gensalt();
    
    public String getHash(String username){
        String URL = ApiUriList.getCheckLoginHashURI(username);
        //String hash = BCrypt.hashpw("hash",salt);
        String hash = null;
        try {
            hash = HttpHandler.httpGet(URL);
        } catch (IOException ex) {
            Logger.getLogger(LoginDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println(hash);
        return hash;
    }
}
