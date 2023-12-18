package game;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.CloseReason;
import jakarta.websocket.EndpointConfig;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/chat/{room}", configurator = HttpSessionConfigurator.class)
public class Server {
	private static final Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
//	private static final Map<String, Long> sessionExitTimestamps = new ConcurrentHashMap<>(); 
	
	private static void sendMessageToRoom(String room, String message) {
        for (Session client : clients) {
            if (client.isOpen() && room.equals(client.getUserProperties().get("room"))) {
                try {
                    client.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }	
	
	@OnOpen
    public void onOpen(Session session, @PathParam("room") String room, EndpointConfig config) {
        clients.add(session);
        session.getUserProperties().put("room", room);
        
        HttpSession httpSession = (HttpSession) config.getUserProperties().get(HttpSession.class.getName());
        
        String id = (String) httpSession.getAttribute("id");
        session.getUserProperties().put("id", id);
        // 입장 메시지 전송
        String message = "System: " + id + "님께서 입장하셨습니다.";
        sendMessageToRoom(room, message);
    }
	
	@OnClose
    public void onClose(Session session) {
        String room = (String) session.getUserProperties().get("room");
        String userId = (String) session. getUserProperties().get("id");
        
        clients.remove(session);
  
        // 퇴장 메시지 전송
        String message = "System: " + session.getUserProperties().get("id") + " 님께서 퇴장하셨습니다.";
        sendMessageToRoom(room, message);
    }
	
	@OnMessage
    public void onMessage(String message, Session session) throws IOException {
        String room = (String) session.getUserProperties().get("room");
        sendMessageToRoom(room, session.getUserProperties().get("id") + ": " + message);
    }
	
	@OnError
    public void onError(Throwable error) {
        error.printStackTrace();
    }
}
