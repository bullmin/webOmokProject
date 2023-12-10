package gameroom;

import java.util.ArrayList;
import java.util.List;

public class WaitingRoomManager {
    private static List<WaitingRoom> waitingRooms = new ArrayList<>();

    public static List<WaitingRoom> getWaitingRooms() {
        return waitingRooms;
    }

    public static int createRoom(String roomName) {
        // 유효성 검사 등을 수행할 수 있습니다.
        if (roomName == null || roomName.equals("")) {
            return -1;  // 실패: 유효성 검사 오류
        }

        // 방 생성 및 추가
        WaitingRoom room = new WaitingRoom(roomName);
        waitingRooms.add(room);

        return 1;  // 성공
    }
}
