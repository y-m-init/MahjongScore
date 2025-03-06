//
//  KeyboardToolbar.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/06.
//

import SwiftUI

struct KeyboardToolbar: View {
    var focusedField: FocusState<Int?>.Binding
    @Binding var scoreText: String
    let totalFields: Int

    var body: some View {
        HStack {
            Button(action: {
                if !scoreText.contains(Strings.minusButton) {
                    scoreText = Strings.minusButton + scoreText
                } else {
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

            Button(focusedField.wrappedValue ?? 0 < totalFields - 1 ? Strings.nextButton : Strings.doneButton) {
                if let field = focusedField.wrappedValue {
                    if field < totalFields - 1 {
                        focusedField.wrappedValue = field + 1
                    } else {
                        focusedField.wrappedValue = nil
                    }
                }
            }
            .padding(.trailing)
        }
        .frame(maxWidth: .infinity, minHeight: 44)
    }
}

