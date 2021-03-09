//
//  King.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class King: Figure{
    init(_ color: PlayerColor){
        super.init(color, "king")
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
}
