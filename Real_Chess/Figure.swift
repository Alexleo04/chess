//
//  Figure.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation

class Figure{
    var theGlifer: String
    var color: PlayerColor
    var weight: Int
    var wasMoved: Bool = false
    func whereCanImove(_ point: Point) -> [Point]{
        return []
    }
    init(_ color: PlayerColor, _ theGlifer: String, _ weight: Int) {
        self.color = color
        self.weight = weight
        if color == PlayerColor.white{
            self.theGlifer = "figure_white_" + theGlifer
        }else{
            self.theGlifer = "figure_black_" + theGlifer
        }
    }
    func canMove(from: Point, to: Point) -> Bool{
        return false
    }
    func canEat(from: Point, to: Point) -> Bool{
        return canMove(from: from, to: to)
    }
    func myPath(from: Point, to: Point) -> [Point]{
        return []
    }
}
