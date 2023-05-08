//
//  GamePresenter.swift
//  Tic-tac-toe-game
//
//  Created by Ксения Кобак on 06.05.2023.
//

import Foundation

protocol GameViewProtocol: AnyObject {
    func nextRound()
    func restartGame()
    //func playerDidMove()
}

protocol GameViewPresenterProtocol: AnyObject {
    init(view: GameViewProtocol)
    func showEmptyFields()
    func showNewGame()
    //func showNewMoveOnBoard()
}


class GamePresenter: GameViewPresenterProtocol {
    
    
    
    
    
    weak var view: GameViewProtocol?

    
    required init(view: GameViewProtocol) {
        self.view = view
        
    }
    
    
    func showEmptyFields() {
        print("Empty fields")
    }
    
    func showNewGame() {
        print("Restart game")
    }
}
