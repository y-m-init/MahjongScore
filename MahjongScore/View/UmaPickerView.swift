//
//  UmaPickerView.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

struct UmaPickerView: View {
    
    // MARK: - バインディング（親ビューからのデータ）
    @Binding var selectedUma: String
    
    // MARK: - メインビュー
    var body: some View {
        VStack {
            
            // MARK: ウマの選択（Picker）
            HStack {
                Text(Strings.umaLabel)
                Picker("", selection: $selectedUma) {
                    ForEach(Strings.umaOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.top, 10)
            
            // MARK: ウマの説明文
            /// ウマのルールを表示
            VStack(alignment: .leading) {
                Text(Strings.umaDescriptionFiveFifteen)
                Text(Strings.umaDescriptionTenThirty)
            }
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.top, 1)
        }
    }
}

