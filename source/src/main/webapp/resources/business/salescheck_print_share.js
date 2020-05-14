
function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}
console.log(GetQueryString("key1"))
// type :print /share;    param:salesNo  key    url:
function pageLoad(type, param, url) {
    $.ajax({
        url: url + param,
        dataType: "json",
        success: function (date) {
            var dat = date.salesCheckingOrderDetails

            if (type = "print") {
                $("title").text(date.salesCheckingOrder.comName + "的销售对账单（" + date.salesCheckingOrder.orderCycle + "）")
            } else {
                $("title").text(date.salesCheckingOrder.comName + "销售对账单")
            }

            $(".list_one").html(
                "<span>客户 : " + date.salesCheckingOrder.partnerShortname + "</span>&#x3000;<span>税号 :" + date.salesCheckingOrder.taxNo + "</span>&#x3000;<span> " + date.salesCheckingOrder.contactName + " (" + date.salesCheckingOrder.contactTel + ")</span>&#x3000;<span>地址 : " + date.salesCheckingOrder.partnerAddress + "</span>"
            )
            $(".total_right").html(
                "<ul class='ding'>"
                + "<li>合&#x3000;&#x3000;&#x3000;计 :<span>" + date.salesCheckingOrder.price.toFixed(2) + "</span></li>"
                + "<li>折&#x3000;&#x3000;&#x3000;扣 :<span> - <i>" + date.salesCheckingOrder.discount.toFixed(2) + "</i> </span></li>"
                + "<li>减&#x3000;&#x3000;&#x3000;免 :<span> - <i>" + date.salesCheckingOrder.preferential.toFixed(2) + "</i> </span></li>"
                + "<li>税&#x3000;&#x3000;&#x3000;款 :<span> <i>" + date.salesCheckingOrder.taxPrice.toFixed(2) + "</i> </span></li>"
                + "<div class='division'></div>"
                + "</ul>"
            )
            $(".total_left").html("<ul><li style='margin-bottom:8px;'>对账单金额 :<span style='float:right;'>" + date.salesCheckingOrder.totalPrice.toFixed(2) + "</span></li>"
                + "<li style='margin-bottom:2px;'>预&#x3000;&#x3000;&#x3000;收 :<span style='float:right;'> - <i>" + date.salesCheckingOrder.depositRequested.toFixed(2) + "</i> </span></li>"
                + "<li style='margin-bottom:2px;' class='li-one'>应&#x3000;&#x3000;&#x3000;收 :<span style='float:right;'>  <i>" + date.salesCheckingOrder.receivablesMoney.toFixed(2) + "</i> </span></li>"
                + "<li style='margin-bottom:2px;' class='li-two'>实&#x3000;&#x3000;&#x3000;收 :<span style='float:right;'>  <i>" + date.salesCheckingOrder.paidUp.toFixed(2) + "</i> </span></li>"
                + "</ul>")
            if (date.salesCheckingOrder.remarks == "" || date.salesCheckingOrder.remarks == "null") {
                $(".total_beizhu").hide()
            } else {
                $("#shifouweikong").html(date.salesCheckingOrder.remarks)
            }
            if (date.salesCheckingOrder.orderStatus != "08") {
                $(".total-preson").html("<p><span class='money'>经办人签字 :</span></p>")
            }

            $(".Customer-address").html(
                "开户 : <span>" + date.bottomComInfo.comBank + "</span>"
                + "账号 : <span>" + date.bottomComInfo.comAccount + "</span>"
                + "<span class='relation'><span style='margin:0;'>联系人 : " + date.bottomComInfo.realName + " (" + date.bottomComInfo.userId + ")</span></span>"
                + "<span class='addr'><span style='margin:0;'>地址 : "
                + "<b>" + date.bottomComInfo.comAddress + "</b>"
                + "</span></span>"
                + "<span style='float:right;margin:0;'>制单人 ：<span style='margin:0;'>" + date.salesCheckingOrder.creatorName + " (" + date.salesCheckingOrder.createTime + ")</span></span>"
            )
            // 收款二微码显隐判断

            $(".alipayCls").css({ "background": "url('/resources/images/qrpay/alipay/" + date.salesCheckingOrder.comKey + ".png')" });
            $(".wechatCls").css({ "background": "url('/resources/images/qrpay/wechat/" + date.salesCheckingOrder.comKey + ".png')" });
            $.each(ProvinceJson, function (key, val) {
                if (val.provinceId == date.bottomComInfo.comProvince) {
                    $("#sheng1").html(val.provinceName);
                    return false;
                }
            });

            $.each(CityJson, function (key, val) {
                if (val.provinceId == date.bottomComInfo.comProvince && val.cityId == date.bottomComInfo.comCity) {
                    $("#shi1").html(val.cityName);
                    return false;
                }
            });

            $.each(CountryJson, function (key, val) {
                if (val.cityId == date.bottomComInfo.comCity && val.countryId == date.bottomComInfo.comCountry) {
                    $("#xian2").html(val.countryName);
                    return false;
                }
            });





            $(".order span").eq(0).text(date.salesCheckingOrder.salescheckingNo)
            if (date.bottomComInfo.realName == "-" && date.bottomComInfo.userId == "-") {
                $(".relation").hide();
            }
            if (date.bottomComInfo.comAddress == "-") {
                $(".addr").hide();
            }
            if (date.salesCheckingOrder.discount == "" || date.salesCheckingOrder.discount == "null") {
                $(".total_right li").eq(1).hide()
            }
            if (date.salesCheckingOrder.preferential == "" || date.salesCheckingOrder.preferential == "null") {
                $(".total_right li").eq(2).hide()
            }
            if (date.salesCheckingOrder.purchasecheckingNo == "" || date.salesCheckingOrder.purchasecheckingNo == "null") {
                $(".order p").eq(1).hide()
            } else {
                $(".cont").text(date.salesCheckingOrder.purchasecheckingNo)
            }
            if (date.salesCheckingOrder.paidUp == "" || date.salesCheckingOrder.paidUp == "null") {
                $(".li-two").hide()
            } else (
                $(".li-one").hide()
            )
            $(".header span span").eq(0).text(date.salesCheckingOrder.comName)
            $(".header span span").eq(2).text("(" + date.salesCheckingOrder.orderCycle + ")")
            reload(dat);
            // mergeCellsByField("order", 'date.salesCheckingOrder.partnerShortname');
            $("#sales_scan").click(function (e) {

                e.preventDefault();
                $(".scan").show();
                $.ajax({
                    type: "POST",
                    url: "/wechat/pay/paykey",
                    data: { "salescheckingNo": date.salesCheckingOrder.salescheckingNo },
                    dataType: "json",
                    success: function (dat) {
                        if (dat.code == 1) {
                            $.ajax({
                                type: "GET",
                                url: "/wechat/pay/doPay?key=" + dat.paykey,
                                dataType: "json",
                                success: function (dt) {
                                    if (dt.status == "1") {
                                        $('.qrCodeDataMid').empty();
                                        $('.qrCodeDataMid').qrcode({ width: 140, height: 140, text: dt.url });
                                        var polling = setInterval(function () {
                                            $.ajax({
                                                type: "GET",
                                                url: "/wechat/pay/polling?tradeNo=" + dat.tradeNo,
                                                dataType: "json",
                                                success: function (dt) {
                                                    if (dt.code == 1) {
                                                        clearInterval(polling);
                                                        $(".scan").hide();
                                                        $(".window-mask").show();
                                                        $("#money").text(date.salesCheckingOrder.receivablesMoney.toFixed(2));
                                                    }
                                                }
                                            })
                                        }, 5000)

                                    } else {
                                        $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(3000).fadeOut(250).appendTo('body');
                                    }
                                }
                            })
                        }else{
                            $("<div class='tips_contants'>").fadeIn(250).html(dat.msg).delay(3000).fadeOut(250).appendTo('body');
                        }

                    }
                })
            })
            $(".closepage").click(function () {
                $(".scan").hide();
            })
        }
    })

}

