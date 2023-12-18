<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>오목</title>
	<style type="text/css">
		body {
			width: 100%;
			margin: 0;
		}

		.container {
			display: flex;
		}

		section {
			width: 75%;
			padding: 20px; /* Optional: Adjust padding as needed */
			display: flex;
			align-items: center;
			justify-content: center;
		}

		aside {
			padding: 1px;
			margin: 2px;
			width: 25%;
			justify-content: center;
		}

		div {
			margin: 1px;
		}

		fieldset {
			padding: 10px;
			margin: 8px;
		}
		#gameStart {
    		display: flex;
    		align-items: center;
    		justify-content: center;
    		border: 1px solid #000000;
    		width: 100%;
    		height: 200px;
}
		#chatset {
			border: 1px solid #000000;
			width: 100%;
			height: 400px;
			overflow-y: auto;
		}

		#baduk-board {
			display: grid;
			grid-template-columns: repeat(18, 30px);
			grid-template-rows: repeat(18, 30px);
			gap: 1px;
		}

		.baduk-intersection {
			width: 30px;
			height: 30px;
			background-color: #e7ae28;
			border: 1px solid #333;
			position: relative;
		}
		h4 {
			margin-bottom: 5px; /* You can adjust the margin value as needed */
		}

		.choice{
			margin-bottom: 10px; /* You can adjust the margin value as needed */
		}
		.stone {
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background-color: #000;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            pointer-events: none;
        }
	</style>
	<script>
    // 통신을 위한 WebSocket 객체
    var webSocket;
	var omokSocket;
    // WebSocket 연결을 초기화하는 함수
    function connectWebSocket() {
        // URL 파라미터에서 방 이름 가져오기
        var roomName = "<%= request.getParameter("roomName") %>";

        // Open WebSocket connection
        webSocket = new WebSocket("ws://localhost:8080/OmocGame/chat/" + roomName);

        // Set up event listeners
        webSocket.onopen = function (event) {
            console.log("입장하셨습니다.");
        };

        webSocket.onmessage = function (event) {
            // Handle incoming messages
            var messageTextArea = document.getElementById("chatset");
            var messageText = "";
            messageText = event.data + "<br>";
            messageTextArea.innerHTML += messageText;
            messageTextArea.scrollTop = messageTextArea.scrollHeight;
        };

        webSocket.onclose = function (event) {
            console.log("퇴장하셨습니다.");
        };
    }

    // Function to send a message through WebSocket
    function sendMessage() {
        var messageInput = document.getElementById("textMessage");
        var message = messageInput.value;

        // Send message only if WebSocket is open and message is not empty
        if (webSocket.readyState === WebSocket.OPEN && message.trim() !== "") {
            webSocket.send(message);
            messageInput.value = "";  // Clear the input field
        }
    }

    // Function to send a message when Enter key is pressed
    function handleKeyPress(event) {
        if (event.keyCode === 13) {
            event.preventDefault();
            sendMessage();
        }
    }
    function connectOmokSocket(){
    	var roomName = "<%= request.getParameter("roomName") %>";
    	
    	omokSocket = new WebSocket("ws://localhost:8080/OmocGame/game/" + roomName);

        omokSocket.onopen = function (event) {
            console.log("오목방 입장하셨습니다.");
        };

        omokSocket.onmessage = function (event) {
            console.log(event.data);
        };

        omokSocket.onclose = function (event) {
            console.log("오목방 퇴장하셨습니다.");
        };
    }
	function startGame(){
		var message = "startGame";
		if(omokSocket.readyState === WebSocket.OPEN ){
			omokSocket.send(message);
		}
	}
    document.addEventListener("DOMContentLoaded", function () {
        connectWebSocket();
        connectOmokSocket()
    });
</script>
</head>
<body>
	<%@ page import="game.GameUser" %>
	<%@ page import="game.GameRoom" %>
	<%@ page import="game.RoomManager" %>
	<%@ page import="java.util.List" %>
	<%
    	String id = null;
		GameUser userOwner = null;
    	String roomOwner = null;
    	int playerNum = 0;
    	if(session.getAttribute("id") != null){
        	id = (String) session.getAttribute("id");
    	}
    	String roomName = request.getParameter("roomName");
    	GameRoom gameRoom = null;
    	List<GameRoom> roomList = new RoomManager().getRoomList();
    	for(GameRoom room : roomList){
        	if(room.getRoomName().equals(roomName)){
            	gameRoom = room;
            	userOwner = gameRoom.getRoomOwner();
            	if(userOwner.getId().equals(id)){
            		roomOwner = id;
            	}
        	}
    	}
%>
	<script type="text/javascript">
		var id = "<%= id %>";
		var roomOwner = "<%= roomOwner %>";
		console.log(id);
		console.log(roomOwner);
	</script>
	<div class="container">
		<section>
			<div id="baduk-board"></div>
		</section>
		<aside>
			<div id="gameStart">
				<input type="button" value="게임 시작" 
				<%
					if((roomOwner != null && roomOwner.equals(id))|| gameRoom.getUserList().size() < 2){
				%> onclick="startGame()"
				<%
					} else {
				%>
				 disabled
				<%
					} 
				%>>
			</div>
			<div>
				<fieldset>
					<div id="chatset"></div>
					<input type="text" id="textMessage">
					<input type="submit" value="보내기" onclick="sendMessage()">
					<input type="button" value="나가기" onclick="leaveRoom()">
				</fieldset>
			</div>
		</aside>
	</div>

	<script>
	document.addEventListener("DOMContentLoaded", function () {
	    const badukBoard = document.getElementById("baduk-board");
	    let currentTurn = "black"; // 초기 턴은 흑돌

	    // 바둑판 그리기
	    for (let row = 0; row < 18; row++) {
	        for (let col = 0; col < 18; col++) {
	            const intersection = document.createElement("div");
	            intersection.className = "baduk-intersection";
	            intersection.dataset.row = row;
	            intersection.dataset.col = col;

	            intersection.addEventListener("mouseenter", function () {
	                this.style.backgroundColor = "#e0e0e0";
	            });

	            intersection.addEventListener("mouseleave", function () {
	                this.style.backgroundColor = "";
	            });

	            intersection.addEventListener("click", function () {
	                drawStone(this);
	            });

	            badukBoard.appendChild(intersection);
	        }
	    }

	    // 돌을 그리는 함수
	    function drawStone(cell) {
	        // 이미 돌이 그려진 경우 무시
	        if (cell.querySelector(".stone")) {
	        	alert("이미 바둑돌이 있는 곳에 다시 돌을 둘 수 없습니다.")
	            return;
	        }

	        const stone = document.createElement("div");
	        stone.className = "stone";
	        stone.style.backgroundColor = currentTurn === "black" ? "#000" : "#fff"; // 턴에 따라 색 변경

	        // 해당 칸에 돌 추가
	        cell.appendChild(stone);

	        // 턴 변경
	        currentTurn = currentTurn === "black" ? "white" : "black";
	    }
	});
	function removeStone(){
		var stones = document.getElementsByClassName("stone");
		stones.parentNode.removeChild(stones);
	}
		function leaveRoom() {
	        location.href = 'LeaveRoomServlet';
	    }
	</script>
</body>
</html>