//
//  Game.swift
//  Real_Chess
//
//  Created by Grigorii Merkushev on 2/5/21.
//

import Foundation

class GameController: ObservableObject{
    @Published var pointFrom: Point?
    @Published var pointTo: Point?
    @Published var boardController: BoardController = BoardController()
    @Published var couterAndRedrawer: Int = 0
    @Published var pawnUpgrade: Bool = false
    @Published var shakh: Bool = false
    var ходCounter: Int = 0
    var aiEnabled: Bool = true

    var ai = Ai()
    
    var player: Player?
    var result: HodResult?

    @Published var whiteGuy: Player = Player(PlayerColor.white);
    @Published var blackGuy: Player = Player(PlayerColor.black);
    
    func recordPoint(point: Point){
        print("moveProcessing: " + letters[point.letter.rawValue]! + ":" + String(point.digit))
        if result?.pawnUpgrade != nil{
            return
        }
        player = currentPlayer()
        if pointFrom == nil{
            let testPoint = boardController.getBoard().getFigureByPoint(point)
            if testPoint != nil && testPoint!.color == player!.color{
                pointFrom = point
            }
            return
        }else{
            let testPoint = boardController.getBoard().getFigureByPoint(point)
            if testPoint != nil && testPoint!.color == player!.color{
                pointFrom = point
                return
            }
        }
        pointTo = point
        moveProcesing(pointFrom: pointFrom!, pointTo: pointTo!)
        pointFrom = nil
        pointTo = nil
    }
    
    func moveProcesing(pointFrom: Point, pointTo: Point){
        
        result = boardController.moveOrEat(pointFrom, pointTo, player!)
        let whiteScore = whiteGuy.warehouseWorth()
        let blackScore = blackGuy.warehouseWorth()
        whiteGuy.score = whiteScore - blackScore
        blackGuy.score = blackScore - whiteScore
        print("white: " + String(whiteGuy.score))
        print("black: " + String(blackGuy.score))
        
        if result!.shakh != nil{
            shakh = true
            print("finally it worked! 💀")
        }else{
            shakh = false
        }
        pawnUpgrade = (result?.pawnUpgrade != nil)
        if !result!.status{
            print("Turn cant be made")
            return
        }
        
        if result?.pawnUpgrade == nil{
            ходCounter += 1
            if result?.shakh == nil{
                result = nil
            }
            if aiEnabled{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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
        pawnUpgrade = false
    }
    
    func isUrgent(point: Point) -> Bool{
        if result != nil && result!.shakh != nil && (result!.shakh!.king == point || result!.shakh!.hostile == point){
            return true
        }else{
            return false
        }
    }
    
    init(aiEnabled: Bool){
        self.aiEnabled = aiEnabled
        whiteGuy.archieve(eaten: Pawn(PlayerColor.black))
        whiteGuy.archieve(eaten: Pawn(PlayerColor.black))
        whiteGuy.archieve(eaten: Pawn(PlayerColor.black))
        whiteGuy.archieve(eaten: Pawn(PlayerColor.black))
        whiteGuy.archieve(eaten: Pawn(PlayerColor.black))
        whiteGuy.archieve(eaten: Pawn(PlayerColor.black))
        whiteGuy.archieve(eaten: Pawn(PlayerColor.black))
        whiteGuy.archieve(eaten: Pawn(PlayerColor.black))
        //whiteGuy.archieve(eaten: Pawn(PlayerColor.black))

//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
//        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
        blackGuy.archieve(eaten: Pawn(PlayerColor.white))
    }
}
