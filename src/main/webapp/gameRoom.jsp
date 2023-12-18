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
	var stonColor = "unknown";
	var gameState = false;
	var currentTurn = "black";
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
            var message = event.data;
            var messageSplit = message.split(':');
            if(messageSplit[0] === "startGame"){
            	stoneColor = messageSplit[1];
            	currentTurn = "black";
            	removeStones();
            	gameState = true;
            	console.log(stoneColor);
            }
            else if(messageSplit[0] === "StoneMove"){
            	var move = messageSplit[1]
            	var row = move.split(',')[0];
            	var col = move.split(',')[1];
            	drawStone(row, col);
            	setTimeout(100);
            	if(!checkWinCondition()){
            		if(stoneColor === currentTurn){
            			sendOmokMessage("ChangeTurn:"+stoneColor);
            		}                	
                }else{
                	console.log(currentTurn + " Win");
                	sendOmokMessage("Win");
                }
            }
            else if (messageSplit[0] === "ChangeTurn") {
            	currentTurn = messageSplit[1];
            }
            else if(messageSplit[1] === "NotReady"){
            	alert("상대가 없습니다.");
            }
            else if(messageSplit[1] === "Win"){
            	gameState = false;
            	var messageTextArea = document.getElementById("chatset");
            	var messageText = currentTurn +" Win<br>";
            	messageTextArea.innerHTML += messageText;
                messageTextArea.scrollTop = messageTextArea.scrollHeight;            	
            }
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
	function sendOmokMessage(message){
		return new Promise((resolve, reject) => {
	        if (omokSocket.readyState === WebSocket.OPEN) {
	            omokSocket.send(message);
	            resolve("Message sent successfully");
	        } else {
	            reject("WebSocket is not open");
	        }
	    });		
	}
	
	function drawStone(row, col) {
		console.log("Draw stone at", row, col);
    	const cell = document.querySelector('.baduk-intersection[data-row="' + row + '"][data-col="' + col + '"]');
    	
        const stone = document.createElement("div");
        stone.className = "stone";
        if(currentTurn === "black"){
        	stone.style.backgroundColor ="#000";
        }else{
        	stone.style.backgroundColor ="#fff";
        }

        // 해당 칸에 돌 추가
        cell.appendChild(stone);        
    }
	function checkWinCondition() {
		console.log("Checking win condition");
	    const intersections = document.querySelectorAll('.baduk-intersection');

	    // 각 intersection에 대해 승리 조건 확인
	    for (const intersection of intersections) {
	        const row = intersection.dataset.row;
	        const col = intersection.dataset.col;

	        // 가로, 세로, 대각선에 대해 승리 조건 확인
	        if (
	            checkLine(row, col, 1, 0) || // 가로
	            checkLine(row, col, 0, 1) || // 세로
	            checkLine(row, col, 1, 1) || // 대각선 (왼쪽 위에서 오른쪽 아래)
	            checkLine(row, col, 1, -1)   // 대각선 (왼쪽 아래에서 오른쪽 위)
	        ) {
	            return true; // 승리 조건이 만족되면 게임 종료
	        }
	    }

	    return false; // 아직 승리 조건이 만족되지 않음
	}
	function checkLine(row, col, rowIncrement, colIncrement) {
	    var currentColor = "";

	    if (currentTurn === "black") {
	        currentColor = "rgb(0, 0, 0)";
	    } else {
	        currentColor = "rgb(255, 255, 255)";
	    }

	    // 현재 위치에서 시작하여 일정 방향으로 다섯 개의 돌이 같은 색인지 확인
	    let count = 0;
	    for (let i = 0; i < 5; i++) {
	        const newRow = parseInt(row) + i * rowIncrement;
	        const newCol = parseInt(col) + i * colIncrement;

	        const cell = document.querySelector('.baduk-intersection[data-row="' + newRow + '"][data-col="' + newCol + '"]');
	        let stone = null;

	        if (cell) {
	            stone = cell.querySelector(".stone");
	        }

	        if (stone && stone.style.backgroundColor === currentColor) {
	            count++;
	        } else {
	            count = 0; // 연속된 돌이 끊겼을 때 count 초기화
	        }

	        if (count === 5) {
	            return true; // 다섯 개의 돌이 같은 색이면 승리 조건이 만족됨
	        }
	    }

	    return false; // 다섯 개의 돌이 같은 색이 아니면 승리 조건이 만족되지 않음
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
					if((roomOwner != null && roomOwner.equals(id))){
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
	            	if(gameState === false  || currentTurn != stoneColor){
	            		event.preventDefault();
	            		return;
	            	}
	            	if (intersection.querySelector(".stone")) {
	                    alert("이미 바둑돌이 있는 곳에 다시 돌을 둘 수 없습니다.");
	                    return;
	                }
	            	const row = this.dataset.row;
	                const col = this.dataset.col;
	                sendOmokMessage("stoneMove:" + row + "," + col);
	            });

	            badukBoard.appendChild(intersection);
	        }
	    }	    
	});
	function removeStones() {
	    var stones = document.getElementsByClassName("stone");

	    // 돌이 한 번에 모두 지워지도록 추가
	    while (stones.length > 0) {
	        stones[0].parentNode.removeChild(stones[0]);
	    }
	}
		function leaveRoom() {
	        location.href = 'LeaveRoomServlet';
	    }
	</script>
</body>
</html>
