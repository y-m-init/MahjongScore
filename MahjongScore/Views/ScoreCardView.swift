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
            Text("\(rank)\(Strings.rankLabel)\(player.name)")
                .font(.headline)
                .padding(.top, 5)
            Text(String(format: "%+d", player.rankScore))
                .font(.title)
                .bold()
                .foregroundColor(rank == 1 ? .green : rank == 4 ? .red : .black)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(rank == 1 ? Color.yellow.opacity(0.3) : Color.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
