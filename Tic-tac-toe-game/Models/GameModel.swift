
import Foundation

enum Turn: String {
    case X 
    case O
}

class Game {
    var numberOfFields = 3
    var moves = 0
    var firstTurn = Turn.X
    var currentTurn = Turn.X
    var field = [[String]]()
    
    init(numberOfFields: Int = 3, moves: Int = 0, firstTurn: Turn = Turn.X, currentTurn: Turn = Turn.X, field: [[String]] = [[String]]()) {
        self.numberOfFields = numberOfFields
        self.moves = moves
        self.firstTurn = firstTurn
        self.currentTurn = currentTurn
        self.field = field
    }
}

//MARK: - ViewModel

struct GameViewModel {
    var size: Int
    var currentPlayer: String
}

