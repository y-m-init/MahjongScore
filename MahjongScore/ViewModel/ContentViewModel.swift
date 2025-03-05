//
//  ContentViewModel.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

// MARK: - ContentViewのViewModel
class ContentViewModel: ObservableObject {
    // MARK: - プロパティ
    /// プレイヤーのリスト（名前・スコア・順位点）
    @Published var players: [Player] = Strings.defaultPlayers.map { Player(name: $0, score: "", rankScore: 0) }
    /// 選択されたウマ（デフォルトは 10-30）
    @Published var selectedUma = Strings.umaTenThirty
    /// 選択されたオカ（デフォルトは「あり」）
    @Published var selectedOka = Strings.okaOptions[0]
    /// 計算後の順位点リスト
    @Published var rankedPlayers: [Player] = []
    /// エラー表示フラグ
    @Published var showError = false
    /// エラーメッセージ
    @Published var errorMessage = ""

    // MARK: - バリデーション＆計算処理
    /// スコアをバリデーションし、順位点を計算する
    func validateAndCalculate() {
        // スコアのバリデーション（未入力 or 数値以外をチェック）
        if let error = ScoreCalculator.validateScores(players: players) {
            errorMessage = error
            showError = true
            return
        }
        // 順位点を計算
        rankedPlayers = ScoreCalculator.calculate(players: players, selectedUma: selectedUma, selectedOka: selectedOka)
    }
}

