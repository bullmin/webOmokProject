package game;

import java.util.ArrayList;
import java.util.List;

public class GameRoom {
	private int id;
	private String roomName;
	private List<GameUser> userList;
	private GameUser roomOwner;
	
	public GameRoom(GameUser user) {
		userList = new ArrayList();
		user.enterRoom(this);
		userList.add(user);
		this.roomOwner=user;
	}	
	
	public GameRoom(int roomId) { // 아무도 없는 방을 생성할 때
        this.id = roomId;
        userList = new ArrayList();
    }
	
	public void enterUser(GameUser user) {
		user.enterRoom(this);
		userList.add(user);
	}
	
	public void exitUser(GameUser user) {
		user.exitRoom(this);
		userList.remove(user);
		
		if(userList.size()<1) {
			RoomManager.removeRoom(this);
			return;
		}
	}
	
	public void close() {
        for (GameUser user : userList) {
            user.exitRoom(this);
        }
        this.userList.clear();
        this.userList = null;
    }
	
	public void setOwner(GameUser gameUser) {
		this.roomOwner =gameUser;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId() {
		this.id =id;
	}
	
	public String getRoomName() {
		return roomName;
	}
	
	public void setRoomName(String name) {
		this.roomName = name;
	}
	
	public List getUserList() {
		return userList;
	}
	
	public void setUserList(List userList) {
		this.userList=userList;
	}

	public GameUser getRoomOwner() {
		return roomOwner;
	}

	public void setRoomOwner(GameUser roomOwner) {
		this.roomOwner = roomOwner;
	}
	
	
}
