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
    var moveCounter: Int = 0
    
    @Published var whiteGuy: Player = Player(PlayerColor.white);
    @Published var blackGuy: Player = Player(PlayerColor.black);
    
    func playerSelector() -> Player{
        if moveCounter % 2 == 0{
            return whiteGuy;
        }
        return blackGuy;
    }
    
    func turnProcesin(point: Point){
        print("moveProcessing: " + letters[point.letter.rawValue]! + ":" + String(point.digit))
        if fromClickedCell != nil {
            let player = playerSelector()
            let result = board.moveOrEat(fromClickedCell!, point, player)
            let whiteScore = whiteGuy.warehouseWorth()
            let blackScore = blackGuy.warehouseWorth()
            whiteGuy.score = whiteScore - blackScore
            blackGuy.score = blackScore - whiteScore
            print("white: " + String(whiteGuy.score))
            print("black: " + String(blackGuy.score))
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
    init(){
//        whiteGuy.archieve(eaten: Pawn(PlayerColor.white))
//        whiteGuy.archieve(eaten: Pawn(PlayerColor.white))
//        whiteGuy.archieve(eaten: Pawn(PlayerColor.white))
//        whiteGuy.archieve(eaten: Pawn(PlayerColor.white))
//        whiteGuy.archieve(eaten: Pawn(PlayerColor.white))
//        whiteGuy.archieve(eaten: Pawn(PlayerColor.white))
//        whiteGuy.archieve(eaten: Pawn(PlayerColor.white))
//        whiteGuy.archieve(eaten: Pawn(PlayerColor.white))
//
//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
    }
}
