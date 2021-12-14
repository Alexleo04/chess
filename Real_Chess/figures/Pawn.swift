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
    
    override func whereCanImove(_ point: Point) -> [Point]{
        var movableCoords: [Point] = []
        var raceDirection: Int = 1
        if self.color == PlayerColor.black{
            raceDirection = -1
        }
        movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue, digitNum: point.digit+raceDirection))
        if point.letter != .a{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue-1, digitNum: point.digit+raceDirection))
        }
        if point.letter != .h{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue+1, digitNum: point.digit+raceDirection))
        }
        if (self.color == PlayerColor.white && point.digit == 2) || (self.color == PlayerColor.black && point.digit == 7){
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue, digitNum: point.digit+2*raceDirection))
        }
        return movableCoords;
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
