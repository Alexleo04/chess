//
//  Board.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class Board: ObservableObject{
    @Published private var board: [[Figure?]] = Array(repeating: [nil,nil,nil,nil,nil,nil,nil,nil], count: 8)
    
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

    
    func moveOrEat(_ from: Point, _ to: Point){
        // check if enemy in dest
        let figureInToCell = figureConverterReciever(to)
        let figureInFromCell = figureConverterReciever(from)
        
        if figureInToCell == nil{
            if canMove(from, to, false){
                figureSpawner(pos: to, fig: figureInFromCell!)
                clearCell(from)
            }
        }
        
        // yes -> moveAndEat() - take enemy figure, move your figure
        // no -> move()
    }
           
    func canMove(_ from: Point, _ to: Point, _ isEat: Bool) -> Bool{
        //1. Valiдность обеих точек
        if !isValid(from) || !isValid(to){
            return false
        }
        //2. From != nil? && To = nil?
        let figureInFromCell = figureConverterReciever(from)
        if figureInFromCell == nil {
            return false
        }
        
        // 2.1
        let figureInToCell = figureConverterReciever(to)
        
        if isEat && (figureInToCell == nil || figureInToCell!.color == figureInFromCell!.color) {
            return false
        }
        
        if !isEat && (figureInToCell != nil) {
            return false
        }
        
        //3. can figure move "from" --> "to" (по правилам)?
        let constFig = figureConverterReciever(from)!
        if !constFig.canMove(from: from, to: to){
            return false
        }
        //4. Clear path?
        let дорожнаяКарта = constFig.myPath(from: from, to: to)
        for точка in дорожнаяКарта{
            if figureConverterReciever(точка) != nil{
                return false
            }
        }
        
        // move figure
        
        return true
    }

    func isValid(_ random: Point) -> Bool{
        return random.digit <= 8 && random.digit > 0
    }

    func clearCell(_ point: Point){
        board[point.digit-1][point.letter.rawValue-1] = nil
    }
    
    func figureSpawner(pos: Point, fig: Figure){
        board[pos.digit-1][pos.letter.rawValue-1] = fig
    }
    
    func figureConverterRecieverIcon(_ pos: Point) -> String{
        let figure = figureConverterReciever(pos)
        
        return figure?.name ?? ""
    }
    
    func figureConverterReciever(_ pos: Point) -> Figure?{
        return board[pos.digit-1][pos.letter.rawValue-1]
    }
    
    // add check letter and digit before creating
    func helperCreatePoint(letterNum: Int, digitNum: Int) -> Point{
        return Point(letter: Letter(rawValue: letterNum) ?? .a, digit: digitNum)
    }
    
}
