//
//  Player.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import Foundation

struct Player: Identifiable {
    let id = UUID()
    var name: String
    var score: String
    var rankScore: Int
}


