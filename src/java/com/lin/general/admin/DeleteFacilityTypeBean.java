/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.admin;

import com.lin.dao.*;
import com.lin.entities.*;
import java.util.Set;
import net.sourceforge.stripes.action.*;

/**
 *
 * @author Yangsta
 */
public class DeleteFacilityTypeBean implements ActionBean{
  private ActionBeanContext context;
  
  private int delete_facility_type_id;
  private String delete_name;
  private FacilityTypeDAO fDAO;
  private FacilityType fType;

    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public int getDelete_facility_type_id() {
        return delete_facility_type_id;
    }

    public void setDelete_facility_type_id(int delete_facility_type_id) {
        this.delete_facility_type_id = delete_facility_type_id;
    }

    public String getDelete_name() {
        return delete_name;
    }

    public void setDelete_name(String delete_name) {
        this.delete_name = delete_name;
    }
    
    
    
    @DefaultHandler
    public Resolution deleteFacilityType() {
        
        //LimitRuleDAO lDAO = new LimitRuleDAO();
        fDAO = new FacilityTypeDAO();
        fType = fDAO.getFacilityType(delete_facility_type_id);
        
        
        try{
//            Set<OpenRule> openRules = fType.getOpenRules();
//            Set<CloseRule> closeRules = fType.getCloseRules();
//            Set<LimitRule> limitRules = fType.getLimitRules();
//            Set<AdvanceRule> advanceRules = fType.getAdvanceRules();
//            
////            if(!openRules.isEmpty()){
//                orDAO = new OpenRuleDAO();
//                for(OpenRule or : openRules){
//                    orDAO.deleteOpenRule(or.getId());
//                }
////            }
//            
//            
////            if(!limitRules.isEmpty()){
//                lrDAO = new LimitRuleDAO();
//                for(LimitRule lr : limitRules){
//                    lrDAO.deleteLimitRule(lr.getId());
//                }
////            }
//            
//            
////            if(!advanceRules.isEmpty()){
//                arDAO = new AdvanceRuleDAO();
//                for(AdvanceRule ar : advanceRules){
//                    arDAO.deleteAdvanceRule(ar.getId());
//                }
////            }
//            
////            if(!closeRules.isEmpty()){
//                crDAO = new CloseRuleDAO();
//                for(CloseRule cr : closeRules){
//                    crDAO.deleteCloseRule(cr.getId());
//                }
////            }
//            
//            fDAO = new FacilityTypeDAO();
            fDAO.deleteFacilityType(delete_facility_type_id);
            return new RedirectResolution("/admin/manage-facilitytypes.jsp?deletesuccess=true"+"&deletemsg="+fType.getName());
        }
        catch(Exception e){
            e.printStackTrace(); 
        }
        return new RedirectResolution("/admin/manage-facilitytypes.jsp?deletesuccess=false");
    }

}
