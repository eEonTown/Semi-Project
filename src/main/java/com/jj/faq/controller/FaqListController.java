package com.jj.faq.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.faq.model.service.FaqService;
import com.jj.faq.model.vo.Faq;

/**
 * Servlet implementation class FaqListController
 */
@WebServlet("/list.faq")
public class FaqListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FaqListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// FAQ목록 조회용
		
		// 3) 요청처리(응답페이지에 필요한 데이터를 조회)
		ArrayList<Faq> list = new FaqService().selectFaqList();
		
		// 4) 응답뷰 => faqList.jsp
		request.setAttribute("list", list);
		request.getRequestDispatcher("views/member/faqList.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
