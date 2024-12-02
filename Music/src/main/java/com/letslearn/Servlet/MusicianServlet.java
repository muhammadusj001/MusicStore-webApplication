package com.letslearn.Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.letslearn.DBcon.DbCon;
import com.letslearn.Dao.MusicianDao;
import com.letslearn.Modal.Musician;

@WebServlet("/MusicianServlet")
public class MusicianServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private int result = 0;
    String action = null;
    String name = null;
    String email = null;
    String nic = null;
    String genre = null;
    int age = 0;
    String instrument = null;
    String id = null;
    String tel = null;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        action = request.getParameter("action");
        id = request.getParameter("musicianId");
        System.out.println(id);
        if (action.equals("delete")) {
            try {
                MusicianDao musicianDao = new MusicianDao(DbCon.getConnection());
                result = musicianDao.deleteMusician(id);
                if (result != 0) {
                    response.sendRedirect("musicianManagement.jsp");
                } else {
                    // Send a JavaScript alert for an error
                    out.write("<script>alert('An error occurred. Please try again.');</script>");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        action = request.getParameter("action");

        name = request.getParameter("name");
        email = request.getParameter("email");
        nic = request.getParameter("nic");
        genre = request.getParameter("genre");
        age = Integer.parseInt(request.getParameter("age"));
        instrument = request.getParameter("instrument");
        id = request.getParameter("musicianId");
        tel = request.getParameter("tel");

        if (action.equals("addMusician")) {
            try {
                Musician musician = new Musician(name, email, nic, genre, age, instrument, id, tel);
                MusicianDao musicianDao = new MusicianDao(DbCon.getConnection());
                result = musicianDao.addMusician(musician);
                if (result != 0) {
                    response.sendRedirect("musicianManagement.jsp");
                } else {
                    // Send a JavaScript alert for an error
                    out.write("<script>alert('An error occurred. Please try again.');</script>");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (action.equals("update")) {
            try {
                Musician musician = new Musician(name, email, nic, genre, age, instrument, id, tel);
                MusicianDao musicianDao = new MusicianDao(DbCon.getConnection());
                result = musicianDao.updateMusician(musician);
                if (result != 0) {
                    response.sendRedirect("musicianManagement.jsp");
                } else {
                    // Send a JavaScript alert for an error
                    out.write("<script>alert('An error occurred. Please try again.');</script>");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
