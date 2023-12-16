package game;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CreateRoomServlet")
public class CreateRoomServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 세션에서 현재 사용자 정보 가져오기
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("id");

        if (userId != null) {
            // 폼에서 입력한 방 이름 가져오기
            String roomName = request.getParameter("roomName");

            // 현재 사용자를 owner로 하는 방 생성
            GameUser owner = new GameUser(userId);
            GameRoom room = RoomManager.createRoom(roomName, owner);
            
            // 방 목록을 다시 가져와서 세션에 저장
            List<GameRoom> roomList = RoomManager.getRoomList();
            session.setAttribute("roomList", roomList);

            // 방 목록 화면으로 이동
            String redirectURL = "gameRoom.jsp?roomName="+roomName;
            response.sendRedirect(redirectURL);
        } else {
            // 사용자가 로그인되어 있지 않은 경우, 로그인 페이지로 이동
			
			 response.sendRedirect("login.jsp"); }
			 
    }
}
