//
//  Board.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class BoardController: ObservableObject{
    var trueData: BoardData
    
    func getBoard() -> BoardData{
        return trueData
    }
    
    init(_ boarddata: BoardData){
        trueData = boarddata
    }
    
    init(){
        trueData = BoardData()
        fillBoard()
    }
    
    func fillBoard(){
        trueData.placeFigure(Point(letter: .a, digit: 1), Tower(.white))
        trueData.placeFigure(Point(letter: .g, digit: 1), Knight(.white))
        trueData.placeFigure(Point(letter: .f, digit: 1), Bishop(.white))
        trueData.placeFigure(Point(letter: .e, digit: 1), Queen(.white))
        trueData.placeFigure(Point(letter: .d, digit: 1), King(.white))
        trueData.placeFigure(Point(letter: .c, digit: 1), Bishop(.white))
        trueData.placeFigure(Point(letter: .b, digit: 1), Knight(.white))
        trueData.placeFigure(Point(letter: .h, digit: 1), Tower(.white))

        trueData.placeFigure(Point(letter: .h, digit: 8), Tower(.black))
        trueData.placeFigure(Point(letter: .g, digit: 8), Knight(.black))
        trueData.placeFigure(Point(letter: .f, digit: 8), Bishop(.black))
        trueData.placeFigure(Point(letter: .e, digit: 8), Queen(.black))
        trueData.placeFigure(Point(letter: .d, digit: 8), King(.black))
        trueData.placeFigure(Point(letter: .c, digit: 8), Bishop(.black))
        trueData.placeFigure(Point(letter: .b, digit: 8), Knight(.black))
        trueData.placeFigure(Point(letter: .a, digit: 8), Tower(.black))

        for j in 0...BoardData.row{
            trueData.placeFigure(Helper.createPoint(letterNum: j, digitNum: 2), Pawn(.white))
        }
        for j in 0...BoardData.row{
            trueData.placeFigure(Helper.createPoint(letterNum: j, digitNum: 7), Pawn(.black))
        }
    }
    
    func moveOrEat(_ from: Point, _ to: Point, _ thePlayer: Player) -> HodResult{
        var testHodResult = moveOrEatInternal(from, to, thePlayer.copy(), trueData.copy())
        var isShakh = shakhDetector(thePlayer.color, testHodResult.boardCondition)
        if isShakh == nil{
            return moveOrEatInternal(from, to, thePlayer, trueData)
        }
        return HodResult.init(status: false, shakh: nil, pawnUpgrade: nil, boardCondition: trueData)
    }
    
    func moveOrEatInternal(_ from: Point, _ to: Point, _ thePlayer: Player, _ data: BoardData) -> HodResult{
        // check if enemy in dest
        let figureInToCell = data.getFigureByPoint(to)
        let figureInFromCell = data.getFigureByPoint(from)
        let hostileColor = thePlayer.color == PlayerColor.black ? PlayerColor.white : PlayerColor.black
        
        if figureInFromCell?.color != thePlayer.color{
            return HodResult(status: false, shakh: shakhDetector(hostileColor, data), pawnUpgrade: nil, boardCondition: data)
        }
        if figureInFromCell! is King {
            if castling(from, to, data){
                return HodResult(status: true, shakh: shakhDetector(hostileColor, data), pawnUpgrade: nil, boardCondition: data)
            }
        }
        if figureInToCell == nil{
            //MOVE
            if canMove(from, to, false, data){
                figureInFromCell!.wasMoved = true
                data.placeFigure(to, figureInFromCell!)
                data.clearCell(from)
                //1.figureInFromCell = пешка?
                //2.to = 8 или 1
                if figureInFromCell is Pawn && (to.digit == 8 || to.digit == 1){
                    //3.Pawn Upgrade
                    return HodResult(status: true, shakh: shakhDetector(hostileColor, data), pawnUpgrade: PawnUpgrade(point: to), boardCondition: data)
                }
                
                return HodResult(status: true, shakh: shakhDetector(hostileColor, data), pawnUpgrade: nil, boardCondition: data)
            }
            return HodResult(status: false, shakh: shakhDetector(hostileColor, data), pawnUpgrade: nil, boardCondition: data)
        }else{
            //EAT
            if canMove(from, to, true, data){
                thePlayer.archieve(eaten: data.getFigureByPoint(to)!)
                data.clearCell(to)
                data.placeFigure(to, figureInFromCell!)
                data.clearCell(from)
                //1.figureInFromCell = пешка?
                //2.to = 8 или 1
                if figureInFromCell is Pawn && (to.digit == 8 || to.digit == 1){
                    //3.Pawn Upgrade
                    return HodResult(status: true, shakh: shakhDetector(hostileColor, data), pawnUpgrade: PawnUpgrade(point: to), boardCondition: data)
                }
                return HodResult(status: true, shakh: shakhDetector(hostileColor, data), pawnUpgrade: nil, boardCondition: data)
            }
            return HodResult(status: false, shakh: shakhDetector(hostileColor, data), pawnUpgrade: nil, boardCondition: data)
        }
        return HodResult(status: false, shakh: shakhDetector(hostileColor, data), pawnUpgrade: nil, boardCondition: data)
     }
    
    func shakhDetector(_ color: PlayerColor, _ data: BoardData) -> Shakh?{
        //где король?
        //какого цвета?
        var kingCoords: Point? = nil
        for i in 0...BoardData.row-1{
            for j in 0...BoardData.column-1{
                var isKing = data.getFigureByPoint(Helper.createPoint(letterNum: j+1, digitNum: i+1))
                if isKing is King && isKing!.color == color{
                    kingCoords = Helper.createPoint(letterNum: j+1, digitNum: i+1)
                }
            }
        }
        if kingCoords == nil{
            return nil
        }
        for i in 1...8{
            //вертикаль
            var hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue, digitNum: i)
            if canMove(hostileCoords, kingCoords!, true, data){
                return Shakh(king: kingCoords!, kingColor: color, hostile: hostileCoords)
            }
            //горизонталь
            hostileCoords = Helper.createPoint(letterNum: i, digitNum: kingCoords!.digit)
            if canMove(hostileCoords, kingCoords!, true, data){
                return Shakh(king: kingCoords!, kingColor: color, hostile: hostileCoords)
            }
        }
        //правая-верхняя
        var hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue, digitNum: kingCoords!.digit)
        while hostileCoords.digit + 1 <= 8 && hostileCoords.letter.rawValue + 1 <= 8{
            hostileCoords = Helper.createPoint(letterNum: hostileCoords.letter.rawValue+1, digitNum: hostileCoords.digit+1)
            if canMove(hostileCoords, kingCoords!, true, data){
                return Shakh(king: kingCoords!, kingColor: color, hostile: hostileCoords)
            }
        }
        //левая-верхняя
        hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue, digitNum: kingCoords!.digit)
        while hostileCoords.digit + 1 <= 8 && hostileCoords.letter.rawValue - 1 >= 1{
            hostileCoords = Helper.createPoint(letterNum: hostileCoords.letter.rawValue-1, digitNum: hostileCoords.digit+1)
            if canMove(hostileCoords, kingCoords!, true, data){
                return Shakh(king: kingCoords!, kingColor: color, hostile: hostileCoords)
            }
        }
        //левая-нижняя
        hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue, digitNum: kingCoords!.digit)
        while hostileCoords.digit - 1 >= 1 && hostileCoords.letter.rawValue - 1 >= 1{
            hostileCoords = Helper.createPoint(letterNum: hostileCoords.letter.rawValue-1, digitNum: hostileCoords.digit-1)
            if canMove(hostileCoords, kingCoords!, true, data){
                return Shakh(king: kingCoords!, kingColor: color, hostile: hostileCoords)
            }
        }
        //правая-нижняя
        hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue, digitNum: kingCoords!.digit)
        while hostileCoords.digit - 1 >= 1 && hostileCoords.letter.rawValue + 1 <= 8{
            hostileCoords = Helper.createPoint(letterNum: hostileCoords.letter.rawValue+1, digitNum: hostileCoords.digit-1)
            if canMove(hostileCoords, kingCoords!, true, data){
                return Shakh(king: kingCoords!, kingColor: color, hostile: hostileCoords)
            }
        }
        //Конь 1
        hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue+1, digitNum: kingCoords!.digit+2)
        if canMove(hostileCoords, kingCoords!, true, data){
            return Shakh(king: kingCoords!, kingColor: color, hostile: hostileCoords)
        }
        
        //Конь 2
        hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue+2, digitNum: kingCoords!.digit+1)
        if canMove(hostileCoords, kingCoords!, true, data){
            return Shakh(king: kingCoords!, kingColor: color, hostile: hostileCoords)
        }
        
        //Конь 3
        hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue+2, digitNum: kingCoords!.digit-1)
        if canMove(hostileCoords, kingCoords!, true, data){
            return Shakh(king: kingCoords!, kingColor: color, hostile: hostileCoords)
        }
        
        //Конь 4
        hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue+1, digitNum: kingCoords!.digit-2)
        if canMove(hostileCoords, kingCoords!, true, data){
            return Shakh(king: kingCoords!, kingColor: color, hostile: hostileCoords)
        }
        
        //Конь 5
        hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue-1, digitNum: kingCoords!.digit-2)
        if canMove(hostileCoords, kingCoords!, true, data){
            return Shakh(king: kingCoords!, kingColor: color, hostile: hostileCoords)
        }
        
        //Конь 6
        hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue-2, digitNum: kingCoords!.digit-1)
        if canMove(hostileCoords, kingCoords!, true, data){
            return Shakh(king: kingCoords!, kingColor: color, hostile: hostileCoords)
        }
        
        //Конь 7
        hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue-2, digitNum: kingCoords!.digit+1)
        if canMove(hostileCoords, kingCoords!, true, data){
            return Shakh(king: kingCoords!, kingColor: color, hostile: hostileCoords)
        }
        
        //Конь 8
        hostileCoords = Helper.createPoint(letterNum: kingCoords!.letter.rawValue-1, digitNum: kingCoords!.digit+2)
        if canMove(hostileCoords, kingCoords!, true, data){
            return Shakh(king: kingCoords!, kingColor: color, hostile: hostileCoords)
        }
        
        return nil
        //идет ли по вертекали способная фигура?
        //идет ли по диагонали способная фигура?
        //конь?
    }
    
    func castling(_ kingPoint: Point, _ targetPoint: Point, _ data: BoardData) -> Bool{
        func castlingKind(_ towerCoordStart: Point, _ kingCoordStart: Point, _ towerCoordEnd: Point, _ kingCoordEnd: Point) -> Bool{
            let towerFig = data.getFigureByPoint(towerCoordStart)
            if towerFig == nil && towerFig!.wasMoved{
                return false
            }
            if !yourPathVerifier(towerFig!.myPath(from: kingCoordStart, to: towerCoordStart), data){
                return false
            }
            data.placeFigure(kingCoordEnd, kingFig!)
            data.placeFigure(towerCoordEnd, towerFig!)
            data.clearCell(kingCoordStart)
            data.clearCell(towerCoordStart)
            return true
        }
        //1.wasMoved?
        if !kingPoint.isValid() || !targetPoint.isValid(){
            return false
        }
        let kingFig = data.getFigureByPoint(kingPoint)
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
    
    func canMove(_ from: Point, _ to: Point, _ isEat: Bool, _ data: BoardData) -> Bool{
        //1. Valiдность обеих точек
        if !from.isValid() || !to.isValid(){
            return false
        }
        //2. From != nil?
        let figureInFromCell = data.getFigureByPoint(from)
        if figureInFromCell == nil {
            return false
        }
        
        // 2.1 get fig from "to"
        let figureInToCell = data.getFigureByPoint(to)
        // if iseat = true and our fig or empty "to"
        if isEat && (figureInToCell == nil || figureInToCell!.color == figureInFromCell!.color) {
            return false
        }
        // if isEat = false and "to" != nil
        if !isEat && (figureInToCell != nil) {
            return false
        }
        
        //3. can figure move "from" --> "to" (по правилам)?
        let movableFig = data.getFigureByPoint(from)!
        if isEat{
            if !movableFig.canEat(from: from, to: to){
                return false
            }
        }else if !movableFig.canMove(from: from, to: to){
            return false
        }
        //4. Clear path?
        let дорожнаяКарта = movableFig.myPath(from: from, to: to)
        if !yourPathVerifier(дорожнаяКарта, data){
            return false
        }

        return true
    }
    
    func yourPathVerifier(_ дорожнаяКарта: [Point], _ данные: BoardData) -> Bool{
        for точка in дорожнаяКарта{
            if данные.getFigureByPoint(точка) != nil{
                return false
            }
        }
        return true
    }
}
