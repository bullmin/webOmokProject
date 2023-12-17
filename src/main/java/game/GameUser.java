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
	    }
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public GameRoom getRoom() {
		return room;
	}
	
	public void setRoom(GameRoom room) {
		this.room = room;
	}
}
