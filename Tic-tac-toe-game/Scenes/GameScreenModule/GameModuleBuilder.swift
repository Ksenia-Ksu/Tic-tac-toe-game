//
//  GameModuleBuilder.swift
//  Tic-tac-toe-game
//
//  Created by Ксения Кобак on 06.05.2023.
//


import UIKit

protocol GameBuilder {
    static func createModule(_ gameFields: Int) -> UIViewController
}

class GameScreenAssembly: GameBuilder {
    
    static func createModule(_ gameFields: Int) -> UIViewController {
        let game = Game(numberOfFields: gameFields)
        let presenter = GamePresenter()
        let interactor = GameInteractor(presenter: presenter, game: game)
        let router = GameRouter()
        let vc = GameViewController(interactor: interactor, router: router, numberOfFields: gameFields)
        presenter.viewController = vc
        router.viewController = vc
        return vc
    }
}
    
