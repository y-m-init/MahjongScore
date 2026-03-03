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
            Button(action: toggleMinusPrefix) {
                Text(Strings.minusButton)
                    .font(.title2)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .accessibilityLabel(Strings.minusButton)

            Spacer()

            Button(nextButtonLabel) {
                guard let field = focusedField.wrappedValue else { return }

                if field < totalFields - 1 {
                    focusedField.wrappedValue = field + 1
                } else {
                    focusedField.wrappedValue = nil
                }
            }
            .padding(.trailing)
            .accessibilityLabel(nextButtonLabel)
        }
        .frame(maxWidth: .infinity, minHeight: 44)
    }

    private var nextButtonLabel: String {
        (focusedField.wrappedValue ?? 0) < totalFields - 1 ? Strings.nextButton : Strings.doneButton
    }

    private func toggleMinusPrefix() {
        let trimmed = scoreText.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.hasPrefix(Strings.minusButton) {
            scoreText = String(trimmed.dropFirst())
            return
        }

        scoreText = Strings.minusButton + trimmed.filter(\.isNumber)
    }
}
