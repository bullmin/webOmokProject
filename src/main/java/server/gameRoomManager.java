package server;

import java.util.HashMap;
import java.util.Map;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint("/roomServer")
public class gameRoomManager {
	private static Map<String, gameRoom> rooms = new HashMap<>();

	@OnOpen
	public void onOpen(Session session) {
		System.out.println("WebSocket Opened: " + session.getId());
	}

    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("Message from " + session.getId() + ": " + message);

        if (message.startsWith("CREATE_ROOM:")) {
            String roomName = message.split(":")[1];
            if (!rooms.containsKey(roomName)) {
                gameRoom newRoom = new gameRoom(roomName);
                rooms.put(roomName, newRoom);
                System.out.println("Room created: " + roomName);
            } else {
            	System.out.println("Failed to create room.");
            	sendMessageToUser(session, "이미 존재하는 방 이름입니다.");
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        System.out.println("WebSocket Closed: " + session.getId());
    }
    
    private void sendMessageToUser(Session session, String message) {
        try {
            if (session != null && session.isOpen()) {
                session.getBasicRemote().sendText(message);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

	

