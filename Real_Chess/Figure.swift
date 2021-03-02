//
//  Figure.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation

class Figure{
    var name: String
    var theGlifer: String
    var color: PlayerColor
    init(_ name: String, _ color: PlayerColor, _ theGlifer: String) {
        self.name = name
        self.color = color
        if color == PlayerColor.white{
            self.theGlifer = "figure_white_" + theGlifer
        }else{
            self.theGlifer = "figure_black_" + theGlifer
        }
    }
    func canMove(from: Point, to: Point) -> Bool{
        return false
    }
    func myPath(from: Point, to: Point) -> [Point]{
        return []
    }
}
