<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.jj.classSelect.model.vo.Class, com.jj.community.model.vo.Review"%>
<%
	Class c = (Class)request.getAttribute("c");

	ArrayList<Review> list = (ArrayList<Review>)request.getAttribute("list");
	int studentCount = (int)request.getAttribute("studentCount");
	int bookmarkCount = (int)request.getAttribute("bookmarkCount");
	boolean isClassing = (boolean)request.getAttribute("isClassing");
	
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/setting.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/classSelect/classDetailView.css">

<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

<title>Insert title here</title>
</head>
<body>
	
	<%@ include file="../common/menubar.jsp" %>

    <!-- 전체를 감싸는 div -->
    <div class="container">

        <div class="container-all">
        <!-- 왼쪽 강의 세부 정보 영역 -->
        <div class="class-detail-area">

            <!-- 클래스 제목 -->
            <div class="class-title">
                <h3><%= c.getClTitle() %></h3>
                <p><%= c.getClSubtitle() %></p>
            </div>

            <hr>

            <!-- 클래스 썸네일 -->
            <div class="class-thumbnail">
                <br>
                <img src="<%= c.getClThumbnailPath() %>" id="thumbnail-img">
            </div>

            <!-- 클래스 소개 -->
            <div class="class-intro">
                <h4>강의 소개</h4>
                <p>
                    <%= c.getClInfo() %>
                </p>
            </div>

            <!-- 멘토 소개 -->
            <div class="lecturer-intro">
                <h4>멘토 소개</h4>
                <div class="lecturer-set">
                    <div class="lecturer-photo">
                        <img src="<%= c.getLtrProfilePath() %>" id="ltr-profile">
                    </div>

                    <div class="lecturer-profile">
                        <p>
                            <%= c.getLtrCareer() %>
                        </p>
                    </div>
                </div>
            </div>

            <!-- 커리큘럼 -->
            <div class="curriculum-intro">
                <h4>커리큘럼</h4>
                <p>
                    <%= c.getClCurri() %>
                </p>
            </div>

            <hr>

            <!-- 수강후기 -->
            <div class="class-review">
                <div class="review-header">
                    <h4>수강후기</h4>
                    <div class="review-sorting">
                            <button type="button" id="sort-date" value="date" >최신 순</button>
                            <button type="button" id="sort-high" value="highScore">높은 평점 순</button>
                            <button type="button" id="sort-low" value="lowScore">낮은 평점 순</button>
                    </div>
                </div>

                <div id="review-detail">
                <% if(list.isEmpty()) { %>
                	<p id="no-reivew"> 아직 등록된 수강후기가 없습니다. </p>
                <% }else { %>
                	<div id="review-table-area">
                	<% for(Review r : list) { %>	<!-- 리뷰 리스트 시작 부분 -->
                    <table class="user-review">
                        <tr>
                        	<% if(r.getReviewScore() == 5) { %>
                        	<td><%= r.getUserNo() %>&nbsp;&nbsp;⭐️⭐️⭐️⭐️⭐ <span class="review-score"><%= r.getReviewScore() %></span></td>
                        	<% } else if(r.getReviewScore() == 4) {%>
                        	<td><%= r.getUserNo() %>&nbsp;&nbsp;⭐️⭐️⭐️⭐ <span class="review-score"><%= r.getReviewScore() %></span>️</td>
                        	<% } else if(r.getReviewScore() == 3) {%>
                        	<td><%= r.getUserNo() %>&nbsp;&nbsp;⭐️⭐️⭐️️ <span class="review-score"><%= r.getReviewScore() %></span></td>
                        	<% } else if(r.getReviewScore() == 2) {%>
                        	<td><%= r.getUserNo() %>&nbsp;&nbsp;⭐️⭐️️️ <span class="review-score"><%= r.getReviewScore() %></span></td>
                        	<% } else { %>
                        	<td><%= r.getUserNo() %>&nbsp;&nbsp;⭐ <span class="review-score"><%= r.getReviewScore() %></span>️️️️</td>
                        	<% } %>
                        </tr>
                        <tr>
                            <td id="review-date"><%= r.getReviewEnrolldate() %></td>
                        </tr>
                        <tr>
                            <td><p id="review-content"><%= r.getReviewContent() %></p></td>
                        </tr>
                    </table>
				<% } %>
				<% } %>
				</div>
                </div>
            </div>
        </div>
        
        <script>
	
        $("#sort-date").click(function(){
        	
        	$.ajax({
				url: "<%= contextPath %>/review.cl",
				data: {
					clNo: <%= c.getClNo() %>,
					standard: $("#sort-date").val()
				},
				type: "post",
				success: function (list) {
					console.log("최신순 리뷰 조회용 AJAX 통신 성공");
					var value = "";
				
                    for(let i=0; i<list.length; i++) {
                    value +=  "<table class='user-review'>"
		                 	+ "<tr>"
                	  	if(list[i].reviewScore == 5) {
                    	value += "<td>" + list[i].userNo + "&nbsp;&nbsp;⭐️⭐️⭐️⭐️⭐ <span class='review-score'>" + list[i].reviewScore + "</span></td>";
                    	} else if(list[i].reviewScore == 4) {
		                value += "<td>" + list[i].userNo + "&nbsp;&nbsp;⭐️⭐⭐️⭐ <span class='review-score'>" + list[i].reviewScore + "</span></td>";
                   	    } else if(list[i].reviewScore == 3) {
                    	value += "<td>" + list[i].userNo + "&nbsp;&nbsp;⭐️️⭐️⭐ <span class='review-score'>" + list[i].reviewScore + "</span></td>";
                   		} else if(list[i].reviewScore == 2) {
                   		value += "<td>" + list[i].userNo + "&nbsp;&nbsp;⭐️️️⭐ <span class='review-score'>" + list[i].reviewScore + "</span></td>";
                   		} else {
                    	value += "<td>" + list[i].userNo + "&nbsp;&nbsp;⭐ <span class='review-score'>" + list[i].reviewScore + "</span></td>";
                    	}
	                    value +=  "</tr>"
                   				+ "<tr>"
                        		+ "<td id='review-date'>" + list[i].reviewCreatedate + "</td>"
                    			+ "</tr>"
                    			+ "<tr>"
                        		+ "<td><p id='review-content'>" + list[i].reviewContent + "</p></td>"
                    			+ "</tr>"
			                	+ "</table>";
                    }
                    
                    $("#review-detail").html(value);
					
				}, error: function () {
					console.log("리뷰 조회용 AJAX 통신 실패");
				}
			})
        })
        
        $("#sort-high").click(function(){
        	
        	$.ajax({
				url: "<%= contextPath %>/review.cl",
				data: {
					clNo: <%= c.getClNo() %>,
					standard: $("#sort-high").val()
				},
				type: "post",
				success: function (list) {
					console.log("높은 평점순 리뷰 조회용 AJAX 통신 성공");
					/* console.log(list); */
					
					var value = "";
					
                    for(let i=0; i<list.length; i++) {
                    value +=  "<table class='user-review'>"
		                 	+ "<tr>"
                	  	if(list[i].reviewScore == 5) {
                    	value += "<td>" + list[i].userNo + "&nbsp;&nbsp;⭐️⭐️⭐️⭐️⭐ <span class='review-score'>" + list[i].reviewScore + "</span></td>";
                    	} else if(list[i].reviewScore == 4) {
		                value += "<td>" + list[i].userNo + "&nbsp;&nbsp;⭐️⭐⭐️⭐ <span class='review-score'>" + list[i].reviewScore + "</span></td>";
                   	    } else if(list[i].reviewScore == 3) {
                    	value += "<td>" + list[i].userNo + "&nbsp;&nbsp;⭐️️⭐️⭐ <span class='review-score'>" + list[i].reviewScore + "</span></td>";
                   		} else if(list[i].reviewScore == 2) {
                   		value += "<td>" + list[i].userNo + "&nbsp;&nbsp;⭐️️️⭐ <span class='review-score'>" + list[i].reviewScore + "</span></td>";
                   		} else {
                    	value += "<td>" + list[i].userNo + "&nbsp;&nbsp;⭐ <span class='review-score'>" + list[i].reviewScore + "</span></td>";
                    	}
	                    value +=  "</tr>"
                   				+ "<tr>"
                        		+ "<td id='review-date'>" + list[i].reviewCreatedate + "</td>"
                    			+ "</tr>"
                    			+ "<tr>"
                        		+ "<td><p id='review-content'>" + list[i].reviewContent + "</p></td>"
                    			+ "</tr>"
			                	+ "</table>";
                    }
                    
                    $("#review-detail").html(value);
                    
				}, error: function () {
					console.log("리뷰 조회용 AJAX 통신 실패");
				}
			})
        })
        
        $("#sort-low").click(function(){
        	
        	$.ajax({
				url: "<%= contextPath %>/review.cl",
				data: {
					clNo: <%= c.getClNo() %>,
					standard: $("#sort-low").val()
				},
				type: "post",
				success: function (list) {
					console.log("낮은 평점순 리뷰 조회용 AJAX 통신 성공");
					
					var value = "";
					
                    for(let i=0; i<list.length; i++) {
                    value +=  "<table class='user-review'>"
		                 	+ "<tr>"
                	  	if(list[i].reviewScore == 5) {
                    	value += "<td>" + list[i].userNo + "&nbsp;&nbsp;⭐️⭐️⭐️⭐️⭐ <span class='review-score'>" + list[i].reviewScore + "</span></td>";
                    	} else if(list[i].reviewScore == 4) {
		                value += "<td>" + list[i].userNo + "&nbsp;&nbsp;⭐️⭐⭐️⭐ <span class='review-score'>" + list[i].reviewScore + "</span></td>";
                   	    } else if(list[i].reviewScore == 3) {
                    	value += "<td>" + list[i].userNo + "&nbsp;&nbsp;⭐️️⭐️⭐ <span class='review-score'>" + list[i].reviewScore + "</span></td>";
                   		} else if(list[i].reviewScore == 2) {
                   		value += "<td>" + list[i].userNo + "&nbsp;&nbsp;⭐️️️⭐ <span class='review-score'>" + list[i].reviewScore + "</span></td>";
                   		} else {
                    	value += "<td>" + list[i].userNo + "&nbsp;&nbsp;⭐ <span class='review-score'>" + list[i].reviewScore + "</span></td>";
                    	}
	                    value +=  "</tr>"
                   				+ "<tr>"
                        		+ "<td id='review-date'>" + list[i].reviewCreatedate + "</td>"
                    			+ "</tr>"
                    			+ "<tr>"
                        		+ "<td><p id='review-content'>" + list[i].reviewContent + "</p></td>"
                    			+ "</tr>"
			                	+ "</table>";
                    }
                    
                    $("#review-detail").html(value);
					
				}, error: function () {
					console.log("리뷰 조회용 AJAX 통신 실패");
				}
			})
        })
        
        
        
        </script>

        <!-- 오른쪽 수강신청 메뉴 영역 -->
        <div class="floating-area">
            <div class="class-order">
                
                <!-- 수강료 표시 영역 -->
                <div class="class-price">
                    <h4><%= c.getClPriceWon() %></h4>
                    <span id="no-limit">/ &nbsp;무제한 수강</span>
                </div>

                <div class="order-btn">
                    <br>
                    
                    <!-- 작성자 이지원 -->
                    <!-- 로그인한 사용자에게만 다음 페이지 이동 허용 -->
                   
                    <% if(loginUser != null) {%>
						<!-- 로그인 사용자가 수강신청중인 경우 -->
						<% if(isClassing) {%>
							<button class="class-buy" onclick="location.href='<%= contextPath %>/userVodList.my?class=<%=c.getClNo()%>';">수강하러가기</button><br><br>
						<% }else { %>
							<!-- 로그인 사용자가 수강신청을 하지 않을 경우 -->
							<button class="class-buy" onclick="location.href='<%= contextPath %>/enrollForm.cl?class=<%=c.getClNo()%>';">수강신청 하기</button><br><br>
						<% } %>
							<button class="class-zzim" onclick="zzim()"><span id="my-zzim"></span></button>
                    <% }else { %>
					<button class="class-buy" onclick="alert('로그인 후 이용 가능한 서비스입니다.');">수강신청 하기</button><br><br>
                    <button class="class-zzim" onclick="alert('로그인 후 이용 가능한 서비스입니다.');">❤️ 강의 찜하기</button>
                    <% } %>
                <!-- 이지원 작성 끝 -->
                    
                    <br><br>
                </div>
                <script>
                
                $(function(){
                	<% if(loginUser != null) { %>	// 로그인한 회원일 때만 찜했는지 안했는지 확인
                	zzimCheck();
                	<% } %>
                })
                
                function zzimCheck(){	// 찜한 강의인지 아니인지 먼저 확인
                	 $.ajax({
 						url: "<%= contextPath %>/checkBm.cl",
 						data: {
 							clNo:<%= c.getClNo() %>},
 						type: "post",
 						success: function (likeCheck) {
 							console.log("찜 여부 확인용 AJAX 통신 성공");
 							if(likeCheck == 0){
 								var value ="<span style='color:red'>♡</span>&nbsp;이 강의 찜하기";
 								$("#my-zzim").html(value);
 								 								
 							}else if(likeCheck == 1){
 								var value ="내가 찜한 강의&nbsp;<span style='color:red'>♥</span>";
 								$("#my-zzim").html(value);
 							}
 							console.log("성공");
 						}, error: function () {
 							console.log("강의 찜하기용 AJAX 통신 실패");
 						}
 					})
                }
				
				function zzim(){
	                $.ajax({
						url: "<%= contextPath %>/insertBm.cl",
						data: {
							clNo:<%= c.getClNo() %>},
						type: "post",
						success: function (a) {
							if(a.likeCheck == 0){
								console.log("찜하기용 AJAX 통신 성공");
								alert("이 강의를 찜했습니다. 😘❤");
								
								value = "내가 찜한 강의&nbsp;<span style='color:red'>♥</span>";
								$("#my-zzim").html(value);
								$("#zzim-count").html(a.likeCount);
								
							}else if(a.likeCheck == 1){
								alert("️이 강의를 마음에서 떠나보냈습니다..😭💔");
								
								value = "<span style='color:red'>♡</span>&nbsp;이 강의 찜하기";
								$("#my-zzim").html(value);
								$("#zzim-count").html(a.likeCount);
							}
							console.log("성공");
						}, error: function () {
							console.log("찜하기용 AJAX 통신 실패");
						}
					})
                 }             
                </script>
                
                
                <script>
                
                </script>

                <div class="class-info">
                    <table class="class-type">
                        <tr>
                            <td width>멘토</td>
                            <td align="center"><%= c.getUserNo() %></td>
                        </tr>
                        <tr>
                            <td>수강생 수</td>
                            <td align="center"><%= studentCount %>명</td>
                        </tr>
                    </table>
                    <div class="heart-icon">
                        <span><i class="bi bi-suit-heart-fill" id="heart"></i></span>
                        <span id="zzim-count"><%= bookmarkCount %></span></td>
                    </div>

                </div>
            </div>
        </div>
        </div>

    </div>
       
    <%@ include file="../common/footer.jsp" %>
</body>
</html>