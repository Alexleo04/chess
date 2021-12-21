//
//  ContentView.swift
//  Real_Chess
//
//  Created by Juvenna Software on 04/12/2020.
//
import SwiftUI
let colorCellWhite: Color = Color.white
let colorCellBlack: Color = Color.blue

let letters: [Int:String] = [1: "a", 2: "b", 3: "c", 4: "d", 5: "e", 6: "f", 7: "g", 8: "h"]

struct ContentView: View {
    @StateObject var gameController: GameController

    init(aiEnabled: Bool){
        _gameController = StateObject(wrappedValue:GameController(aiEnabled: aiEnabled))
    }
    
    func colorCellGenerator(_ isOdd: Bool, _ isPressed: Bool, _ isUrgent: Bool) -> Color{
        print(isUrgent)
        if isPressed{
            return Color.green
        }
        if isUrgent{
            return Color.red
        }
        if isOdd{
            return Color.blue
        }else{
            return Color.white
        }
    }
    
    func clickHandler(point: Point){
        gameController.moveProcesing(point: point)
    }
    
    func pawnHandler(fig: String){
        gameController.realPawnUpgrade(theChosen: fig)
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
            if gameController.currentPlayer().color == PlayerColor.black{
                
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
                Spacer()
//                HStack{
//                    Spacer()
//                    VStack{
//                        Text("White Score:")
//                        Text(String(gameController.whiteGuy.score))
//                    }
//                    Spacer()
//                    Spacer()
//                    VStack{
//                        Text("Black Score:")
//                        Text(String(gameController.blackGuy.score))
//                    }
//                    Spacer()
//                }
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
                Spacer()
//                HStack{
//                    Spacer()
//                    VStack{
//                        Text("White Score:")
//                        Text(String(gameController.whiteGuy.score))
//                    }
//                    Spacer()
//                    Spacer()
//                    VStack{
//                        Text("Black Score:")
//                        Text(String(gameController.blackGuy.score))
//                    }
//                    Spacer()
//                }
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
                    HStack(spacing: 0){
                        HeaderCell(color: Color.white, content: String(convertedRow))
                        ForEach((1..<9)) { col in
//
                            var column: Int = col
//
                            let point = Helper.createPoint(letterNum: column, digitNum: convertedRow)
                            
                            var realisUrgent: Bool = gameController.isUrgent(point: point)
                            var isPressed: Bool = point == gameController.cellFrom
//
                            let cellContent: String = Helper.getGlyphNameFromFigure(gameController.boardController.getBoard().getFigureByPoint(point))
//
                            var cellColor: Color = colorCellGenerator((col+row)%2 == 1, isPressed, realisUrgent)
                            
//                            if col%2 == 0{
//
//                            }
//
//                            if isPressed{
//                                cellColor = "green"
//                            }
                            
                            Cell(color: cellColor, theGlifer: cellContent, point: point, funcHandler: clickHandler)
                        }
                        HeaderCell(color: Color.white)
                    }
            }
//            Spacer()
//            //Счет
//            HStack(spacing: 0){
//                Text("Score:")
//                Text("00000")
//            }
            
            
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
            Group{
            if gameController.pawnUpgrade{
                HStack(spacing: 0){
                    if gameController.currentPlayer().color == PlayerColor.white{
                        PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_white_queen", funcHandler: pawnHandler, askedFigure: "Queen")
                        PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_white_tower", funcHandler: pawnHandler, askedFigure: "Tower")
                        PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_white_bishop", funcHandler: pawnHandler, askedFigure: "Bishop")
                        PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_white_knight", funcHandler: pawnHandler, askedFigure: "Knight")
                    }
                    if gameController.currentPlayer().color == PlayerColor.black{
                        PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_black_queen", funcHandler: pawnHandler, askedFigure: "Queen")
                        PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_black_tower", funcHandler: pawnHandler, askedFigure: "Tower")
                        PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_black_bishop", funcHandler: pawnHandler, askedFigure: "Bishop")
                        PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_black_knight", funcHandler: pawnHandler, askedFigure: "Knight")
                    }
                }
            }
            Spacer()
            HStack(spacing: 0){
                ForEach((0..<8)) { col in
                    var visualAchiever = gameController.whiteGuy.figureOrNothin(idx: col)
                    let cellGlyph: String = Helper.getGlyphNameFromFigure(visualAchiever)
                    
                    Еaten(color: Color.white, content: cellGlyph)
                }
            }
            }
        }
//        .alert(isPresented: $gameController.shakh) {
//                    Alert(title: Text("Shakh!"), message: Text("This app is meant to be fun for you and your friends. If you get shakh please do not cheat, unless you want to bug your friends!"), dismissButton: .default(Text("Got it!")))
//                }
    }
}

/*letters[point.letter.rawValue]! + ":" + String(point.digit) - cell coords*/
struct Cell: View{
    // what is your coordinate
    var color: Color
    var theGlifer: String = ""
    var point: Point
    var funcHandler: (Point) -> Void
    var body: some View{
        Button(action: {funcHandler(point)}) {
            Image(theGlifer)
                .resizable()
                .scaledToFit()
                .frame(width: 37.5, height: 37.5)
                .padding()
        }
        .frame(width: 37.5, height: 37.5)
        .background(color)
        .contentShape(Rectangle())
        .border(Color.black, width: 0.5)
    }
}

struct PawnUpgradeDemostraitor: View{
    // what is your coordinate
    var color: Color
    var theGlifer: String = ""
    var funcHandler: (String) -> Void
    var askedFigure: String
    var body: some View{
        Button(action: {funcHandler(askedFigure)}) {
            Image(theGlifer)
                .resizable()
                .scaledToFit()
                .frame(width: 37.5, height: 37.5)
                .padding()
        }
        .frame(width: 37.5, height: 37.5)
        .background(color)
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(aiEnabled: false)
//    }
//}

//func getColor(_ color: String) -> Color{
//    switch color {
//    case "green":
//        return Color.green
//    case "white":
//        return Color.white
//    case "blue":
//        return Color.blue
//    default:
//        return Color.white
//    }
//}
