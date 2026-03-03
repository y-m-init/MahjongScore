//
//  ContentViewModel.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

struct ScoreInputSanitizer {
    private static let maxDigits = 6

    static func sanitize(_ raw: String) -> (displayText: String, value: Int?) {
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.isEmpty {
            return ("", nil)
        }

        let isNegative = trimmed.hasPrefix(Strings.minusButton)
        let digitsOnly = trimmed.filter(\.isNumber)
        let limitedDigits = String(digitsOnly.prefix(maxDigits))

        if limitedDigits.isEmpty {
            return isNegative ? (Strings.minusButton, nil) : ("", nil)
        }

        let normalizedText = isNegative ? Strings.minusButton + limitedDigits : limitedDigits
        let value = Int(normalizedText)

        return (normalizedText, value)
    }
}

// MARK: - ContentViewのViewModel
@MainActor
final class ContentViewModel: ObservableObject {
    // MARK: - プロパティ
    @Published var players: [Player]
    @Published var scoreInputs: [String]
    @Published var selectedUma: UmaOption
    @Published var selectedOka: OkaOption
    @Published var rankedPlayers: [Player] = []
    @Published var showError = false
    @Published var errorMessage = ""

    init() {
        let initialPlayers = Strings.players.enumerated().map { index, name in
            Player(name: name, seatOrder: index)
        }

        self.players = initialPlayers
        self.scoreInputs = Array(repeating: "", count: initialPlayers.count)
        self.selectedUma = .tenThirty
        self.selectedOka = .enabled
    }

    func isValidPlayerIndex(_ index: Int) -> Bool {
        players.indices.contains(index)
    }

    func scoreInput(at index: Int) -> String {
        guard scoreInputs.indices.contains(index) else { return "" }
        return scoreInputs[index]
    }

    func updateScoreInput(_ text: String, at index: Int) {
        guard players.indices.contains(index), scoreInputs.indices.contains(index) else { return }

        let sanitized = ScoreInputSanitizer.sanitize(text)
        scoreInputs[index] = sanitized.displayText
        players[index].score = sanitized.value
    }

    // MARK: - バリデーション＆計算処理
    func validateAndCalculate() {
        switch ScoreCalculator.calculate(players: players, uma: selectedUma, oka: selectedOka) {
        case let .success(result):
            rankedPlayers = result
            showError = false
        case let .failure(error):
            rankedPlayers = []
            errorMessage = error.errorDescription ?? Strings.errorTitle
            showError = true
        }
    }
}
