package game;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/JoinRoomServlet")
public class JoinRoomServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 요청 파라미터에서 방 이름 가져오기
        String roomName = request.getParameter("roomName");

        // 세션 및 사용자 정보 가져오기
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("id");

        // RoomManager에서 방 가져오기
        GameRoom roomToJoin = null;
        List<GameRoom> roomList = RoomManager.getRoomList();
        for (GameRoom room : roomList) {
            if (room.getRoomName().equals(roomName)) {
                roomToJoin = room;
                break;
            }
        }

        if (roomToJoin != null && userId != null) {
            // 방에 2명 미만의 사용자가 있는지 확인
            if (roomToJoin.getUserList().size() < 2) {
                // 방 참여
                GameUser user = new GameUser(userId);
                roomToJoin.enterUser(user);

                // 게임 방 페이지로 리다이렉션
                String redirectURL = "gameRoom.jsp?roomName=" + roomName;
                response.sendRedirect(redirectURL);
            } else {
                // 방이 가득 찼음을 알리는 오류 메시지 표시
                session.setAttribute("messageType", "오류");
                session.setAttribute("messageContent", "방에 더 이상 참여할 수 없습니다. 방이 이미 가득 찼습니다.");
                response.sendRedirect("Index.jsp");
            }
        } else {
            // 유효하지 않은 방이나 사용자 정보인 경우, 인덱스 페이지로 리다이렉션
            session.setAttribute("messageType", "오류");
            session.setAttribute("messageContent", "유효하지 않은 방이나 사용자 정보입니다.");
            response.sendRedirect("Index.jsp");
        }
    }
}
