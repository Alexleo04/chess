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
    @Published var shakh: Bool = false
    var ходCounter: Int = 0

    var player: Player?
    var result: HodResult?

    @Published var whiteGuy: Player = Player(PlayerColor.white);
    @Published var blackGuy: Player = Player(PlayerColor.black);
    
    func playerSelector() -> Player{
        if ходCounter % 2 == 0{
            return whiteGuy;
        }
        return blackGuy;
    }
    
    func moveProcesing(point: Point){
        print("moveProcessing: " + letters[point.letter.rawValue]! + ":" + String(point.digit))
        if result?.pawnUpgrade != nil{
            return
        }
        if fromClickedCell != nil {
            player = playerSelector()
            result = board.moveOrEat(fromClickedCell!, point, player!)
            let whiteScore = whiteGuy.warehouseWorth()
            let blackScore = blackGuy.warehouseWorth()
            whiteGuy.score = whiteScore - blackScore
            blackGuy.score = blackScore - whiteScore
            print("white: " + String(whiteGuy.score))
            print("black: " + String(blackGuy.score))
            fromClickedCell = nil

            if result!.shakh{
                shakh = true
                print("finally it worked! 💀")
            }else{
                shakh = false
            }
            
            if !result!.status{
                print("Turn cant be made")
                return
            }
            if result?.pawnUpgrade == nil{
                ходCounter += 1
                result = nil
            }
        }else{
            fromClickedCell = point
        }

        couterAndRedrawer += 1
    }
    
    func realPawnUpgrade(theChosen: String){
        var theChosenFigure: Figure
        switch theChosen{
        case "Queen":
            theChosenFigure = Queen(player!.color)
        case "Tower":
            theChosenFigure = Tower(player!.color)
        case "Bishop":
            theChosenFigure = Bishop(player!.color)
        case "Knight":
            theChosenFigure = Knight(player!.color)
        default:
            return
        }
        if result != nil && result!.pawnUpgrade != nil{
            board.placeFigure(pos: result!.pawnUpgrade!.point, fig: theChosenFigure)
            couterAndRedrawer += 1
            ходCounter += 1
            result = nil
        }
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
