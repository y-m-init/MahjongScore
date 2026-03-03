//
//  Strings.swift
//  MahjongScore
//
//  Created by Yukiko Mitani on 2025/03/05.
//

import Foundation

struct Strings {
    private static func localized(_ key: String, _ fallback: String) -> String {
        NSLocalizedString(key, tableName: nil, bundle: .main, value: fallback, comment: "")
    }

    // タイトル
    static let headerTitle = localized("header_title", "麻雀 順位点計算機")

    // プレースホルダー
    static let scorePlaceholder = localized("score_placeholder", "点数")
    static let namePlaceholder = localized("name_placeholder", "名前")

    // ラベル
    static let umaLabel = localized("uma_label", "ウマ")
    static let okaLabel = localized("oka_label", "オカ")
    static let rankLabel = localized("rank_label", "位")
    static let pointLabel = localized("point_label", "ポイント")

    static let players = [
        localized("player_east", "東家"),
        localized("player_south", "南家"),
        localized("player_west", "西家"),
        localized("player_north", "北家")
    ]

    // ボタン文言
    static let calculateButton = localized("calculate_button", "計算")
    static let okButton = localized("ok_button", "OK")
    static let doneButton = localized("done_button", "完了")
    static let nextButton = localized("next_button", "次へ")
    static let minusButton = localized("minus_button", "-")
    static let cancelButton = localized("cancel_button", "キャンセル")

    // エラータイトル
    static let errorTitle = localized("error_title", "入力エラー")

    // エラーメッセージ
    static func errorScoreMissing(players: [String]) -> String {
        let format = localized("error_score_missing", "%@の点数を入力してください")
        return String(format: format, players.joined(separator: "、"))
    }

    static func errorUnsupportedPlayerCount(expected: Int, actual: Int) -> String {
        let format = localized("error_unsupported_player_count", "プレイヤー数が不正です（期待: %d人 / 実際: %d人）")
        return String(format: format, expected, actual)
    }

    // ウマの種類
    static let umaFiveTen = localized("uma_5_10", "5-10")
    static let umaFiveFifteen = localized("uma_5_15", "5-15（雀魂友人戦ルール）")
    static let umaTenTwenty = localized("uma_10_20", "10-20")
    static let umaTenThirty = localized("uma_10_30", "10-30（Mリーグルール）")
    static let umaTwentyThirty = localized("uma_20_30", "20-30")

    // オカの選択肢
    static let okaEnabled = localized("oka_enabled", "あり")
    static let okaDisabled = localized("oka_disabled", "なし")

    // アクセシビリティ
    static let scoreInputAccessibility = localized("a11y_score_input", "点数入力")
    static let umaSelectionAccessibility = localized("a11y_uma_selection", "ウマ設定")
    static let okaSelectionAccessibility = localized("a11y_oka_selection", "オカ設定")
    static let resultCardAccessibility = localized("a11y_result_card", "順位結果")
}
