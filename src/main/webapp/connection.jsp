<!DOCTYPE html>
<html>
<head>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <%
 	Context initCtx = new InitialContext();
 	DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/mysql");
 	Connection conn = ds.getConnection();
 	Statement stmt = conn.createStatement();
 	ResultSet rset = stmt.executeQuery("SELECT VERSION();");
 	while(rset.next()){
 		out.print("MySQL Version: " + rset.getString("version()"));
 	}
 	rset.close();
 	stmt.close();
 	conn.close();
 	initCtx.close();
 %>
</body>
</html> 