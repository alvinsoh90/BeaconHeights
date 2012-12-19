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
//test comments

public abstract class BaseActionBean implements ActionBean {

    private MyAppActionBeanContext context;

    /** Interface method from ActionBean. */
    public void setContext(ActionBeanContext context) {
        this.context = (MyAppActionBeanContext) context;
    }

    /** Interface method from ActionBean, using a co-variant return type! */
    public MyAppActionBeanContext getContext() {
        return this.context;
    }
}
