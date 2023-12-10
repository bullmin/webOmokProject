<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gameroom.WaitingRoom, gameroom.WaitingRoomManager" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>오목</title>
	<style type="text/css">
        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            border: 1px solid #ccc;
            background-color: #fff;
            padding: 20px;
            z-index: 1000;
        }
    </style>
	<script type="text/javascript">
		function disableMessageModal(){
			var modal = document.getElementById("messageModal");
    		modal.style.display = 'none';
		}
	</script>
<style>
	
</style>
</head>
<body>
	<%
		String userEmail = null;
		if(session.getAttribute("userEmail") != null) {
			userEmail = (String) session.getAttribute("userEmail");
		}
	%>
	<header>
		<a>오목 웹 게임</a>
		<%
			if(userEmail == null){
		%>
		<input type="button" onclick="location.href='login.jsp'" value="로그인">
		<input type="button" onclick="location.href='join.jsp'" value="회원가입">
		
		<%
			} else {
		%>
		<input type="button" onclick="location.href='logoutAction.jsp'" value="로그아웃">
		
		<%
			}
		%>	
	</header>
	<%
		String messageContent = null;
		if(session.getAttribute("messageContent") != null){
			messageContent = (String) session.getAttribute("messageContent");
		}
		String messageType = null;
		if(session.getAttribute("messageType") != null){
			messageType = (String) session.getAttribute("messageType");
		}
		if(messageContent != null){
	%>
	<div id="messageModal" class="modal">
		<div class="modal-header">
			<h4 class="modal-title"><%= messageType %></h4>
		</div>
		<div class="modal-content">
			<%= messageContent %>
		</div>
		<div class="modal-footer">
			<input type="button" value="확인" onclick="disableMessageModal()">
		</div>
	</div>
	
	<script>
		document.getElementById("messageModal").style.display = 'block';
	</script>
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
	%>
	<form method="post" action="CreateRoomServlet">
		<input type="text" name="roomName">
		<input type="submit" value="방 만들기">
	</form>
     

</body>
</html>