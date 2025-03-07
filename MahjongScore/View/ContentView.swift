//
//  ContentView.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: 状態管理
    /// データ管理用viewModel
    @StateObject private var viewModel = ContentViewModel()
    /// フォーカス管理（現在選択中のTextField）
    @FocusState private var focusedField: Int?
    /// タップ判定の制御用
    @State private var ignoreTextFieldTap = false
    
    // MARK: - メインビュー
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    // MARK: ヘッダー
                    Text(Strings.headerTitle)
                        .font(.title)
                        .bold()
                        .padding(.top, 20)
                    
                    // MARK: スコア入力欄
                    ForEach(viewModel.players.indices, id: \.self) { index in
                        HStack {
                            Text(viewModel.players[index].name)
                                .font(.headline)
                                .frame(width: 50, alignment: .leading)
                                .padding(.leading, 8)
                            
                            TextField(Strings.scorePlaceholder, text: $viewModel.players[index].score)
                                .keyboardType(.numberPad)
                                .padding()
                                .frame(width: 150, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .focused($focusedField, equals: index)
                                .onTapGesture {
                                    ignoreTextFieldTap = true
                                }
                        }
                    }
                    
                    // MARK: ウマ選択
                    UmaSelectionView(selectedUma: $viewModel.selectedUma)
                        .padding(.vertical, 5)
                    
                    // MARK: オカ選択
                    OkaSelectionView(selectedOka: $viewModel.selectedOka)
                        .padding(.bottom, 15)
                    
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
                    /// 入力エラー時のアラート表示
                    .alert(isPresented: $viewModel.showError) {
                        Alert(title: Text(Strings.errorTitle), message: Text(viewModel.errorMessage), dismissButton: .default(Text(Strings.okButton)))
                    }
                    
                    // MARK: 計算結果の表示
                    VStack {
                        ForEach(viewModel.rankedPlayers.indices, id: \.self) { index in
                            let player = viewModel.rankedPlayers[index]
                            ScoreCardView(player: player, rank: index + 1)
                        }
                    }
                    Spacer()
                }
                .padding()
                // MARK: - キーボードカスタムツールバー（マイナスボタン / 次へボタン）
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        KeyboardToolbar(
                            focusedField: $focusedField,
                            scoreText: Binding(
                                get: { viewModel.players[focusedField ?? 0].score },
                                set: { viewModel.players[focusedField ?? 0].score = $0 }
                            ),
                            totalFields: viewModel.players.count
                        )
                    }
                }
            }
            .navigationBarHidden(true)
            // MARK: - 枠外タップ時にキーボードを閉じる
            .simultaneousGesture(
                TapGesture().onEnded {
                    if !ignoreTextFieldTap {
                        focusedField = nil
                    }
                    ignoreTextFieldTap = false
                }
            )
        }
    }
}
