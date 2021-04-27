//
//  Board.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class Board: ObservableObject{
    @Published private var board: [[Figure?]] = Array(repeating: [nil,nil,nil,nil,nil,nil,nil,nil], count: 8)
    
    let row = 8
    let column = 8
    
    func getBoard() -> [[Figure?]]{
        return board
    }
    
    init(){
        fillBoard()
//        board[6][3] = Pawn(.white)
//        board[1][3] = Pawn(.black)
        board[3][3] = King(.black)
        board[4][7] = Tower(.white)
    }
    
    func fillBoard(){
        board[0][0] = Tower(.white)
        board[0][1] = Knight(.white)
        board[0][2] = Bishop(.white)
        board[0][3] = Queen(.white)
        board[0][4] = King(.white)
        board[0][5] = Bishop(.white)
        board[0][6] = Knight(.white)
        //board[0][7] = Tower(.white)

        board[7][0] = Tower(.black)
        board[7][1] = Knight(.black)
        board[7][2] = Bishop(.black)
        board[7][3] = Queen(.black)
        //board[7][4] = King(.black)
        board[7][5] = Bishop(.black)
        board[7][6] = Knight(.black)
        board[7][7] = Tower(.black)

        for j in 0...board[1].count-1{
            board[1][j] = Pawn(.white)
        }
        for j in 0...board[6].count-1{
            board[6][j] = Pawn(.black)
        }
    }
    
    func moveOrEat(_ from: Point, _ to: Point, _ thePlayer: Player) -> HodResult{
        // check if enemy in dest
        let figureInToCell = getFigureByPoint(to)
        let figureInFromCell = getFigureByPoint(from)
        let hostileColor = thePlayer.color == PlayerColor.black ? PlayerColor.white : PlayerColor.black
        
        if figureInFromCell?.color != thePlayer.color{
            return HodResult(status: false, shakh: shakhDetector(hostileColor), pawnUpgrade: nil)
        }
        if figureInFromCell! is King {
            if castling(from, to){
                return HodResult(status: true, shakh: shakhDetector(hostileColor), pawnUpgrade: nil)
            }
        }
        if figureInToCell == nil{
            //MOVE
            if canMove(from, to, false){
                figureInFromCell!.wasMoved = true
                placeFigure(pos: to, fig: figureInFromCell!)
                clearCell(from)
                //1.figureInFromCell = пешка?
                //2.to = 8 или 1
                if figureInFromCell is Pawn && (to.digit == 8 || to.digit == 1){
                    //3.Pawn Upgrade
                    return HodResult(status: true, shakh: shakhDetector(hostileColor), pawnUpgrade: PawnUpgrade(point: to))
                }
                return HodResult(status: true, shakh: shakhDetector(hostileColor), pawnUpgrade: nil)
            }
            return HodResult(status: false, shakh: shakhDetector(hostileColor), pawnUpgrade: nil)
        }else{
            //EAT
            if canMove(from, to, true){
                thePlayer.archieve(eaten: getFigureByPoint(to)!)
                clearCell(to)
                placeFigure(pos: to, fig: figureInFromCell!)
                clearCell(from)
                //1.figureInFromCell = пешка?
                //2.to = 8 или 1
                if figureInFromCell is Pawn && (to.digit == 8 || to.digit == 1){
                    //3.Pawn Upgrade
                    return HodResult(status: true, shakh: shakhDetector(hostileColor), pawnUpgrade: PawnUpgrade(point: to))
                }
                return HodResult(status: true, shakh: shakhDetector(hostileColor), pawnUpgrade: nil)
            }
            return HodResult(status: false, shakh: shakhDetector(hostileColor), pawnUpgrade: nil)
        }
        return HodResult(status: false, shakh: shakhDetector(hostileColor), pawnUpgrade: nil)
     }
    
    func shakhDetector(_ color: PlayerColor) -> Bool{
        //где король?
        //какого цвета?
        var kingCoords: Point?
        for i in 0...row-1{
            for j in 0...column-1{
                if board[i][j] is King && board[i][j]!.color == color{
                    kingCoords = Helper.createPoint(letterNum: i+1, digitNum: j+1)
                }
            }
        }
        if kingCoords == nil{
            return false
        }
        for i in 1...8{
            var hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue, digitNum: i)
            if canMove(hostileCoords, kingCoords!, true){
                return true
            }
            hostileCoords = Helper.createPoint(letterNum: i, digitNum: kingCoords!.digit)
            if canMove(hostileCoords, kingCoords!, true){
                return true
            }
        }
        //правая-верхняя
        var hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue, digitNum: kingCoords!.digit)
        while hostileCoords.digit + 1 <= 8 && hostileCoords.letter.rawValue + 1 <= 8{
            if canMove(hostileCoords, kingCoords!, true){
                return true
            }
            hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue+1, digitNum: kingCoords!.digit+1)
            return false
        }
        //левая-верхняя
        hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue, digitNum: kingCoords!.digit)
        while hostileCoords.digit + 1 <= 8 && hostileCoords.letter.rawValue - 1 >= 1{
            if canMove(hostileCoords, kingCoords!, true){
                return true
            }
            hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue-1, digitNum: kingCoords!.digit+1)
            return false
        }
        //левая-нижняя
        hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue, digitNum: kingCoords!.digit)
        while hostileCoords.digit - 1 >= 1 && hostileCoords.letter.rawValue - 1 >= 1{
            if canMove(hostileCoords, kingCoords!, true){
                return true
            }
            hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue-1, digitNum: kingCoords!.digit-1)
            return false
        }
        //правая-нижняя
        hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue, digitNum: kingCoords!.digit)
        while hostileCoords.digit - 1 >= 1 && hostileCoords.letter.rawValue + 1 <= 8{
            if canMove(hostileCoords, kingCoords!, true){
                return true
            }
            hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue+1, digitNum: kingCoords!.digit-1)
            return false
        }
        
        return false
        //идет ли по вертекали способная фигура?
        //идет ли по диагонали способная фигура?
        //конь?
    }
    
    func castling(_ kingPoint: Point, _ targetPoint: Point) -> Bool{
        func castlingKind(_ towerCoordStart: Point, _ kingCoordStart: Point, _ towerCoordEnd: Point, _ kingCoordEnd: Point) -> Bool{
            let towerFig = getFigureByPoint(towerCoordStart)
            if towerFig == nil && towerFig!.wasMoved{
                return false
            }
            if !yourPathVerifier(towerFig!.myPath(from: kingCoordStart, to: towerCoordStart)){
                return false
            }
            placeFigure(pos: kingCoordEnd, fig: kingFig!)
            placeFigure(pos: towerCoordEnd, fig: towerFig!)
            clearCell(kingCoordStart)
            clearCell(towerCoordStart)
            return true
        }
        //1.wasMoved?
        if !kingPoint.isValid() || !targetPoint.isValid(){
            return false
        }
        let kingFig = getFigureByPoint(kingPoint)
        if kingFig == nil {
            return false
        }
        if kingFig!.wasMoved{
            return false
        }
        //2.Узнать тип ракировки
        if targetPoint == Point(letter: .c, digit: 1){
            return castlingKind(Point(letter: .a, digit: 1), Point(letter: .e, digit: 1), Point(letter: .d, digit: 1), Point(letter: .c, digit: 1))
        }
        if targetPoint == Point(letter: .g, digit: 1){
            return castlingKind(Point(letter: .h, digit: 1), Point(letter: .e, digit: 1), Point(letter: .f, digit: 1), Point(letter: .g, digit: 1))
        }
        if targetPoint == Point(letter: .c, digit: 8){
            return castlingKind(Point(letter: .a, digit: 8), Point(letter: .e, digit: 8), Point(letter: .d, digit: 8), Point(letter: .c, digit: 8))
        }
        if targetPoint == Point(letter: .g, digit: 8){
            return castlingKind(Point(letter: .h, digit: 8), Point(letter: .e, digit: 8), Point(letter: .f, digit: 8), Point(letter: .g, digit: 8))
        }
        return false
    }
    
    func canMove(_ from: Point, _ to: Point, _ isEat: Bool) -> Bool{
        //1. Valiдность обеих точек
        if !from.isValid() || !to.isValid(){
            return false
        }
        //2. From != nil?
        let figureInFromCell = getFigureByPoint(from)
        if figureInFromCell == nil {
            return false
        }
        
        // 2.1 get fig from "to"
        let figureInToCell = getFigureByPoint(to)
        // if iseat = true and our fig or empty "to"
        if isEat && (figureInToCell == nil || figureInToCell!.color == figureInFromCell!.color) {
            return false
        }
        // if isEat = false and "to" != nil
        if !isEat && (figureInToCell != nil) {
            return false
        }
        
        //3. can figure move "from" --> "to" (по правилам)?
        let movableFig = getFigureByPoint(from)!
        if isEat{
            if !movableFig.canEat(from: from, to: to){
                return false
            }
        }else if !movableFig.canMove(from: from, to: to){
            return false
        }
        //4. Clear path?
        let дорожнаяКарта = movableFig.myPath(from: from, to: to)
        if !yourPathVerifier(дорожнаяКарта){
            return false
        }

        return true
    }
    
    func yourPathVerifier(_ дорожнаяКарта: [Point]) -> Bool{
        for точка in дорожнаяКарта{
            if getFigureByPoint(точка) != nil{
                return false
            }
        }
        return true
    }
    
    func clearCell(_ point: Point){
        board[point.digit-1][point.letter.rawValue-1] = nil
    }
    
    func placeFigure(pos: Point, fig: Figure){
        board[pos.digit-1][pos.letter.rawValue-1] = fig
    }
    
    func getFigureByPoint(_ pos: Point) -> Figure?{
        return board[pos.digit-1][pos.letter.rawValue-1]
    }
}
