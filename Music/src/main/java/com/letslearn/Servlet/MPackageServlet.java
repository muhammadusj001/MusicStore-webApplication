package com.letslearn.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.letslearn.DBcon.DbCon;
import com.letslearn.Dao.MusicPackageDao;
import com.letslearn.Modal.MusicPackage;

/**
 * Servlet implementation class MPackageServlet
 */
@WebServlet("/MPackageServlet")
public class MPackageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private int result = 0;
	private RequestDispatcher dis = null;
	private String action = null;
	private String name = null;
	private String price = null;
	private String numberOfSongs = null;
	private boolean unlimitedStreaming = false;
	private String id = null;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();

		action = request.getParameter("action");

		if (action.equals("delete")) {
			id = request.getParameter("musicPackageId");
			try {
				MusicPackageDao musicPackageDao = new MusicPackageDao(DbCon.getConnection());
				result = musicPackageDao.deleteMusicPackage(Integer.parseInt(id));
				if (result != 0) {
					response.sendRedirect("PackageM.jsp");
				} else {
					// Send a JavaScript alert for an error
					out.write("<script>alert('An error occurred. Please try again.');</script>");
				}
			} catch (Exception e) {
				e.printStackTrace();
				out.write("<script>alert('An error occurred. Please try again.');</script>");
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		action = request.getParameter("action");

		name = request.getParameter("packageName");
		price = request.getParameter("packagePrice");
		numberOfSongs = request.getParameter("packageNumberOfSongs");
		unlimitedStreaming = Boolean.parseBoolean(request.getParameter("packageUnlimitedStreaming"));

		if (action.equals("addMusicPackage")) {
			try {
				MusicPackage musicPackage = new MusicPackage(name, price, numberOfSongs,unlimitedStreaming);
				MusicPackageDao musicPackageDao = new MusicPackageDao(DbCon.getConnection());
				result = musicPackageDao.addMusicPackage(musicPackage);
				if (result != 0) {
					response.sendRedirect("PackageM.jsp");
				} else {
					// Send a JavaScript alert for an error
					out.write("<script>alert('An error occurred. Please try again.');</script>");
				}
			} catch (Exception e) {
				e.printStackTrace();
				out.write("<script>alert('An error occurred. Please try again.');</script>");
			}
		} else if (action.equals("update")) {
			id = request.getParameter("musicPackageId");
			try {
				MusicPackage musicPackage = new MusicPackage(name, price, numberOfSongs, unlimitedStreaming);
				musicPackage.setId(Integer.parseInt(id));
				MusicPackageDao musicPackageDao = new MusicPackageDao(DbCon.getConnection());
				result = musicPackageDao.updateMusicPackage(musicPackage);
				if (result != 0) {
					response.sendRedirect("PackageM.jsp");
				} else {
					// Send a JavaScript alert for an error
					out.write("<script>alert('An error occurred. Please try again.');</script>");
				}
			} catch (Exception e) {
				e.printStackTrace();
				out.write("<script>alert('An error occurred. Please try again.');</script>");
			}
		}
	}
}
