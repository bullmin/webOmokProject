package user;

import java.util.Hashtable;

public class userLoginManager {
	private static Hashtable<String, String> loggedInUsers = new Hashtable<>();
	
	// 사용자 로그인 여부 확인
    public static synchronized boolean isUserLoggedIn(String userEmail) {
        return loggedInUsers.containsValue(userEmail);
    }

    // 사용자 로그인
    public static synchronized void loginUser(String sessionID, String userEmail) {
        loggedInUsers.put(sessionID, userEmail);
    }

    // 사용자 로그아웃
    public static synchronized void logoutUser(String sessionID) {
        loggedInUsers.remove(sessionID);
    }
}
