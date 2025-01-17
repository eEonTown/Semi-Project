package com.jj.userMyPage.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jj.member.model.vo.Member;
import com.jj.userMyPage.model.service.CouponListService;
import com.jj.userMyPage.model.vo.UCoupon;

/**
 * Servlet implementation class CouponListSelectController
 */
@WebServlet("/listCp.my")
public class CouponListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CouponListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		HttpSession session = request.getSession();
		int userNo = ((Member)session.getAttribute("loginUser")).getUserNo();
		
		 
		 ArrayList <UCoupon> list = new CouponListService().selectListCp(userNo);
		 
		 
		 int result = new CouponListService().countCp(userNo);
		
		
		request.setAttribute("list", list);
//		객체에 값 담아서 보내야함!!
		request.setAttribute("countCp", result);
		request.getRequestDispatcher("views/userMyPage/myCouponView.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
