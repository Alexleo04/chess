//
//  Point.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

import Foundation
struct Point: Equatable{
    var letter: Letter
    var digit: Int
    func comparer(victim: Point) -> Bool{
        return letter == victim.letter && digit == victim.digit
    }
}
