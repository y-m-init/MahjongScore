//
//  KeyboardToolbar.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/06.
//

import SwiftUI

struct KeyboardToolbar: View {
    var focusedField: FocusState<Int?>.Binding
    let totalFields: Int

    var body: some View {
        HStack {
            Spacer()
            Button(isLastField ? Strings.doneButton : Strings.nextButton) {
                if let field = focusedField.wrappedValue {
                    focusedField.wrappedValue = isLastField ? nil : field + 1
                }
            }
            .padding(.trailing)
        }
        .frame(maxWidth: .infinity, minHeight: 44)
    }

    private var isLastField: Bool {
        (focusedField.wrappedValue ?? 0) >= (totalFields - 1)
    }
}
