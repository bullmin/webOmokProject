package game;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LeaveRoomServlet")
public class LeaveRoomServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 세션 및 사용자 정보 가져오기
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("id");

        if (userId != null) {
            // RoomManager에서 방 정보 가져오기
            GameRoom userRoom = getUserRoom(userId);

            if (userRoom != null) {
                // 방에서 나가는 사용자 찾기
                GameUser leavingUser = findUserInRoom(userRoom, userId);
                if(userRoom.getUserList().size()==2 &&leavingUser == userRoom.getRoomOwner() ) {
                		userRoom.setOwner(userRoom.getUserList().get(1));
                }
            	userRoom.exitUser(leavingUser);
                
                // 방 목록을 다시 가져와서 세션에 저장
                RoomManager.setRoomList(RoomManager.getRoomList());
                List<GameRoom> roomList = RoomManager.getRoomList();
                session.setAttribute("roomList", roomList);
            }
            // 사용자가 나간 후 어디로 이동할지 결정 (예: 로비 페이지)
            response.sendRedirect("Index.jsp");
        }
    }
    // 사용자가 속한 방을 찾아서 반환하는 메서드
    private GameRoom getUserRoom(String userId) {
        List<GameRoom> roomList = RoomManager.getRoomList();

        for (GameRoom room : roomList) {
            for (GameUser user : room.getUserList()) {
                if (user.getId().equals(userId)) {
                    return room;
                }
            }
        }
        return null; // 사용자가 속한 방이 없는 경우
    }
    // 방에서 특정 ID를 가진 사용자를 찾아서 반환하는 메서드
    private GameUser findUserInRoom(GameRoom room, String userId) {
        List<GameUser> userList = room.getUserList();

        for (GameUser user : userList) {
            if (user.getId().equals(userId)) {
                return user;
            }
        }
        return null; // 사용자를 찾지 못한 경우
    }
}
