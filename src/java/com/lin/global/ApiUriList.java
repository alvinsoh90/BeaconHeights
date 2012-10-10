/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.global;

/**
 *
 * @author Shamus
 */
public class ApiUriList {
    public static final String BaseURL = "http://106.187.95.45/";
    public static final String apiURL = "api/";
    
    public static String getCheckLoginHashURI(String username){
        return BaseURL + apiURL + "getUserHash/" + username;
    }
}
