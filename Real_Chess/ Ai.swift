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
    
    func minMax(_ depth: Int, _ isMaximizing: Bool, _ boardController: BoardController) -> Int{
        
        var field = boardController.getBoard()
        
        if depth == 0{
            return -boardScore(field)
        }
        
        var moveList = moveListGenerator(field, Player(.white)) + moveListGenerator(field, Player(.black))
        
        if isMaximizing{
            var bestMove = -9999
            for movePair in moveList{
                //копия игрока
                var whitePlayer = Player(.white)
                //результат хода
                var result = boardController.moveOrEat(movePair.from, movePair.to, whitePlayer)
//                if result.pawnUpgrade != nil{
//                    result.boardCondition.placeFigure(result.pawnUpgrade!.point, Queen(whitePlayer.color))
//                }
                //вызов рекурсии
                bestMove = max(bestMove, minMax(depth-1, !isMaximizing, boardController))
                boardController.undoOnce()
            }
            return bestMove
        }
        var bestMove = 9999
        for movePair in moveList{
            //копия игрока
            var blackPlayer = Player(.black)
            //результат хода
            var result = boardController.moveOrEat(movePair.from, movePair.to, blackPlayer)
//            if result.pawnUpgrade != nil{
//                result.boardCondition.placeFigure(result.pawnUpgrade!.point, Queen(blackPlayer.color))
//            }
            //вызов рекурсии
            bestMove = max(bestMove, minMax(depth-1, !isMaximizing, boardController))
            boardController.undoOnce()
        }
        return bestMove
    }
    
    func лучшийХод(_ field: BoardData, _ normalPlayer: Player, _ aiPlayer: Player) -> FromTooToo{
        var coordsFromTo: FromTooToo?
        var minScore = -100000
        var boardControllerCopy = BoardController(field.copy())
        var isMaximizing = true
        var moveList = moveListGenerator(field, Player(.white)) + moveListGenerator(field, Player(.black))
        for movePair in moveList{
            //копия игрока
            var blackPlayer = Player(.black)
            //результат хода
            var result = boardControllerCopy.moveOrEat(movePair.from, movePair.to, blackPlayer)
            var scoreResult = minMax(2, !isMaximizing, boardControllerCopy)
            boardControllerCopy.undoOnce()
            if scoreResult > minScore{
                minScore = scoreResult
                coordsFromTo = movePair
            }
        }
        
        print(coordsFromTo)
        return coordsFromTo!
    }
    
    func moveScore(_ field: BoardData, _ aiPlayer: Player, _ movePair: FromTooToo) -> Int{
        //копия поля
        var boardController = BoardController(field.copy())
        //копия игрока
        var fakePlayer = aiPlayer.copy()
        //предыдущий счет
        var before = boardScore(field)
        //результат хода
        var result = boardController.moveOrEat(movePair.from, movePair.to, fakePlayer)
        //проверяем что у нас нету шаха и плохого хода
        if result.shakh != nil{ return 100000 }
        if result.status == false{ return 100000 }
        if result.pawnUpgrade != nil{
            result.boardCondition.placeFigure(result.pawnUpgrade!.point, Queen(aiPlayer.color))
        }
        //счет после
        var after = boardScore(result.boardCondition)
        //формируем счет...
        var scoreResult = after - before
        return scoreResult
    }
    
}
struct FromTooToo{
    var from: Point
    var to: Point
}
