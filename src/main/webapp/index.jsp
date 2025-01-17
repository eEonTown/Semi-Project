<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/setting.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

<title>Insert title here</title>
    <style>
        /* Make the image fully responsive */
        .carousel-inner img {
          width: 870px;
          height: 200px;
        }
        
        .carousel slide{
        	width : 870px;
        	overflow : hidden;
        }
        
        .carousel-inner {
        	width : 870px;
        }
        
        p{
        	margin : 0;
        }
        
        h2{
        	margin : 0;
        	font-weight : bold;
        	font-size : 24px;
        }
        
        h4{
        	margin : 0;
        	font-weight : bold;
        	font-size : 16px;
        }

		/*채팅버튼 부분*/
		.chat-area{
			width : 300px;
			height : 470px;
			position : absolute;
			bottom : 100px;
			right : 80px;
			display : flex;
			flex-direction: column;
			justify-content: flex-end;
			align-items :flex-end;
			z-index : 999;
		}

		.chat-btn{
			width : 70px;
			height : 70px;
			background-color: #6363ff;
			color : white;
			font-size : 32px;
			text-align: center;
			line-height: 70px;
			border-radius: 70%;
			float : right;
			transition: all 0.3s;
			box-shadow: 3px 3px 10px #ccc;
			cursor: pointer;
		}

		.chat-btn:hover{
			transform: scale(1.1);
		}

		.message-area{
			width : 300px;
			height : 470px;
			border-radius: 10px;
			background-color: white;
			box-shadow: 3px 3px 10px #ccc;
			padding : 10px;
			display : flex;
			flex-direction: column;
			justify-content: space-between;
		}

		.chat-send{
			width : 100%;
			height : 40px;
			display : flex;
			justify-content: space-between;
		}

		.chat-send .message{
			width : 80%;
			height : 100%;
			font-size : 14px;
			border: 1px solid #6363ff;
			padding : 3px;
			border-radius: 5px;
		}

		.chat-send .message:focus,
		.chat-view .you-chat:focus,
		.chat-view .my-chat:focus{
			outline: none;
		}

		.chat-send button{
			width : 18%;
			height : 100%;
			font-size : 14px;
			background-color: #6363ff;
			border-radius: 5px;
			color : white;
			border-style : none;
		}

		.chat-view{
			overflow: auto;
			width : 100%;
			height : 335px;
		}

		.chat-view .you-chat{
			background : rgb(236, 236, 236);
			display : inline-block;
			padding : 5px;
			border-radius: 5px;
			border-style : none;
			margin-bottom: 10px;
			font-size : 14px;
			float : left;
		}

		.chat-view .my-chat{
			background : #6363ff;
			color : white;
			display : inline-block;
			padding : 5px;
			border-radius: 5px;
			border-style : none;
			text-align: right;
			float : right;
			margin-bottom: 10px;
			font-size : 14px;
		}
        </style>
