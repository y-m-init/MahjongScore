//
//  OkaPickerView.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

struct OkaPickerView: View {
    
    // MARK: - プロパティ
    @Binding var selectedOka: String
    
    // MARK: - メインビュー
    var body: some View {
        
        // MARK: オカの選択（Picker）
        /// 「オカあり / なし」を選択する
        HStack {
            Text(Strings.okaLabel)
            Picker("", selection: $selectedOka) {
                ForEach(Strings.okaOptions, id: \.self) { option in
                    Text(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
    }
}

