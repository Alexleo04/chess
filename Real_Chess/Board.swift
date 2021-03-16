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
        board[0][3] = King(.white)
        board[0][4] = Queen(.white)
        board[0][5] = Bishop(.white)
        board[0][6] = Knight(.white)
        board[0][7] = Tower(.white)

        board[7][0] = Tower(.black)
        board[7][1] = Knight(.black)
        board[7][2] = Bishop(.black)
        board[7][3] = King(.black)
        board[7][4] = Queen(.black)
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
           
    func canMove(_ from: Point, _ to: Point, _ isEat: Bool) -> Bool{
        //1. Valiдность обеих точек
        if !from.isValid() || !to.isValid(){
            return false
        }
        //2. From != nil? && To = nil?
        let figureInFromCell = getFigureByPoint(from)
        if figureInFromCell == nil {
            return false
        }
        
        // 2.1
        let figureInToCell = getFigureByPoint(to)
        
        if isEat && (figureInToCell == nil || figureInToCell!.color == figureInFromCell!.color) {
            return false
        }
        
        if !isEat && (figureInToCell != nil) {
            return false
        }
        
        //3. can figure move "from" --> "to" (по правилам)?
        let constFig = getFigureByPoint(from)!
        if !constFig.canMove(from: from, to: to){
            return false
        }
        //4. Clear path?
        let дорожнаяКарта = constFig.myPath(from: from, to: to)
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
