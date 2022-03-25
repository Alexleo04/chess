//
//  ContentView.swift
//  Real_Chess
//
//  Created by Juvenna Software on 04/12/2020.
//
import SystemConfiguration
import UIKit
import SwiftUI
let colorCellWhite: Color = Color.white
let colorCellBlack: Color = Color.blue

let modelName = UIDevice().type

let screenWidth : CGFloat = UIScreen.main.bounds.size.width

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
        gameController.recordPoint(point: point)
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
            
            
            
            Spacer()
            
            Board(gameController: gameController, clickHandler: clickHandler)
            
            Spacer()
        }
        VStack{
            BenchOfEatenFigures(player: $gameController.blackGuy, isActive: gameController.currentPlayer().color == PlayerColor.black || gameController.aiEnabled, isRotated: gameController.aiEnabled).rotationEffect(.degrees(-180))
            
            Group{
            if gameController.pawnUpgrade && gameController.currentPlayer().color == PlayerColor.black{
                PawnUpgradeView(player: gameController.currentPlayer(), pawnHandler: pawnHandler).rotationEffect(.degrees(-180))
            }
            Spacer()
                
            }
            
            Spacer()
            
            Group{
            Spacer()
            if gameController.pawnUpgrade && gameController.currentPlayer().color == PlayerColor.white{
                PawnUpgradeView(player: gameController.currentPlayer(), pawnHandler: pawnHandler)
            }
                
            }
            
            BenchOfEatenFigures(player: $gameController.whiteGuy, isActive: gameController.currentPlayer().color == PlayerColor.white, isRotated: false)//.offset(x: 0, y: 20)
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

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct Cell: View{
    // what is your coordinate
    var size: CGFloat
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
            .frame(width: size, height: size)
            .padding()
            .rotationEffect(.degrees(isRotated ? -180 : 0))
          
        }
        .frame(width: size, height: size)
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
//для новых 16 == 150 && 8 == 110
//для старых 16 == 100 && 8 == 60
//player.warehouse.count > 8 ? 100 : 60
//func heightOfBenchOfEatenFigures(){
//
//}

struct BenchOfEatenFigures: View{
    @Binding var player: Player
    var isActive: Bool
    var isRotated: Bool //здесь мы переворачиваем фигуры внутри клетки
    var body: some View{
        ZStack{
            if isActive{
                Color.white
                    .frame(width: UIScreen.main.bounds.size.width, height: player.warehouse.count > 8 ? !oldTimesHeight() ? 150 : 100 : !oldTimesHeight() ? 110 : 60)
                    .clipShape(RoundedCorner(radius: 25, corners: [.topLeft, .topRight]))
            }else{
                Color.white.blur(radius: 50)
                    .frame(width: UIScreen.main.bounds.size.width, height: player.warehouse.count > 8 ? !oldTimesHeight() ? 150 : 100 : !oldTimesHeight() ? 110 : 60)
                    .clipShape(RoundedCorner(radius: 25, corners: [.topLeft, .topRight]))
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
//            .offset(.bottom, !oldTimes() ? 0 : 50)
            
            .padding(.bottom, 15)
            .padding(.horizontal, 45)
            .padding(.top, 10)
            .cornerRadius(50)
//            .background(Color.blue)
            //.background(Color.blue.blur(radius: 50))
        }
        .offset(x: 0.0, y: 0.0)
    }
}

struct Board: View{
    var gameController: GameController
    var clickHandler: (Point) -> Void
    var body: some View{
        ZStack{
            Image("board_background")
                .resizable()
                .frame(width: screenWidth, height: screenWidth)
                
            VStack{
                HStack(spacing: 0){
                    ForEach((1..<9)) { col in
                        //рисуем буквы
                        HeaderCell(size: screenWidth/10, color: Color.white, content: letters[col]!)
                    }
                }
                ForEach((1..<9)) { row in
                    // we need to count in reverse as board have 8 -> 1 numeration
                    var convertedRow: Int = 9-row
                        HStack(spacing: 0){
                            HeaderCell(size: screenWidth/10, color: Color.white, content: String(convertedRow))
                            ForEach((1..<9)) { col in
        //
                                var column: Int = col
        //
                                let point = Helper.createPoint(letterNum: column, digitNum: convertedRow)
                                
                                var realisUrgent: Bool = gameController.isUrgent(point: point)
                                var isPressed: Bool = point == gameController.pointFrom
        //
                                let cellContent: String = Helper.getGlyphNameFromFigure(gameController.boardController.getBoard().getFigureByPoint(point))
        //
                                //var cellColor: Color = colorCellGenerator((col+row)%2 == 1, isPressed, realisUrgent)
                                var cellGarder: Bool = (col+row)%2 == 1
                                
                                Cell(size: screenWidth/10, isRotated: gameController.currentPlayer().color == PlayerColor.black && !gameController.aiEnabled, isDark: cellGarder, theGlifer: cellContent, point: point, funcHandler: clickHandler)
                            }
                            HeaderCell(size: screenWidth/10, color: Color.white, content: String(convertedRow)).rotationEffect(.degrees(-180))
                        }
                }
                HStack(spacing: 0){
                    ForEach((1..<9)) { col in
                        //рисуем буквы
                        HeaderCell(size: screenWidth/10, color: Color.white, content: letters[col]!).rotationEffect(.degrees(-180))
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
    var size: CGFloat
    var color: Color
    var content: String = ""
    var body: some View{
        Text(content)
        .frame(width: size, height: size)
            .foregroundColor(.white)
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
        //.border(Color.black, width: 0.5)
    }
}

func oldTimesHeight() -> Bool{
//    switch UIDevice().type {
//    case .iPhone6,
//         .iPhone6Plus,
//         .iPhone6S,
//         .iPhone6SPlus,
//         .iPhone7,
//         .iPhone7Plus,
//         .iPhone8,
//         .iPhone8Plus,
//         .iPod7,
//         .iPhoneSE,
//         .iPhoneSE2:
//        return true
//    default:
//        return false
//    }
    return true
}

public enum Model : String {

//Simulator
case simulator     = "simulator/sandbox",

//iPod
iPod1              = "iPod 1",
iPod2              = "iPod 2",
iPod3              = "iPod 3",
iPod4              = "iPod 4",
iPod5              = "iPod 5",
iPod6              = "iPod 6",
iPod7              = "iPod 7",

//iPad
iPad2              = "iPad 2",
iPad3              = "iPad 3",
iPad4              = "iPad 4",
iPadAir            = "iPad Air ",
iPadAir2           = "iPad Air 2",
iPadAir3           = "iPad Air 3",
iPadAir4           = "iPad Air 4",
iPad5              = "iPad 5", //iPad 2017
iPad6              = "iPad 6", //iPad 2018
iPad7              = "iPad 7", //iPad 2019
iPad8              = "iPad 8", //iPad 2020
iPad9              = "iPad 9", //iPad 2021

//iPad Mini
iPadMini           = "iPad Mini",
iPadMini2          = "iPad Mini 2",
iPadMini3          = "iPad Mini 3",
iPadMini4          = "iPad Mini 4",
iPadMini5          = "iPad Mini 5",
iPadMini6          = "iPad Mini 6",

//iPad Pro
iPadPro9_7         = "iPad Pro 9.7\"",
iPadPro10_5        = "iPad Pro 10.5\"",
iPadPro11          = "iPad Pro 11\"",
iPadPro2_11        = "iPad Pro 11\" 2nd gen",
iPadPro3_11        = "iPad Pro 11\" 3rd gen",
iPadPro12_9        = "iPad Pro 12.9\"",
iPadPro2_12_9      = "iPad Pro 2 12.9\"",
iPadPro3_12_9      = "iPad Pro 3 12.9\"",
iPadPro4_12_9      = "iPad Pro 4 12.9\"",
iPadPro5_12_9      = "iPad Pro 5 12.9\"",

//iPhone
iPhone4            = "iPhone 4",
iPhone4S           = "iPhone 4S",
iPhone5            = "iPhone 5",
iPhone5S           = "iPhone 5S",
iPhone5C           = "iPhone 5C",
iPhone6            = "iPhone 6",
iPhone6Plus        = "iPhone 6 Plus",
iPhone6S           = "iPhone 6S",
iPhone6SPlus       = "iPhone 6S Plus",
iPhoneSE           = "iPhone SE",
iPhone7            = "iPhone 7",
iPhone7Plus        = "iPhone 7 Plus",
iPhone8            = "iPhone 8",
iPhone8Plus        = "iPhone 8 Plus",
iPhoneX            = "iPhone X",
iPhoneXS           = "iPhone XS",
iPhoneXSMax        = "iPhone XS Max",
iPhoneXR           = "iPhone XR",
iPhone11           = "iPhone 11",
iPhone11Pro        = "iPhone 11 Pro",
iPhone11ProMax     = "iPhone 11 Pro Max",
iPhoneSE2          = "iPhone SE 2nd gen",
iPhone12Mini       = "iPhone 12 Mini",
iPhone12           = "iPhone 12",
iPhone12Pro        = "iPhone 12 Pro",
iPhone12ProMax     = "iPhone 12 Pro Max",
iPhone13Mini       = "iPhone 13 Mini",
iPhone13           = "iPhone 13",
iPhone13Pro        = "iPhone 13 Pro",
iPhone13ProMax     = "iPhone 13 Pro Max",

// Apple Watch
AppleWatch1         = "Apple Watch 1gen",
AppleWatchS1        = "Apple Watch Series 1",
AppleWatchS2        = "Apple Watch Series 2",
AppleWatchS3        = "Apple Watch Series 3",
AppleWatchS4        = "Apple Watch Series 4",
AppleWatchS5        = "Apple Watch Series 5",
AppleWatchSE        = "Apple Watch Special Edition",
AppleWatchS6        = "Apple Watch Series 6",
AppleWatchS7        = "Apple Watch Series 7",

//Apple TV
AppleTV1           = "Apple TV 1gen",
AppleTV2           = "Apple TV 2gen",
AppleTV3           = "Apple TV 3gen",
AppleTV4           = "Apple TV 4gen",
AppleTV_4K         = "Apple TV 4K",
AppleTV2_4K        = "Apple TV 4K 2gen",

unrecognized       = "?unrecognized?"
}

// #-#-#-#-#-#-#-#-#-#-#-#-#
// MARK: UIDevice extensions
// #-#-#-#-#-#-#-#-#-#-#-#-#

    public extension UIDevice {
        
    var type: Model {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
            }
        }
    
        let modelMap : [String: Model] = [
    
            //Simulator
            "i386"      : .simulator,
            "x86_64"    : .simulator,
    
            //iPod
            "iPod1,1"   : .iPod1,
            "iPod2,1"   : .iPod2,
            "iPod3,1"   : .iPod3,
            "iPod4,1"   : .iPod4,
            "iPod5,1"   : .iPod5,
            "iPod7,1"   : .iPod6,
            "iPod9,1"   : .iPod7,
    
            //iPad
            "iPad2,1"   : .iPad2,
            "iPad2,2"   : .iPad2,
            "iPad2,3"   : .iPad2,
            "iPad2,4"   : .iPad2,
            "iPad3,1"   : .iPad3,
            "iPad3,2"   : .iPad3,
            "iPad3,3"   : .iPad3,
            "iPad3,4"   : .iPad4,
            "iPad3,5"   : .iPad4,
            "iPad3,6"   : .iPad4,
            "iPad6,11"  : .iPad5, //iPad 2017
            "iPad6,12"  : .iPad5,
            "iPad7,5"   : .iPad6, //iPad 2018
            "iPad7,6"   : .iPad6,
            "iPad7,11"  : .iPad7, //iPad 2019
            "iPad7,12"  : .iPad7,
            "iPad11,6"  : .iPad8, //iPad 2020
            "iPad11,7"  : .iPad8,
            "iPad12,1"  : .iPad9, //iPad 2021
            "iPad12,2"  : .iPad9,
    
            //iPad Mini
            "iPad2,5"   : .iPadMini,
            "iPad2,6"   : .iPadMini,
            "iPad2,7"   : .iPadMini,
            "iPad4,4"   : .iPadMini2,
            "iPad4,5"   : .iPadMini2,
            "iPad4,6"   : .iPadMini2,
            "iPad4,7"   : .iPadMini3,
            "iPad4,8"   : .iPadMini3,
            "iPad4,9"   : .iPadMini3,
            "iPad5,1"   : .iPadMini4,
            "iPad5,2"   : .iPadMini4,
            "iPad11,1"  : .iPadMini5,
            "iPad11,2"  : .iPadMini5,
            "iPad14,1"  : .iPadMini6,
            "iPad14,2"  : .iPadMini6,
    
            //iPad Pro
            "iPad6,3"   : .iPadPro9_7,
            "iPad6,4"   : .iPadPro9_7,
            "iPad7,3"   : .iPadPro10_5,
            "iPad7,4"   : .iPadPro10_5,
            "iPad6,7"   : .iPadPro12_9,
            "iPad6,8"   : .iPadPro12_9,
            "iPad7,1"   : .iPadPro2_12_9,
            "iPad7,2"   : .iPadPro2_12_9,
            "iPad8,1"   : .iPadPro11,
            "iPad8,2"   : .iPadPro11,
            "iPad8,3"   : .iPadPro11,
            "iPad8,4"   : .iPadPro11,
            "iPad8,9"   : .iPadPro2_11,
            "iPad8,10"  : .iPadPro2_11,
            "iPad13,4"  : .iPadPro3_11,
            "iPad13,5"  : .iPadPro3_11,
            "iPad13,6"  : .iPadPro3_11,
            "iPad13,7"  : .iPadPro3_11,
            "iPad8,5"   : .iPadPro3_12_9,
            "iPad8,6"   : .iPadPro3_12_9,
            "iPad8,7"   : .iPadPro3_12_9,
            "iPad8,8"   : .iPadPro3_12_9,
            "iPad8,11"  : .iPadPro4_12_9,
            "iPad8,12"  : .iPadPro4_12_9,
            "iPad13,8"  : .iPadPro5_12_9,
            "iPad13,9"  : .iPadPro5_12_9,
            "iPad13,10" : .iPadPro5_12_9,
            "iPad13,11" : .iPadPro5_12_9,
    
            //iPad Air
            "iPad4,1"   : .iPadAir,
            "iPad4,2"   : .iPadAir,
            "iPad4,3"   : .iPadAir,
            "iPad5,3"   : .iPadAir2,
            "iPad5,4"   : .iPadAir2,
            "iPad11,3"  : .iPadAir3,
            "iPad11,4"  : .iPadAir3,
            "iPad13,1"  : .iPadAir4,
            "iPad13,2"  : .iPadAir4,
            
    
            //iPhone
            "iPhone3,1" : .iPhone4,
            "iPhone3,2" : .iPhone4,
            "iPhone3,3" : .iPhone4,
            "iPhone4,1" : .iPhone4S,
            "iPhone5,1" : .iPhone5,
            "iPhone5,2" : .iPhone5,
            "iPhone5,3" : .iPhone5C,
            "iPhone5,4" : .iPhone5C,
            "iPhone6,1" : .iPhone5S,
            "iPhone6,2" : .iPhone5S,
            "iPhone7,1" : .iPhone6Plus,
            "iPhone7,2" : .iPhone6,
            "iPhone8,1" : .iPhone6S,
            "iPhone8,2" : .iPhone6SPlus,
            "iPhone8,4" : .iPhoneSE,
            "iPhone9,1" : .iPhone7,
            "iPhone9,3" : .iPhone7,
            "iPhone9,2" : .iPhone7Plus,
            "iPhone9,4" : .iPhone7Plus,
            "iPhone10,1" : .iPhone8,
            "iPhone10,4" : .iPhone8,
            "iPhone10,2" : .iPhone8Plus,
            "iPhone10,5" : .iPhone8Plus,
            "iPhone10,3" : .iPhoneX,
            "iPhone10,6" : .iPhoneX,
            "iPhone11,2" : .iPhoneXS,
            "iPhone11,4" : .iPhoneXSMax,
            "iPhone11,6" : .iPhoneXSMax,
            "iPhone11,8" : .iPhoneXR,
            "iPhone12,1" : .iPhone11,
            "iPhone12,3" : .iPhone11Pro,
            "iPhone12,5" : .iPhone11ProMax,
            "iPhone12,8" : .iPhoneSE2,
            "iPhone13,1" : .iPhone12Mini,
            "iPhone13,2" : .iPhone12,
            "iPhone13,3" : .iPhone12Pro,
            "iPhone13,4" : .iPhone12ProMax,
            "iPhone14,4" : .iPhone13Mini,
            "iPhone14,5" : .iPhone13,
            "iPhone14,2" : .iPhone13Pro,
            "iPhone14,3" : .iPhone13ProMax,
            
            // Apple Watch
            "Watch1,1" : .AppleWatch1,
            "Watch1,2" : .AppleWatch1,
            "Watch2,6" : .AppleWatchS1,
            "Watch2,7" : .AppleWatchS1,
            "Watch2,3" : .AppleWatchS2,
            "Watch2,4" : .AppleWatchS2,
            "Watch3,1" : .AppleWatchS3,
            "Watch3,2" : .AppleWatchS3,
            "Watch3,3" : .AppleWatchS3,
            "Watch3,4" : .AppleWatchS3,
            "Watch4,1" : .AppleWatchS4,
            "Watch4,2" : .AppleWatchS4,
            "Watch4,3" : .AppleWatchS4,
            "Watch4,4" : .AppleWatchS4,
            "Watch5,1" : .AppleWatchS5,
            "Watch5,2" : .AppleWatchS5,
            "Watch5,3" : .AppleWatchS5,
            "Watch5,4" : .AppleWatchS5,
            "Watch5,9" : .AppleWatchSE,
            "Watch5,10" : .AppleWatchSE,
            "Watch5,11" : .AppleWatchSE,
            "Watch5,12" : .AppleWatchSE,
            "Watch6,1" : .AppleWatchS6,
            "Watch6,2" : .AppleWatchS6,
            "Watch6,3" : .AppleWatchS6,
            "Watch6,4" : .AppleWatchS6,
            "Watch6,6" : .AppleWatchS7,
            "Watch6,7" : .AppleWatchS7,
            "Watch6,8" : .AppleWatchS7,
            "Watch6,9" : .AppleWatchS7,
    
            //Apple TV
            "AppleTV1,1" : .AppleTV1,
            "AppleTV2,1" : .AppleTV2,
            "AppleTV3,1" : .AppleTV3,
            "AppleTV3,2" : .AppleTV3,
            "AppleTV5,3" : .AppleTV4,
            "AppleTV6,2" : .AppleTV_4K,
            "AppleTV11,1" : .AppleTV2_4K
        ]
    
        guard let mcode = modelCode, let map = String(validatingUTF8: mcode), let model = modelMap[map] else { return Model.unrecognized }
        if model == .simulator {
            if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                if let simMap = String(validatingUTF8: simModelCode), let simModel = modelMap[simMap] {
                    return simModel
                }
            }
        }
        return model
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
