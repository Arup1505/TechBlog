/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package arup.dao;

import arup.entity.Categories;
import arup.entity.Post;

import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author arupb
 */
public class AddPostDao {

    Connection con;

    public AddPostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Categories> getAllCategorieses() {
        ArrayList<Categories> list = new ArrayList<>();
        try {
            String q = "select * from catagories";
            PreparedStatement pstm = con.prepareStatement(q);
            ResultSet set = pstm.executeQuery();
            while (set.next()) {
                int catit = set.getInt("catId");
                String name = set.getString("cName");
                String des = set.getString("description");
                Categories c = new Categories(catit, name, des);
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean savePost(Post p) {
        boolean f = false;
        try {
            String q = "insert into post(pTitle,pContent,pCode,pPic,catId,user_id) values(?,?,?,?,?,?)";
            PreparedStatement pstm = con.prepareStatement(q);
            pstm.setString(1, p.getpTitle());
            pstm.setString(2, p.getpContent());
            pstm.setString(3, p.getpCode());
            pstm.setString(4, p.getpPic());
            pstm.setInt(5, p.getCatid());
            pstm.setInt(6, p.getUser_id());
            pstm.execute();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public List<Post> getAllPosts() {
        List<Post> list = new ArrayList<>();

        try {
            PreparedStatement pstm = con.prepareStatement("select * from post");
            ResultSet set = pstm.executeQuery();
            while(set.next())
            {
                int id=set.getInt("pId");
                String title = set.getString("pTitle");
                String content = set.getString("pContent");
                String code = set.getString("pCode");
                String pic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int catid=set.getInt("catId");
                int userid=set.getInt("user_id");
                Post posts = new Post(id, title, content, code, pic, date, catid, userid);
                list.add(posts);
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public List<Post> getPostByCategories(int catId){
        List<Post> list = new ArrayList<>();
        
        try {
            PreparedStatement pstm = con.prepareStatement("select * from post where catId=?");
            pstm.setInt(1, catId);
            ResultSet set = pstm.executeQuery();
            while(set.next())
            {
                int id=set.getInt("pId");
                String title = set.getString("pTitle");
                String content = set.getString("pContent");
                String code = set.getString("pCode");
                String pic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int userid=set.getInt("user_id");
                Post posts = new Post(id, title, content, code, pic, date, catId, userid);
                list.add(posts);
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public Post getPostsByPostId(int pid){
        Post posts=null;
        
        String q = "select * from post where pId=?";
        
        try {
          PreparedStatement pst = con.prepareStatement(q);
          pst.setInt(1, pid);
          ResultSet set=pst.executeQuery();
            if (set.next()) {
                int id=set.getInt("pId");
                String title = set.getString("pTitle");
                String content = set.getString("pContent");
                String code = set.getString("pCode");
                String pic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int catid=set.getInt("catId");
                int userid=set.getInt("user_id");
                posts=new Post(pid, title, content, code, pic, date, catid, userid);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return posts;
    }

}
