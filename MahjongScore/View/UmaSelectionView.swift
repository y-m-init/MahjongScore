//
//  UmaPickerView.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

struct UmaSelectionView: View {

    @Binding var selectedUma: UmaOption
    @State private var isShowingDialog = false

    var body: some View {
        HStack {
            Text(Strings.umaLabel)
                .font(.headline)
                .frame(width: 50, alignment: .leading)

            Button(action: {
                isShowingDialog = true
            }) {
                Text(selectedUma.displayName)
                    .foregroundColor(.blue)
                    .frame(maxWidth: 230, minHeight: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .accessibilityLabel(Strings.umaSelectionAccessibility)
            .confirmationDialog(Strings.umaLabel, isPresented: $isShowingDialog, titleVisibility: .visible) {
                ForEach(UmaOption.allCases) { option in
                    Button(option.displayName) {
                        selectedUma = option
                    }
                }
                Button(Strings.cancelButton, role: .cancel) {}
            }
        }
    }
}
