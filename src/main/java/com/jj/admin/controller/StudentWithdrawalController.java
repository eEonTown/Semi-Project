package com.jj.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.admin.model.service.AdminService2;

/**
 * Servlet implementation class StudentWithdrawal
 */
@WebServlet("/withdrawalStu.up")
public class StudentWithdrawalController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentWithdrawalController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		
		int result = new AdminService2().withdrawalStu(name,id);
		
		if(result>0) {
			request.getSession().setAttribute("alertMsg", "회원탈퇴를 정상적으로 처리했습니다.");
			response.sendRedirect(request.getContextPath()+"/stuInfo.li?p=1");
		}else {
			request.getSession().setAttribute("alertMsg", "회원탈퇴처리에 실패했습니다.");
			response.sendRedirect(request.getContextPath()+"/stuInfo.li?p=1");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
