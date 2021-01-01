let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)  // start from square 0 until 25; in total 26 squares

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0

gameLoop: repeat {
    diceRoll = Int.random(in: 1...6)
    switch square + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        print("Reach square \(finalSquare)!")
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        print("diceRoll \(diceRoll) will move us beyond the final square, so roll again")
        continue gameLoop
    case let newSquare:
        square = newSquare
        print("Move to \(square)")
        let movement = board[newSquare]
        square += movement
        if movement > 0 {
            print("Move forward to \(square) through ladder +\(movement)")
        }
        else if movement < 0 {
            print("Move backward to \(square) through snake \(movement)")
        }
    }
} while square != afinalSquare
print("Game over!")

