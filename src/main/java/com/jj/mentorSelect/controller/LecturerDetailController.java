package com.jj.mentorSelect.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.classSelect.model.vo.Class;
import com.jj.mentorSelect.model.service.LecturerService;
import com.jj.mentorSelect.model.vo.Lecturer;

/**
 * Servlet implementation class LecturerDetailController
 */
@WebServlet("/detail.lt")
public class LecturerDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LecturerDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 강의자 번호를 받아서 개별 강의자에 대한 정보 조회
		int lecNo = Integer.parseInt(request.getParameter("lecNo"));
		
		Lecturer l = new LecturerService().selectLecturer(lecNo);
		ArrayList<Class> classList = new LecturerService().selectClass(lecNo);
				
		request.setAttribute("l", l);
		request.setAttribute("classList", classList);
		request.getRequestDispatcher("views/mentorSelect/lecturerDetailView.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
