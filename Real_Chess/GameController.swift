//
//  Game.swift
//  Real_Chess
//
//  Created by Grigorii Merkushev on 2/5/21.
//

import Foundation

class GameController: ObservableObject{
    @Published var fromClickedCell: Point?
    @Published var board: Board = Board()
    @Published var couterAndRedrawer: Int = 0
    var whoMoves: PlayerColor = .white
    var moveCounter: Int = 0
    
    // add Player 1
    // add Player 2
    
    func moveProcessing(point: Point){
        print("moveProcessing: " + letters[point.letter.rawValue]! + ":" + String(point.digit))
        if moveCounter % 2 == 0{
            print("Its white's turn. There are " + String(moveCounter) + " turns in total.")
            whoMoves = .white
        }else{
            print("Its black's turn. There are " + String(moveCounter) + " turns in total.")
            whoMoves = .black
        }
        if fromClickedCell != nil {
            let result = board.moveOrEat(fromClickedCell!, point)
            fromClickedCell = nil
            
            if !result{
                print("Turn cant be made")
                return
            }
            
            moveCounter += 1
        }else{
            fromClickedCell = point
        }
        couterAndRedrawer += 1
    }
}
