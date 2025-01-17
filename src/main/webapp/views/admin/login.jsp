<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.jj.admin.model.vo.UserInfoAd"%>
    
<%@ page import="java.util.ArrayList, com.jj.mtm.model.vo.Mtm, com.jj.notice.model.vo.Notice" %>
<%
	UserInfoAd u = (UserInfoAd)session.getAttribute("UserInfoAd");
	String alertMsg = (String)session.getAttribute("alertMsg");
	
	ArrayList<Mtm> mtmList = (ArrayList<Mtm>)request.getAttribute("Mtm");
	ArrayList<Notice> noticeList = (ArrayList<Notice>)request.getAttribute("Notice");
	int mentorApprovalCount = (int)request.getAttribute("mentorApprovalCount");
	int vodApprovalCount = (int)request.getAttribute("vodApprovalCount");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin-login.css">
<title>Insert title here</title>
</head>
<body>

	<% if(u == null){ %>
		<!-- 로그인 전 보여질 화면 -->
		<div style="display : none;">
			<%@ include file="common/topbar.jsp" %>
		</div>
		
	    <div class="admin-login-area">
	        <img src="${pageContext.request.contextPath}/resources/image/logo.png" alt="logo" width="150">
	        <p>관리자로그인</p>
	        <form action="adLogin.do" method="post" class="login-area">
	            <input type="text" name="adminId" class="form-control" placeholder="아이디" required><br>
	            <input type="password" name="adminPwd" class="form-control" placeholder="비밀번호" required><br>
	            <button type="submit">로그인</button>
	        </form>
	    </div>
	<% } else { %>
		<!-- 로그인 후 보여질 화면 -->
		<%@ include file="common/topbar.jsp" %>
	
		<div class="content-wrap">
	    	<div class="left">
				<%@ include file="common/menubar.jsp" %>
			</div>
	
		    <div class="right">
		        <h3 style="color : #6363ff">대시보드</h3>
		        
		        <!-- 통꼐 -->
		        <div class="statistics-area">
					<div class="item1">
						<div class="text">
							<span>총 회원수</span><br>
							<span><%=request.getAttribute("totalMember") %></span>
						</div>
						<div class="img">
							<i class="fas fa-user-friends"></i>
						</div>
					</div>
					<div class="item2">
						<div class="text">
							<span>수강생수</span><br>
							<span><%=request.getAttribute("totalStu") %></span>
						</div>
						<div class="img">
							<i class="fas fa-user-alt"></i>
						</div>
					</div>
					<div class="item3">
						<div class="text">
							<span>멘토수</span><br>
							<span><%=request.getAttribute("totalMentor") %></span>
						</div>
						<div class="img">
							<i class="fas fa-user-alt"></i>
						</div>
					</div>
					<div class="item4">
						<div class="text">
							<span>일일 접속자</span><br>
							<span><%=request.getAttribute("todayConnect") %></span>
						</div>
						<div class="img">
							<i class="fas fa-user-friends"></i>
						</div>
					</div>
		        </div>
				
				<!-- 게시글 -->
		        <div class="post-area">
						<ul class="item1">
							<li class="item-title">
								<span>1대1 문의관리</span>
								<span><a href="<%= contextPath %>/mtmListView.ad?cpage=1">더보기</a></span>
							</li>
							<% if(mtmList.isEmpty()){ %>
								<li class="item-content">
									<span><a href="">조회된 문의가 없습니다.</a></span>
								</li>
							<% } else { %>
									<% for(Mtm i : mtmList){ %>
											<li class="item-content">
												<span><a href="<%= contextPath %>/mtmAnswerForm.ad?no=<%= i.getMtmNo() %>"><%= i.getMtmTitle() %></a></span>
												<span><%= i.getMtmEnrolldate() %></span>
											</li>
									<% } %>
							<% } %>
						</ul>
						
						<ul class="item2">
							<li class="item-title">
								<span>공지사항 관리</span>
								<span><a href="<%= contextPath %>/noticeListView.ad?cpage=1">더보기</a></span>
							</li>
							<% if(noticeList.isEmpty()){ %>
								<li class="item-content">
									<span><a href="">조회된 공지사항이 없습니다.</a></span>
								</li>
							<% } else { %>
									<% for(Notice i : noticeList){ %>
										<li class="item-content">
											<span><a href="<%= contextPath %>/noticeListView.ad?cpage=1"><%= i.getNoticeTitle() %></a></span>
											<span><%= i.getNoticeEnrolldate() %></span>
										</li>
									<% } %>
							<% } %>
						</ul>
				</div>
				
				<!-- 알림 -->
		        <div class="notification-area">
					<div class="item1">
						<div class="text">
							<span>멘토 가입 신청</span><br>
							<span><%= mentorApprovalCount %></span>
						</div>
						<div class="img">
							<a href="<%= contextPath %>/mentorApprovalListView.ad?cpage=1">
								<i class="fas fa-angle-right"></i>
							</a>
						</div>
					</div>
					<div class="item2">
						<div class="text">
							<span>강의 등록 신청</span><br>
							<span><%= vodApprovalCount %></span>
						</div>
						<div class="img">
							<a href="<%= contextPath %>/mentorVodApprovalListView.ad?cpage=1">
								<i class="fas fa-angle-right"></i>
							</a>
						</div>
					</div>
					<div class="item3">
						<div class="text">
							<span>결제</span><br>
							<span><%=request.getAttribute("todayPay") %></span>
						</div>
						<div class="img">
							<a href="<%= contextPath %>/paymentselect.bo?p=1">
								<i class="fas fa-angle-right"></i>
							</a>
						</div>
					</div>
					<div class="item4">
						<div class="text">
							<span>환불 요청</span><br>
							<span><%=request.getAttribute("rqRefundCount") %></span>
						</div>
						<div class="img">
							<a href="<%= contextPath %>/refundRequest.li?p=1">
								<i class="fas fa-angle-right"></i>
							</a>
						</div>
					</div>
				</div>
		    </div>
	    </div>
	<% } %>
</body>
</html>