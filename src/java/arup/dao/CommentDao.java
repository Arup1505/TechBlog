/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package arup.dao;

/**
 *
 * @author arupb
 */
import arup.entity.Comments;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
public class CommentDao {
    private Connection con;

    public CommentDao(Connection con) {
        this.con = con;
    }
    
    public boolean addComments(Comments c){
        boolean f= false;
         try {
             
             String q="insert into post_comment(pId,idusers,cContent) values(?,?,?)";
             PreparedStatement pst=con.prepareStatement(q);
             pst.setInt(1, c.getpId());
             pst.setInt(2, c.getIdusers());
             pst.setString(3,c.getcContent());
             pst.executeUpdate();
             f=true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    public ArrayList<Comments> getAllComments(int pid){
        ArrayList<Comments> comm= new ArrayList<>();
        try {
            String q="select * from post_comment where pId=?";
            PreparedStatement p = con.prepareStatement(q);
            p.setInt(1, pid);
            ResultSet rs = p.executeQuery();
            while (rs.next()) {
                int commentid=rs.getInt("comment_id");
                int pId=rs.getInt("pId");
                int uid=rs.getInt("idusers");
                String content=rs.getString("cContent");
                Timestamp timedate = rs.getTimestamp("cDate");
                Comments com = new Comments(commentid, pId, uid, content, timedate);
                comm.add(com);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return comm;
    }
    
}
