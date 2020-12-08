//
//  Bishop.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class Bishop: Figure{
    init(_ color: Color){
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
}
