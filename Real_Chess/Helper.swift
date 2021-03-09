//
//  Helper.swift
//  Real_Chess
//
//  Created by Grigorii Merkushev on 3/5/21.
//

import Foundation

class Helper{
    
    // add check letter and digit before creating
    static func createPoint(letterNum: Int, digitNum: Int) -> Point{
        return Point(letter: Letter(rawValue: letterNum) ?? .a, digit: digitNum)
    }
    
    static func getGlyphNameFromFigure(_ figure: Figure?) -> String{
        return figure?.theGlifer ?? "empty_cell"
    }
}
