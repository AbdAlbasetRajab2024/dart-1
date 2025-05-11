import 'dart:io';

List<String> board = List.filled(9, ' ');

void main() {
  print('Welcome to Tic-Tac-Toe!');
  String playAgain;

  do {
    resetBoard();
    playGame();
    print('Do you want to play again? (y/n)');
    playAgain = stdin.readLineSync()!.toLowerCase();
  } while (playAgain == 'y');
}

void playGame() {
  String currentPlayer = 'X';
  bool gameEnded = false;

  while (!gameEnded) {
    printBoard();
    int move = getPlayerMove(currentPlayer);
    board[move] = currentPlayer;

    if (checkWin(currentPlayer)) {
      printBoard();
      print('Player $currentPlayer wins!');
      gameEnded = true;
    } else if (boardFull()) {
      printBoard();
      print('The game is a draw!');
      gameEnded = true;
    } else {
      currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
    }
  }
}

void printBoard() {
  print('\n');
  for (int i = 0; i < 9; i += 3) {
    print(' ${board[i]} | ${board[i + 1]} | ${board[i + 2]} ');
    if (i < 6) print('-----------');
  }
  print('\n');
}

int getPlayerMove(String player) {
  int? move;

  while (true) {
    print('Player $player, enter your move (1-9):');
    String? input = stdin.readLineSync();

    if (input == null || int.tryParse(input) == null) {
      print('Invalid input. Please enter a number between 1 and 9.');
      continue;
    }

    move = int.parse(input) - 1;

    if (move < 0 || move >= 9) {
      print('Move out of range. Try again.');
    } else if (board[move] != ' ') {
      print('Cell already taken. Try another.');
    } else {
      break;
    }
  }

  return move;
}

bool checkWin(String player) {
  List<List<int>> winPatterns = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (var pattern in winPatterns) {
    if (board[pattern[0]] == player &&
        board[pattern[1]] == player &&
        board[pattern[2]] == player) {
      return true;
    }
  }

  return false;
}

bool boardFull() {
  return !board.contains(' ');
}

void resetBoard() {
  for (int i = 0; i < 9; i++) {
    board[i] = ' ';
  }
}
