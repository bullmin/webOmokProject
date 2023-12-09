<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content=""text/html; charset=UTF-8">
<title>오목</title>
</head>
<body>
	<%
		String userNickName = null;
		if(session.getAttribute("userNickName") != null) {
			userNickName = (String) session.getAttribute("userNickName");
		}
	%>
	<header>
		<a>오목 웹 게임</a>
		<%
			if(userNickName == null){
		%>
		<input type="button" value="로그인">
		<input type="button" value="회원가입">
		<%
			} else {
		%>
		<input type="button" value="로그아웃">
		<%
			}
		%>	
	</header>
	
	
</body>
</html>