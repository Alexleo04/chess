//
//  King.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class King: Figure{
    init(_ color: Color){
        super.init("🤴🏿", color)
    }
    
    func canMove(from: Point, to: Point) -> Bool{
        let digitDiff = from.digit - to.digit;
        let letterDiff = from.letter.rawValue - to.letter.rawValue;
        if digitDiff >= -1 && digitDiff <= 1 && letterDiff <= 1 && letterDiff >= -1{
            return true
        }
        return false
    }
}
