/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.login;

import com.lin.entities.User;
import net.sourceforge.stripes.action.ActionBeanContext;

/**
 *
 * @author fayannefoo
 */
public class MyAppActionBeanContext extends ActionBeanContext {

    public void setUser(User user) {
        getRequest().getSession().setAttribute("user", user);
    }

    public User getUser() {
        return (User) getRequest().getSession().getAttribute("user");
    }
}