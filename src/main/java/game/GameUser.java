package game;

public class GameUser {
	private String email;
	private GameRoom room;
	
	public GameUser(String email) {
		this.email=email;
		
	}
	public void enterRoom(GameRoom room) {
		room.enterUser(this);
		this.room=room;
	}
	
	public void exitRoom(GameRoom room) {
		this.room=null;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public GameRoom getRoom() {
		return room;
	}
	public void setRoom(GameRoom room) {
		this.room = room;
	}
}
