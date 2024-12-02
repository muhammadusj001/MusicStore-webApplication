package com.letslearn.Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.letslearn.DBcon.DbCon;
import com.letslearn.Dao.AlbumDao;
import com.letslearn.Modal.Album;

@WebServlet("/AlbumServlet")
public class AlbumServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private int result = 0;
    String action = null;
    String title = null;
    String artist = null;
    int yearReleased = 0;
    String genre = null;
    int numberOfTracks = 0;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        action = request.getParameter("action");
        if (action.equals("delete")) {
            title = request.getParameter("title");
            try {
                AlbumDao albumDao = new AlbumDao(DbCon.getConnection());
                result = albumDao.deleteAlbum(title);
                if (result != 0) {
                    response.sendRedirect("albumManagement.jsp");
                } else {
                    out.write("<script>alert('An error occurred. Please try again.');</script>");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        action = request.getParameter("action");

        title = request.getParameter("title");
        artist = request.getParameter("artist");
        yearReleased = Integer.parseInt(request.getParameter("yearReleased"));
        genre = request.getParameter("genre");
        numberOfTracks = Integer.parseInt(request.getParameter("numberOfTracks"));

        if (action.equals("addAlbum")) {
            try {
                Album album = new Album(title, artist, yearReleased, genre, numberOfTracks);
                AlbumDao albumDao = new AlbumDao(DbCon.getConnection());
                result = albumDao.addAlbum(album);
                if (result != 0) {
                    response.sendRedirect("albumManagement.jsp");
                } else {
                    out.write("<script>alert('An error occurred. Please try again.');</script>");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (action.equals("update")) {
            try {
                Album album = new Album(title, artist, yearReleased, genre, numberOfTracks);
                AlbumDao albumDao = new AlbumDao(DbCon.getConnection());
                result = albumDao.updateAlbum(album);
                if (result != 0) {
                    response.sendRedirect("albumManagement.jsp");
                } else {
                    out.write("<script>alert('An error occurred. Please try again.');</script>");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
