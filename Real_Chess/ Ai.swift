//
//  AiController.swift
//  Real_Chess
//
//  Created by Juvenna Software on 18/05/2021.
//

import Foundation
class Ai{
    func лучшийХод(_ field: BoardData, _ normalPlayer: Player, _ aiPlayer: Player) -> FromTooToo{
        var result: FromTooToo?
        var maxScore = -100000
        for m in 0...BoardData.row-1{
            for t in 0...BoardData.column-1{
                var pointFrom = Helper.createPoint(letterNum: t+1, digitNum: m+1)
                var fig = field.getFigureByPoint(pointFrom)
                if fig == nil{ continue }
                if fig!.color != aiPlayer.color{ continue }
                var points = fig!.whereCanImove(pointFrom)
                for point in points{
                    var boardController = BoardController(field.copy())
                    var fakePlayer = aiPlayer.copy()
                    var before = fakePlayer.warehouseWorth()
                    boardController.moveOrEat(pointFrom, point, fakePlayer)
                    var after = fakePlayer.warehouseWorth()
                    var scoreResult = after - before
                    if scoreResult > maxScore{
                        maxScore = scoreResult
                        result = FromTooToo(from: pointFrom, to: point)
                    }
                }
            }
        }
        return result!
    }
    
}
struct FromTooToo{
    var from: Point
    var to: Point
}
