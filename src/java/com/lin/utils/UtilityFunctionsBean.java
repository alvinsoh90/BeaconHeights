/*
 * This bean will contain utility methods (duh) 
 * that will be used in more than one page
 * It's a bean and not just a utility class because beans (that extend BaseActionBean)
 * provide convenient access to the session scope
 */
package com.lin.utils;

import com.lin.dao.UserDAO;
import com.lin.entities.User;
import com.lin.general.login.BaseActionBean;

/**
 *
 * @author Yangsta
 */
public class UtilityFunctionsBean extends BaseActionBean{
    
  //gets a newly initialized user with newest fields from DB
  public User refreshUser(User user){
      UserDAO uDAO = new UserDAO();
      return uDAO.getUser(user.getUserId());
  }
}
