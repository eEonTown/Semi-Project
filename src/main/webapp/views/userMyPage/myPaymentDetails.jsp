<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.jj.userMyPage.model.vo.Payment" %>
<%
  Payment p = (Payment)request.getAttribute("p");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Document</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<style>
  thead{
    background-color: whitesmoke;
  }
</style>
</head>
<body>
    <%@ include file="../common/menubar.jsp" %>

    <div class="container">
      <br><br><br>
        <h2>결제내역 > <span style=" color:#6363FF;">결제 상세내역</span></h2>
        <br>
        <h4>주문정보</h4>
          <table class="table table-hover table-bordered">
            <thead align="center">
              <tr>
                <th>주문번호</th>
                <th>주문상품</th>
                <th>결제금액</th>
                <th>상태</th>
              </tr>
            </thead>
            <tbody align="center">
              <tr>
                <td><%= p.getPayNo()%></td>
                <td>
                  <span><%= p.getClTitle()%></span>
                </td>
                <td>
                  <p>판매가 : <%= p.getClPrice()%>원</p>
         
                  <p>쿠폰할인 : -<%= p.getDiscount()%>원</p>
                  <hr>
                  <p>결제금액 : <%= p.getFinalPayment()%>원</p>
                </td>
                <td>
                  <%if(p.getRefund().equals("N")) { %>
                    <span>결제완료</span>
                  <%}if(p.getRefund().equals("W")){ %>
                    <span>환불확인중</span>
                  <%}if(p.getRefund().equals("Y")){ %>
                    <span>환불완료</span>
                  <% } %>
                </td>
              </tr>
          </table>

          <br>
          <h4>결제정보</h4>
            <table class="table table-hover table-bordered">
              <thead align="center">
                <tr>
                  <th>결제방식</th>
                  <th>승인일시</th>
                  <th>결제금액</th>
                </tr>
              </thead>
              <tbody align="center">
                <tr>
                  <td><%= p.getPayment()%></td>
                  <td><%= p.getPayDate()%></td>
                  <td><%= p.getFinalPayment()%>원</td>
                </tr>
            </table>

            <br>
            <h4>주문자정보</h4>
              <table class="table table-hover table-bordered">
                  <tr>
                    <th style="background-color:whitesmoke; width: 80px;">이름</th>
                    <td><%= p.getOrderName()%></td>
                  </tr>
                  <tr>
                    <th style="background-color:whitesmoke">연락처</th>
                    <td><%= p.getOrderPhone()%></td>
                  </tr>
                  <tr>
                    <th style="background-color:whitesmoke">이메일</th>
                    <td><%= p.getOrderEmail()%></td>
                  </tr>
              </table>

  </div>

 <%@ include file="../common/footer.jsp" %>
</body>
</html>