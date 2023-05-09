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
        let game = Game()
        game.numberOfFields = gameFields
        let view = GameViewController(game: game)
       // let presenter = GamePresenter(view: view)
       // view.presenter = presenter
        return view
    }
}
    
