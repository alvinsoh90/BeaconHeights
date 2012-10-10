/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.entities;

import com.lin.utils.BCrypt;
import java.security.SecureRandom;

/**
 *
 * @author Shamus
 */
public class LoginDAO {
    String salt = BCrypt.gensalt();
    
    public String getHash(String username){
        String hash = BCrypt.hashpw("hash",salt);
        return hash;
    }
}
