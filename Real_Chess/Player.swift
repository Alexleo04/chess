//
//  Player.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 26/02/2021.
//

import Foundation

class Player{
    var color: PlayerColor;
    var warehouse: [Figure]
    func archieve(eaten: Figure){
        warehouse.append(eaten)
    }
    func figureOrNothin(idx: Int) -> Figure?{
        if warehouse.count > idx{
            return warehouse[idx]
        }
        return nil
    }
    init(_ color: PlayerColor) {
        self.color = color
        warehouse = []
    }
}
