//
//  Bishop.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class Bishop: Figure{
    init(_ color: PlayerColor){
        super.init("🐘", color)
    }

    override func canMove(from: Point, to: Point) -> Bool {
        if from.digit - to.digit == from.letter.rawValue - to.letter.rawValue{
            return true
        }
        if from.digit - to.digit == -(from.letter.rawValue - to.letter.rawValue){
            return true
        }
        return false
    }

    override func myPath(from: Point, to: Point) -> [Point]{
        var distancePro: [Point] = []
        if from.digit - to.digit == from.letter.rawValue - to.letter.rawValue{
            if to.digit > from.digit{
                var distance = to.digit - from.digit - 1
                if distance == 0{
                    return []
                }
                for i in 1...distance{
                    distancePro.append(Point(letter: Letter(rawValue: from.letter.rawValue + i)!, digit: from.digit + i))
                }
            }
            if to.digit < from.digit{
                var distance = from.digit - to.digit - 1
                if distance == 0{
                    return []
                }
                for i in 1...distance{
                    distancePro.append(Point(letter: Letter(rawValue: from.letter.rawValue - i)!, digit: from.digit - i))
                }
            }
        }
        else{
            if to.digit > from.digit{
                var distance = to.digit - from.digit - 1
                if distance == 0{
                    return []
                }
                for i in 1...distance{
                    distancePro.append(Point(letter: Letter(rawValue: from.letter.rawValue - i)!, digit: from.digit + i))
                }
            }
            if to.digit < from.digit{
                var distance = from.digit - to.digit - 1
                if distance == 0{
                    return []
                }
                for i in 1...distance{
                    distancePro.append(Point(letter: Letter(rawValue: from.letter.rawValue + i)!, digit: from.digit - i))
                }
            }
        }
        return distancePro
    }
}
//d4 e5 f6
