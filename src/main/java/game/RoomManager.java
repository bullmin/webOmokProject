package game;

import java.util.ArrayList;
import java.util.List;

public class RoomManager {
	private static List<GameRoom> roomList = new ArrayList<>();

	public RoomManager() {
	}
	public static GameRoom createRoom(String roomName,GameUser owner) { // 유저가 방을 생성할 때 사용(유저가 방장으로 들어감)
			
	        GameRoom room = new GameRoom(roomName,owner);
	        room.setOwner(owner);
	        roomList.add(room);
	        
	        return room;
	    }
	public static void removeRoom(GameRoom room) {
		room.close();
		roomList.remove(room);
	}
	public static List<GameRoom> getRoomList() {
		return roomList;
	}
	public static void setRoomList(List<GameRoom> roomList) {
		RoomManager.roomList = roomList;
	}
}
