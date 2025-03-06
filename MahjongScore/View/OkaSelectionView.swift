//
//  OkaPickerView.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

struct OkaSelectionView: View {
    
    // MARK: - プロパティ
    /// 選択されたオカ
    @Binding var selectedOka: String
    /// アクションシートの表示状態
    @State private var isShowingActionSheet = false

    // MARK: - ビュー
    var body: some View {
        HStack {
            // MARK: ラベル
            Text(Strings.okaLabel)
                .font(.headline)
                .frame(width: 50, alignment: .leading)
            
            // MARK: 選択ボタン
            Button(action: {
                isShowingActionSheet = true
            }) {
                Text(selectedOka)
                    .foregroundColor(.blue)
                    .frame(maxWidth: 230, minHeight: 40)
                    .background(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1))
            }
            .actionSheet(isPresented: $isShowingActionSheet) {
                ActionSheet(
                    title: Text(Strings.okaLabel),
                    buttons: Strings.okaOptions.map { option in
                        .default(Text(option)) { selectedOka = option }
                    } + [.cancel()]
                )
            }
        }
    }
}
