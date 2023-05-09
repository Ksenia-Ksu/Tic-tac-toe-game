import Foundation

enum GameDataFlow {
    
    enum FetchGame {
        struct Request {
            let numberOfFields: Int
        }
        
        struct Response {
            let model: Game
        }
        
        struct ViewModel {
            let gameViewModel: GameViewModel
        }
    }
    
    enum SelectCell {
        
        struct Request {
            let cellIndex: Int
            let title: String?
        }
        
        struct Response {
            let motion: Turn
        }
        
        struct ViewModel {
            let gameViewModel: String
        }
    }
}