</head>
<body>
	<%@ include file="views/common/menubar.jsp" %>
	
	<div class="main-banner-wrap">
	
		<!-- 슬라이드 이미지 부분 -->
	    <div id="demo" class="carousel slide" data-ride="carousel">
	      
	        <div class="carousel-inner">
				<!-- ajax로 데이터 조회 중 -->
	        </div>
	      
	        <a class="carousel-control-prev" href="#demo" data-slide="prev">
	          <span class="carousel-control-prev-icon"></span>
	        </a>
	        <a class="carousel-control-next" href="#demo" data-slide="next">
	          <span class="carousel-control-next-icon"></span>
	        </a>
	        
	        <!-- 슬라이드 데이터 출력 ajax -->
	        <script>
		        $(document).ready(function(){
		        	$.ajax({
		        		url : "ajaxSlideImgList.me",
		        		date : {},
		        		success : function(result){
		        			
		        			let value = "";
		        			for(let i = 0; i < result.length; i++){
		        				if(i == 1){
									value += '<div class="carousel-item active">'
									      +  	'<img src="' + result[i].filePath + result[i].fileName + '" alt="slide-img-' + i + '">'
									      +  '</div>'
		        				}else{
									value += '<div class="carousel-item">'
									      +  	'<img src="' + result[i].filePath + result[i].fileName + '" alt="slide-img-' + i + '">'
									      +  '</div>'
		        				}
		        			}
		        			
		        			$(".carousel-inner").html(value);
		        		},
		        		error : function(){
		        			console.log("슬라이드 이미지 부분 ajax 통신 실패");
		        		}
		        	})
		        });
	        </script>
	    </div><!-- 슬라이드 이미지 부분 끝 -->
	    
	    <!-- 로그인 전 보여질 부분 -->
		<div class="main-login-area">
			<% if(loginUser == null){ %>
				<a href="<%= contextPath %>/firstlogin.me" class="main-login-btn">로그인</a>
				<p class="main-regist">
					처음이신가요? <a href="<%= contextPath %>/loginEnrollForm.me"><b>회원가입</b></a><br>
					<a href="<%=contextPath%>/mentorEnroll.me"><b>멘토가입</b></a>
				</p><!-- 로그인 전 보여질 부분 끝 -->
			<!-- 로그인 후 보여질 부분 -->
			<% } else { %>
				
			    <!-- 채팅창 부분 (로그인시 나오게 해야함) -->
				<div class="chat-area">
					<div class="message-area" style="display : none;">
							<div class="chat-view">
								<!--ajax출력중-->
							</div>
							<div class="chat-send">
								<textarea class="message" placeholder="실시간 문의를 해보세요!" style="resize : none;"></textarea>
								<button onclick="sendMessage();">전송</button>
							</div>
					</div>
			
					<div class="chat-btn">
						<i class="fas fa-comment"></i>
					</div>
				</div>
				
				<script>
					/*채팅 버튼이 따라오는 기능*/
					$(document).ready(function(){
						var btnCurrentPosition = parseInt($(".chat-area").css("top"));
			
						$(window).scroll(function() {
							var btnPosition = $(window).scrollTop(); 
							$(".chat-area").stop().animate({"top":btnPosition+btnCurrentPosition+"px"},500);
						});
			
						/*버튼 클릭하면 채팅창이 나오는 기능*/
						$(".chat-btn").click(function(){
							$(".message-area").toggle();
						})
					})
				</script>
				
				<script>
					/*메세지를 보내면 db에 저장하는 ajax*/
					function sendMessage(){
						$.ajax({
							url : "chatting.me",
							data : {userno : <%= loginUser.getUserNo() %>,
									message : $(".message").val()
								   },
							success : function(result){
								/*메세지가 db에 삽입되면 textarea창을 비우고 스크롤을 가장 아래로 내려줌*/
								$(".message").val("");
								$(".chat-view").scrollTop($(".chat-view")[0].scrollHeight);
							},
							error : function(){
								console.log("채팅부분 ajax통신 실패");	
							}
						})
					}
				</script>
				
				<script>
					setInterval(function(){
						selectChatList();
					}, 1000);
				</script>
				
				<script>
					/*메세지를 계속 출력해주는 ajax*/
						function selectChatList(){
							/*db에 있는 유저의 메세지를 출력하기위해 db에 insert되었을 때 ajax를 재호출 함*/
							$.ajax({
								url : "selectChatting.me",
								data : {userno : <%= loginUser.getUserNo() %>},
								success : function(result){
									let value = "";
									for(let i = 0; i < result.length; i++){
										if(result[i].sendTo == "관리자1"){
											value +=  '<textarea class="my-chat" style="resize : none;" readonly>' + result[i].message + '</textarea><br>'
										}else{
											value += '<textarea class="you-chat" style="resize : none;" readonly>' + result[i].message + '</textarea><br>'
										}
										
										$(".chat-view").html(value);
									}
								},
								error : function(){
									console.log("채팅 메세지 출력 부분 ajax통신 실패");
								}
							})
						}
				</script>
				<!-- 채팅창 부분 끝 -->
				
				<p class="main-logout"><b><a href="<%=contextPath%>/userlogout.me">로그아웃</a></b></p>
				<div class="main-profile-img">
					<!-- ajax조회 중 -->
				</div>
				<p class="main-mypage-menu">
					<b id="userName"><%= loginUser.getUserName() %></b>님<br><br>
					<b id="classIng"><a href="">수강중인강의 3</a></b><br><br>
					<b><a href="<%=contextPath%>/myPage.my">마이페이지</a></b>
					
					<script>
						<!-- 수강중인 강의 수 출력 ajax -->
						$(document).ready(function(){
							<% if(loginUser != null){ %>
								$.ajax({
									url : "ajaxSelectClassIng.me",
									data : {name : $("#userName").text()},
									success : function(result){
										$("#classIng").text("수강중인강의 " + result);
									},
									error : function(){
										console.log("로그인 부분 ajax통신 실패");
									}
								})
							<% } %>
						})

						<!-- 프로필 이미지 ajax -->
						$(document).ready(function(){
							<% if(loginUser != null){ %>
								$.ajax({
									url : "ajaxLoginProfile.me",
									data : {no : <%= loginUser.getUserNo() %>},
									success : function(result){
										
										let value = "";
										if(<%= loginUser.getMtGrade() != 2 %>){
											value = '<img class="login-profile-img" src="resources/image/defaultProfile.jpg" alt="profile">';
											$(".main-profile-img").html(value);
										}else{
											value = '<img class="login-profile-img" src="' + result + '" alt="profile">';
											$(".main-profile-img").html(value);
										}
									},
									error : function(){
										console.log("프로필 이미지 부분 ajax통신 실패");
									}
								})
							<% } %>
						})
					</script>
				</p><!-- 로그인 후 보여질 부분 끝 -->
			<% } %>
			

		</div>
	</div>

	<div class="main-content-wrap">

		<!--검색 부분-->	
		<div class="search-bar">
			<form action="searchResultView.me">
				<input type="search" name="keyword" placeholder="클래스, 강의자, 게시글 검색">
				<button type="submit">
					<i class="fas fa-search"></i>
				</button>
			</form>
		</div><!-- 검색 부분 끝 -->

		<!--vod 부분-->
		<div class="main-vod-title">
			<h2>클래스목록</h2>
			<p><b><a href="">더보기</a></b></p>
		</div>
		<div class="main-vod-list">
			<div class="vod-slide-btn-left">
				<i class="fas fa-angle-left"></i>
			</div>

            <div class="main-window">
                <div class="main-container">
					<!-- ajax로 데이터 조회중 -->
                </div>
            </div>

			<div class="vod-slide-btn-right">
				<i class="fas fa-angle-right"></i>
			</div>
			
			<!-- vod부분 ajax -->
			<script>
				$(document).ready(function(){
					$.ajax({
						url : "ajaxClassList.me",
						data : {},
						success : function(result){
							let value = "";
							for(let i = 0; i < 9; i++){
								value += '<div class="vod" onclick="location.href=\'<%= contextPath %>\/detail.cl?class=' + result[i].clNo +'\'">'
								      +  	'<h4>' + result[i].clTitle + '</h4>'
								      +     '<p style="margin : 20px;">' + result[i].userNo + '&nbsp&nbsp&nbsp&nbsp' + result[i].mtCompany + '<p>'
								      +     '<img class="class-thumbnail" src="' + result[i].clThumbnailPath + '" alt="thumbnail' + i + '" width="200">'
								      +  '</div>'
							}
							
							$(".main-container").html(value);
						},
						error : function(){
							console.log("클래스 조회 부분 ajax통신 실패");
						}
					})
				})
			</script>
		</div><!-- vod부분 끝 -->

		<!--멘토 부분-->
		<div class="main-mentor-title">
			<h2>멘토목록</h2>
			<p><b><a href="">더보기</a></b></p>
		</div>
		<div class="main-mentor-list">
			<div class="mentor-slide-btn-left">
				<i class="fas fa-angle-left"></i>
			</div>

            <div class="mentor-window">
                <div class="mentor-container">
					<!-- ajax 조회 중 -->
                </div>
            </div>

			<div class="mentor-slide-btn-right">
				<i class="fas fa-angle-right"></i>
			</div>
			
			<!-- 멘토부분 ajax -->
			<script>
				$(document).ready(function(){
					$.ajax({
						url : "ajaxMentorList.me",
						data : {},
						success : function(result){
							
							let value = "";
							for(let i = 0; i < 12; i ++){
								value += '<div class="mentor">'
								      +  	'<div class="mentor-profile-img">'
								      +     	'<img src="' + result[i].ltrProfilePath + '" alt="profile-image">'
								      +     '</div>'
				                      +  	'<div class="mentor-info">'
	                            	  +	 		'<span>' + result[i].userName + '</span>'
	                           		  +	    	'<span>' + result[i].ltrCompany + '</span>'
	                        		  +	    '</div>'
	                        		  + 	'<a href="<%= contextPath %>\/detail.lt?lecNo=' + result[i].userNo + '">방문하기</a>'
	                        		  +  '</div>'
							}
							
							$(".mentor-container").html(value);
						},
						error : function(){
							console.log("멘토 조회 부분 ajsx통신 실패");
						}
					})
				})
			</script>
			
		</div><!-- 멘토 부분 끝 -->

		<!--커뮤니티 부분-->
		<div class="main-community-title">
			<h2>커뮤니티</h2>
			<p><b><a href="<%= contextPath %>/list.co?category=1&cpage=1">더보기</a></b></p>
		</div>
		<div class="main-community-list">
			<div class="community-slide-btn-left">
				<i class="fas fa-angle-left"></i>
			</div>

            <div class="community-window">
                <div class="community-container">
					<!-- ajax 조회중 -->
                </div>
            </div>

			<div class="community-slide-btn-right">
				<i class="fas fa-angle-right"></i>
			</div>
			
			<!-- 커뮤니티 ajax -->
			<script>
				$(document).ready(function(){
					$.ajax({
						url : "ajaxPostList.me",
						data : {},
						success : function(result){
							let value = "";
							for(let i = 0; i < 6; i++){
								value += '<div class="community" onclick="location.href=\'<%= contextPath %>\/detail.co?contentNo=' + result[i].commNo + '\'">'
							          +  	'<div class="text-area">'
						              +  		'<span>' + result[i].commTitle + '</span><br>'
						              +  		'<pre class="text">' + result[i].commContent + '</pre>'
						              +  		'<span>' + result[i].commWriter + '</span>'
						              +  	'</div>'
						              +  	'<div class="reply-area">'
						              +  		'<span>' + result[i].count + '</span><br>'
						              +  		'<span>조회수</span>'
						              +  	'</div>'
						              +  '</div>'
							}
							
							$(".community-container").html(value);
						},
						error : function(){
							console.log("커뮤니티 부분 ajax통신 실패");
						}
					})
				})
			</script>
			
		</div><!-- 커뮤니티 부분 끝 -->
	</div>
	
	<%@ include file="views/common/footer.jsp" %>
	
	<!--vod슬라이드 부분-->
    <script>
        let vodPosition = 0;

        $(".main-vod-list>.vod-slide-btn-right").click(function(){
            vodPosition += 245;
            $(".main-container").css('transform', 'translateX(-'+ vodPosition +'px)');
            if(vodPosition >= 1000){
                vodPosition = -245;
            }
        })

        $(".main-vod-list>.vod-slide-btn-left").click(function(){
            vodPosition -= 245;
            if(vodPosition <= 0){
                vodPosition = 1000;
            }
            $(".main-container").css('transform', 'translateX(-'+ vodPosition +'px)');
        })
    </script>

    <!--mentor슬라이드 부분-->
    <script>
        let mentorPosition = 0;

        $(".main-mentor-list>.mentor-slide-btn-right").click(function(){
            mentorPosition += 190;
            $(".mentor-container").css('transform', 'translateX(-'+ mentorPosition +'px)');
            if(mentorPosition >= 825){
                mentorPosition = -190;
            }
        })

        $(".main-mentor-list>.mentor-slide-btn-left").click(function(){
            mentorPosition -= 190;
            if(mentorPosition <= 0){
                mentorPosition = 825;
            }
            $(".mentor-container").css('transform', 'translateX(-'+ mentorPosition +'px)');
        })
    </script>

    <!--community슬라이드 부분-->
    <script>
        let commPosition = 0;

        $(".main-community-list>.community-slide-btn-right").click(function(){
            commPosition += 496;
            $(".community-container").css('transform', 'translateX(-'+ commPosition +'px)');
            if(commPosition >= 1984){
                commPosition = -496;
            }
        })

        $(".main-community-list>.community-slide-btn-left").click(function(){
            commPosition -= 496;
            if(commPosition <= 0){
                commPosition = 1984;
            }
            $(".community-container").css('transform', 'translateX(-'+ commPosition +'px)');
        })
    </script>
</body>
</html>