package gameroom;

import java.util.ArrayList;
import java.util.List;

public class WaitingRoomManager {
	 private static List<WaitingRoom> waitingRooms = new ArrayList<>();
	 
	 
	 public static List<WaitingRoom> getWaitingRooms() {
	        return waitingRooms;
	    }	
	 
	 public static void createRoom(WaitingRoom room) {
		 	waitingRooms.add(room);
	 }
}
