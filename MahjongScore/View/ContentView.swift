//
//  ContentView.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: 状態管理
    @StateObject private var viewModel = ContentViewModel()
    @FocusState private var focusedField: Int?
    
    // MARK: - メインビュー
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    // MARK: ヘッダー
                    Text(Strings.headerTitle)
                        .font(.title)
                        .bold()
                        .padding(.top, 20)
                    
                    // MARK: スコア入力欄
                    ForEach(viewModel.players.indices, id: \ .self) { index in
                        HStack {
                            Text(viewModel.players[index].name)
                                .font(.headline)
                                .frame(width: 50, alignment: .leading)
                                .padding(.leading, 8)
                            
                            TextField(Strings.scorePlaceholder, text: $viewModel.players[index].score)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 150, alignment: .leading)
                                .focused($focusedField, equals: index)
                        }
                    }
                    
                    // MARK: ウマ選択
                    UmaPickerView(selectedUma: $viewModel.selectedUma)
                        .onTapGesture {
                            focusedField = nil
                        }
                    
                    // MARK: オカ選択
                    OkaPickerView(selectedOka: $viewModel.selectedOka)
                        .onTapGesture {
                            focusedField = nil
                        }
                    
                    // MARK: 計算ボタン
                    Button(action: viewModel.validateAndCalculate) {
                        Text(Strings.calculateButton)
                            .font(.headline)
                            .frame(width: 100, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 2)
                    }
                    .alert(isPresented: $viewModel.showError) {
                        Alert(title: Text(Strings.errorTitle), message: Text(viewModel.errorMessage), dismissButton: .default(Text(Strings.okButton)))
                    }
                    
                    // MARK: 計算結果の表示
                    VStack {
                        ForEach(viewModel.rankedPlayers.indices, id: \ .self) { index in
                            let player = viewModel.rankedPlayers[index]
                            ScoreCardView(player: player, rank: index + 1)
                        }
                    }
                    Spacer()
                }
                .padding()
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        KeyboardToolbar(focusedField: $focusedField, totalFields: viewModel.players.count)
                    }
                }
            }
            .navigationBarHidden(true)
            .simultaneousGesture(
                TapGesture().onEnded {
                    focusedField = nil
                }
            )
        }
    }
}
