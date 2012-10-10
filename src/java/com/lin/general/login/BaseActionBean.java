/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.login;

import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;

/**
 *
 * @author Shamus
 */
public abstract class BaseActionBean implements ActionBean { 
    private ActionBeanContext context; 
    
    public ActionBeanContext getContext() { 
        return context; 
    }
    
    public void setContext(ActionBeanContext context) { 
        this.context = context; } 
    }
