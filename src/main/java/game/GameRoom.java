package game;

import java.util.ArrayList;
import java.util.List;

public class GameRoom {
	private String roomName;
	private List<GameUser> userList;
	private GameUser roomOwner;
	
	public GameRoom(String roomName, GameUser user) {
		this.roomName = roomName;
		userList=new ArrayList();
		userList.add(user);
	}
	
	public void enterUser(GameUser user) {
	        userList.add(user);
	}

	public void close() {
        this.userList.clear();
        this.userList = null;
    }
	
	public void exitUser(GameUser user) {
        userList.remove(user);
        // 사용자가 방에서 나가면서 방이 비어있으면 방을 닫음
        if (userList.isEmpty()) {
            RoomManager.removeRoom(this);
        }
    }	
	
	public void setOwner(GameUser gameUser) {
		this.roomOwner =gameUser;
	}
	
	public String getRoomName() {
		return roomName;
	}
	
	public void setRoomName(String name) {
		this.roomName = name;
	}
	
	public List<GameUser> getUserList() {
		return userList;
	}
	
	public void setUserList(List<GameUser> userList) {
		this.userList=userList;
	}

	public GameUser getRoomOwner() {
		return roomOwner;
	}

	public void setRoomOwner(GameUser roomOwner) {
		this.roomOwner = roomOwner;
	}
}
