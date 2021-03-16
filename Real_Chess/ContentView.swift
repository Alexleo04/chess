//
//  ContentView.swift
//  Real_Chess
//
//  Created by Aleksey Leonov on 04/12/2020.
//
import SwiftUI
let colorCellWhite: Color = Color.white
let colorCellBlack: Color = Color.blue

let letters: [Int:String] = [1: "a", 2: "b", 3: "c", 4: "d", 5: "e", 6: "f", 7: "g", 8: "h"]

struct ContentView: View {
    @StateObject var gameController: GameController = GameController()
    
    func clickHandler(point: Point){
        gameController.moveSelector(point: point)
    }
    
    var body: some View {
        VStack{
            //отображение съедания черными
                
            HStack(spacing: 0){
                ForEach((0..<8)) { idx in
                    var visualAchiever = gameController.blackGuy.figureOrNothin(idx: idx)//съедание черными
                    let cellGlyph: String = Helper.getGlyphNameFromFigure(visualAchiever)
                    Еaten(color: Color.white, content: cellGlyph)//отрисoвка
                }
            }
                
            if gameController.blackGuy.warehouse.count > 8{
                
                HStack(spacing: 0){
                    ForEach((8..<16)) { idx in
                        var visualAchiever = gameController.blackGuy.figureOrNothin(idx: idx)//съедание черными
                        let cellGlyph: String = Helper.getGlyphNameFromFigure(visualAchiever)
                        Еaten(color: Color.white, content: cellGlyph)//отрисoвка
                    }
                }
            }
            Spacer()
            //ресуем чей ход
            if gameController.playerSelector().color == PlayerColor.black{
                HStack{
                    Spacer()
                    Text("Black's")
                        .foregroundColor(Color.white)
                        .padding(5)
                        .border(Color.black, width: 0.5)
                        .background(Color.black)
                    Text(" turn")
                    Spacer()
                }
            }else{
                HStack{
                    Spacer()
                    Text("White's")
                        .foregroundColor(Color.black)
                        .padding(5)
                        .border(Color.black, width: 0.5)
                        .background(Color.white)
                    Text(" turn")
                    Spacer()
                }
            }
            Spacer()
            HStack(spacing: 0){
                ForEach((1..<9)) { col in
                    //рисуем буквы
                    HeaderCell(color: Color.white, content: letters[col]!)
                }
            }
            ForEach((1..<9)) { row in
                // we need to count in reverse as board have 8 -> 1 numeration
                var convertedRow: Int = 9-row
                if convertedRow%2 == 1 {
                    HStack(spacing: 0){
                        HeaderCell(color: Color.white, content: String(convertedRow))
                        ForEach((1..<9)) { col in
                   
                            var column: Int = col
                            
                            let point = Helper.createPoint(letterNum: column, digitNum: convertedRow)
                            
                            var comparisonRes: Bool = point == gameController.fromClickedCell
                            
                            let cellContent: String = Helper.getGlyphNameFromFigure(gameController.board.getFigureByPoint(point))
                       
                            if col%2 == 1{
                                Cell(color: colorCellWhite, theGlifer: cellContent, point: point, funcHandler: clickHandler, isPresed: comparisonRes)
                            }else{
                                Cell(color: colorCellBlack, theGlifer: cellContent, point: point, funcHandler: clickHandler, isPresed: comparisonRes)
                            }
                        }
                        HeaderCell(color: Color.white)
                    }
                }else{
                    HStack(spacing: 0){
                        HeaderCell(color: Color.white, content: String(convertedRow))
                        // we need to count in reverse as board have 8 -> 1 numeration
                        ForEach((1..<9)) { col in
                            var column: Int = col
                            
                            let point = Helper.createPoint(letterNum: column, digitNum: convertedRow)
                            
                            var comparisonRes: Bool = point == gameController.fromClickedCell
                            
                            let cellContent: String = Helper.getGlyphNameFromFigure(gameController.board.getFigureByPoint(point))
                                                   
                            if col%2 == 1{
                                Cell(color: colorCellBlack, theGlifer: cellContent, point: point, funcHandler: clickHandler, isPresed: comparisonRes)
                            }else{
                                Cell(color: colorCellWhite, theGlifer: cellContent, point: point, funcHandler: clickHandler, isPresed: comparisonRes)
                            }
                        }
                        HeaderCell(color: Color.white)
                    }
                }
            }
            Spacer()
            if gameController.whiteGuy.warehouse.count > 8{
                
                HStack(spacing: 0){
                    ForEach((8..<16)) { idx in
                        var visualAchiever = gameController.whiteGuy.figureOrNothin(idx: idx)//съедание черными
                        let cellGlyph: String = Helper.getGlyphNameFromFigure(visualAchiever)
                        Еaten(color: Color.white, content: cellGlyph)//отрисoвка
                    }
                }
            }
            HStack(spacing: 0){
                ForEach((0..<8)) { col in
                    var visualAchiever = gameController.whiteGuy.figureOrNothin(idx: col)
                    let cellGlyph: String = Helper.getGlyphNameFromFigure(visualAchiever)
                    
                    Еaten(color: Color.white, content: cellGlyph)
                }
            }
        }
    }
}

/*letters[point.letter.rawValue]! + ":" + String(point.digit) - cell coords*/
struct Cell: View{
    // what is your coordinate
    var color: Color
    var theGlifer: String = ""
    var point: Point
    var funcHandler: (Point) -> Void
    var isPresed: Bool
    var body: some View{
        Button(action: {funcHandler(point)}) {
            Image(theGlifer)
                .resizable()
                .scaledToFit()
                .frame(width: 37.5, height: 37.5)
                .padding()
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

struct Еaten: View{
    var color: Color
    var content: String = ""
    var body: some View{
        Button(action: {}) {
            Image(content)
                .resizable()
                .scaledToFit()
                .frame(width: 37.5, height: 37.5)
                .padding()
        }
        .frame(width: 37.5, height: 37.5)
        .contentShape(Rectangle())
        .border(Color.black, width: 0.5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

