
import Foundation

protocol GameBusinessLogic {
    func startGame(_ request: GameDataFlow.FetchGame.Request)
    func playerDidMove(_ request: GameDataFlow.SelectCell.Request)

}

final class GameInteractor: GameBusinessLogic {
    
    private var game: Game
    private let presenter: GameViewPresentationLogic
  
    init(presenter: GameViewPresentationLogic, game: Game) {
        self.presenter = presenter
        self.game = game
    }
    
    func startGame(_ request: GameDataFlow.FetchGame.Request) {
        resetGame()
        let newField = createGame(sizeOfField: request.numberOfFields)
        game.field = newField
        presenter.showNewGame(.init(model: game))
    }
    
    func playerDidMove(_ request: GameDataFlow.SelectCell.Request) {
        moveDone()
        
        if checkingWinner(request.cellIndex) {
            presenter.showWinner(.init(motion: game.currentTurn))
        } else if !checkingWinner(request.cellIndex) &&
                    game.moves == (game.numberOfFields * game.numberOfFields) {
            presenter.showTheEndGame()
        }
        
        if request.title == nil {
            if game.currentTurn == Turn.O {
                game.currentTurn = Turn.X
            } else if game.currentTurn == Turn.X {
                game.currentTurn = Turn.O
            }
            presenter.showNewMoveOnBoard(.init(model: game))
          
        }
    }
    
    private func createGame(sizeOfField: Int ) -> [[String]] {
        return [[String]](repeating: [String](repeating: "-", count: sizeOfField), count: sizeOfField)
    }
    
    func moveDone() {
        game.moves += 1
        
    }
    
    func resetGame() {
        game.moves = 0
        game.currentTurn = Turn.X
        game.field = []
    }
    
    private func checkingWinner(_ field: Int) -> Bool {
        var row = 0
        var column = 0
        if field < game.numberOfFields {
            column = field
        } else {
            row = (field) / game.numberOfFields
            column = (field) % game.numberOfFields
        }
        return self.isWinner(row, column, motion: game.currentTurn.rawValue)
    }
    
    
    private func isWinner(_ row: Int, _ column: Int, motion: String) -> Bool {
        
        game.field[row][column] = motion
        let numberFields = game.numberOfFields
        if Set(game.field[row]).count == 1 {
            return true
        } else {
            var columns = [String]()
            for i in 0..<numberFields {
                columns.append(game.field[i][column])
            }
            if Set(columns).count == 1 {
                return true
            }
         
            if row == column {
                var mainDiagonal = [String]()
                for i in 0..<numberFields {
                    mainDiagonal.append(game.field[i][i])
                }
                if Set(mainDiagonal).count == 1 && mainDiagonal[0] != "-" {
                    return true
                }
            } else {
                var secondaryDiagonal = [String]()
                for i in 0..<numberFields {
                    secondaryDiagonal.append(game.field[i][numberFields - i - 1])
                }
                if Set(secondaryDiagonal).count == 1 && secondaryDiagonal[0] != "-" {
                    return true
                }
            }
        }
        return false
    }
}
