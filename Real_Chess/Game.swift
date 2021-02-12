//
//  Game.swift
//  Real_Chess
//
//  Created by Grigorii Merkushev on 2/5/21.
//

import Foundation

class Game: ObservableObject{
    @Published var fromClickedCell: Point?
    @Published var board: Board = Board()
    @Published var couterAndRedrawer: Int = 0
    var чейХод: PlayerColor = .white
    var xодCounter: Int = 0
    
    func moveProcessing(point: Point){
        print("moveProcessing: " + letters[point.letter.rawValue]! + ":" + String(point.digit))
        if xодCounter % 2 == 0{
            print("Its white's turn. There are " + String(xодCounter) + "turns in total.")
            чейХод = .white
        }else{
            print("Its black's turn. There are " + String(xодCounter) + "turns in total.")
            чейХод = .black
        }
        if fromClickedCell != nil{
            print("firstClickedCell: " + letters[fromClickedCell!.letter.rawValue]! + ":" + String(fromClickedCell!.digit))
        }
        if fromClickedCell != nil {
            board.moveOrEat(fromClickedCell!, point)
            fromClickedCell = nil
            xодCounter += 1
        }else{
            fromClickedCell = point
        }
        couterAndRedrawer += 1
    }
}
