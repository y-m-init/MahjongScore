//
//  UmaPickerView.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

struct UmaSelectionView: View {
    
    // MARK: - プロパティ
    /// 選択されたウマ
    @Binding var selectedUma: String
    /// アクションシートの表示状態
    @State private var isShowingActionSheet = false

    // MARK: - ビュー
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                // MARK: ラベル
                Text(Strings.umaLabel)
                    .font(.headline)
                    .frame(width: 50, alignment: .leading)
                
                // MARK: 選択ボタン
                Button(action: {
                    isShowingActionSheet = true
                }) {
                    Text(selectedUma)
                        .foregroundColor(.blue)
                        .frame(maxWidth: 230, minHeight: 40)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1))
                }
                .actionSheet(isPresented: $isShowingActionSheet) {
                    ActionSheet(
                        title: Text(Strings.umaLabel),
                        buttons: Strings.umaOptions.map { option in
                            .default(Text(option)) { selectedUma = option }
                        } + [.cancel()]
                    )
                }
            }
        }
    }
}
