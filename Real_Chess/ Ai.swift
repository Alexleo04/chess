//
//  AiController.swift
//  Real_Chess
//
//  Created by Juvenna Software on 18/05/2021.
//

import Foundation
class Ai{
    func лучшийХод(_ field: BoardData, _ normalPlayer: Player, _ aiPlayer: Player) -> FromTooToo{
        return FromTooToo(from: Point(letter: .a, digit: 7), to: Point(letter: .a, digit: 5))
    }
}
struct FromTooToo{
    var from: Point
    var to: Point
}
