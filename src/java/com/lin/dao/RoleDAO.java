/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Role;
import com.lin.utils.HibernateUtil;
import java.util.ArrayList;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Yangsta
 */
public class RoleDAO {

    private static ArrayList<Role> roleList = new ArrayList<Role>();
    Session session = null;
    
    public RoleDAO(){
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }
    
    public ArrayList<Role> getAllRoles() {
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery ("from Role order by id DESC");
            roleList = (ArrayList<Role>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roleList;
    }

    public static void updateRole(String roleId) {
    }

    public static void createRole(String name, String description) {
    }
    
    public Role getRoleByName(String name){
        //refresh role list
        getAllRoles();
        
        for(Role r : roleList){
            if(r.getName().equals(name)){
                return r;
            }
        }
        return null;
    }
    public Role getRoleById(int id){
        //refresh role list
        getAllRoles();
        
        for(Role r : roleList){
            if(r.getId()==id){
                return r;
            }
        }
        return null;
    }
}
