//
//  Board.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class Board{
    private var board: [[Figure?]] = Array(repeating: [nil,nil,nil,nil,nil,nil,nil,nil], count: 8)
    
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
    
    func printBoard(){
        for i in board{
            var line: String = ""
            for j in i{
                if j != nil{
                    line += j!.name
                }else{
                    line += "🎛"
                }
            }
            print(line)
        }
    }

    func canMove(_ from: Point, _ to: Point) -> Bool{
        //1. Valiдность обеих точек
        if !isValid(from) || !isValid(to){
            return false
        }
        //2. From != nil?
        //3. To = nil?
        if figureReciever(from) == nil || figureReciever(to) != nil{
            return false
        }
        //4. can figure move "from" --> "to"?
        var constFig = figureReciever(from)!
        if !constFig.canMove(from: from, to: to){
            return false
        }
    //5. Clear path
        return true
    }

    func isValid(_ random: Point) -> Bool{
        return random.digit <= 8 && random.digit > 0
    }

    func figureSpawner(pos: Point, fig: Figure){
        board[pos.digit-1][pos.letter.rawValue-1] = fig
    }
    func figureReciever(_ pos: Point) -> Figure?{
        return board[pos.digit-1][pos.letter.rawValue-1]
    }
}
