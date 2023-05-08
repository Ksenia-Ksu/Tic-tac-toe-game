//
//  Models.swift
//  Tic-tac-toe-game
//
//  Created by Ксения Кобак on 06.05.2023.
//

import Foundation

enum Turn: String {
    case X 
    case O
}

class Game {
    
    var numberOfFields = 3
    var firstTurn = Turn.X
    var currentTurn = Turn.X
    
    private var field = [[String]]()
    
    func createGame() {
        field = [[String]](repeating: [String](repeating: "-", count: numberOfFields), count: numberOfFields)
    }
    
    func isWinner(_ row: Int, _ column: Int, motion: String) -> Bool {
        
        field[row][column] = motion
        
        //check row
        
        if Set(field[row]).count == 1 {
            return true
        } else {
            
            //check column
            var columns = [String]()
            for i in 0..<numberOfFields {
                columns.append(field[i][column])
            }
            if Set(columns).count == 1 {
                return true
            }
            
            //check main diagonal
            
            if row == column {
               var mainDiagonal = [String]()
                for i in 0..<numberOfFields {
                    mainDiagonal.append(field[i][i])
                }
                if Set(mainDiagonal).count == 1 && mainDiagonal[0] != "-" {
                    return true
                }
            } else {
                
                //secondaryDiagonal
                
                var secondaryDiagonal = [String]()
                for i in 0..<numberOfFields {
                    secondaryDiagonal.append(field[i][numberOfFields - i - 1])
                }
                if Set(secondaryDiagonal).count == 1 && secondaryDiagonal[0] != "-" {
                    return true
                }
            }
        }
        
        
        return false
    }
    
}

