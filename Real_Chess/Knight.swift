//
//  Knight.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class Knight: Figure{
    init(_ color: PlayerColor){
        super.init("🐎", color)
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
}
