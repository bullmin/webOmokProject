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
            padding: 20px;
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

        #aside-box1 {
            display: flex;
        }

        #select-color {
            width: 50%;
        }

        #radio-group {
            width: 50%;
        }

<<<<<<< HEAD
        #chatset {
            border: 1px solid #000000;
            width: 100%;
            height: 400px;
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

        .stone {
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background-color: #000;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        h4 {
            margin-bottom: 5px;
        }

        .choice {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <section>
            <div id="baduk-board"></div>
        </section>
        <aside>
            <div id="aside-box1">
                <fieldset id="select-color">
                    <h4>백돌</h4>
                    <input type="button" class="choice" value="선택">
                    <h4>흑돌</h4>
                    <input type="button" class="choice" value="선택">
                </fieldset>
                <fieldset id="radio-group">
                    <h4>대결 횟수 설정</h4>
                    <label><input type="radio" name="gameType" value="단판승" checked>단판승</label><br>
                    <label><input type="radio" name="gameType" value="3판 2선승">3판 2선승</label><br>
                    <label><input type="radio" name="gameType" value="5판 3선승">5판 3선승</label>
                    <input type="button" value="게임 시작">
                </fieldset>
            </div>
            <div>
                <fieldset>
                    <div id="chatset"></div>
                    <input type="text">
                    <input type="submit" value="보내기">
                    <input type="button" value="나가기">
                </fieldset>
            </div>
        </aside>
    </div>
=======
		.choice{
			margin-bottom: 10px; /* You can adjust the margin value as needed */
		}
	</style>
	<script>
    // 통신을 위한 WebSocket 객체
    var webSocket;

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
            messageText = event.data + "\n";
            messageTextArea.innerHTML += messageText;
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
            // Enter key is pressed
            event.preventDefault();  // Prevent the default action (form submission)
            sendMessage();
        }
    }

    document.addEventListener("DOMContentLoaded", function () {
        connectWebSocket();
    });
</script>
</head>
<body>
	<div class="container">
		<section>
			<div id="baduk-board"></div>
		</section>
		<aside>
			<div id="aside-box1">
				<fieldset id="select-color">
					<h4>백돌</h4>
					<input type="button" class="choice" value="선택">
					<h4>흑돌</h4>
					<input type="button" class="choice" value="선택">
				</fieldset>
				<fieldset id="radio-group">
					<h4>대결 횟수 설정</h4>
					<label><input type="radio" name="gameType" value="단판승" checked>단판승</label><br>
					<label><input type="radio" name="gameType" value="3판 2선승">3판 2선승</label><br>
					<label><input type="radio" name="gameType" value="5판 3선승">5판 3선승</label>
					<input type="button" value="게임 시작">
				</fieldset>
			</div>
			<div>
				<fieldset>
					<div id="chatset"></div>
					<input type="text" id="textMessage">
					<input type="submit" value="보내기" onclick="sendMessage()">
					<input type="button" value="나가기">
				</fieldset>
			</div>
		</aside>
	</div>
>>>>>>> 7ac724c9fe6538fde7c8f9198a780b989ddd6c67

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
                    drawStone(this);
                });

                badukBoard.appendChild(intersection);
            }
        }

        // 돌을 그리는 함수
        function drawStone(cell) {
            // 이미 돌이 그려진 경우 무시
            if (cell.querySelector(".stone")) {
                return;
            }

            const stone = document.createElement("div");
            stone.className = "stone";

            // 해당 칸에 돌 추가
            cell.appendChild(stone);
        }
    });
    </script>
</body>
</html>

