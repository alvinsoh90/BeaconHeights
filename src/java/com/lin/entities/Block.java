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
    private long id;
    private String blockName;
    private float lng;
    private float lat;
    private String block_description;

    public Block(long id, String block_name, float block_lat, float block_lng, String block_description) {
        this.id = id;
        this.blockName = block_name;
        this.lng = block_lng;
        this.lat = block_lat;
        this.block_description = block_description;
    }

    public String getBlockDescription() {
        return block_description;
    }

    public void setBlockDescription(String block_description) {
        this.block_description = block_description;
    }

    public float getLat() {
        return lat;
    }

    public void setLat(int block_lat) {
        this.lat = block_lat;
    }

    public float getLng() {
        return lng;
    }

    public void setLng(int block_lng) {
        this.lng = block_lng;
    }

    public String getBlockName() {
        return blockName;
    }

    public void setBlockName(String block_name) {
        this.blockName = block_name;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "Block{" + "id=" + id + ", blockName=" + blockName + ", lng=" + lng + ", lat=" + lat + ", block_description=" + block_description + '}';
    }
    
    
}
