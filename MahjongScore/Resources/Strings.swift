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
    static let players = ["東家", "南家", "西家", "北家"]
    // ボタン文言
    static let calculateButton = "計算"
    static let okButton = "OK"
    static let doneButton = "完了"
    static let nextButton = "次へ"
    static let minusButton = "-"
    // エラータイトル
    static let errorTitle = "入力エラー"
    // エラーメッセージ
    static let errorScoreMissing = "{players}の点数を入力してください"
    static let errorScoreInvalid = "{players}の点数には整数を入力してください"
    // ウマの種類
    static let umaFiveTen = "5-10"
    static let umaFiveFifteen = "5-15（雀魂友人戦ルール）"
    static let umaTenTwenty = "10-20"
    static let umaTenThirty = "10-30（Mリーグルール）"
    static let umaTwentyThirty = "20-30"
    static let umaOptions = [umaFiveTen, umaFiveFifteen, umaTenTwenty, umaTenThirty, umaTwentyThirty]
    // オカの選択肢
    static let okaEnabled = "あり"
    static let okaDisabled = "なし"
    static let okaOptions = [okaEnabled, okaDisabled]
}
