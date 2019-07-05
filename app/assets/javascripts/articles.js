$(document).on("turbolinks:load", function() {
    var cb = $("#article_no_expiration"); // チェックボックス
    var field = $("#article_expired_at"); // 日付入力項目

    // 実際にチェックボックスをクリックしたときの処理
    var changeExpiredAt = function() {
        if (cb.prop("checked"))
            // チェックボックスのチェックがONのときに、クリックされた場合
            // 日付入力項目を隠す
            field.hide()
        else
            // チェックボックスのチェックがOFFのときに、クリックされた場合
            // 日付入力項目を表示する
            field.show()
    }

    // チェックボックスと処理を関係させる
    cb.bind("click", changeExpiredAt);

    changeExpiredAt();
})
