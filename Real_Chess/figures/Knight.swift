//
//  Knight.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class Knight: Figure{
    init(_ color: PlayerColor){
        super.init(color, "knight", 30)
    }

    override func canMove(from: Point, to: Point) -> Bool {
        if from.letter.rawValue == to.letter.rawValue+2 || from.letter.rawValue == to.letter.rawValue-2{
            if from.digit == to.digit+1 || from.digit == to.digit-1{
                return true
            }
        }
        if from.digit == to.digit+2 || from.digit == to.digit-2{
            if from.letter.rawValue == to.letter.rawValue+1 || from.letter.rawValue == to.letter.rawValue-1{
                return true
            }
        }
        return false
    }
    
    override func whereCanImove(_ point: Point) -> [Point] {
        var movableCoords: [Point] = []
        if point.letter != .a && point.digit != 2 && point.digit != 1{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue-1, digitNum: point.digit-2))
        }
        
        if point.letter != .a && point.letter != .b && point.digit != 1{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue-2, digitNum: point.digit-1))
        }
        
        if point.digit != 8 && point.letter != .a && point.letter != .b{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue-2, digitNum: point.digit+1))
        }
        
        if point.digit != 8 && point.digit != 7 && point.letter != .a{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue-1, digitNum: point.digit+2))
        }
        
        if point.digit != 8 && point.digit != 7 && point.letter != .h{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue+1, digitNum: point.digit+2))
        }
        
        if point.letter != .g && point.letter != .h && point.digit != 8{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue+2, digitNum: point.digit+1))
        }
        
        if point.letter != .g && point.letter != .h && point.digit != 1{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue+2, digitNum: point.digit-1))
        }
        
        if point.digit != 2 && point.digit != 1 && point.letter != .h{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue+1, digitNum: point.digit-2))
        }
        return movableCoords;
    }
}