function reload(dat) {
    var arr = [];
    var col = [
        { field: 'orderDate', title: '订単日期', width: 120, align: 'center' },
        { field: 'businessDesc', title: '业务内容', width: 250, align: 'left' },
        { field: 'requirements', title: '物料/制作/说明', width: 231, align: 'left' },
        {
            field: 'specification', title: '规格(m)', width: 130, align: 'center'
        },
        { field: 'quantity', title: '数量', width: 60, align: 'center' },
        { field: 'totalArea', title: '面积(㎡)', width: 75, align: 'center' },
        { field: 'unit', title: '单位', width: 90, align: 'center' },
        {
            field: 'unitPrice', title: '单价', width: 90, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2)
            }
        },
        {
            field: 'totalPrice', title: '行小计', width: 90, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2)
            }
        }
    ];
    var tdCol = "";
    for (var j = 0; j < col.length; j++) {
        tdCol += "<th align='center' width='" + col[j].width + "'>" + col[j].title + "</th>";
    }
    $('#order thead').html("<tr>" + tdCol + "</tr>");
    for (var i = 0; i < dat.length; i++) {
        arr.push("<tr><td align='" + col[0].align + "'><input type='hidden' value='" + dat[i]['salesNo'] + "' />" + dat[i][col[0].field] + "</td><td align='" + col[1].align + "'>" + dat[i][col[1].field] + "</td><td align='" + col[2].align + "'>" + dat[i][col[2].field] + "</td><td align='" + col[3].align + "'>" + dat[i]["specification"] + "</td><td align='" + col[4].align + "'>" + dat[i][col[4].field] + "</td><td align='" + col[5].align + "'>" + dat[i][col[5].field] + "</td><td align='" + col[6].align + "' >" + dat[i][col[6].field] + "</td><td align='" + col[7].align + "'>" + accounting.formatNumber(dat[i][col[7].field], 2) + "</td><td align='" + col[8].align + "'>" + accounting.formatNumber(dat[i][col[8].field], 2) + "</td></tr>");
    }
    $('#order tbody').html(arr.join(""));
    $("#order tbody").rowspan(0);
}
function onLoadSuccess(data) {
    if (data.rows.length > 0) {
        mergeCellsByField("order", 'orderDate,salesNo');
    } else {

    }
}
$(function () {
    $("#print").click(function () {
        window.print();
    });
})

    ; (function ($) {
        $.fn.extend({
            //表格合并单元格，colIdx要合并的列序号，从0开始
            "rowspan": function (colIdx) {
                return this.each(function () {
                    var that;
                    var thatVal;
                    $('tr', this).each(function (row) {
                        var $tdVal = $("td:eq(0)", this).find("input").val();
                        $('td:eq(' + colIdx + ')', this).filter(':visible').each(function (col) {
                            if (that != null && $(this).find("input").val() == $(that).find("input").val()) {

                                rowspan = $(that).attr("rowSpan");
                                if (rowspan == undefined) {
                                    $(that).attr("rowSpan", 1);
                                    rowspan = $(that).attr("rowSpan");
                                }
                                rowspan = Number(rowspan) + 1;
                                $(that).attr("rowSpan", rowspan);
                                $(this).hide();

                            } else {
                                that = this;
                            }
                        });
                    });
                });
            }
        });

    })(jQuery);