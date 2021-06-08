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
    
    override func whereCanImove(_ point: Point) -> [Point] {
        var movableCoords: [Point] = []
        for t in 1...BoardData.row{
            if t != point.digit{
                movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue, digitNum: t))
            }
        }
        for m in 1...BoardData.column{
            if m != point.letter.rawValue{
                movableCoords.append(Helper.createPoint(letterNum: m, digitNum: point.digit))
            }
        }
        for m in 1...8{
            if point.letter.rawValue+m <= 8 && point.digit+m <= 8{
                movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue+m, digitNum: point.digit+m))
            }
            if point.letter.rawValue+m <= 8 && point.digit-m >= 1{
                movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue+m, digitNum: point.digit-m))
            }
            if point.letter.rawValue-m >= 1 && point.digit+m <= 8{
                movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue-m, digitNum: point.digit+m))
            }
            if point.letter.rawValue-m >= 1 && point.digit-m >= 1{
                movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue-m, digitNum: point.digit-m))
            }
        }
        return movableCoords;
    }
}
