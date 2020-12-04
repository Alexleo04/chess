//
//  Tower.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class Tower: Figure{
    init(_ color: Color){
        super.init("🏛", color)
    }
    func canMove(from: Point, to: Point) -> Bool {
        if from.digit != to.digit && from.letter != to.letter{
            return false
        }
        return true
    }
}
