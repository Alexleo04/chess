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

struct ContentView: View {
    var board: Board = Board()
    var body: some View {
        VStack{
            HStack(spacing: 0){
                Cell(color: Color.black, content: board.figureConverterReciever(Point(letter: .a, digit: 8))!.name)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
            }
            HStack(spacing: 0){
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
            }
            HStack(spacing: 0){
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
            }
            HStack(spacing: 0){
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
            }
            HStack(spacing: 0){
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
            }
            HStack(spacing: 0){
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
            }
            HStack(spacing: 0){
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
            }
            HStack(spacing: 0){
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
                Cell(color: Color.white)
                Cell(color: Color.black)
            }
        }
    }
}



struct Cell: View{
    var color: Color
    var content: String = ""
    var body: some View{
        Button(content) {
            print(type(of: self.body))
        }
        .frame(width: 37.5, height: 37.5)
        .background(color)
        .border(Color.black, width: 0.5)
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
