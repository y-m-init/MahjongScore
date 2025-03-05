//
//  ContentView.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import SwiftUI

struct ContentView: View {
    @State private var players: [Player] = Strings.defaultPlayers.map { Player(name: $0, score: "", rankScore: 0) }
    @State private var selectedUma = Strings.umaGoto
    @State private var rankedPlayers: [Player] = []
    @State private var selectedOka = Strings.okaOptions[0]
    @State private var showError = false
    @State private var errorMessage = ""
    @FocusState private var focusedField: Int?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text(Strings.headerTitle)
                        .font(.title)
                        .bold()
                        .padding(.top, 20)
                    
                    // スコア入力欄
                    ForEach(players.indices, id: \.self) { index in
                        HStack {
                            TextField(Strings.namePlaceholder, text: $players[index].name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 80)
                            
                            TextField(Strings.scorePlaceholder, text: $players[index].score)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 120)
                                .focused($focusedField, equals: index)
                                .submitLabel(.done)
                                .onSubmit {
                                    focusedField = (index < players.count - 1) ? index + 1 : nil
                                }
                        }
                    }
                    
                    // ウマ選択
                    VStack {
                        HStack {
                            Text(Strings.umaLabel)
                            Picker("", selection: $selectedUma) {
                                ForEach(Strings.umaOptions, id: \.self) { option in
                                    Text(option)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding(.top, 10)
                        // ウマの説明文
                        VStack(alignment: .leading) {
                            Text(Strings.umaDescriptionFiveFifteen)
                            Text(Strings.umaDescriptionTenThirty)
                        }
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 1)
                    }
                    // オカ選択
                    HStack {
                        Text(Strings.okaLabel)
                        Picker("", selection: $selectedOka) {
                            ForEach(Strings.okaOptions, id: \.self) { option in
                                Text(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                    
                    // 計算ボタン
                    Button(action: validateAndCalculate) {
                        Text(Strings.calculateButton)
                            .font(.headline)
                            .frame(width: 100, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 2)
                    }
                    .alert(isPresented: $showError) {
                        Alert(title: Text(Strings.errorTitle), message: Text(errorMessage), dismissButton: .default(Text(Strings.okButton)))
                    }
                    
                    // 計算結果
                    VStack {
                        ForEach(rankedPlayers.indices, id: \.self) { index in
                            let player = rankedPlayers[index]
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
    
    func validateAndCalculate() {
        if let error = ScoreCalculator.validateScores(players: players) {
            errorMessage = error
            showError = true
            return
        }
        rankedPlayers = ScoreCalculator.calculate(players: players, selectedUma: selectedUma, selectedOka: selectedOka)
    }
}

#Preview {
    ContentView()
}
