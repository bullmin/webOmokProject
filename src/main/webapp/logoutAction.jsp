<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "user.userLoginManager" %>
<!DOCTYPE html>
<html>
<head>
	<%
		session.invalidate();
		userLoginManager.logoutUser(session.getId());
	%>
	<script>
		location.href = "Index.jsp";
	</script>
</head>
</html>