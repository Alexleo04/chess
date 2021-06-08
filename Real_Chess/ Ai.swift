//
//  AiController.swift
//  Real_Chess
//
//  Created by Juvenna Software on 18/05/2021.
//

import Foundation
class Ai{
    func moveListGenerator(_ field: BoardData, _ thePlayer: Player) -> [FromTooToo]{
        var moveList: [FromTooToo] = []
        for m in 1...BoardData.row{
            for t in 1...BoardData.column{
                //получаем точку
                var pointFrom = Helper.createPoint(letterNum: t, digitNum: m)
                //получаем фигуру
                var fig = field.getFigureByPoint(pointFrom)
                //проверяем пустая или нет?
                if fig == nil{ continue }
                //удоставеряемся что цвет не отличается
                if fig!.color != thePlayer.color{ continue }
                //получаем точки куда fig может пойти
                var points = fig!.whereCanImove(pointFrom)
                for point in points{
                    moveList.append(FromTooToo(from: pointFrom, to: point))
                }
            }
        }
        return moveList
    }
    func boardScore(_ field: BoardData) -> Int{
        var totalScore: Int = 0
        for m in 1...BoardData.row{
            for t in 1...BoardData.column{
                //получаем точку
                var pointFrom = Helper.createPoint(letterNum: t, digitNum: m)
                //получаем фигуру
                var fig = field.getFigureByPoint(pointFrom)
                if fig == nil{ continue }
                if fig!.color == PlayerColor.white{
                    totalScore += fig!.weight
                }else{
                    totalScore -= fig!.weight
                }
            }
        }
        return totalScore
    }
    func лучшийХод(_ field: BoardData, _ normalPlayer: Player, _ aiPlayer: Player) -> FromTooToo{
        var coordsFromTo: FromTooToo?
        var maxScore = 100000
        for movePair in moveListGenerator(field, aiPlayer){
            //копия поля
            var boardController = BoardController(field.copy())
            //копия игрока
            var fakePlayer = aiPlayer.copy()
            //предыдущий счет
            var before = boardScore(field)
            //результат хода
            var result = boardController.moveOrEat(movePair.from, movePair.to, fakePlayer)
            //проверяем что у нас нету шаха и плохого хода
            if result.shakh != nil{ continue }
            if result.status == false{ continue }
            if result.pawnUpgrade != nil{ result.boardCondition.placeFigure(result.pawnUpgrade!.point, Queen(aiPlayer.color)) }
            //счет после
            var after = boardScore(result.boardCondition)
            //проверяем счет...
            var scoreResult = after - before
            if scoreResult < maxScore{
                maxScore = scoreResult
                coordsFromTo = movePair
                //...и делаем ход
            }
        }
        
        print(coordsFromTo)
        return coordsFromTo!
    }
    
}
struct FromTooToo{
    var from: Point
    var to: Point
}
