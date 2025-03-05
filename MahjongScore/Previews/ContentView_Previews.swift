//
//  ContentView_Previews.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // ライトモード
        ContentView()
            .previewDevice("iPhone 15 Pro")
            .preferredColorScheme(.light)
        // ダークモード
        ContentView()
            .previewDevice("iPhone 15 Pro")
            .preferredColorScheme(.dark)
    }
}

