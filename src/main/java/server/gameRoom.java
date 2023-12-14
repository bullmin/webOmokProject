package server;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

public class gameRoom {
	private String roomName;
	private Set<String> usersInRoom;
	private LocalDateTime createTime;
	private static final int maxUsers = 2;
	
	public gameRoom(String roomName) {
		this.roomName = roomName;
		this.usersInRoom = new HashSet<>();
		this.createTime = LocalDateTime.now();
	}
	
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public Set<String> getUsersInRoom() {
		return usersInRoom;
	}
	public void setUsersInRoom(Set<String> usersInRoom) {
		this.usersInRoom = usersInRoom;
	}
	
	public LocalDateTime getCreateTime() {
		return createTime;
	}
	
	public void setCreateTime() {
		this.createTime = LocalDateTime.now();
	}
	
	public boolean addUsers(String userEmail) {
		if(usersInRoom.size() < maxUsers) {
			usersInRoom.add(userEmail);
			return true;
		}
		else {
			return false;
		}
	}
}
