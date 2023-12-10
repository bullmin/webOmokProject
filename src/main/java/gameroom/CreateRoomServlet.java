package gameroom;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/createRoomServlet")
public class CreateRoomServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 방 생성에 필요한 파라미터를 받아옵니다.
        String roomName = request.getParameter("roomName");
        int numberOfPlayers = Integer.parseInt(request.getParameter("numberOfPlayers"));

        // 유효성 검사 등을 수행할 수 있습니다.
        if (roomName == null || roomName.equals("") || numberOfPlayers <= 0) {
            // 유효성 검사에 실패할 경우 오류 메시지를 설정하고 페이지를 리다이렉트합니다.
            request.getSession().setAttribute("messageType", "오류 메세지");
            request.getSession().setAttribute("messageContent", "방 이름과 플레이어 수를 정확히 입력하세요.");
            response.sendRedirect("index.jsp"); // 실제 페이지 URL로 변경
            return;
        }

        // 방 생성 메서드를 호출하고 결과를 확인합니다.
        int result = WaitingRoomManager.createRoom(roomName, numberOfPlayers);

        if (result == 1) {
            // 성공적으로 방이 생성된 경우
            request.getSession().setAttribute("messageType", "성공 메세지");
            request.getSession().setAttribute("messageContent", "방이 성공적으로 생성되었습니다.");
            response.sendRedirect("index.jsp"); // 생성 후의 페이지 URL로 변경
        } else {
            // 방 생성에 실패한 경우
            request.getSession().setAttribute("messageType", "오류 메세지");
            request.getSession().setAttribute("messageContent", "방 생성에 실패했습니다.");
            response.sendRedirect("index.jsp"); // 실패 시의 페이지 URL로 변경
        }
    }
}
