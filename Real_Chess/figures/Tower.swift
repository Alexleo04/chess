//
//  Tower.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class Tower: Figure{
    init(_ color: PlayerColor){
        super.init(color, "tower", 50)
    }

    override func canMove(from: Point, to: Point) -> Bool {
        if from.digit != to.digit && from.letter != to.letter{
            return false
        }
        return true
    }
    override func myPath(from: Point, to: Point) -> [Point]{
        var distancePro: [Point] = []
        if from.letter == to.letter {
            if to.digit > from.digit {
                var distance = to.digit - from.digit - 1
                if distance == 0{
                    return []
                }
                for i in 1...distance {
                    distancePro.append(Point(letter: from.letter, digit: from.digit + i))
                }
            } else if from.digit > to.digit {
                var distance = from.digit - to.digit - 1
                if distance == 0{
                    return []
                }
                for i in 1...distance {
                    distancePro.append(Point(letter: from.letter, digit: from.digit - i))
                }
            }
        }
        if from.digit == to.digit {
            if to.letter.rawValue > from.letter.rawValue {
                var distance = to.letter.rawValue - from.letter.rawValue - 1
                if distance == 0{
                    return []
                }
                for i in 1...distance {
                    distancePro.append(Point(letter: Letter(rawValue: from.letter.rawValue + i)!, digit: from.digit))
                }
            } else if from.letter.rawValue > to.letter.rawValue {
                var distance = from.letter.rawValue - to.letter.rawValue - 1
                if distance == 0{
                    return []
                }
                for i in 1...distance {
                    distancePro.append(Point(letter: Letter(rawValue: from.letter.rawValue - i)!, digit: from.digit))
                }
            }
        }
        return distancePro
    }
}
