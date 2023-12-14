package user;

public class userDTO {
	String id;
	String password;
	String userNickName;
	int userWin;
	int userLose;

	public String getId() {
		return id; 
	} 
	public void setUserId(String id) { 
		this.id = id; 
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getUserWin() {
		return userWin;
	}
	public void setUserWin(int userWin) {
		this.userWin = userWin;
	}
	public int getUserLose() {
		return userLose;
	}
	public void setUserLose(int userLose) {
		this.userLose = userLose;
	}
}
