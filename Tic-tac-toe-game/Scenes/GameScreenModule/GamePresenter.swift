import Foundation


protocol GameViewPresentationLogic: AnyObject {
    func showNewGame(_ response: GameDataFlow.FetchGame.Response)
    func showNewMoveOnBoard(_ response: GameDataFlow.FetchGame.Response)
    func showWinner(_ response: GameDataFlow.SelectCell.Response)
    func showTheEndGame()
}


class GamePresenter: GameViewPresentationLogic {
   
    weak var viewController: DisplayGameViewLogic?
    
    func showNewGame(_ response: GameDataFlow.FetchGame.Response) {
        let viewModel = GameViewModel(size: response.model.numberOfFields, currentPlayer: response.model.currentTurn.rawValue)
        viewController?.displayNewGame(.init(gameViewModel: viewModel))
    }
    
    func showNewMoveOnBoard(_ response: GameDataFlow.FetchGame.Response) {
        let viewModel = GameViewModel(size: response.model.numberOfFields, currentPlayer: response.model.currentTurn.rawValue)
        viewController?.displayNewField(.init(gameViewModel: viewModel))
    }
    
    func showWinner(_ response: GameDataFlow.SelectCell.Response) {
        viewController?.displayWinner(.init(gameViewModel: response.motion.rawValue))
    }
    
    func showTheEndGame() {
        viewController?.displayTheEndGame()
    }
}
