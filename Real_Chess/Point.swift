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
    func isValid() -> Bool{
        return digit <= 8 && digit > 0
    }
}
