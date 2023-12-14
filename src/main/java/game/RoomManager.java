package game;

import java.util.ArrayList;
import java.util.List;

public class RoomManager {
	private static List<GameRoom> roomList = new ArrayList<>();
    private static int roomIdCounter = 1;

	
	public RoomManager() {
		
	}
	
	 public static GameRoom createRoom(String roomName,GameUser owner) { // 유저가 방을 생성할 때 사용(유저가 방장으로 들어감)
	        int roomId = roomIdCounter;// room id 채번
			
	        GameRoom room = new GameRoom(roomName,owner);
	        room.setOwner(owner);
	        roomList.add(room);
	        
	        roomIdCounter++;
	        return room;
	    }
	
	public static void removeRoom(GameRoom room) {
		room.close();
		roomList.remove(room);
	}
	
}
