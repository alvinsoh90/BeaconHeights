/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.controllers;

import com.lin.dao.FacilityTypeDAO;
import com.lin.entities.FacilityType;

/**
 *
 * @author Yangsta
 */
public class FacilityTypeController {
    
    FacilityTypeDAO tDAO = new FacilityTypeDAO();
    
    public FacilityType editFacilityType(FacilityType fType){
        FacilityType ft = null;
        
        ft = tDAO.editFacilityType(fType);        
        //tDAO.deleteFacilityType(fType);
        
        //tDAO.createFacilityType(fType);
        
        
        return ft;
    }
    
    public FacilityType createFacilityType(FacilityType fType){
        FacilityType ft = null;
        
        ft = tDAO.createFacilityType(fType);
        if (ft != null) {
            System.out.println("facility saved, id: " + ft.getId());
        } else {
            System.out.println("Failed to save facility!");
        }
        
        return ft;
    }
    
}
