package game;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

public class RoomManager {
	private static List roomList;
	private static AtomicInteger atomicInteger;
	
	static {
		roomList = new ArrayList();
		atomicInteger = new AtomicInteger();
	}
	
	public RoomManager() {
		
	}
	
	 public static GameRoom createRoom(GameUser owner) { // 유저가 방을 생성할 때 사용(유저가 방장으로 들어감)
	        int roomId = atomicInteger.incrementAndGet();// room id 채번

	        GameRoom room = new GameRoom(roomId);
	        room.enterUser(owner);
	        room.setOwner(owner);

	        roomList.add(room);
	        return room;
	    }
	
	public static void removeRoom(GameRoom room) {
		room.close();
		roomList.remove(room);
	}
	
}
