/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.controller;

import com.lin.entities.LoginDAO;

/**
 *
 * @author Shamus
 */
public class LoginController {
    LoginDAO loginDAO = new LoginDAO();
    
    public String getHash(String username){
        return loginDAO.getHash(username);
    }
}
