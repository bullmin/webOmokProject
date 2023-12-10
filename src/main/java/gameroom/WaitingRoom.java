package gameroom;

public class WaitingRoom {
	private String roomName;
	
	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	
	public WaitingRoom(String roomName) {
		this.roomName=roomName;
	}
}
