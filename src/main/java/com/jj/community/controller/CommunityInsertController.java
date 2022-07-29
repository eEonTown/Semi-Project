package com.jj.community.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.community.model.service.CommunityService;
import com.jj.community.model.vo.Community;

/**
 * Servlet implementation class communityInsertController
 */
@WebServlet("/insert.co")
public class CommunityInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommunityInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		// 로그인 기능 필요
		// 세션 영역에 담긴 loginMember 객체 사용 위한 세션 선언
//		HttpSession session = request.getSession("세션명");
		
		// 카테고리 번호, 제목, 내용, 로그인한 회원번호
		String categoryNo = request.getParameter("categorySelect");
		String title = request.getParameter("contentTitle");
		String content = request.getParameter("contentBody");
		
		// 로그인 기능 필요
//		String writerNo = Integer.toString(((Member)session.getAttribute("loginUserInfo")).getUserNo());
		String writerNo = "2";	// test용 - 추후 삭제
		
//		System.out.println(no);
//		System.out.println(title);
//		System.out.println(content);
//		System.out.println(writerNo);
		
		// community 객체에 담아서 전달
		Community c = new Community();
		c.setCommCategory(categoryNo);
		c.setCommTitle(title);
		c.setCommContent(content);
		c.setCommWriter(writerNo);
		
//		System.out.println(c);
		
		int result = new CommunityService().insertCommunity(c);
		
		if(result > 0) {	// 성공
			response.sendRedirect(request.getContextPath() + "/list.co?category=" + categoryNo + "&cpage=1");
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