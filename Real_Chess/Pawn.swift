//
//  pawn.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class Pawn: Figure{
    init(_ color: Color){
        super.init("🖱", color)
    }

    override func canMove(from: Point, to: Point) -> Bool{
        if from.digit+1 == to.digit && from.letter == to.letter{
            return true
        }
        if from.digit == 2 && to.digit == 4 && from.letter == to.letter{
            return true
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
