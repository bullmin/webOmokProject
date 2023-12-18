<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
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
	var httpRequest = false;
	if(window.XMLHttpRequest){
		httpRequest = new XMLHttpRequest();
		httpRequest.overrideMimeType('text/xml');
	}
	function registerCheckFunction(){
		var id = document.getElementById("id").value;
		httpRequest.open("POST", "userRegisterCheckServlet", true);
		var qry = "id=" + id;
		httpRequest.onreadystatechange = getResult;
		httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		httpRequest.send(qry);
	}
	function getResult(){
	    if (httpRequest.readyState === XMLHttpRequest.DONE) {
	        if (httpRequest.status === 200) {
	            var result = parseInt(httpRequest.responseText);
	            if(result == 1){
	                document.getElementById("checkMessage").innerHTML = "사용할 수 있는 아이디 입니다.";
	            } else{
	                document.getElementById("checkMessage").innerHTML = "사용할 수 없는 아이디 입니다.";
	            }
	            var modal = document.getElementById("checkModal");
	            modal.style.display = 'block';
	        } else {
	            console.error('Error:', httpRequest.status);
	        }
	    }
	}
	/* function getNickNameResult(){
	    if (httpRequest.readyState === XMLHttpRequest.DONE) {
	        if (httpRequest.status === 200) {
	            var result = parseInt(httpRequest.responseText);
	            if(result == 1){
	                document.getElementById("checkMessage").innerHTML = "사용할 수 있는 닉네임 입니다.";
	            } else{
	                document.getElementById("checkMessage").innerHTML = "사용할 수 없는 닉네임 입니다.";
	            }
	            var modal = document.getElementById("checkModal");
	            modal.style.display = 'block';
	        } else {
	            console.error('Error:', httpRequest.status);
	        }
	    }
	} */

	function passwordCheckFunction(){
		var password = document.getElementById("password").value;
		var passcheck = document.getElementById("passcheck").value;
		if(password != passcheck){
			document.getElementById("passwordCheckMessage").innerHTML = "비밀번호가 일치하지 않습니다.";
		}else{
			document.getElementById("passwordCheckMessage").innerHTML = "";
		}
	}
	function disableCheckModal(){
		var modal = document.getElementById("checkModal");
        modal.style.display = 'none';
	}
	function disableMessageModal(){
		var modal = document.getElementById("messageModal");
        modal.style.display = 'none';
	}
</script>
<title>회원가입</title>

</head>
<body>
	<%
		String id = null;
		if(session.getAttribute("id") != null){
			id = (String) session.getAttribute("id");
		}
		if(id != null){
			session.setAttribute("messageType", "오류 메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어있는 상태입니다.");
			response.sendRedirect("Index.jsp");
		}
	%>
	<form method="post" action="userRegisterServlet">
		<label>아이디: <input type="text" id="id" name="id"></label>
		<!-- <label>이메일: <input type="email" id="userEmail" name="userEmail"></label> -->
		<input type="button" value="중복확인" onclick="registerCheckFunction()"><br>
		<label>비밀번호: <input type="password" id="password" name="password"></label><br>
		<label>비밀번호 확인: <input type="password" onkeyup="passwordCheckFunction()" id="passcheck" name="passcheck"></label><br>
		<!-- <label>닉네임: <input type="text" id="userNickName" name="userNickName"></label> -->
		<!-- <input type="button" value="중복확인" onclick="nickNameCheckFunction()"><br> -->
		<h5 style="color: red" id="passwordCheckMessage"></h5>
		<input type="submit" value="회원가입">
		<input type="button" onclick="location.href='Index.jsp'" value="취소">
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
	<div id="checkModal" class="modal">
		<div class="modal-header">
			<h4 class="modal-title">확인 메세지</h4>
		</div>
		<div class="modal-content" id="checkMessage">
		</div>
		<div class="modal-footer">
			<input type="button" value="확인" onclick="disableCheckModal()">
		</div>
	</div>
</body>
</html>