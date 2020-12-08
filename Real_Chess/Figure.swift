//
//  Figure.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
class Figure{
    var name: String
    var color: Color
    init(_ name: String, _ color: Color) {
        self.name = name
        self.color = color
    }
    func canMove(from: Point, to: Point) -> Bool{
        return false
    }
}
