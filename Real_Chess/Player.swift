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
    var score: Int = 0
    func warehouseWorth() -> Int {
        var tempWeight = 0
        if warehouse.count == 0{
            return 0
        }
        for i in 0...warehouse.count-1{
            tempWeight += warehouse[i].weight
        }
        return tempWeight
    }
    func archieve(eaten: Figure){
        warehouse.append(eaten)
    }
    func figureOrNothin(idx: Int) -> Figure?{
        if warehouse.count > idx{
            return warehouse[idx]
        }
        return nil
    }
    func copy() -> Player{
        var copy = Player(color)
        copy.warehouse = warehouse
        copy.score = score
        return copy
    }
    init(_ color: PlayerColor) {
        self.color = color
        warehouse = []
    }
}
