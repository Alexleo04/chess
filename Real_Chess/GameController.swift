//
//  Game.swift
//  Real_Chess
//
//  Created by Grigorii Merkushev on 2/5/21.
//

import Foundation

class GameController: ObservableObject{
    @Published var cellFrom: Point?
    @Published var boardController: BoardController = BoardController()
    @Published var couterAndRedrawer: Int = 0
    @Published var shakh: Bool = false
    var ходCounter: Int = 0

    var ai = Ai()
    
    var player: Player?
    var result: HodResult?

    @Published var whiteGuy: Player = Player(PlayerColor.white);
    @Published var blackGuy: Player = Player(PlayerColor.black);
    
    func moveProcesing(point: Point){
        print("moveProcessing: " + letters[point.letter.rawValue]! + ":" + String(point.digit))
        if result?.pawnUpgrade != nil{
            return
        }
        if cellFrom != nil {
            player = currentPlayer()
            result = boardController.moveOrEat(cellFrom!, point, player!)
            let whiteScore = whiteGuy.warehouseWorth()
            let blackScore = blackGuy.warehouseWorth()
            whiteGuy.score = whiteScore - blackScore
            blackGuy.score = blackScore - whiteScore
            print("white: " + String(whiteGuy.score))
            print("black: " + String(blackGuy.score))
            cellFrom = nil

            if result!.shakh != nil{
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
                if result?.shakh == nil{
                    result = nil
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                    self.player = self.currentPlayer()
                    var aiMoveCoords = self.ai.лучшийХод(self.boardController.getBoard().copy(), self.whiteGuy.copy(), self.blackGuy.copy())
                    self.result = self.boardController.moveOrEat(aiMoveCoords.from, aiMoveCoords.to, self.blackGuy)
                    
                    if self.result?.shakh != nil{
                        self.shakh = true
                        print("finally it worked! 💀")
                    }else{
                        self.shakh = false
                    }
                    
                    if self.result?.pawnUpgrade != nil{
                        self.realPawnUpgrade(theChosen: "Queen")
                    }else{
                        self.ходCounter += 1
                    }
                    self.couterAndRedrawer += 1
                }
            }
        }else{
            cellFrom = point
        }

        couterAndRedrawer += 1
    }
    
    func currentPlayer() -> Player{
        if ходCounter % 2 == 0{
            return whiteGuy;
        }
        return blackGuy;
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
            boardController.getBoard().placeFigure(result!.pawnUpgrade!.point, theChosenFigure)
            couterAndRedrawer += 1
            ходCounter += 1
            result = nil
        }
    }
    
    func isUrgent(point: Point) -> Bool{
        if result != nil && result!.shakh != nil && (result!.shakh!.king == point || result!.shakh!.hostile == point){
            return true
        }else{
            return false
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
