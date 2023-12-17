<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오목 게임</title>
    <style>
        #gomoku-board {
            display: grid;
            grid-template-columns: repeat(15, 40px);
            grid-template-rows: repeat(15, 40px);
            gap: 1px;
        }

        .intersection {
            width: 40px;
            height: 40px;
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }

        .black-stone {
            width: 30px;
            height: 30px;
            background-color: #333;
            border-radius: 50%;
        }

        .white-stone {
            width: 30px;
            height: 30px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 50%;
        }
    </style>
</head>
<body>
    <h1>오목 게임</h1>
    <div id="gomoku-board"></div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const board = document.getElementById("gomoku-board");
            const boardSize = 15;
            let currentPlayer = "black";
            let gameOver = false;

            // Create the game board
            for (let row = 0; row < boardSize; row++) {
                for (let col = 0; col < boardSize; col++) {
                    const intersection = document.createElement("div");
                    intersection.className = "intersection";
                    intersection.dataset.row = row;
                    intersection.dataset.col = col;

                    intersection.addEventListener("click", function () {
                        if (!gameOver) {
                            placeStone(row, col);
                        }
                    });

                    board.appendChild(intersection);
                }
            }

            // Place a stone on the board
            function placeStone(row, col) {
                const intersection = document.querySelector(`[data-row='${row}'][data-col='${col}']`);

                if (!intersection.hasChildNodes()) {
                    const stone = document.createElement("div");
                    stone.className = `${currentPlayer}-stone`;
                    intersection.appendChild(stone);

                    // Check for a winner
                    if (checkWinner(row, col)) {
                        alert(`${currentPlayer.toUpperCase()} 플레이어가 이겼습니다!`);
                        gameOver = true;
                    } else {
                        // Switch to the other player
                        currentPlayer = currentPlayer === "black" ? "white" : "black";
                    }
                }
            }

            // Check for a winner
            function checkWinner(row, col) {
                // Implement your winning condition logic here
                // This is a placeholder for illustration purposes
                // In a real game, you need a more sophisticated algorithm
                return false;
            }
        });
    </script>
</body>
</html>
