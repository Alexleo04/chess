//
//  BoardData.swift
//  Real_Chess
//
//  Created by Juvenna Software on 12/05/2021.
//

import Foundation
class BoardData{
    private var data: [[Figure?]] = Array(repeating: [nil,nil,nil,nil,nil,nil,nil,nil], count: 8)
    
    static let row = 8 // начинаем с 0 заканчиваем -1
    static let column = 8
    
    func clearField(){
        for m in 0...BoardData.row-1{
            for n in 0...BoardData.column-1{
                data[m][n] = nil
            }
        }
    }
    
    func clearCell(_ point: Point){
        data[point.digit-1][point.letter.rawValue-1] = nil
    }
    
    func placeFigure(_ pos: Point, _ fig: Figure){
        data[pos.digit-1][pos.letter.rawValue-1] = fig
    }
    
    func getFigureByPoint(_ pos: Point) -> Figure?{
        return data[pos.digit-1][pos.letter.rawValue-1]
    }
}
