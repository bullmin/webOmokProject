package user;

import java.util.Hashtable;

public class userLoginManager {
	private static Hashtable<String, String> loggedInUsers = new Hashtable<>();
	
	public static synchronized boolean isUserLoggedIn(String id) {
		return loggedInUsers.containsValue(id);
	}
	 
	public static synchronized void loginUser(String sessionID, String id) {
		loggedInUsers.put(sessionID, id);
	}
	 
    // 사용자 로그아웃
    public static synchronized void logoutUser(String sessionID) {
        loggedInUsers.remove(sessionID);
    }
}
