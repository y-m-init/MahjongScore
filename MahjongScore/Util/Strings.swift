//
//  Strings.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import Foundation

struct Strings {
    // タイトル
    static let headerTitle = "麻雀 順位点計算機"
    // プレースホルダー
    static let scorePlaceholder = "点数"
    static let namePlaceholder = "名前"
    // ラベル
    static let umaLabel = "ウマ"
    static let okaLabel = "オカ"
    static let rankLabel = "位: "
    static let pointLabel = "ポイント: "
    // 説明文
    // ボタン文言
    static let calculateButton = "計算"
    static let okButton = "OK"
    // エラータイトル
    static let errorTitle = "入力エラー"
    // エラーメッセージ
    static let errorScoreMissing = "{players}の点数を入力してください"
    static let errorScoreInvalid = "{players}の点数には整数を入力してください"
    // デフォルト値
    static let defaultPlayers = ["東家", "南家", "西家", "北家"]
    static let defaultUma = "5"
    static let defaultOka = "10"
    static let defaultPlayerName = "プレイヤー"
    // ウマの種類
    static let umaGoto = "5-10"
    static let umaFiveFifteen = "5-15"
    static let umaOneTwo = "10-20"
    static let umaOneThree = "10-30"
    static let umaTwoThree = "20-30"
    static let umaOptions = [umaGoto, umaFiveFifteen, umaOneTwo, umaOneThree, umaTwoThree]
    // ウマの説明文
    static let umaDescriptionFiveFifteen = "※ 5-15：雀魂友人戦ルール"
    static let umaDescriptionTenThirty = "※ 10-30：Mリーグルール"
    // オカの選択肢
    static let okaOptions = ["あり", "なし"]
}
