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
    public static final String BaseURL = "http://127.0.0.1:3000/";
    public static final String apiURL = "api/";
    
    public static String getCheckLoginHashURI(String username){
        return BaseURL + apiURL + "getUserHash/" + username;
    }

    public static String getDoesUserExistURI(String username) {
        return BaseURL + apiURL + "doesUserExist/" + username;
    }

    public static String getAddTempUserURI(String username, String password, String firstname, String lastname, String block, String level, String unitnumber) {
        return BaseURL + apiURL + "addTempUser/" + username +"," + password + "," + firstname + "," + lastname + "," + block + "," + level + "," + unitnumber;
    }
}
