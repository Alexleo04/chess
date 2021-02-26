//
//  ContentView.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//

//1.Player Turn
//2.Eaten Figures
//3.Error Text

import SwiftUI

//                Cell(color: Color.black, content: board.figureConverterReciever(Point(letter: .a, digit: 8))!.name)

let letters: [Int:String] = [1: "a", 2: "b", 3: "c", 4: "d", 5: "e", 6: "f", 7: "g", 8: "h"]

struct ContentView: View {
    @StateObject var gameController: GameController = GameController()
    
    func clickHandler(point: Point){
        gameController.moveProcessing(point: point)
    }
    
    var body: some View {
        VStack{
            
            HStack(spacing: 0){
                ForEach((1..<9)) { col in
                    HeaderCell(color: Color.white, content: letters[col]!)
                }
            }
            
            ForEach((1..<9)) { row in
                var convertedRow: Int = 9-row
                if convertedRow%2 == 1 {
                    HStack(spacing: 0){
                        HeaderCell(color: Color.white, content: String(convertedRow))
                        ForEach((1..<9)) { col in
                   
                            var testCol: Int = col
                            
                            let point = gameController.board.helperCreatePoint(letterNum: testCol, digitNum: convertedRow)
                            
                            var comparisonRes: Bool = point == gameController.fromClickedCell
                            
                            let cellContent: String = gameController.board.getFigureIconByPoint(point)
                       
                            if col%2 == 1{
                                Cell(color: Color.white, content: cellContent, point: point, funcHandler: clickHandler, isPresed: comparisonRes)
                            }else{
                                Cell(color: Color.black, content: cellContent, point: point, funcHandler: clickHandler, isPresed: comparisonRes)
                            }
                        }
                        HeaderCell(color: Color.white)
                    }
                }else{
                    HStack(spacing: 0){
                        HeaderCell(color: Color.white, content: String(convertedRow))
                        ForEach((1..<9)) { col in
                            var testCol: Int = col
                            
                            let point = gameController.board.helperCreatePoint(letterNum: testCol, digitNum: convertedRow)
                            
                            var comparisonRes: Bool = point == gameController.fromClickedCell
                            
                            let cellContent: String  = gameController.board.getFigureIconByPoint(point)
                                                   
                            if col%2 == 1{
                                Cell(color: Color.black, content: cellContent, point: point, funcHandler: clickHandler, isPresed: comparisonRes)
                            }else{
                                Cell(color: Color.white, content: cellContent, point: point, funcHandler: clickHandler, isPresed: comparisonRes)
                            }
                        }
                        HeaderCell(color: Color.white)
                    }
                }
            }
        }
    }
}

/*letters[point.letter.rawValue]! + ":" + String(point.digit) - cell coords*/
struct Cell: View{
    // what is your coordinate
    var color: Color
    var content: String = ""
    var point: Point
    var funcHandler: (Point) -> Void
    var isPresed: Bool
    var body: some View{
        Button(content) {
            funcHandler(point)
        }
        .frame(width: 37.5, height: 37.5)
        .background(isPresed ? Color.green : color)
        .contentShape(Rectangle())
        .border(Color.black, width: 0.5)
    }
}

struct HeaderCell: View{
    var color: Color
    var content: String = ""
    var body: some View{
        Text(content)
        .frame(width: 37.5, height: 37.5)
        .background(color)
        //.border(Color.black, width: 0.5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
