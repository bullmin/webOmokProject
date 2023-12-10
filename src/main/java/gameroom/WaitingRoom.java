package gameroom;

public class WaitingRoom {
	private String roomName;
	private int numberOfPlayers;
	
	@Override
	public String toString() {
		return "Room Name : " + roomName + ", Plyers : " + numberOfPlayers;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public int getNumberOfPlayers() {
		return numberOfPlayers;
	}

	public void setNumberOfPlayers(int numberOfPlayers) {
		this.numberOfPlayers = numberOfPlayers;
	}
}
