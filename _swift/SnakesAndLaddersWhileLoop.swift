let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)  // start from square 0 until 25; in total 26 squares

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0

while square < finalSquare {
    // roll the dice
    diceRoll = Int.random(in: 1...6)
    square += diceRoll
    print("Move to \(square)")
    if square < board.count {
        // if we're still on the board, move up or down for a snake or a ladder
        let movement = board[square]
        square += movement
        if movement > 0 {
            print("Move forward to \(square) through ladder +\(movement)")
        }
        else if movement < 0 {
            print("Move backward to \(square) through snake \(movement)")
        }
    }
}
print("Game over!")

