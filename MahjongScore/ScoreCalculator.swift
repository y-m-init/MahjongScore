//
//  ScoreCalculator.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import Foundation

enum UmaOption: String, CaseIterable, Identifiable {
    case fiveTen
    case fiveFifteen
    case tenTwenty
    case tenThirty
    case twentyThirty

    var id: Self { self }

    var displayName: String {
        switch self {
        case .fiveTen:
            return Strings.umaFiveTen
        case .fiveFifteen:
            return Strings.umaFiveFifteen
        case .tenTwenty:
            return Strings.umaTenTwenty
        case .tenThirty:
            return Strings.umaTenThirty
        case .twentyThirty:
            return Strings.umaTwentyThirty
        }
    }

    var points: (high: Int, low: Int) {
        switch self {
        case .fiveTen:
            return (10, 5)
        case .fiveFifteen:
            return (15, 5)
        case .tenTwenty:
            return (20, 10)
        case .tenThirty:
            return (30, 10)
        case .twentyThirty:
            return (30, 20)
        }
    }
}

enum OkaOption: String, CaseIterable, Identifiable {
    case enabled
    case disabled

    var id: Self { self }

    var displayName: String {
        switch self {
        case .enabled:
            return Strings.okaEnabled
        case .disabled:
            return Strings.okaDisabled
        }
    }
}

struct RuleSet {
    let baseScore: Int
    let pointUnit: Int
    let okaBonus: Int

    static let standard = RuleSet(baseScore: 30_000, pointUnit: 1_000, okaBonus: 20)
}

enum TieBreakPolicy {
    case seatOrder
}

enum ValidationError: LocalizedError, Equatable {
    case unsupportedPlayerCount(expected: Int, actual: Int)
    case missingScores(players: [String])

    var errorDescription: String? {
        switch self {
        case let .unsupportedPlayerCount(expected, actual):
            return Strings.errorUnsupportedPlayerCount(expected: expected, actual: actual)
        case let .missingScores(players):
            return Strings.errorScoreMissing(players: players)
        }
    }
}

struct ScoreCalculator {

    static func validate(players: [Player], expectedPlayerCount: Int = 4) -> ValidationError? {
        guard players.count == expectedPlayerCount else {
            return .unsupportedPlayerCount(expected: expectedPlayerCount, actual: players.count)
        }

        let missingPlayers = players.compactMap { player in
            player.score == nil ? player.name : nil
        }

        if !missingPlayers.isEmpty {
            return .missingScores(players: missingPlayers)
        }

        return nil
    }

    static func calculate(
        players: [Player],
        uma: UmaOption,
        oka: OkaOption,
        rules: RuleSet = .standard,
        tieBreakPolicy: TieBreakPolicy = .seatOrder
    ) -> Result<[Player], ValidationError> {
        if let validationError = validate(players: players) {
            return .failure(validationError)
        }

        let sortedPlayers = sortPlayers(players, tieBreakPolicy: tieBreakPolicy)
        let scoredPlayers = applyRules(to: sortedPlayers, uma: uma, oka: oka, rules: rules)

        return .success(scoredPlayers)
    }

    private static func sortPlayers(_ players: [Player], tieBreakPolicy: TieBreakPolicy) -> [Player] {
        players.sorted { lhs, rhs in
            let lhsScore = lhs.score ?? .min
            let rhsScore = rhs.score ?? .min

            if lhsScore != rhsScore {
                return lhsScore > rhsScore
            }

            switch tieBreakPolicy {
            case .seatOrder:
                return lhs.seatOrder < rhs.seatOrder
            }
        }
    }

    private static func applyRules(
        to players: [Player],
        uma: UmaOption,
        oka: OkaOption,
        rules: RuleSet
    ) -> [Player] {
        var rankedPlayers = players

        for index in rankedPlayers.indices {
            guard let score = rankedPlayers[index].score else { continue }
            rankedPlayers[index].rankScore = (score - rules.baseScore) / rules.pointUnit
        }

        let umaPoints = uma.points
        rankedPlayers[0].rankScore += umaPoints.high
        rankedPlayers[1].rankScore += umaPoints.low
        rankedPlayers[2].rankScore -= umaPoints.low
        rankedPlayers[3].rankScore -= umaPoints.high

        if oka == .enabled {
            rankedPlayers[0].rankScore += rules.okaBonus
        }

        return rankedPlayers
    }
}
