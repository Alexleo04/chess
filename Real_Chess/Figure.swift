//
//  Figure.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class Figure{
    var name: String
    var color: PlayerColor
    init(_ name: String, _ color: PlayerColor) {
        self.name = name
        self.color = color
    }
    func canMove(from: Point, to: Point) -> Bool{
        return false
    }
    func myPath(from: Point, to: Point) -> [Point]{
        return []
    }
}
