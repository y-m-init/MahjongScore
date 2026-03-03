//
//  MahjongScoreTests.swift
//  MahjongScoreTests
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import XCTest
@testable import MahjongScore

final class MahjongScoreTests: XCTestCase {

    func testCalculateTenThirtyWithOkaEnabled() throws {
        let players = makePlayers(scores: [35_000, 30_000, 25_000, 10_000])

        let result = ScoreCalculator.calculate(players: players, uma: .tenThirty, oka: .enabled)

        let rankedPlayers = try XCTUnwrap(result.value)
        XCTAssertEqual(rankedPlayers.map(\.name), ["東家", "南家", "西家", "北家"])
        XCTAssertEqual(rankedPlayers.map(\.rankScore), [55, 10, -15, -50])
    }

    func testCalculateFiveTenWithoutOkaAllowsNegativeScore() throws {
        let players = makePlayers(scores: [45_000, 25_000, 20_000, 10_000])

        let result = ScoreCalculator.calculate(players: players, uma: .fiveTen, oka: .disabled)

        let rankedPlayers = try XCTUnwrap(result.value)
        XCTAssertEqual(rankedPlayers.map(\.rankScore), [25, 0, -15, -30])
    }

    func testTieBreakUsesSeatOrder() throws {
        let players = makePlayers(scores: [30_000, 30_000, 20_000, 20_000])

        let result = ScoreCalculator.calculate(players: players, uma: .tenThirty, oka: .disabled)

        let rankedPlayers = try XCTUnwrap(result.value)
        XCTAssertEqual(rankedPlayers.map(\.name), ["東家", "南家", "西家", "北家"])
        XCTAssertEqual(rankedPlayers.map(\.rankScore), [30, 10, -20, -40])
    }

    func testValidateFailsWhenScoreIsMissing() {
        let players = [
            Player(name: "東家", seatOrder: 0, score: 30_000),
            Player(name: "南家", seatOrder: 1, score: nil),
            Player(name: "西家", seatOrder: 2, score: 20_000),
            Player(name: "北家", seatOrder: 3, score: 10_000)
        ]

        let validationError = ScoreCalculator.validate(players: players)
        XCTAssertEqual(validationError, .missingScores(players: ["南家"]))
    }

    func testValidateFailsWhenPlayerCountIsUnsupported() {
        let players = [
            Player(name: "東家", seatOrder: 0, score: 30_000),
            Player(name: "南家", seatOrder: 1, score: 20_000),
            Player(name: "西家", seatOrder: 2, score: 10_000)
        ]

        let validationError = ScoreCalculator.validate(players: players)
        XCTAssertEqual(validationError, .unsupportedPlayerCount(expected: 4, actual: 3))
    }

    private func makePlayers(scores: [Int]) -> [Player] {
        Array(zip(Strings.players.enumerated(), scores)).map { element in
            let ((index, name), score) = element
            return Player(name: name, seatOrder: index, score: score)
        }
    }
}

private extension Result {
    var value: Success? {
        guard case let .success(success) = self else { return nil }
        return success
    }
}
