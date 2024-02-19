/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package arup.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import arup.entity.Users;
import java.sql.ResultSet;
public class UserDao {
    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }
    
    public boolean addUsers(Users user){
        boolean f = false;
        try {
            String query = "insert into users(user_name,password,user_email,gender,abouts) values(?,?,?,?,?)";
            PreparedStatement pstm = con.prepareStatement(query);
            pstm.setString(1, user.getName());
            pstm.setString(2, user.getPassword());
            pstm.setString(3,user.getEmail());
            pstm.setString(4,user.getGender());
            pstm.setString(5,user.getAbout());
            pstm.executeUpdate();
            f=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    public Users getUserNammeAndPass(String email,String password){
        Users user=null;
        try {
            String quereyString="select * from users where user_email=? and password=?";
            PreparedStatement pstm = con.prepareStatement(quereyString);
            pstm.setString(1, email);
            pstm.setString(2, password);
            ResultSet set = pstm.executeQuery();
            
            if (set.next()) {
                user = new Users();
                String name = set.getString("user_name");
                user.setName(name);
                user.setId(set.getInt("idusers"));
                user.setPassword(set.getString("password"));
                user.setEmail(set.getString("user_email"));
                user.setGender(set.getString("gender"));
                user.setDateTimestamp(set.getTimestamp("reg_date"));
                user.setAbout(set.getString("abouts"));
                user.setProfile(set.getString("profile"));
                
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public boolean updateUser(Users user){
        boolean f = false;
        
        try {
            String query = "update users set user_name=?,password=?,user_email=?,abouts=?,profile=? where idusers=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, user.getName());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getAbout());
            ps.setString(5, user.getProfile());
            ps.setInt(6, user.getId());
            ps.executeUpdate();
            f=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return f;
    }
    
     public Users getPostByUserIdDetils(int userId){
        Users user = null;
        
        String qString = "select * from users where idusers=?";
        try {
            PreparedStatement pstm = con.prepareStatement(qString);
            pstm.setInt(1, userId);
            ResultSet set = pstm.executeQuery();
            
            if (set.next()) {
                user = new Users();
                user.setName(set.getString("user_name"));
                user.setId(set.getInt("idusers"));
                user.setPassword(set.getString("password"));
                user.setEmail(set.getString("user_email"));
                user.setGender(set.getString("gender"));
                user.setDateTimestamp(set.getTimestamp("reg_date"));
                user.setAbout(set.getString("abouts"));
                user.setProfile(set.getString("profile"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return user;
    }
     
    
}