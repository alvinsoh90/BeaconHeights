/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Role;
import java.util.ArrayList;

/**
 *
 * @author Yangsta
 */
public class RoleDAO {

    private static ArrayList<Role> roleList = new ArrayList<Role>();
    
    public static ArrayList<Role> getAllRoles() {
        roleList.add(new Role("Admin","Boss man of Beacon"));
        return roleList;
    }

    public static void updateRole(String roleId) {
    }

    public static void createRole(String name, String description) {
    }
    
    public static Role getRoleByName(String name){
        //temp return
        return new Role("Admin","Boss man of Beacon");
    }
}
