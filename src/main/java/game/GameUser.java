package game;

public class GameUser {
	private String id;
	private GameRoom room;
	
	public GameUser(String id) {
		this.id=id;
	}
	
	public void enterRoom(GameRoom room) {
	    if (this.room != room) {
	        this.room = room;
	    }
	}

	public void exitRoom(GameRoom room) {
	    if (this.room == room) {
	        this.room = null;
	        room.exitUser(this);
	    }
	}
	
	public String getEmail() {
		return id;
	}
	
	public void setEmail(String id) {
		this.id = id;
	}
	
	public GameRoom getRoom() {
		return room;
	}
	
	public void setRoom(GameRoom room) {
		this.room = room;
	}
}
