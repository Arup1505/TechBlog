/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package arup.servlets;

import arup.dao.UserDao;
import arup.entity.Message;
import arup.entity.Users;
import arup.helper.ConnectionProvider;
import arup.helper.FileHelper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author arupb
 */
@MultipartConfig
public class EditServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");
            out.println("</head>");
            out.println("<body>");

            String name = request.getParameter("user_name");
            String pass = request.getParameter("user_pass");
            String email = request.getParameter("user_email");
            String about = request.getParameter("about");
            Part part = request.getPart("image");
            String profile = part.getSubmittedFileName();
            HttpSession hs = request.getSession();
            Users us = (Users) hs.getAttribute("currentUser");
            us.setName(name);
            us.setEmail(email);
            us.setPassword(pass);
            us.setAbout(about);
            String oldFileName=us.getProfile();
            us.setProfile(profile);

            UserDao ud = new UserDao(ConnectionProvider.createConnection());
            boolean b = ud.updateUser(us);
            if (b) {
                out.println("Update Complete");
                
                if (!oldFileName.equals("default.png")) {
                String deletePath = request.getRealPath("/") + "pics" + File.separator + oldFileName;    
                FileHelper.deleteFile(deletePath);
                }
                String path = request.getRealPath("/") + "pics" + File.separator + us.getProfile();
                

                if (FileHelper.saveFile(part.getInputStream(), path)) {
                    Message msg = new Message("Profile details Updated", "success", "alert-success");

                    hs.setAttribute("msg", msg);
                    response.sendRedirect("profile.jsp");
                }

            } else {
                Message msg = new Message("Sorry! Something went wrong", "error", "alert-denger");

                    hs.setAttribute("msg", msg);
                    response.sendRedirect("profile.jsp");
            }

            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
