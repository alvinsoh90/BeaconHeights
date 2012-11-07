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
    public static final String BASE_URL = "http://127.0.0.1:3000/";
    public static final String API_URL = "api/";
    
    public static String getCheckLoginHashURI(String username){
        return BASE_URL + API_URL + "getUserHash/" + username;
    }

    public static String getDoesUserExistURI(String username) {
        return BASE_URL + API_URL + "doesUserExist/" + username;
    }

    public static String getAddTempUserURI(String username, String password, String firstname, String lastname, String block, int level, int unitnumber) {
        return BASE_URL + API_URL + "addTempUser/" + username +"," + password + "," + firstname + "," + lastname + "," + block + "," + level + "," + unitnumber;
    }
}
