//
//  Player.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import Foundation

struct Player: Identifiable, Equatable {
    let id: UUID
    let name: String
    let seatOrder: Int
    var score: Int?
    var rankScore: Int

    init(
        id: UUID = UUID(),
        name: String,
        seatOrder: Int,
        score: Int? = nil,
        rankScore: Int = 0
    ) {
        self.id = id
        self.name = name
        self.seatOrder = seatOrder
        self.score = score
        self.rankScore = rankScore
    }
}
