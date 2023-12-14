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
		#aside-box1{
			display: flex;
			
		}
		#select-color{
			width: 50%;
		}
		#radio-group{
			width: 50%;
		}

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
		}
		h4 {
			margin-bottom: 5px; /* You can adjust the margin value as needed */
		}

		.choice{
			margin-bottom: 10px; /* You can adjust the margin value as needed */
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

					badukBoard.appendChild(intersection);
				}
			}
		});
	</script>
</body>
</html>
