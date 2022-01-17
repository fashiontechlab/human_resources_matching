$(function () {
    // addボタン押下時の処理
    $("#total").on("click", function(){
        $("#total").css("background-color","pink");
        $("#total").css("color","white");
        // 画面表示時に経費の合計値を計算
        var sum_price = sum();
        function sum(){
            // 表の金額を取得する(tdの列を取得)
            var pricelist = $("table td[class=price]").map(function(index, val){
                var price = parseInt($(val).text());
                if(price >= 0) {
                    return price;
                } else {
                    return null;
                }
            });
            // 価格の合計を求める
            var total = 0;

            pricelist.each(function(index, val){
                total = total + val;
            });
            $(".sum_price").text(total+"円");
        }
    });
});
