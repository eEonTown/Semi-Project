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
	<%@ include file="common/topbar.jsp" %>
	
	<div class="content-wrap">
	
	<div class="left">
		<%@ include file="common/menubar.jsp" %>
	</div>
	
		<div class="right">
		    <h3>공지사항 관리</h3>
		    
		    <table class="table table-bordered table-hover admin-table">
                <thead>
                    <tr>
                        <th width="60">번호</th>
                        <th width="300">공지사항</th>
                        <th width="100">등록일</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>10</td>
                        <td>공지사항이 들어갈 자리입니다.</td>
                        <td>2022-12-12</td>
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
            
            <div class="table-bottom-btn" style="float : right">
            	<button type="button" onclick="location.href='<%= contextPath %>/noticeInsert.ad'">작성하기</button>
            </div>

		</div>
		
	</div>
</body>
</html>