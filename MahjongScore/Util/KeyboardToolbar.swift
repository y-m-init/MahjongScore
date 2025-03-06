//
//  KeyboardToolbar.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/06.
//

import SwiftUI

struct KeyboardToolbar: View {
    /// フォーカスされているフィールドを管理
    var focusedField: FocusState<Int?>.Binding
    /// 入力されたスコアのテキスト
    @Binding var scoreText: String
    /// 合計のフィールド数
    let totalFields: Int
    
    var body: some View {
        HStack {
            // MARK: - マイナスボタン
            Button(action: {
                if !scoreText.contains(Strings.minusButton) {
                    /// マイナスが含まれていなければ追加
                    scoreText = Strings.minusButton + scoreText
                } else {
                    /// マイナスが含まれていれば削除
                    scoreText = scoreText.replacingOccurrences(of: Strings.minusButton, with: "")
                }
            }) {
                Text(Strings.minusButton)
                    .font(.title2)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            
            Spacer()
            
            // MARK: - 次へ / 完了ボタン
            Button(focusedField.wrappedValue ?? 0 < totalFields - 1 ? Strings.nextButton : Strings.doneButton) {
                if let field = focusedField.wrappedValue {
                    if field < totalFields - 1 {
                        /// 次のフィールドにフォーカスを移動
                        focusedField.wrappedValue = field + 1
                    } else {
                        /// 最後のフィールドならフォーカスを解除
                        focusedField.wrappedValue = nil
                    }
                }
            }
            .padding(.trailing)
        }
        .frame(maxWidth: .infinity, minHeight: 44)
    }
}
