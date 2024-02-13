/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package arup.entity;

/**
 *
 * @author arupb
 */
public class Categories {
    
    private int catId;
    private String cName;
    private String description;

    public Categories() {
    }

    public Categories(String cName, String description) {
        this.cName = cName;
        this.description = description;
    }

    public Categories(int catId, String cName, String description) {
        this.catId = catId;
        this.cName = cName;
        this.description = description;
    }

    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }

    public String getcName() {
        return cName;
    }

    public void setcName(String cName) {
        this.cName = cName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
    
}
