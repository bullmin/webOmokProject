package game;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.CopyOnWriteArrayList;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.EndpointConfig;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/game/{room}", configurator = HttpSessionConfigurator.class)
public class OmokServer {
    private static final List<Session> sessions = new CopyOnWriteArrayList<>();
    private static final Map<String, String> playerColors = new HashMap<>();
    private static final Random random = new Random();

    @OnOpen
    public void onOpen(Session session, @PathParam("room") String room, EndpointConfig config) {
        sessions.add(session);
        session.getUserProperties().put("room", room);

        HttpSession httpSession = (HttpSession) config.getUserProperties().get(HttpSession.class.getName());
        String id = (String) httpSession.getAttribute("id");

        session.getUserProperties().put("id", id);
        playerColors.put(id, "unknown"); // 초기 돌 색은 "unknown"으로 설정
    }

    @OnMessage
    public void onMessage(Session session, String message, @PathParam("room") String room) {
        if ("startGame".equals(message)) {
            assignRandomStoneColors(room);
            if(!checkAllPlayersReady(room)) {
            	broadcastGameState(session, room, "NotReady");
            }
            else {
            	broadcastGameState(session, room, "startGame");
            }
            
        }
        else if(message.startsWith("ChangeTurn:")) {
        	String messageSplit = message.split(":")[1];
        	handleTurnChange(session, room, messageSplit);
        }
        else if(message.startsWith("stoneMove:")) {
        	String[] messageSplit = message.substring("stoneMove:".length()).split(",");
        	handleStoneMove(messageSplit[0], messageSplit[1], room);
        }
        else if(message.equals("Win")) {
        	broadcastGameState(session, room, message);
        }
        System.out.println(message);
    }
    private boolean isTurnBlack(String color) {
    	if(color.equals("black")) {
    		return true;
    	}
    	return false;
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
        String idToRemove = (String) session.getUserProperties().get("id");
        playerColors.remove(idToRemove);
    }

    private void assignRandomStoneColors(String room) {
        List<String> availableColors = new ArrayList<>(Arrays.asList("black", "white"));

        for (Session userSession : sessions) {
            String username = (String) userSession.getUserProperties().get("id");
            int randomIndex = random.nextInt(availableColors.size());
            String assignedColor = availableColors.remove(randomIndex);

            playerColors.put(username, assignedColor);
        }
    }

    private boolean checkAllPlayersReady(String room) {
    	 int players = 0;

    	 for (Session userSession : sessions) {
    		 if (userSession.isOpen() && userSession.getUserProperties().get("room") != null &&
    				 userSession.getUserProperties().get("room").equals(room)) {
    			 	 players++;
    	        }
    	    }

    	    return players >= 2;
    }

    private void broadcastGameState(Session currentSession, String room, String message) {
        try {
            for (Session userSession : sessions) {
                if (userSession.isOpen() && userSession.getUserProperties().get("room") != null &&
                        userSession.getUserProperties().get("room").equals(room)) {
                    String gameState = createGameState(message);

                    if ("startGame".equals(message)) {
                        // 동일한 방에 있는 각 세션에 사용자 색상 정보를 추가합니다.
                        String userColor = playerColors.get(userSession.getUserProperties().get("id"));
                        gameState += ":" + userColor;
                    }

                    userSession.getBasicRemote().sendText(gameState);
                    System.out.println(gameState);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    private void handleTurnChange(Session currentSession, String room, String Color) {
        try {
            for (Session userSession : sessions) {
                if (userSession.isOpen() && userSession.getUserProperties().get("room") != null &&
                        userSession.getUserProperties().get("room").equals(room)) {
                	String gameState = "";
                    if(isTurnBlack(Color)) {
                    	gameState = "white";
                    }
                    else {
                    	gameState = "black";
                    }

                    userSession.getBasicRemote().sendText("ChangeTurn:"+gameState);
                    System.out.println(gameState);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private String createGameState(String rMessage) {
        String message = "";
        switch (rMessage) {
            case "startGame":
                message = "startGame";
                break;
            case "NotReady":
                message = "message:NotReady";
                break;
            case "Win":
                message = "message:Win";
                break;
        }
        return message;
    }
    
    private void handleStoneMove(String row, String col, String room) {
    	System.out.println(row + ":" + col);
    	for (Session userSession : sessions) {
		    if (userSession.isOpen() && userSession.getUserProperties().get("room") != null &&
		            userSession.getUserProperties().get("room").equals(room)) {
		        String gameState = "StoneMove:"+ row + "," + col;
		        
		        try {
					userSession.getBasicRemote().sendText(gameState);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		    }
		}
    }
    
}
