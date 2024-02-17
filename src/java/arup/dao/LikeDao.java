/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package arup.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author arupb
 */
public class LikeDao {
    
    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }
    
    public boolean insertLike(int pid,int uid){
        
        boolean f= false;
        
        try {
            String q = "insert into like_post(pId,idusers) values(?,?)";
            PreparedStatement pst=con.prepareStatement(q);
            pst.setInt(1, pid);
            pst.setInt(2, uid);
            pst.executeUpdate();
            f=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return f;
        
    }
    
    public int countLikes(int pid){
        int count=0;
        
        try {
            String q = "select count(*) from like_post where pId=?";
            PreparedStatement p = con.prepareStatement(q);
            p.setInt(1, pid);
            ResultSet set= p.executeQuery();
            if (set.next()) {
                count=set.getInt("count(*)");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return count;
    }
    
    public boolean isLikedByUser(int pid,int uid){
        
        boolean f=false;
        try {
           PreparedStatement p = con.prepareStatement("select * from like_post where pId=? and idusers=?");
           p.setInt(1, pid);
           p.setInt(2, uid);
           ResultSet set = p.executeQuery();
            if (set.next()) {
                f=true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    public boolean deleteLike(int pid, int uid){
        boolean f=false;
        try {
            PreparedStatement p = con.prepareStatement("delete from like_post where pId=? and idusers=?");
            p.setInt(1, pid);
            p.setInt(2, uid);
            p.executeUpdate();
            f=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
}
