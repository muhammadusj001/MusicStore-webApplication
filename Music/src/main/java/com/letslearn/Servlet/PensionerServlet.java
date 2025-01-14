package com.letslearn.Servlet;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.random.RandomGenerator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.letslearn.DBcon.DbCon;
import com.letslearn.Dao.PensionerDao;
import com.letslearn.Modal.Pensioner;

/**
 * Servlet implementation class PensionerServlet
 */
@WebServlet("/PensionerServlet")
public class PensionerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private int result = 0;
	RequestDispatcher dis = null;
	String action = null;
	String nic = null;
	String city = null;
	String tel = null;
	String grade = null;
	String fname = null;
	String emailString = null;
	String pensionerRetired=null;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		action = request.getParameter("action");
		if(action.equals("delete")){
			emailString = request.getParameter("email");
			nic = request.getParameter("nic");
			city = request.getParameter("city");
			tel = request.getParameter("tel");
			grade = request.getParameter("grade");
			fname = request.getParameter("fname");
			
			try {
				PensionerDao pensionerDao = new PensionerDao(DbCon.getConnection());
				result = pensionerDao.deletePensioner(emailString);
				if (result != 0) {
					response.sendRedirect("EmpManagement.jsp");
					
				} else {
					// Send a JavaScript alert for an error
					out.write("<script>alert('An error . Please try again.');</script>");
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
		
		emailString = request.getParameter("email");
		nic = request.getParameter("nic");
		city = request.getParameter("city");
		tel = request.getParameter("tel");
		grade = request.getParameter("grade");
		fname = request.getParameter("fname");
		pensionerRetired = request.getParameter("pensionerRetired");
		System.out.println(pensionerRetired);
		if(action.equals("addPensioner")) {
			try {
				
				Pensioner pensioner = new Pensioner(city, grade,tel,emailString, fname,nic);
				PensionerDao pensionerDao = new PensionerDao(DbCon.getConnection());
				result = pensionerDao.addPensioner(pensioner);
				if (result != 0) {
					response.sendRedirect("EmpManagement.jsp");
				} else {
					// Send a JavaScript alert for an error
					out.write("<script>alert('An error occurred. Please try again.');</script>");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(action.equals("update")){
			try {
				Pensioner pensioner = new Pensioner(city, grade,tel,emailString, fname,nic);
				PensionerDao pensionerDao = new PensionerDao(DbCon.getConnection());
				result = pensionerDao.updatePensioner(pensioner);
				if (result != 0) {
					response.sendRedirect("EmpManagement.jsp");
				} else {
					// Send a JavaScript alert for an error
					out.write("<script>alert('An error  Please try again.');</script>");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(action.equals("delete")) {
			System.out.println(emailString);
			try {
				PensionerDao pensionerDao = new PensionerDao(DbCon.getConnection());
				result = pensionerDao.deletePensioner(emailString);
				if (result != 0) {
					response.sendRedirect("EmpManagement.jsp");
				} else {
					// Send a JavaScript alert for an error
					out.write("<script>alert('An error  Please try again.');</script>");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
