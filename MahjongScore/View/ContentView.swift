//
//  ContentView.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()
    @FocusState private var focusedField: Int?
    @State private var ignoreTextFieldTap = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Text(Strings.headerTitle)
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)

                    VStack(spacing: 10) {
                        ForEach(Array(viewModel.players.enumerated()), id: \.element.id) { index, player in
                            ScoreInputRow(
                                playerName: player.name,
                                scoreText: scoreBinding(for: index),
                                focusedField: $focusedField,
                                index: index,
                                ignoreTextFieldTap: $ignoreTextFieldTap
                            )
                        }
                    }

                    UmaSelectionView(selectedUma: $viewModel.selectedUma)
                        .padding(.vertical, 5)

                    OkaSelectionView(selectedOka: $viewModel.selectedOka)
                        .padding(.bottom, 15)

                    Button(action: viewModel.validateAndCalculate) {
                        Text(Strings.calculateButton)
                            .font(.title2.bold())
                            .frame(width: 130, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 2)
                            .padding(.bottom, 15)
                    }
                    .accessibilityLabel(Strings.calculateButton)

                    if !viewModel.rankedPlayers.isEmpty {
                        ResultListView(players: viewModel.rankedPlayers)
                    }

                    Spacer()
                }
                .padding()
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        KeyboardToolbar(
                            focusedField: $focusedField,
                            scoreText: toolbarScoreBinding,
                            totalFields: viewModel.players.count
                        )
                    }
                }
            }
            .navigationBarHidden(true)
            .simultaneousGesture(
                TapGesture().onEnded {
                    if !ignoreTextFieldTap {
                        focusedField = nil
                    }
                    ignoreTextFieldTap = false
                }
            )
            .alert(isPresented: $viewModel.showError) {
                Alert(
                    title: Text(Strings.errorTitle),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text(Strings.okButton))
                )
            }
        }
    }

    private func scoreBinding(for index: Int) -> Binding<String> {
        Binding(
            get: { viewModel.scoreInput(at: index) },
            set: { viewModel.updateScoreInput($0, at: index) }
        )
    }

    private var toolbarScoreBinding: Binding<String> {
        Binding(
            get: {
                guard let field = focusedField, viewModel.isValidPlayerIndex(field) else { return "" }
                return viewModel.scoreInput(at: field)
            },
            set: { newValue in
                guard let field = focusedField, viewModel.isValidPlayerIndex(field) else { return }
                viewModel.updateScoreInput(newValue, at: field)
            }
        )
    }
}

private struct ScoreInputRow: View {
    let playerName: String
    @Binding var scoreText: String
    var focusedField: FocusState<Int?>.Binding
    let index: Int
    @Binding var ignoreTextFieldTap: Bool

    var body: some View {
        HStack {
            Text(playerName)
                .font(.headline)
                .frame(width: 60, alignment: .leading)
                .padding(.leading, 8)

            TextField(Strings.scorePlaceholder, text: $scoreText)
                .keyboardType(.numberPad)
                .padding()
                .frame(width: 170, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .focused(focusedField, equals: index)
                .onTapGesture {
                    ignoreTextFieldTap = true
                }
                .accessibilityLabel("\(playerName)\(Strings.scoreInputAccessibility)")
        }
    }
}

private struct ResultListView: View {
    let players: [Player]

    var body: some View {
        VStack(spacing: 8) {
            ForEach(Array(players.enumerated()), id: \.element.id) { index, player in
                ScoreCardView(player: player, rank: index + 1)
                    .accessibilityLabel("\(Strings.resultCardAccessibility) \(index + 1)")
            }
        }
    }
}
