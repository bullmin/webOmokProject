<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="game.RoomManager" %>
<%@ page import="game.GameRoom" %>
<%@ page import="game.GameUser" %>

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
        .room {
            border: 2px solid black;
            padding: 10px;
            margin: 10px;
            cursor: pointer;
        }
    </style>
	<script type="text/javascript">
		function disableMessageModal(){
			var modal = document.getElementById("messageModal");
    		modal.style.display = 'none';
		}
		
		function joinRoom(roomName) {
            // JoinRoomServlet 호출
            location.href = 'JoinRoomServlet?roomName=' + roomName;
        }
	</script>
</head>
<body>
	<%
		String id = null;
		if(session.getAttribute("id") != null) {
			id = (String) session.getAttribute("id");
		} 
	%>
	<header>
		<a>오목 웹 게임</a>
		<%
			if(id == null){
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
	<form action="CreateRoomServlet" method="post">
        <input type="text" name="roomName" placeholder="방 제목을 입력하세요" required>
        <input type="submit" value="방 만들기">
    </form>
	<section id="rooms">
        <%
            List<GameRoom> roomList = new RoomManager().getRoomList();
            for (GameRoom room : roomList) {
        %>
                <%-- <div class="room" onclick="location.href='gameRoom.jsp?roomName=<%=room.getRoomName() %>'">
                    <label>방 제목 : </label><p><%= room.getRoomName() %></p>
                    <label>참가자 수 : </label><p><%= room.getUserList().size() %></p>
                </div> --%>
                <div class="room" onclick="joinRoom('<%= room.getRoomName() %>')">
	                <label>방 제목 : </label><p><%= room.getRoomName() %></p>
	                <label>참가자 수 : </label><p><%= room.getUserList().size() %>/ 2 </p>
            	</div>
        <%
            }
        %>
    </section>
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
</body>
</html>