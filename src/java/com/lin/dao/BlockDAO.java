/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Block;

/**
 *
 * @author Yangsta
 */
public class BlockDAO {
    
    public static void getAllBlocks(){
        
    } 
    
    public static void updateBlock(String blockId){
        
    }
    
    public static Block getBlockByName(String name){
        //temp return
        return new Block(Long.parseLong("1"),"Beacon Heights",1.0000F,1.2000F,"The One And Only Beacon Heights!");
    }
    
    public static void createBlock(Long id, String name, float lat, float lng, 
            String desc){
        
    }

}
