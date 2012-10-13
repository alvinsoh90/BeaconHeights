/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Role;

/**
 *
 * @author Yangsta
 */
public class RoleDAO {

    public static void getAllRoles() {
    }

    public static void updateRole(String roleId) {
    }

    public static void createRole(String name, String description) {
    }
    
    public static Role getRoleByName(String name){
        //temp return
        return new Role(1,"Admin","Boss man of Beacon");
    }
}
