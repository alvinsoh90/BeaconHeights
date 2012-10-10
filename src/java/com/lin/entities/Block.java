/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.entities;

/**
 *
 * @author Keffeine
 */
public class Block {
    private int id;
    private String block_name;
    private int block_lng;
    private int block_lat;
    private String block_description;

    public Block(int id, String block_name, int block_lng, int block_lat, String block_description) {
        this.id = id;
        this.block_name = block_name;
        this.block_lng = block_lng;
        this.block_lat = block_lat;
        this.block_description = block_description;
    }

    public String getBlock_description() {
        return block_description;
    }

    public void setBlock_description(String block_description) {
        this.block_description = block_description;
    }

    public int getBlock_lat() {
        return block_lat;
    }

    public void setBlock_lat(int block_lat) {
        this.block_lat = block_lat;
    }

    public int getBlock_lng() {
        return block_lng;
    }

    public void setBlock_lng(int block_lng) {
        this.block_lng = block_lng;
    }

    public String getBlock_name() {
        return block_name;
    }

    public void setBlock_name(String block_name) {
        this.block_name = block_name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    
}
