<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
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
	<h4>로그인 양식</h4>
	<form method="post" action="userLoginServlet">
		<input type="text" id="id" name="id"><br>
<!-- 		<input type="text" id="userEmail" name="userEmail"><br> -->
		<input type="password" id="password" name="password"><br>
		<input type="submit" value="로그인">		
	</form>
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