//
//  OkaPickerView.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

struct OkaSelectionView: View {

    @Binding var selectedOka: OkaOption
    @State private var isShowingDialog = false

    var body: some View {
        HStack {
            Text(Strings.okaLabel)
                .font(.headline)
                .frame(width: 50, alignment: .leading)

            Button(action: {
                isShowingDialog = true
            }) {
                Text(selectedOka.displayName)
                    .foregroundColor(.blue)
                    .frame(maxWidth: 230, minHeight: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .accessibilityLabel(Strings.okaSelectionAccessibility)
            .confirmationDialog(Strings.okaLabel, isPresented: $isShowingDialog, titleVisibility: .visible) {
                ForEach(OkaOption.allCases) { option in
                    Button(option.displayName) {
                        selectedOka = option
                    }
                }
                Button(Strings.cancelButton, role: .cancel) {}
            }
        }
    }
}
