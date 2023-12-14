<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<body>
	<%
		String userEmail = null;
		if(session.getAttribute("userEmail") != null) {
			userEmail = (String) session.getAttribute("userEmail");
		}
	%>
	<header>
		<h2>오목 웹 게임</h2>
		<%
			if(userEmail == null){
		%>
		<input type="button" onclick="location.href='login.jsp'" value="로그인">
		<input type="button" onclick="location.href='join.jsp'" value="회원가입">
		<%
			} else {
		%>
		<h5><%= userEmail %></h5>
		<input type="button" onclick="location.href='logoutAction.jsp'" value="로그아웃">
		<%
			}
		%>	
	</header>
	<% 
		if(userEmail != null){		
		%>
		<script type="text/javascript">
		var socket = new WebSocket("ws://localhost:8080/OmocGame/roomServer");
		socket.onopen = function (event) {
		        console.log("WebSocket opened:", event);
		    };

		socket.onmessage = function (event) {
		        console.log("WebSocket message:", event.data);
		        showModal(event.data);
		    };

		socket.onclose = function (event) {
		        console.log("WebSocket closed:", event);
		    };
		function showModal(message) {
			var modal = document.getElementById("messageModal");
			var modalContent = document.querySelector(".modal-content");
			var modalTitle = document.querySelector(".modal-title");

        	// 메시지 내용을 모달에 표시
        	modalTitle.innerHTML = "오류 메세지"
        	modalContent.innerHTML = message;

        	// 모달을 화면에 표시
        	modal.style.display = 'block';

       		// 확인 버튼을 누르면 모달을 닫음
	    	modal.onclick = function () {
	            modal.style.display = 'none';
			};
		}

		function createRoom() {
		        roomName = document.getElementById("roomName").value;
		        var message = "CREATE_ROOM:" + roomName;
		        socket.send(message);
		    }
		</script>
		<div>
			<input type="text" placeholder="방 이름을 입력하세요" id="roomName">
			<input type="button" value="등록" onclick="createRoom()">
		</div>
		<%
			}
		%>
	<section id="roomlist">
		<h4>방 목록</h4>
		
	</section>
	<%
		//메세지 모달 창 
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
	
</body>
</html>