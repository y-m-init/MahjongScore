//
//  ScoreCardView.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

struct ScoreCardView: View {

    let player: Player
    let rank: Int

    var body: some View {
        VStack {
            Text("\(rank)\(Strings.rankLabel): \(player.name)")
                .font(.headline)
                .foregroundColor(.primary)

            Text(String(format: "%+d", player.rankScore))
                .font(.title)
                .bold()
                .foregroundColor(rankColor)
                .accessibilityLabel("\(Strings.pointLabel) \(player.rankScore)")
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 2)
    }

    private var rankColor: Color {
        switch rank {
        case 1:
            return .green
        case 4:
            return .red
        default:
            return .primary
        }
    }

    private var backgroundColor: Color {
        switch rank {
        case 1:
            return Color.yellow.opacity(0.3)
        default:
            return Color.gray.opacity(0.1)
        }
    }
}
