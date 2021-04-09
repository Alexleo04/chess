//
//  ХодResult.swift
//  Real_Chess
//
//  Created by Juvenna Software on 26/03/2021.
//
//  хранит статус пешки и хода для дальнейшего обновления

import Foundation
struct HodResult{
    var status: Bool //успешное перемещение
    var pawnUpgrade: PawnUpgrade? // pawn upgrade
}
struct PawnUpgrade{
    var point: Point
}
