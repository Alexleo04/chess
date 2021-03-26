//
//  Queen.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class Queen: Figure{
    init(_ color: PlayerColor){
        super.init(color, "queen", 90)
    }

    override func canMove(from: Point, to: Point) -> Bool {
        if from.digit - to.digit == from.letter.rawValue - to.letter.rawValue{
            return true
        }
        if from.digit - to.digit == -(from.letter.rawValue - to.letter.rawValue){
            return true
        }
        if from.digit != to.digit && from.letter == to.letter{
            return true
        }
        if from.digit == to.digit && from.letter != to.letter{
            return true
        }
        return false
    }

    override func myPath(from: Point, to: Point) -> [Point] {
        if from.letter == to.letter || from.digit == to.digit{
            let tower: Tower = Tower(color)
            return tower.myPath(from: from, to: to)
        }
        let bishop: Bishop = Bishop(color)
        return bishop.myPath(from: from, to: to)
    }
}
