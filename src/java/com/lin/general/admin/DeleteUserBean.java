/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.BlockDAO;
import com.lin.dao.RoleDAO;
import com.lin.entities.User;
import com.lin.dao.UserDAO;
import com.lin.entities.Block;
import com.lin.entities.Role;
import net.sourceforge.stripes.action.*;

/**
 *
 * @author Yangsta
 */
public class DeleteUserBean implements ActionBean{
  private ActionBeanContext context;
  private User user;
  
  private String id;
  private String username;
    
    @DefaultHandler
    public Resolution deleteUser(){
        UserDAO dao = new UserDAO();

        try{
            dao.deleteUser(Integer.parseInt(id));
            return new RedirectResolution("/admin/users.jsp?deletesuccess=true"+"&deletemsg="+username);
        }
        catch(Exception e){
            e.printStackTrace(); 
        }
        return new RedirectResolution("/admin/users.jsp?deletesuccess=false");
        
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
  

}
