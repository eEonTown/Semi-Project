package com.jj.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.admin.model.service.AdminService2;

/**
 * Servlet implementation class DeleteUserCpController
 */
@WebServlet("/deleteUserCp.de")
public class DeleteUserCpController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUserCpController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		int result = new AdminService2().deleteUserCp(no);
		if(result>0) {
			request.getSession().setAttribute("alertMsg", "쿠폰회수에 성공했습니다.");
			response.sendRedirect(request.getContextPath()+"/selectCoupon.li?p=1");
		}else {
			request.getSession().setAttribute("alertMsg", "쿠폰회수에 실패했습니다.");
			response.sendRedirect(request.getContextPath()+"/selectCoupon.li?p=1");
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
