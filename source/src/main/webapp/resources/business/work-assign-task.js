var pageUrl = "/order/workingassigntask/listAssignWorkingTaskAndDetailsByOrder";// 本页面请求url1
$(function () {
    $(".jump").click(function(){
        var App = window.parent.App;
        var config = {
            path: "/ad/salesorder/forward-synchroSingleSalesOrder"
        };
        App.open(config.path, config);
    })
    var dateObj = orderUtil.dpDateCompute("ld", 30);
    $('#datetimepickers').datetimepicker({
        format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true,
        minView: 'month'
    }).on("click", function () {
        $("#datetimepickers").datetimepicker("setEndDate", $("#datetimepickere").val())
    });
    $('#datetimepickere').datetimepicker({
        format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true,
        minView: 'month'
    }).on("click", function () {
        $("#datetimepickere").datetimepicker("setStartDate", $("#datetimepickers").val())
    });
    $("#datetimepickers").val(dateObj.beforeDate);
    $("#datetimepickere").val(dateObj.nowDate);
    $("#dateDat").html(returnopt(orderUtil.dateConfig, 2)).change(function () {
        var code = $(this).val().substring(0, 2);
        var num = $(this).val().substring(2, $(this).val().length);
        var dt = orderUtil.dpDateCompute(code, num);
        $("#datetimepickers").val(dt.beforeDate);
        $("#datetimepickere").val(dt.nowDate);
    });
    $("#dateDat").select2({
        minimumResultsForSearch: Infinity
    });

    $.ajax({
        url: "/system/partner/dropdownPartner?partnerType=1",
        dataType: "json",
        timeout: "8000",
        success: function (data) {
            $("#customerDat").html(returnopt(data, 1));
            $("#customerDat").select2({
//                        maximumInputLength:2,
                templateResult: formatState
            });
            var showNum = "order4";
            var type = GetRequest().type;
            if (type != "" && type != undefined) {
                showNum = type;
            }
            $("#navCondition").find("." + showNum).addClass("smcolor").siblings().removeClass("smcolor");

            var status = $("#navCondition").find("." + showNum).attr("data-s");
            reload(status);
        },
        error: function () {
        }
    });
    //全部订单搜索
    $("#searchBtn").click(function () {
        var status = $("#navCondition").find(".smcolor").attr("data-s");
        reload(status);
    })
    $("#switch_order").on("click", "span", function () {
        $(this).addClass("switch_handle_on").siblings().removeClass("switch_handle_on");
        var status = $("#navCondition").find(".smcolor").attr("data-s");
        reload(status);
    });
    $("#navCondition").on("click","li",function () {
        $(this).addClass("smcolor").siblings().removeClass("smcolor");
        reload("");

    });
});
function returnopt(data, type) {
    var opt = "";
    for (var i = 0; i < data.length; i++) {
        var dt = data[i];
        var dtn = "";
        if (type == 1) {
//                    if(dt.partnerShortname==undefined){continue;}
            dtn = dt.myComShortname == undefined ? "全部客户" : dt.myComShortname;
            opt += '<option value="' + dt.partnerKey + '">' + dtn + '</option>';
        }
        if (type == 2) {
            dtn = dt.show;
            opt += '<option value="' + dt.key + '">' + dtn + '</option>';
        }
    }
    return opt;
}
function formatState(state) {
    var $state = $(
        '<span >' + state.text + '</span>'
//                '<span style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:90px;display: block;">'+state.text + '</span><i style="position:absolute;right:0;top:5px;">sfsd</i>'
//                '<span><img src="/' + state.element.value.toLowerCase() + '.png" class="img-flag" /> ' + state.text + '</span>'
    );
    return $state;
}
function GetRequest() {
    var url = location.search; //获取url中"?"符后的字串
    var theRequest = new Object();
    if (url.indexOf("?") != -1) {
        var str = url.substr(1);
        strs = str.split("&");
        for (var i = 0; i < strs.length; i++) {
            theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);
        }
    }
    return theRequest;
}

