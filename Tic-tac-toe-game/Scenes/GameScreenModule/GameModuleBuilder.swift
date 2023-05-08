//
//  GameModuleBuilder.swift
//  Tic-tac-toe-game
//
//  Created by Ксения Кобак on 06.05.2023.
//


import UIKit

protocol Builder {
    static func createModule(_ game: Game) -> UIViewController
}

class GameScreenAssembly: Builder {
    
    static func createModule(_ game: Game) -> UIViewController {
        let view = GameViewController(game: game)
       // let presenter = GamePresenter(view: view)
       // view.presenter = presenter
        return view
    }
}
    
