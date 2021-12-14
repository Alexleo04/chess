//
//  King.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class King: Figure{
    init(_ color: PlayerColor){
        super.init(color, "king", 900)
    }

    override func canMove(from: Point, to: Point) -> Bool{
        let digitDiff = from.digit - to.digit;
        let letterDiff = from.letter.rawValue - to.letter.rawValue;
        if digitDiff >= -1 && digitDiff <= 1 && letterDiff <= 1 && letterDiff >= -1{
            return true
        }
        return false
    }
    
    override func myPath(from: Point, to: Point) -> [Point]{
        return []
    }
    
    override func whereCanImove(_ point: Point) -> [Point] {
        var movableCoords: [Point] = []
        if point.letter != .a && point.digit != 8{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue-1, digitNum: point.digit+1))
        }
        
        if point.letter != .h && point.digit != 8{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue+1, digitNum: point.digit+1))
        }
        
        if point.digit != 8{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue, digitNum: point.digit+1))
        }
        
        if point.letter != .a{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue-1, digitNum: point.digit))
        }
        
        if point.letter != .a && point.digit != 1{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue-1, digitNum: point.digit-1))
        }
        
        if point.letter != .h && point.digit != 1{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue+1, digitNum: point.digit-1))
        }
        
        if point.digit != 1{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue, digitNum: point.digit-1))
        }
        
        if point.letter != .h{
            movableCoords.append(Helper.createPoint(letterNum: point.letter.rawValue+1, digitNum: point.digit))
        }
        return movableCoords;
    }
}
