//
//  ScoreCalculator.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import Foundation

struct ScoreCalculator {
    // ウマの値を取得する
    private static func getUmaValues(uma: String) -> (high: Int, low: Int) {
        switch uma {
        case Strings.umaGoto: return (10, 5)
        case Strings.umaFiveFifteen: return (15, 5)
        case Strings.umaOneTwo: return (20, 10)
        case Strings.umaOneThree: return (30, 10)
        case Strings.umaTwoThree: return (30, 20)
        default: return (10, 5)
        }
    }
    
    // 点数のバリデーション
    static func validateScores(players: [Player]) -> String? {
        var emptyPlayers: [String] = []
        var invalidPlayers: [String] = []
        
        for player in players {
            let trimmedScore = player.score.trimmingCharacters(in: .whitespaces)
            if trimmedScore.isEmpty {
                emptyPlayers.append(player.name)
            } else if Int(trimmedScore) == nil {
                invalidPlayers.append(player.name)
            }
        }
        // 点数未入力
        if !emptyPlayers.isEmpty {
            return Strings.errorScoreMissing.replacingOccurrences(of: "{players}", with: emptyPlayers.joined(separator: "、"))
        }
        // 数値以外を入力
        if !invalidPlayers.isEmpty {
            return Strings.errorScoreInvalid.replacingOccurrences(of: "{players}", with: invalidPlayers.joined(separator: "、"))
        }
        
        return nil
    }
    
    // 順位点計算
    static func calculate(players: [Player], selectedUma: String, selectedOka: String) -> [Player] {
        let umaValues = getUmaValues(uma: selectedUma)
        let okaValue = selectedOka == "あり" ? 20 : 0
        // 点数をIntに変換し、降順ソート
        var sortedPlayers = players.compactMap { player -> Player? in
            guard let score = Int(player.score) else { return nil }
            return Player(name: player.name.isEmpty ? Strings.defaultPlayerName : player.name, score: "\(score)", rankScore: 0)
        }.sorted { Int($0.score)! > Int($1.score)! }
        
        // ① 30,000点（基準点）との差を計算（1000点単位のポイント変換 / 切り捨て）
        for i in 0..<sortedPlayers.count {
            if let score = Int(sortedPlayers[i].score) {
                let adjustedScore = Double(score - 30_000) / 1_000
                sortedPlayers[i].rankScore = Int(adjustedScore.rounded(.down))
            }
        }
        
        // ② ウマの適用
        sortedPlayers[0].rankScore += umaValues.high  // 1位
        sortedPlayers[1].rankScore += umaValues.low   // 2位
        sortedPlayers[2].rankScore -= umaValues.low   // 3位
        sortedPlayers[3].rankScore -= umaValues.high  // 4位
        
        // ③ オカの適用
        sortedPlayers[0].rankScore += okaValue
        
        return sortedPlayers
    }
}
