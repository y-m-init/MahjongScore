//
//  ScoreCalculator.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import Foundation

struct ScoreCalculator {
    
    // MARK: - 定数
    private static let baseScore = 30_000   // 30,000点基準
    private static let pointUnit = 1_000    // 1000点単位でポイント換算
    private static let okaDefaultValue = 20 // オカあり時の加算値
    
    // MARK: - ウマの値を取得
    private static func getUmaValues(uma: String) -> (high: Int, low: Int) {
        switch uma {
        case Strings.umaFiveTen: return (10, 5)
        case Strings.umaFiveFifteen: return (15, 5)
        case Strings.umaTenTwenty: return (20, 10)
        case Strings.umaTenThirty: return (30, 10)
        case Strings.umaTwentyThirty: return (30, 20)
        default: return (10, 5)
        }
    }
    
    // MARK: - スコアのバリデーション
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
        // 点数未入力の場合
        if !emptyPlayers.isEmpty {
            return Strings.errorScoreMissing.replacingOccurrences(of: "{players}", with: emptyPlayers.joined(separator: "、"))
        }
        // 数値以外を入力の場合
        if !invalidPlayers.isEmpty {
            return Strings.errorScoreInvalid.replacingOccurrences(of: "{players}", with: invalidPlayers.joined(separator: "、"))
        }
        
        return nil
    }
    
    // MARK: - 順位点の計算
    static func calculate(players: [Player], selectedUma: String, selectedOka: String) -> [Player] {
        let umaValues = getUmaValues(uma: selectedUma)
        let okaValue = selectedOka == Strings.okaEnabled ? okaDefaultValue : 0
        
        // スコアをIntに変換し、降順ソート
        var sortedPlayers = players.compactMap { player -> Player? in
            guard let score = Int(player.score) else { return nil }
            return Player(name: player.name.isEmpty ? Strings.defaultPlayerName : player.name, score: "\(score)", rankScore: 0)
        }.sorted { Int($0.score)! > Int($1.score)! }
        
        // 30,000点（基準点）との差を計算（1000点単位のポイント変換 / 切り捨て）
        for i in 0..<sortedPlayers.count {
            if let score = Int(sortedPlayers[i].score) {
                sortedPlayers[i].rankScore = (score - baseScore) / pointUnit
            }
        }
        // ウマの適用（1位・2位が加点、3位・4位が減点）
        sortedPlayers[0].rankScore += umaValues.high
        sortedPlayers[1].rankScore += umaValues.low
        sortedPlayers[2].rankScore -= umaValues.low
        sortedPlayers[3].rankScore -= umaValues.high
        // オカの適用（1位のプレイヤーにオカを加算）
        sortedPlayers[0].rankScore += okaValue
        
        return sortedPlayers
    }
}
