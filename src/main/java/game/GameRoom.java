package game;

import java.util.ArrayList;
import java.util.List;

public class GameRoom {
	private String roomName;
	private List<GameUser> userList;
	private GameUser roomOwner;
	
	/*
	 * public GameRoom(GameUser user) { userList = new ArrayList();
	 * user.enterRoom(this); userList.add(user); this.roomOwner=user; }
	 */	
	
	public GameRoom(String roomName, GameUser user) {
		this.roomName = roomName;
		userList=new ArrayList();
		user.enterRoom(this);
		userList.add(user);
	}
	
	/*
	 * public GameRoom(int roomId) { // 아무도 없는 방을 생성할 때 this.id = roomId; userList =
	 * new ArrayList(); }
	 */
	
	public void enterUser(GameUser user) {
	    if (!userList.contains(user)) {
	        userList.add(user);
	    }
	}

	public void exitUser(GameUser user) {
	    if (userList.contains(user)) {
	        user.exitRoom(this);
	        userList.remove(user);

	        if (userList.size() < 1) {
	            RoomManager.removeRoom(this);
	        }
	    }}
	
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
