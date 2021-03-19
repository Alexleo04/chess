//
//  Board.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class Board: ObservableObject{
    @Published private var board: [[Figure?]] = Array(repeating: [nil,nil,nil,nil,nil,nil,nil,nil], count: 8)
    
    func getBoard() -> [[Figure?]]{
        return board
    }
    
    init(){
        fillBoard()
    }
    
    func fillBoard(){
        board[0][0] = Tower(.white)
        board[0][1] = Knight(.white)
        board[0][2] = Bishop(.white)
        board[0][3] = Queen(.white)
        board[0][4] = King(.white)
        board[0][5] = Bishop(.white)
        board[0][6] = Knight(.white)
        board[0][7] = Tower(.white)

        board[7][0] = Tower(.black)
        board[7][1] = Knight(.black)
        board[7][2] = Bishop(.black)
        board[7][3] = Queen(.black)
        board[7][4] = King(.black)
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
    
    func moveOrEat(_ from: Point, _ to: Point, _ thePlayer: Player) -> Bool{
        // check if enemy in dest
        let figureInToCell = getFigureByPoint(to)
        let figureInFromCell = getFigureByPoint(from)
        
        if figureInFromCell?.color != thePlayer.color{
            return false
        }
        
        if figureInToCell == nil{
            //MOVE
            if canMove(from, to, false){
                figureInFromCell!.wasMoved = true
                placeFigure(pos: to, fig: figureInFromCell!)
                clearCell(from)
                return true
            }
            return false
        }else{
            //EAT
            if canMove(from, to, true){
                thePlayer.archieve(eaten: getFigureByPoint(to)!)
                clearCell(to)
                placeFigure(pos: to, fig: figureInFromCell!)
                clearCell(from)
                return true
            }
            return false
        }
        
        return false
     }
    
    func castling(_ kingPoint: Point, _ towerPoint: Point) -> Bool{
        //1.wasMoved?
        if !kingPoint.isValid() || !towerPoint.isValid(){
            return false
        }
        let kingFig = getFigureByPoint(kingPoint)
        if kingFig == nil {
            return false
        }
        let towerFig = getFigureByPoint(towerPoint)
        if towerFig == nil {
            return false
        }
        if kingFig?.wasMoved || towerFig?.wasMoved{
            return false
        }
        //2.Узнать тип ракировки
        
        //3.Свободен путь?
        //4.Ракируем
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
        // if iseat = false and "to" != nil
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
