//
//  ContentView.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - ViewModel（状態管理）
    @StateObject private var viewModel = ContentViewModel()
    
    // MARK: - メインビュー
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    // MARK: ヘッダー
                    /// 画面のタイトル
                    Text(Strings.headerTitle)
                        .font(.title)
                        .bold()
                        .padding(.top, 20)
                    
                    // MARK: スコア入力欄
                    /// 各プレイヤーの名前 & スコア入力欄
                    ForEach(viewModel.players.indices, id: \.self) { index in
                        HStack {
                            TextField(Strings.namePlaceholder, text: $viewModel.players[index].name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 80)
                            
                            TextField(Strings.scorePlaceholder, text: $viewModel.players[index].score)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 120)
                        }
                    }
                    
                    // MARK: ウマ選択
                    /// ウマの選択（5-10, 10-20 など）
                    UmaPickerView(selectedUma: $viewModel.selectedUma)
                    
                    // MARK: オカ選択
                    /// オカの選択（あり / なし）
                    OkaPickerView(selectedOka: $viewModel.selectedOka)
                    
                    // MARK: 計算ボタン
                    /// 計算を実行するボタン
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
                    /// 計算後の順位点（ポイント）を表示
                    VStack {
                        ForEach(viewModel.rankedPlayers.indices, id: \.self) { index in
                            let player = viewModel.rankedPlayers[index]
                            ScoreCardView(player: player, rank: index + 1)
                        }
                    }
                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}
