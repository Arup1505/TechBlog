/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package arup.entity;


import java.sql.Timestamp;

/**
 *
 * @author arupb
 */
public class Comments {
    private int comment_id;
    private int pId;
    private int idusers;
    private String cContent;
    private Timestamp cDate;

    public Comments() {
    }

    public Comments(int comment_id, int pId, int idusers, String cContent, Timestamp cDate) {
        this.comment_id = comment_id;
        this.pId = pId;
        this.idusers = idusers;
        this.cContent = cContent;
        this.cDate = cDate;
    }

    public Comments(int pId, int idusers, String cContent, Timestamp cDate) {
        this.pId = pId;
        this.idusers = idusers;
        this.cContent = cContent;
        this.cDate = cDate;
    }

    public int getComment_id() {
        return comment_id;
    }

    public void setComment_id(int comment_id) {
        this.comment_id = comment_id;
    }

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public int getIdusers() {
        return idusers;
    }

    public void setIdusers(int idusers) {
        this.idusers = idusers;
    }

    public String getcContent() {
        return cContent;
    }

    public void setcContent(String cContent) {
        this.cContent = cContent;
    }

    public Timestamp getcDate() {
        return cDate;
    }

    public void setcDate(Timestamp cDate) {
        this.cDate = cDate;
    }
    
    
    
}
