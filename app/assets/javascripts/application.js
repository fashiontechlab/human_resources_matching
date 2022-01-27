// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require moment
//= require fullcalendar
//= require fullcalendar/lang/ja
//= require_tree .

$(function () {
    // addボタン押下時の処理
    $("#total").on("click", function(){
        $("#total").css("background-color","pink");
        $("#total").css("color","white");
        // 画面表示時に経費の合計値を計算
        var sum_price = sum();
        function sum(){
            // 表の金額を取得する(tdの列を取得)
            var pricelist = $("[class=price]").map(function(index, val){
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
            $(".sum_price").text(total);
        }

        var sales_sum_price = sales_sum();
        function sales_sum(){
            var sales_pricelist = $("[class=sales_price]").map(function(index, val){
                var sales_price = parseInt($(val).text());
                if (sales_price >= 0 ) {
                    return sales_price;
                } else {
                    return null;
                }
            });
            var sales_total = 0;

            sales_pricelist.each(function(index, val){
                sales_total = sales_total + val;
            });
            $(".sales_sum_price").text(sales_total);
        }

        var system_sum_price = system_sum();
        function system_sum(){
            var system_pricelist = $("[class=system_price]").map(function(index, val){
                var system_price = parseInt($(val).text());
                if (system_price >= 0 ) {
                    return system_price;
                } else {
                    return null;
                }
            });
            var system_total = 0;

            system_pricelist.each(function(index, val){
                system_total = system_total + val;
            });
            $(".system_sum_price").text(system_total);
        }
    });
});
