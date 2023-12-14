package user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/userLoginServlet")
public class userLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userEmail = request.getParameter("userEmail");
		String password = request.getParameter("password");
		if(userEmail == null || userEmail.equals("") || password == null || password.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "모든 칸을 입력하세요.");
			response.sendRedirect("login.jsp");
			return;
		}
		int result = new userDAO().login(userEmail, password);
		if(result == 1) {
			request.getSession().setAttribute("userEmail", userEmail);
			userLoginManager.loginUser(request.getSession().getId(), userEmail);
			request.getSession().setAttribute("messageType", "성공 메세지");
			request.getSession().setAttribute("messageContent", "로그인에 성공했습니다.");
			response.sendRedirect("Index.jsp");
		}
		else if(result == 2) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "비밀번호를 다시 확인해주세요.");
			response.sendRedirect("login.jsp");
		}
		else if(result == 0) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "존재하지 않는 회원입니다.");
			response.sendRedirect("login.jsp");
		}
		else if(result == 3) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "이미 로그인 중인 사용자 입니다.");
			response.sendRedirect("login.jsp");
		}
		else if(result == -1) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "데이터베이스 오류가 발생했습니다.");
			response.sendRedirect("login.jsp");
		}
	}

}
