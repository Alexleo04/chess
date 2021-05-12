//
//  ХодResult.swift
//  Real_Chess
//
//  Created by Juvenna Software on 26/03/2021.
//
//  хранит статус пешки и хода для дальнейшего обновления

import Foundation
struct HodResult{
    var status: Bool // перемещение
    var shakh: Shakh? // шах
    var pawnUpgrade: PawnUpgrade? // pawn upgrade
}
struct Shakh{
    var king: Point
    var kingColor: PlayerColor
    var hostile: Point
}
struct PawnUpgrade{
    var point: Point
}
