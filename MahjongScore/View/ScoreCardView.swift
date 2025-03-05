//
//  ScoreCardView.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

struct ScoreCardView: View {
    
    // MARK: - プロパティ
    let player: Player
    let rank: Int
    
    // MARK: - メインビュー
    var body: some View {
        VStack {
            // 順位とプレイヤー名
            Text("\(rank)\(Strings.rankLabel)\(player.name)")
                .font(.headline)
                .foregroundColor(Color.primary)
    
            // 順位点（ポイント）
            Text(String(format: "%+d", player.rankScore))
                .font(.title)
                .bold()
                .foregroundColor(getRankColor(rank))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(getBackgroundColor(rank))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
    
    // MARK: - 色のロジック
    /// 順位によって文字色を変える
    private func getRankColor(_ rank: Int) -> Color {
        switch rank {
        case 1: return .green
        case 4: return .red
        default: return .primary
        }
    }
    
    /// 順位によって背景色を変える
    private func getBackgroundColor(_ rank: Int) -> Color {
        switch rank {
        case 1:
            return Color(uiColor: UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ? UIColor.systemYellow.withAlphaComponent(0.3) : UIColor.yellow.withAlphaComponent(0.3)
            })
        default:
            return Color(uiColor: UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ? UIColor(white: 0.2, alpha: 1) : UIColor.gray.withAlphaComponent(0.1)
            })
        }
    }
}
