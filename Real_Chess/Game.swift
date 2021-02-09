//
//  Game.swift
//  Real_Chess
//
//  Created by Grigorii Merkushev on 2/5/21.
//

import Foundation

class Game: ObservableObject{
    @Published var firstClickedCell: Point?
    @Published var SecondClickedCell: Point?
    @Published var board: Board
    
    init(){
        board = Board()
    }

}
