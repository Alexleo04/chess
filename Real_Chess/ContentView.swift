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
        ZStack{
            Image("chess_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            
        
        VStack{
            //отображение съедания черными
                
            
            
            Spacer()
            
            //ресуем чей ход
//            if gameController.currentPlayer().color == PlayerColor.black{
//
//                HStack{
//                    Spacer()
//
//                    Text("Black's")
//                        .foregroundColor(Color.white)
//                        .padding(5)
//                        .border(Color.black, width: 0.5)
//                        .background(Color.black)
//                    Text(" turn")
//                    Spacer()
//                }
//                Spacer()
//            }else{
//                HStack{
//                    Spacer()
//                    Text("White's")
//                        .foregroundColor(Color.black)
//                        .padding(5)
//                        .border(Color.black, width: 0.5)
//                        .background(Color.white)
//                    Text(" turn")
//                    Spacer()
//                }
//                Spacer()
//            }
            Spacer()
            
            Board(gameController: gameController, clickHandler: clickHandler)
            
            Spacer()
            Group{
            if gameController.pawnUpgrade{
                PawnUpgradeView(player: gameController.currentPlayer(), pawnHandler: pawnHandler)
            }
            Spacer()
                
            }
        }
        VStack{
            BenchOfEatenFigures(player: $gameController.blackGuy, isActive: gameController.currentPlayer().color == PlayerColor.black || gameController.aiEnabled, isRotated: gameController.aiEnabled).rotationEffect(.degrees(-180))
            
            Spacer()
            
            BenchOfEatenFigures(player: $gameController.whiteGuy, isActive: gameController.currentPlayer().color == PlayerColor.white, isRotated: false)
        }
        .ignoresSafeArea()
    }
//        .background(Color.green)
//        .edgesIgnoringSafeArea(.bottom)
//        .edgesIgnoringSafeArea(.top)
//        .alert(isPresented: $gameController.shakh) {
//                    Alert(title: Text("Shakh!"), message: Text("This app is meant to be fun for you and your friends. If you get shakh please do not cheat, unless you want to bug your friends!"), dismissButton: .default(Text("Got it!")))
//                }
    }
}

struct Cell: View{
    // what is your coordinate
    var isRotated: Bool
    var isDark: Bool
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
            .rotationEffect(.degrees(isRotated ? -180 : 0))
          
        }
        .frame(width: 37.5, height: 37.5)
//        .background(
//            Image(isDark ? "dark_cell" : "normal_cell")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 37.5, height: 37.5)
//                .padding(0)
//        )
        .contentShape(Rectangle())
        //.border(Color.black, width: 0.5)
    }
}

struct BenchOfEatenFigures: View{
    @Binding var player: Player
    var isActive: Bool
    var isRotated: Bool //здесь мы переворачиваем фигуры внутри клетки
    var body: some View{
        ZStack{
            if isActive{
                Color.white
                    .frame(width: 400, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            }else{
                Color.white.blur(radius: 50)
                    .frame(width: 350, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            }
            VStack{
                HStack(spacing: 0){
                    ForEach((0..<8)) { idx in
                        var visualAchiever = player.figureOrNothin(idx: idx)//съедание черными
                        var cellGlyph: String = Helper.getGlyphNameFromFigure(visualAchiever)
                        Еaten(content: cellGlyph).rotationEffect(.degrees(isRotated ? -180 : 0))//отрисoвка
                    }
                }
                //.print(player.warehouse.count)
                    
                if player.warehouse.count > 8{
                    
                    HStack(spacing: 0){
                        ForEach((8..<16)) { idx in
                            var visualAchiever = player.figureOrNothin(idx: idx)//съедание черными
                            var cellGlyph: String = Helper.getGlyphNameFromFigure(visualAchiever)
                            Еaten(content: cellGlyph).rotationEffect(.degrees(isRotated ? -180 : 0))//отрисoвка
                        }
                    }
                }
            }
            .padding(.bottom, 50)
            .padding(.horizontal, 45)
            .padding(.top, 10)
            .cornerRadius(50)
//            .background(Color.blue)
            //.background(Color.blue.blur(radius: 50))
        }
        
    }
}

struct Board: View{
    var gameController: GameController
    var clickHandler: (Point) -> Void
    var body: some View{
        ZStack{
            Image("board_background")
                .resizable()
                .frame(width: 375, height: 375)
                
            VStack{
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
                                //var cellColor: Color = colorCellGenerator((col+row)%2 == 1, isPressed, realisUrgent)
                                var cellGarder: Bool = (col+row)%2 == 1
                                
                                Cell(isRotated: gameController.currentPlayer().color == PlayerColor.black && !gameController.aiEnabled, isDark: cellGarder, theGlifer: cellContent, point: point, funcHandler: clickHandler)
                            }
                            HeaderCell(color: Color.white, content: String(convertedRow)).rotationEffect(.degrees(-180))
                        }
                }
                HStack(spacing: 0){
                    ForEach((1..<9)) { col in
                        //рисуем буквы
                        HeaderCell(color: Color.white, content: letters[col]!).rotationEffect(.degrees(-180))
                    }
                }
            }
        }
        
    }
}

struct PawnUpgradeView: View{
    var player: Player
    var pawnHandler: (String) -> Void
    var body: some View{
        HStack(spacing: 0){
            if player.color == PlayerColor.white{
                PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_white_queen", funcHandler: pawnHandler, askedFigure: "Queen")
                PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_white_tower", funcHandler: pawnHandler, askedFigure: "Tower")
                PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_white_bishop", funcHandler: pawnHandler, askedFigure: "Bishop")
                PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_white_knight", funcHandler: pawnHandler, askedFigure: "Knight")
            }
            if player.color == PlayerColor.black{
                PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_black_queen", funcHandler: pawnHandler, askedFigure: "Queen")
                PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_black_tower", funcHandler: pawnHandler, askedFigure: "Tower")
                PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_black_bishop", funcHandler: pawnHandler, askedFigure: "Bishop")
                PawnUpgradeDemostraitor(color: Color.white, theGlifer: "figure_black_knight", funcHandler: pawnHandler, askedFigure: "Knight")
            }
        }
    }
}

extension View {
    func print(_ value: Any) -> Self {
        Swift.print(value)
        return self
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
        //.background(color)
        //.border(Color.black, width: 0.5)
    }
}

struct Еaten: View{
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
