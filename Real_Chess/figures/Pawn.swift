//
//  pawn.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class Pawn: Figure{
    init(_ color: PlayerColor){
        super.init(color, "pawn", 10)
    }

    override func canMove(from: Point, to: Point) -> Bool{
        if self.color == PlayerColor.white{
            if from.digit+1 == to.digit && from.letter == to.letter{
                return true
            }
            if from.digit == 2 && to.digit == 4 && from.letter == to.letter{
                return true
            }
        }
        if self.color == PlayerColor.black{
            if from.digit-1 == to.digit && from.letter == to.letter{
                return true
            }
            if from.digit == 7 && to.digit == 5 && from.letter == to.letter{
                return true
            }

        }
        return false
    }
    
    override func canEat(from: Point, to: Point) -> Bool {
        if self.color == PlayerColor.white{
            if from.digit+1 == to.digit && from.letter.rawValue - 1 == to.letter.rawValue{
                return true
            }
            if from.digit+1 == to.digit && from.letter.rawValue + 1 == to.letter.rawValue{
                return true
            }
        }
        if self.color == PlayerColor.black{
            if from.digit-1 == to.digit && from.letter.rawValue - 1 == to.letter.rawValue{
                return true
            }
            if from.digit-1 == to.digit && from.letter.rawValue + 1 == to.letter.rawValue{
                return true
            }
        }
        return false
    }
    
    override func myPath(from: Point, to: Point) -> [Point] {
        if from.letter == to.letter && to.digit == 4 && from.digit == 2{
            return [Point(letter: from.letter, digit: 3)]
        }
        return []
    }
}
