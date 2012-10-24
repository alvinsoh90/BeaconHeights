/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Block;
import com.lin.utils.HibernateUtil;
import java.util.ArrayList;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Yangsta
 */
public class BlockDAO {
    
    private static ArrayList<Block> blockList = new ArrayList<Block>();
    Session session = null;
    
    public BlockDAO(){
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }
    
    public ArrayList<Block> getAllBlocks(){
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery ("from Block");
            blockList = (ArrayList<Block>) q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return blockList;
    } 
    
    public static void updateBlock(String blockId){
        
    }
    
    public Block getBlockByName(String name){
        //refresh role list
        getAllBlocks();
        
        for(Block r : blockList){
            if(r.getBlockName().equals(name)){
                return r;
            }
        }
        
        return null;
    }
    
    public static void createBlock(Long id, String name, float lat, float lng, 
            String desc){
        
    }

}