function arrFunDetail(){
    var arrclo=[];
    arrclo.push({
        field: 'orderDate',
        title: '订单日期',
        width: 100,
        align: 'center',
        sortable: true,
        formatter: function (value, row) {
            return '<span class="namebdsml">'+value+'</span>';
        }
    });
    arrclo.push({field: 'partnerShortname', title: '客户', width: 100,      formatter: function (value, row) {

        return '<div>' + row.partnerShortname + '</div>'+'<div class="namebd"><span class="namebdsml">'+row.contactName+'</span></div>';
    }});
    arrclo.push({field: 'businessDesc', width: 280, title: '业务内容'});
    arrclo.push({field: 'requirements', width: 218, title: '物料/制作/说明', formatter: function (value, row) {
        if (row.isUrgent=="1") {//加急
        return value + '<p class="plistmarkSale" id="sale" style="background: #FF5858;color:#fff;transform: scale(0.9);">加急</p>';
    }
    return value;
}});
    arrclo.push({field: 'workingStatus', width: 100, align: 'center', title: '制作进度',      formatter: function (value, row) {
        if(value=="制作中"){
            return '<div data-id="'+row.salesNo+'" onclick="openDt(this)" style="cursor:pointer;color:#ff9900;">' + value + '</div>';
        }else if(value=="完工") {
            return '<div data-id="'+row.salesNo+'" onclick="openDt(this)" style="cursor:pointer;color:#44ae80;">' + value + '</div>';
        }else {
            return '<div data-id="'+row.salesNo+'" onclick="openDt(this)" style="cursor:pointer;color:#EB6877;">' + value + '</div>';
        }
        
    }});
    arrclo.push({field: 'specification', width: 100, align: 'left', title: '规格(m)'});
    arrclo.push({field: 'quantity', width: 60, align: 'center', title: '数量'});
    arrclo.push({field: 'totalArea', width: 60, align: 'center', title: '面积(㎡)'});
    // arrclo.push({field: 'unit', width: 60, align: 'center', title: '单位'});


    arrclo.push({
        field: 'salesNo', width: 160, align: 'center', title: '单号', formatter: function (value, row) {
            if (row.purchaseNo != '') {
                return value + '<p class="plistmarkSale">协</p>';
            }
            return value;
        }
    });
    // arrclo.push({field: 'cz', width: 100, align: 'center', title: '操作', formatter: function (value, row) {
    //     return '<span style="cursor:pointer;color: #4284d9;" onclick="openProReq()">重新派工</span>';
    // }});

return arrclo;
}
function openProReq() {
    alert("重新派工");
}
function reload() {
    var status = $("#navCondition").find(".smcolor").attr("data-s");
    var arrclo=[],url="",pageSize=30,pageList=[30,40];
         arrclo = arrFunDetail();
        url = pageUrl;
        $('#order').datagrid({
            url: url,
            fit:true,
            onLoadSuccess:onLoadSuccess,
            pagination: true,
            pageSize:pageSize,
            pageList: pageList,
            columns: [arrclo],
            queryParams:{
                "partnerKey":$('#customerDat').val(),
                "startDate":$('#datetimepickers').val(),
                "endDate":$('#datetimepickere').val(),
                "searchKey":$('#searchK').val()
                 // "workingProcedure":"01"
            }
        });

    var pager = $('#order').datagrid('getPager');	// get the pager of datagrid
    pager.pagination({
        layout: ['first', 'links', 'last'],
        showRefresh: false,
        displayMsg: ''
    });
    $(".pagination").show();
}
function onLoadSuccess(data) {
    if (data.rows.length > 0) {
        var num = 0;
        for (var i = 0; i < data.rows.length; i++) {
            num += Number(data.rows[i]["totalPrice"]);
        }
        $("#order2PagerNum").text(data.total);
        $("#order2PagerPrice").text(accounting.formatNumber(num, 2));
            mergeCellsByField("order", 'ck,orderDate,salesNo,partnerShortname,cz,workingStatus');
            $("#totalTextSpan").html("行小计金额(元)：");


    } else {
        $("#order2PagerNum").text(0);
        $("#order2PagerPrice").text("0.00");
        $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
    }
}
function openDt(obj) {
    $("#topBarPR").show();
    $(".loading_box").removeClass("loadingssss");
    reloadPg($(obj).attr("data-id") );
}
function arrFunPg(){
    var arrclo=[];

    arrclo.push({field: 'businessDesc', width: 250, title: '业务内容', formatter: function (value, row) {

        return value;
    }});
    arrclo.push({field: 'requirements', width: 200, title: '物料/制作/说明', formatter: function (value, row) {
        if (row.isUrgent=="1") {//加急
            return value + '<p class="plistmarkSale" id="sale" style="background: #FF5858;color:#fff;transform: scale(0.9);">加急</p>';
        }
        return value;
    }});



    arrclo.push({field: 'workingProcedure', width: 100, align: 'center', title: '制作工序', formatter: function (value, row) {
        var trhtml="";
        $.map(wkListType, function (val) {
            if (value == val.id) {
                trhtml=val.text;
            }
        })
        return trhtml;
    }});
    arrclo.push({field: 'statusDesc', width: 100, align: 'center', title: '状态'});
    arrclo.push({field: 'specification', width: 100, align: 'center', title: '规格(m)', formatter: function (value, row) {
        return row.length +"x"+ row.width+"";
    }});
    return arrclo;
}
function closeProReq() {
    $(".window-mask").hide();
    $("#topBarPR").hide();
}
function reloadPg(salesno) {
    var arrclo=arrFunPg();
    var status = $("#navCondition").find(".smcolor").attr("data-s");
    var  queryParams={
        "partnerKey": "ALL",
        "searchKey": salesno,
        "page":1,
        "rows":300
    };
    $.ajax({
        url:"/order/workingassigntask/listAssignWorkingTaskAndDetails",
        data:queryParams,
        type:'post',
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        dataType:"json",
        success:function(dt){
            $('#orderPg').datagrid({
                data : dt.rows,
                columns: [arrclo]
            });
        }
    })

    $('[data-toggle="popover"]').popover();
}
function msg(content) {
    $("#msgwindow").html(content).addClass("activ");
}
function hideMsg() {
    $(".window-mask").hide();
    $("#msgwindow").css({left: "100%"}).removeClass("activ");
}
function showMessageDialog(url, title, width, height, shadow) {
    var content = '<iframe id="msgF" src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="yes"></iframe>';
    $("#msgwindow").empty();
    $("#msgwindow").css({left: "16%"});
    $(".window-mask").hide();
    var last = Date.now();
    setTimeout(function () {
        // 监听动画完成时间
        if ($("#msgwindow").hasClass("activ")) {
            msg(content);
        } else {
            $("#msgwindow")[0].addEventListener('webkitTransitionEnd', function () {
                if (Date.now() - last < 3000) {
                    msg(content);
                }
            }, false);
        }

    }, 0);
}
function showOverFlow() {
    $("#orderProcedure").css({display: 'block'})
    $(".window-mask").show();
}
function closeOverFlow() {
    $("#orderProcedure").css({display: 'none'})
    $(".window-mask").hide()
}
function mergeCellsByField(tableID, colList) {
    var ColArray = colList.split(",");
    var tTable = $("#" + tableID);
    var TableRowCnts = tTable.datagrid("getRows").length;
    var tmpA;
    var tmpB;
    var PerTxt = "";
    var CurTxt = "";
    var alertStr = "";
    for (j = ColArray.length - 1; j >= 0; j--) {
        PerTxt = "";
        tmpA = 1;
        tmpB = 0;

        for (i = 0; i <= TableRowCnts; i++) {
            if (i == TableRowCnts) {
                CurTxt = "";
            }
            else {
                CurTxt = tTable.datagrid("getRows")[i][ColArray[j]] + tTable.datagrid("getRows")[i]["salesNo"];
            }
            if (PerTxt == CurTxt) {
                tmpA += 1;
            }
            else {
                tmpB += tmpA;

                tTable.datagrid("mergeCells", {
                    index: i - tmpA,
                    field: ColArray[j],//合并字段
                    rowspan: tmpA,
                    colspan: null
                });
                tmpA = 1;
            }
            PerTxt = CurTxt;
        }
    }
}
function modifyOrder() {

    var modifyRow = new Array();
    var flag = false;
    var order4ItemsArr = $('#order').datagrid('getChecked');
    console.log(order4ItemsArr);
    var cols = [];
    var checkRow = "";
    for (var i = 0; i < order4ItemsArr.length; i++) {
        if (i == 0) {
            checkRow = order4ItemsArr[i].salesNo;
            cols.push(order4ItemsArr[i]);
        } else {
            if (order4ItemsArr[i].salesNo == checkRow) {
                continue;
            } else {
                checkRow = order4ItemsArr[i].salesNo;
                cols.push(order4ItemsArr[i]);
            }
        }
    }
    $.each(cols, function (index, item) {

        modifyRow.push(item);
    });

    /*      if (flag) {
     $("<div class='tips_contants'>").fadeIn(250).html("好友协同单已经被收货，不可修改。").delay(4000).fadeOut(250).appendTo('body');
     return false;
     }*/


    if (modifyRow.length == 1) {
        //查询订单状态
        var saleOrderNo = modifyRow[0].salesNo;
        $.post("/ad/salesorder/saleOrderOne", {salesNo: saleOrderNo}, function (data) {
            var callback = eval("(" + data + ")");
            var orderStatus = callback.orderStatus;
            if (orderStatus != modifyRow[0].orderStatus) {
                $("<div class='tips_contants'>").fadeIn(250).html("订单状态已过期，请刷新").delay(4000).fadeOut(250).appendTo('body');
                return false;
            } else {
                var App = window.parent.App;
                var config = {
                    closeable: "true",
                    icon: "icon dashboard",
                    label: "修改销售订单",
                    path: "/ad/salesorder/updatePage?salesNo=" + modifyRow[0].salesNo,
                    type: "subWindow"
                };
                App.open(config.path, config);
            }

        });
        //调转修改页面

    } else {
        if ($(".tips_contants").length > 0) {
            $(".tips_contants").remove();
            $("<div class='tips_contants'>").fadeIn(250).html("只可修改单笔订单").delay(3000).fadeOut(250).appendTo('body');
        } else {
            $("<div class='tips_contants'>").fadeIn(250).html("只可修改单笔订单").delay(3000).fadeOut(250).appendTo('body');
        }
    }


}
function openTaxPoint() {
    var order4ItemsArr = $('#order').datagrid('getChecked');
    console.log(order4ItemsArr);
    var order4Items = [];
    var checkRow = "";
    for (var i = 0; i < order4ItemsArr.length; i++) {
        if (i == 0) {
            checkRow = order4ItemsArr[i].salesNo;
            order4Items.push(order4ItemsArr[i]);
        } else {
            if (order4ItemsArr[i].salesNo == checkRow) {
                continue;
            } else {
                checkRow = order4ItemsArr[i].salesNo;
                order4Items.push(order4ItemsArr[i]);
            }
        }
    }

    var partnetKey, partnerShortname;
    var flag = false;
    var numIndex = 0, partnerIndex = 0;
    $.each(order4Items, function (index, element) {
        //判断是否同一用户
        if (numIndex == 0) {
            partnetKey = element.partnerKey;
            partnerShortname = element.partnerShortname;
        } else if (partnetKey != element.partnerKey) {
            $("<div class='tips_contants'>").fadeIn(250).html("请选择相同客户").delay(3000).fadeOut(250).appendTo('body');
            flag = true;
            return false;
        }
        numIndex++;
    });
//        只能勾选同一类型的订单生成对账单
//        如订单号旁标识“协”，则说明此单为好友订单

    if (flag) {
        return false;
    }

    $.each(order4Items, function (index, element) {
        if (partnerIndex == 0) {
            purchaseNo = element.purchaseNo;
        } else if (purchaseNo != "" && element.purchaseNo == "") {
            $("<div class='tips_contants' style='line-height: 40px;'>").fadeIn(250).html("只能勾选同一类型的订单生成对账单<br>如订单号旁标识“协”，则说明此单为好友订单").delay(3000).fadeOut(250).appendTo('body');
            flag = true;
            return false;
        } else if (purchaseNo == "" && element.purchaseNo != "") {
            $("<div class='tips_contants' style='line-height: 40px;'>").fadeIn(250).html("只能勾选同一类型的订单生成对账单<br>如订单号旁标识“协”，则说明此单为好友订单").delay(3000).fadeOut(250).appendTo('body');
            flag = true;
            return false;
        }
        partnerIndex++;
    });
    if (flag) {
        return false;
    }

    var totalPrice = 0, depositRequested = 0, receivePrice = 0;
    var salesNos = new Array();
    $.each(order4Items, function (index, element) {
        salesNos.push(element.salesNo);
        if($("#switch_order").find(".switch_handle_on").index()==0){
            totalPrice = totalPrice + element.totalPriceOrder;
        }else{
            totalPrice = totalPrice + element.totalPrice;
        }

        depositRequested = depositRequested + element.depositRequested;
    });
    if (salesNos.length == 0) {
        $("<div class='tips_contants'>").fadeIn(250).html("请选择需要对账的订单").delay(3000).fadeOut(250).appendTo('body');
    } else {
        $("#depositRequestedHid").val(depositRequested);
        $("#totalPriceHid").val(totalPrice);
//            $("#totalPriceWithTaxHid").val(totalPrice);
//            $("#taxPriceHid").val(0);
        //depositRequested 没有返回
        receivePrice = Number(totalPrice) - Number(depositRequested);
        totalPrice = accounting.formatNumber(totalPrice, 2);
        depositRequested = accounting.formatNumber(depositRequested, 2);

        receivePrice = accounting.formatNumber(receivePrice, 2);


        $("#receivePriceHid").val(receivePrice);
        $("#totalPrice").text(totalPrice);//销售价格
        $("#numIndex").text(numIndex);//订单笔数
        $("#partnerShortname").text(partnerShortname);//客户简称
        $("#depositRequested").text(depositRequested);//预收金额

        //需要变换的值
        $("#taxRateView").val(0);//税率赋值0
        $("#totalPriceWithTax").text(totalPrice);//默认价格
        $("#taxPrice").text(0.00);//默认税额
        $("#receivePrice").text(receivePrice);//应收金额
        $(".window-mask").show();
        $("#taxPointWin").css({display: 'block'});
    }
}
function addShuiDian(o) {
//        model.set("taxObj.taxRateView", 0);
    if ($("#shuidainBtn").text() == "添加税点") {
        $("#shuiDianCtrl").slideDown();
        $("#shuidainBtn").text("撤销税点")
    }
    else if ($("#shuidainBtn").text() == "撤销税点") {
        $("#taxRateView").val(0);//税率赋值0
        $("#totalPriceWithTax").text($("#totalPrice").text());//默认价格
        $("#taxPrice").text(0.00);//默认税额
        $("#receivePrice").text($("#receivePriceHid").val());//应收金额

//            $("#totalPriceWithTaxHid").val($("#receivePriceHid").val());
//            $("#taxPriceHid").val(0);

        $("#shuiDianCtrl").slideUp();
        $("#shuidainBtn").text("添加税点")
    }
}
function inputCalMoney(o) {
    if (isNaN($(o).val())) {
        $("#taxRateView").val(0);//税率赋值0
        $("#totalPriceWithTax").text($("#totalPrice").text());//默认价格
        $("#taxPrice").text(0.00);//默认税额
        $("#receivePrice").text($("#receivePriceHid").val());//应收金额

        $("#totalPriceWithTaxHid").val($("#receivePriceHid").val());
        $("#taxPriceHid").val(0);

        return;
    }
//        $("#totalPriceWithTaxHid").val(Number($("#totalPriceHid").val())*(1+Number($("#taxRateView").val())/100));
//        $("#taxPriceHid").val((Number($("#taxRateView").val())*Number($("#totalPriceHid").val())).toFixed(2));

    $("#taxPrice").text(accounting.formatNumber((Number($("#taxRateView").val()) * Number($("#totalPriceHid").val())).toFixed(0) / 100, 2));
    $("#totalPriceWithTax").text(accounting.formatNumber(Number($("#totalPriceHid").val()) * (1 + Number($("#taxRateView").val()) / 100), 2));
    $("#receivePrice").text(accounting.formatNumber((Number($("#totalPriceHid").val()) * (1 + Number($("#taxRateView").val()) / 100)) - Number($("#depositRequestedHid").val()), 2));
}
function closeTaxPoint() {
    $(".window-mask").hide();
    $("#taxPointWin").css({display: 'none'});
    $("#taxRateView").val(0);//税率赋值0
    $("#totalPriceWithTax").text($("#totalPrice").text());//默认价格
    $("#taxPrice").text(0.00);//默认税额
    $(".generatorBill").attr("disabled", false);
    $("#receivePrice").text($("#receivePriceHid").val());//应收金额
    $("#shuiDianCtrl").slideUp();
    $("#shuidainBtn").text("添加税点")
}
function batchGenerateBill(btn) {
    $(btn).attr("disabled", true);
    var order4ItemsArr = $('#order').datagrid('getChecked');
    var order4Items = [];
    var checkRow = "";
    for (var i = 0; i < order4ItemsArr.length; i++) {
        if (i == 0) {
            checkRow = order4ItemsArr[i].salesNo;
            order4Items.push(order4ItemsArr[i]);
        } else {
            if (order4ItemsArr[i].salesNo == checkRow) {
                continue;
            } else {
                checkRow = order4ItemsArr[i].salesNo;
                order4Items.push(order4ItemsArr[i]);
            }
        }
    }
    var salesNos = new Array();
    var partnetKey;
    var flag = false;
    var numIndex = 0;
    $.each(order4Items, function (index, element) {
        salesNos.push(element.salesNo);
        //判断是否同一用户
        if (numIndex == 0) {
            partnetKey = element.partnerKey;
        } else if (partnetKey != element.partnerKey) {
            $(btn).attr("disabled", false);
            $("<div class='tips_contants'>").fadeIn(250).html("请选择相同客户").delay(3000).fadeOut(250).appendTo('body');
            flag = true;
            return false;
        }
        numIndex++;

    });
    if (flag) {
        return false;
    }

    var parse = {};
    parse.salesNos = JSON.stringify(salesNos);
    parse.taxRateView = Number($("#taxRateView").val()) / 100;
    parse.taxRate = Number($("#taxRateView").val()) / 100;

    parse.totalPrice = accounting.unformat($("#totalPrice").text());
    parse.taxPrice = accounting.unformat($("#taxPrice").text());
    parse.totalPriceWithTax = accounting.unformat($("#totalPriceWithTax").text());
    $.ajax({
        type: "POST",
        url: "/ad/salesorder/generateBill",
        data: jQuery.param(parse),
        async: "false",
        dataType: "json",
        success: function (callback) {
            if (callback.status == "1") {
                closeTaxPoint();
                $(btn).attr("disabled", false);
                $("<div class='tips_contants'  style='line-height: 40px'>").fadeIn(250).html("已成功生成对账单</br>请到【销售对账单】---【待收款对账单】查看").delay(3000).fadeOut(250).appendTo('body');
                setTimeout(function () {
//                        $("#order").datagrid('reload');
                    $(".max-hidden", window.parent.document).find("li[data-url='/openPage?pageName=advert_saleschecking-order-list']").click().addClass("active");
                }, 2000);

            } else {
                closeTaxPoint();
                $(btn).attr("disabled", false);
                $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(3000).fadeOut(250).appendTo('body');
            }
        },
        error: function () {
            $(btn).attr("disabled", false);
            $("<div class='tips_contants'>").fadeIn(250).html("生成对账单失败").delay(3000).fadeOut(250).appendTo('body');
        }
    })
}
