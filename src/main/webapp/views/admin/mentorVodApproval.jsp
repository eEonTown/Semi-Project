<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin-table-paging.css">
<title>Insert title here</title>
</head>
<body>
	<%if(session.getAttribute("UserInfoAd") == null){ %>
	<script>
		alert("유효하지않은 접근입니다.");
		location.href="<%= request.getContextPath() %>/login.ad";
	</script>
	<%}else{ %>
	<%@ include file="common/topbar.jsp" %>
	
	<div class="content-wrap">
	
	<div class="left">
		<%@ include file="common/menubar.jsp" %>
	</div>
	
		<div class="right">
		    <h3>멘토 강의 등록 승인</h3>
		    
		    <table class="table table-bordered table-hover admin-table">
                <thead>
                    <tr>
                        <th width="60">번호</th>
                        <th width="200">클래스명</th>
                        <th width="200">강의명</th>
                        <th width="60">강사명</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>10</td>
                        <td>컴퓨터비전, 머신러닝, 딥러닝을 이용한 의료영상 분석</td>
                        <td>강의명이들어갈자리입니다</td>
                        <td>홍길동</td>
                    </tr>
                </tbody>
            </table>

            <div class="paging-area">
                <a href="">&lt</a>
                <a href="">1</a>
                <a href="">2</a>
                <a href="">3</a>
                <a href="">4</a>
                <a href="">5</a>
                <a href="">&gt</a>
            </div>
		</div>
		
	</div>
	<%} %>
</body>
</html>