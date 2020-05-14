// 统一配置页面的table显示的column
//  A B行业不需要上传物料服务  CD行业需要上传服务内容
var jsonCl = '[{"columns":["businessDesc","requirements","length","width","priceWay","quantity","unit","unitPrice","additionalService","additionalPrice","totalPrice"],"label":"通用类","modelName":"model00","type":"00"}]';
var globDtCl, globVar = {}, globReqClick = false, globReqDat;//区别物料说明两个事件

var contactListUrl = "/system/partner/listPartnerContacter";// 获取联系人下拉框
var customerListUrl = "/ydz/salesorder/partner";// 获取客户下拉框
// var pageServiceConUrl="/company/dropdownComProPrices"; //服务定价请求内容
var pageListSaleConUrl = "/ydz/salesorder/listSalesMan"; //销售代表下拉框
var pageDefaultSaleConUrl = "/ydz/salesorder/getDefaultSalesMan"; //销售代表默认值
var pagesearchConConUrl = "/company/dropdownComProPriceByDesc"; //搜索服务内容
var pageConfigConUrl = "/company/config/get"; //配置信息获取

var pageSaveOrderConUrl = ""; //保存订单
var pageSaveTempConUrl = ""; //保存草稿箱
var pageSaveCashConUrl = ""; //保存订单并付款
var pageDetailConConUrl = "";
var salesOrder = {
    "salesNo": "",
    "salescheckingNo": "",
    "purchaseNo": "",
    "comKey": "",
    "comName": "",
    "creator": "",
    "creatorName": "",
    "industryId": "",
    "orderStatus": "",
    "orderStatusDesc": ""
};

function initPageData() {
    $("#orderDate").val(new Date().Format("yyyy-MM-dd"));

    $.ajax({
        url: customerListUrl,
        dataType: "json",
        success: function (data) {
            $("#clientsDp").html(returnopt(data, 1)).val("");
            $("#clientsDp").select2({
                templateResult: formatState
            });
            function changeClients(o) {
                $.ajax({
                    url: contactListUrl,
                    dataType: "json",
                    data: { "partnerKey": $(o).val() },
                    timeout: "8000",
                    success: function (data) {
                        $("#contacterDp").html(returnopt(data, 2));
                        $("#contacterDp").select2({

                            minimumResultsForSearch: Infinity
                        });
                    },
                    error: function () {
                    }
                })
            }
            $("#clientsDp").on("change", function (e) { req_teamsData();changeClients(this) });
        },
        error: function () {
        }
    });

    $("#contacterDp").select2({ minimumResultsForSearch: Infinity });
    saleManDp();
    $.ajax({
        url: pageDefaultSaleConUrl,
        type: 'GET',
        dataType: "json",
        success: function (data) {
            if (data.employeeId) {
                $("#saleManDp").val(data.employeeId);
            }
        }
    });

}
function saleManDp() {
    $.ajax({
        url: pageListSaleConUrl,
        dataType: "json",
        timeout: "8000",
        success: function (dt) {
            // dt=[];
            // $("#saleManDp").html( returnopt(data,2));
            var dtall = $.map(dt, function (obj) {
                obj.text = obj.realName; // replace name with the property used for the text
                obj.id = obj.employeeId; // replace name with the property used for the text
                return obj;
            });
            $("#saleManDp").select2({ data: dtall, minimumResultsForSearch: Infinity });
        },
        error: function () {
        }
    })
}
function initPageDataUPdate() {

    $.ajax({
        url: pageDetailConConUrl,
        dataType: "json",
        timeout: "8000",
        success: function (data) {
            initPageTwoData(data);
        },
        error: function () {
        }
    });

}
function changeClients2(o) {
    $.ajax({
        url: contactListUrl,
        dataType: "json",
        data: { "partnerKey": $(o).val() },
        timeout: "8000",
        success: function (data) {
            $("#contacterDp").html(returnopt(data, 2));
            $("#contacterDp").select2({

                minimumResultsForSearch: Infinity
            });
        },
        error: function () {
        }
    })
}
function initPageTwoData(data) {
    salesOrder = data.salesOrder;
    var salesOrderDetail = data.salesOrderDetail;
    var salesMen = data.salesMen;
    //判断订单状态
    var salseOrderStatus = salesOrder.orderStatus;
    var purchaseNo = salesOrder.purchaseNo;
    if (salseOrderStatus == "01") {
        $("#status01_btn_group").show();
        $("#status04_btn_group").hide();
    } else {
        $("#status01_btn_group").hide();
        $("#status04_btn_group").show();
    }
    // 启用后的派工单，不能关闭，在修改订单时，启用派工为置灰效果
    // if (salseOrderStatus == "05") {
    //     $(".onPaiGong").prop("checked",false);
    // }else{$(".onPaiGong").prop("checked",false).attr("disabled",true)}

    if (salesOrder.isUrgent == "1") {
        $(".onJiaji").prop("checked", true)
    }
    if (purchaseNo == "") {
        $("#draftBtnText").removeClass("hide");
    }
    if (salesOrder.taskStatus == "1") {
        $("#draftBtnTw").addClass("hide");
        $("#saveCashPg").addClass("hide");
        $(".onPaiGong").prop("checked", true).attr("disabled", true)
    }
    if (salesOrder.orderType == "1") {
        $(".onPaiGong").prop("checked", true);
    }
    var remarks = salesOrder.remarks;
    if (remarks != undefined && remarks != null) {
        $("#remarkBtn").click();
    }


    if (salesOrder.purchaseNo == "") {

        $(".purchaseNameLb").removeClass("hide");
    } else {
        $(".purchaseNoLb").removeClass("hide");
    }
    $("#createOrder").datagrid("loadData", salesOrderDetail);


    // $("#clientsDp").html("<option value='"+salesOrder.partnerKey+"'>"+salesOrder.partnerShortname+"</option>");

    var partnerContacters = data.partnerContacters;
    var partner1 = $.map(partnerContacters, function (obj) {
        obj.text = obj.contacterName;
        obj.id = obj.contacterId;
        return obj;
    });
    $("#contacterDp").select2({ data: partner1, minimumResultsForSearch: Infinity }).val(salesOrder.contactId).trigger("change");
    $("#partnerShortnameText").val(salesOrder.partnerShortname);
    $("#contactNameText").val(salesOrder.contactName);
    $.ajax({
        url: customerListUrl,
        dataType: "json",
        timeout: "8000",
        success: function (data) {
            $("#clientsDp").on("change", function (e) { req_teamsData() ;changeClients2(this)});
            $("#clientsDp").html(returnopt(data, 1)).val(salesOrder.partnerKey);
            $("#clientsDp").select2({
                templateResult: formatState
            });
            changeClients3();
            function changeClients3() {
                $.ajax({
                    url: contactListUrl,
                    dataType: "json",
                    data: { "partnerKey": $("#clientsDp").val() },
                    timeout: "8000",
                    success: function (data) {
                        $("#contacterDp").html(returnopt(data, 2)).val(salesOrder.contactId);
                        $("#contacterDp").select2({

                            minimumResultsForSearch: Infinity
                        });
                    },
                    error: function () {
                    }
                })
            }
            req_teamsData() ;
        },
        error: function () {
        }
    });
    // $("#contacterDp").html("<option value='"+salesOrder.contactId+"'>"+salesOrder.contactName+"</option>");
    // $("#contacterDp").select2({  minimumResultsForSearch: Infinity});
    $("#orderDate").val(salesOrder.orderDate);
    var dtall = $.map(salesMen, function (obj) {
        obj.text = obj.realName;
        obj.id = obj.employeeId;
        return obj;
    });
    $("#saleManDp").select2({ data: dtall, minimumResultsForSearch: Infinity }).val(salesOrder.salesId).trigger("change");
    $("#caseDesc").val(salesOrder.caseDesc);
    $("#remarkInput").val(salesOrder.remarks);
    $("#salesCount").val(Number(salesOrder.discountRate) * 100);
    $("#preferentialVal").val(salesOrder.preferential);
    $("#depositRequested").val(salesOrder.depositRequested);
    $(".rowLb").removeClass("hide");
    // onLoadS();
    $("[data-toggle='popover']").popover();
}

$(function () {

    if (localStorage.getItem("industryIdYdz") && localStorage.getItem("industryIdYdz") != "1C") {
        $(".onPaiGong").prop("checked", false).attr("disabled", true);
    }//设置行业
    if (salesNo == "") {  //新建
        pageSaveOrderConUrl = "/ydz/salesorder/save"; //保存订单
        pageSaveTempConUrl = "/ydz/salesorder/saveDraft"; //保存草稿箱
        pageSaveCashConUrl = "/ydz/salesorder/saveCash"; //保存订单并付款
        $.ajax({
            url: pageConfigConUrl,
            type: 'GET',
            dataType: "json",
            success: function (dt) {
                var d = dt.data;
                if (d.length > 0) {
                    for (var i = 0; i < d.length; i++) {
                        if (d[i].configKey == "ASSIGN_DESIGN") {
                            $(".onPaiGongDesignLabel").removeClass("hide");
                            if (d[i].configValue == "1") {
                                $(".onPaiGongDesign").prop("checked", true);
                            }
                        } else if (d[i].configKey == "ASSIGN_WORKING") {
                            $(".onPaiGongLabel").removeClass("hide");
                            if (d[i].configValue == "1") {
                                $(".onPaiGong").prop("checked", true);
                            }

                        }
                    }

                }
            }
        });
        initPageData();
    } else {
        pageSaveOrderConUrl = "/ydz/salesorder/submitUpdate"; //保存订单
        pageSaveTempConUrl = "/ydz/salesorder/updateAsDraft"; //保存草稿箱
        pageSaveCashConUrl = "/ydz/salesorder/updateAsCash"; //保存订单并付款
        pageDetailConConUrl = "ydz/salesorder/orderAndDetails?salesNo=" + salesNo;
        $.ajax({
            url: pageConfigConUrl,
            type: 'GET',
            dataType: "json",
            success: function (dt) {
                var d = dt.data;
                if (d.length > 0) {
                    for (var i = 0; i < d.length; i++) {
                        if (d[i].configKey == "ASSIGN_DESIGN") {
                            $(".onPaiGongDesignLabel").removeClass("hide");
                        } else if (d[i].configKey == "ASSIGN_WORKING") {
                            $(".onPaiGongLabel").removeClass("hide");
                        }
                    }

                }
            }
        });
        initPageDataUPdate();
    }
});

function readyData() {

    var rows = $('#createOrder').datagrid("getRows");

    for (var i = 0; i < rows.length; i++) {
        rows[i].requirements = $("input.autocomplete_req")[i].value;
        rows[i].unitPrice = $("input.unitPriceChange")[i].value;
        rows[i].totalPrice = $("input.totalpriceChange")[i].value;
        rows[i].unit = $("input.inputTemplateUnit")[i].value;
        // rows[i].isUrgent="0";
        rows[i].isValid = "1";
        rows[i].isDel = "0";
        rows[i].remarks = $("input.remarksChange")[i].value;
        rows[i].length = parseFloat($("input.inputTemplateLength")[i].value);
        rows[i].width = parseFloat($("input.inputTemplateWidth")[i].value);
        rows[i].quantity = parseFloat($("input.inputTemplateQuantity")[i].value);
        console.log(rows[i]);
    }
    // console.log($("input.inputTemplateJiaji:eq(0)").prop("checked"));
    // console.log($("input.inputTemplateJiaji:eq(1)").prop("checked"));
    // console.log($("input.inputTemplateJiaji:eq(2)").prop("checked"));

    var saveData = {};
    saveData.details = rows;
    var order = {
        "businessType": "00",
        "salesNo": salesOrder.salesNo,
        "salescheckingNo": salesOrder.salescheckingNo,
        "purchaseNo": salesOrder.purchaseNo,
        "comKey": salesOrder.comKey,
        "comName": salesOrder.comName,
        "creator": salesOrder.creator,
        "creatorName": salesOrder.creatorName,
        "industryId": salesOrder.industryId,
        "orderStatus": salesOrder.orderStatus,
        "isUrgent": $(".onJiaji").prop("checked") == true ? "1" : "0",
        "orderStatusDesc": salesOrder.orderStatusDesc,

        "caseDesc": $("#caseDesc").val(),
        "orderDate": new Date($("#orderDate").val()),
        "partnerShortname": $("#clientsDp").find("option:selected").attr("data-s"),
        "partnerKey": $("#clientsDp").val(),
        "partnerName": $("#clientsDp").find("option:selected").attr("data-n"),
        "salesId": $("#saleManDp").val(),
        "salesName": $("#saleManDp").find("option:selected").text(),
        "contactId": $("#contacterDp").val(),
        "contactName": $("#contacterDp").find("option:selected").text(),
        "remarks": $("#remarkInput").val(),
        "taskStatus": $(".onPaiGong").prop("checked") == true ? "1" : "0",
        "orderType": $(".onPaiGongDesign").prop("checked") == true ? "D" : "0",
        "taxRate": Number($("#rateNum").val()) / 100,

        "price": $("#priceTextVal").val(),//合计金额
        "discountRate": globVar.discountRate,//折扣优惠
        "discount": $("#discountVal").val(),//折扣金额
        "preferential": $("#preferentialVal").val(),// 减免金额
        "totalPrice": $("#totalPriceVal").val(),// 订单金额
        "depositRequested": $("#depositRequested").val(),//预收金额
        "receivablesMoney": $("#receivablesMoneyVal").val() //应收金额
    };
    saveData.salesOrder = order;
    return saveData;
}
function openHideUpload() {
    $("#fileButton").click();
}
$(function () {
    var oFileSpan = $("#fileSpanNew");					//选择文件框
    oFileSpan.on("dragenter",function(){
        $(this).css({"border":"2px dashed #4284d9"});
        return false;
    });
    oFileSpan.on("dragover",function(){
        return false;
    });
    oFileSpan.on("dragleave",function(){
        $(this).css({"border":"2px dashed #ccc"});
        return false;
    });
    oFileSpan.on("drop",function(ev){
        ev.preventDefault();
        var fs = ev.originalEvent.dataTransfer.files;
        analysisList(fs);
        $(this).css({"border":"2px dashed #ccc"});
        return false;
    });
})
function showRemark() {
    var hasClass;
    var self = $("#remarkBtn");
    hasClass = self.hasClass("secondary");
    self.toggleClass("secondary", !hasClass);
    if (hasClass) {
        self.html("<i class='iconfont_new'>&#xe6ca;</i>添加备注").css("padding", "10px 0px 10px 26px");
        $("#remarkInput").val("").hide();
    } else {
        self.html("备注").css("padding", "5px 0px 10px 0px");
        return $("#remarkInput").show();
    }
}
//上传预览
function preview() {
    var $fileList = $($("#topBar").find("input").prop("files"));
    analysisList($fileList);
}
function analysisList($fileList){
    //如果没有文件
    if( $fileList.length<1 ){
        return false;
    }
    var uploadBox1 = $("#upload_box ul").eq(0);
    var uploadBox2 = $("#upload_box ul").eq(1);
    uploadBox1.children().remove();
    uploadBox2.children().remove();
    var len = $fileList.length / 2;
    $("#uploadNote").html("上传文件数:    " + "<span style='color:#fa2b2f;font-size:20px;'>&nbsp;" + $fileList.length + "</span>");
    for( var i=0;i<$fileList.length;i++ ){
        var element = $fileList[i];		//单个文件
            var showName = element.name.substring(0, element.name.lastIndexOf("."));
            var lable_show = "<li><label>" + showName + "</label></li>";
            var $lable_show = $(lable_show);

          var  btn = '<button type="button" onclick="javascript:$(this).parent(\'li\').remove()" class="btn">删除</button>';
            $lable_show.append(btn);
            if (i > len) {
                uploadBox2.append($lable_show);
            } else {
                uploadBox1.append($lable_show);
            }

    }
}
//账期订单
var nums = true;
function saveAll(self) {
    $(self).attr("disabled", true);
    if ($(self).attr("dat") == 0) {
        $.ajax({
            url: '/ydz/salesorder/validOrderCount',
            type: 'GET',
            dataType: "json",
            success: function (data) {
                if (data.balanceOrderCount <= 5&&nums) {
                    $(".stroke").text(data.freeOrderCount);
                    $(".stroke_count").text(data.balanceOrderCount);
                    $(".alart_one").show();
                    $(".cover").show();
                    nums = false;
                } else {
                    var clientsDpValue = $("#clientsDp").val();
                    if (clientsDpValue == "temp-customer") {
                        $("<div class='tips_contants'>").fadeIn(250).html("过路客不能保存为账期订单").delay(1500).fadeOut(250).appendTo('body');
                        $(self).attr("disabled", false);
                        return false;
                    }
                    saveOrder(self, pageSaveOrderConUrl, "dd");
                    
                }
            }
        })

    } else {

        var clientsDpValue = $("#clientsDp").val();
        if (clientsDpValue == "temp-customer") {
            $("<div class='tips_contants'>").fadeIn(250).html("过路客不能保存为账期订单").delay(1500).fadeOut(250).appendTo('body');
            $(self).attr("disabled", false);
            return false;
        }
        saveOrder(self, pageSaveOrderConUrl, "dd");
    }
}
// 取消创建
function back(self) {
    var config = {
        menuUrl: "/openPage?pageName=advert_sales-order-list"
    };
    parent.mainConfigUrl(config);
}
//保存草稿
function saveDraft(self) {
    $(self).attr("disabled", true);
    if ($(self).attr("dat") == 0){
        $.ajax({
        url: '/ydz/salesorder/validOrderCount',
        type: 'GET',
        dataType: "json",
        success: function (data) {
            if (data.balanceOrderCount <= 5 && nums) {
                $(".stroke").text(data.freeOrderCount);
                $(".stroke_count").text(data.balanceOrderCount);
                $(".alart_one").show();
                $(".cover").show();
                nums = false;
            } else {
                if ($(".onPaiGong").prop("checked")) {
                    $("<div class='tips_contants'>").fadeIn(250).html("启用派工无法保存至草稿箱").delay(1500).fadeOut(250).appendTo('body');
                    $(self).attr("disabled", false);
                    return;
                }
                saveOrder(self, pageSaveTempConUrl, "cgx");
            }
        }
    })
}else{
    
        if ($(".onPaiGong").prop("checked")) {
                    $("<div class='tips_contants'>").fadeIn(250).html("启用派工无法保存至草稿箱").delay(1500).fadeOut(250).appendTo('body');

            $(self).attr("disabled", false);
            return;
                }
                saveOrder(self, pageSaveTempConUrl, "cgx");

    }
   
}
//是否确认现金订单
function ifSaveCash(self) {
    $(self).attr("disabled", true);
     if ($(self).attr("dat") == 0){
        $.ajax({
        url: '/ydz/salesorder/validOrderCount',
        type: 'GET',
        dataType: "json",
        success: function (data) {
            if (data.balanceOrderCount <= 5 && nums) {
                $(".stroke").text(data.freeOrderCount)
                $(".stroke_count").text(data.balanceOrderCount)
                $(".alart_one").show();
                $(".cover").show();
                nums = false;
            } else {
                if ($(".onPaiGong").prop("checked") && salesNo != "") {
                    $("<div class='tips_contants' style='line-height: 40px;'>").fadeIn(250).html("启用派工，无法创建订单并收款<br>创建订单并收款的订单可以去已对账启用").delay(3000).fadeOut(250).appendTo('body');
                    $(self).attr("disabled", false);
                    return;
                }
                if (!seleSales()) {
                    $(self).attr("disabled", false);
                    return false;
                }
                var depositRequested = Number($("#depositRequested").val());
                if (depositRequested > 0) {
                    $(".tips_contants").remove();
                    $("<div class='tips_contants' style='line-height: 40px;'>").fadeIn(250).html("现金订单,“应收金额”即为“实收金额”<br>无需填写“预收金额”").delay(3000).fadeOut(250).appendTo('body');
                } else {
                    var saleMon = Number($("#receivablesMoneyVal").val()).toFixed(2);
                    var saleMonA = accounting.formatNumber(Number($("#receivablesMoneyVal").val()), 2);
                    $("#orderMoney,#payAmout").text(saleMonA);//订单金额赋值
                    $("#orderMoneyActual").text(saleMon);//订单金额赋值
                    $("#rateAmount").text("0");
                    $("#rateNum").val("0");
                    $(".window-mask").show();
                    $('#createOrderPop').show();
                     nums = true;
                }
            }
        }
    })
     }else{
         if ($(".onPaiGong").prop("checked") && salesNo != "") {
                    $("<div class='tips_contants' style='line-height: 40px;'>").fadeIn(250).html("启用派工，无法创建订单并收款<br>创建订单并收款的订单可以去已对账启用").delay(3000).fadeOut(250).appendTo('body');
             $(self).attr("disabled", false);
                    return;
                }
                if (!seleSales()) {
                    $(self).attr("disabled", false);
                    return false;
                }
                var depositRequested = Number($("#depositRequested").val());
                if (depositRequested > 0) {
                    $(".tips_contants").remove();
                    $("<div class='tips_contants' style='line-height: 40px;'>").fadeIn(250).html("现金订单,“应收金额”即为“实收金额”<br>无需填写“预收金额”").delay(3000).fadeOut(250).appendTo('body');
                } else {
                    var saleMon = Number($("#receivablesMoneyVal").val()).toFixed(2);
                    var saleMonA = accounting.formatNumber(Number($("#receivablesMoneyVal").val()), 2);
                    $("#orderMoney,#payAmout").text(saleMonA);//订单金额赋值
                    $("#orderMoneyActual").text(saleMon);//订单金额赋值
                    $("#rateAmount").text("0");
                    $("#rateNum").val("0");
                    $(".window-mask").show();
                    $('#createOrderPop').show();
                     nums = true;
                }
     }
    


}
function hideOrderPop() {
    $(".window-mask").hide();
    $('#createOrderPop').hide();
    $("#saveCashPg").attr("disabled",false);
}
function saveCash(self) {
    $(self).attr("disabled", true);
    saveOrder(self, pageSaveCashConUrl, "xj");
}
function saveOrder(o, url, tp) {
    var self = $(o);
    if (!seleSales()) {
        self.attr("disabled", false);
        return;
    }
    self.attr("disabled", true);
    $.ajax({
        url: url,
        type: "post",
        data: JSON.stringify(readyData()),
        dataType: "json",
        contentType: "application/json",
        success: function (callBack) {
            if (callBack.status == '1') {
                var cType = callBack.type;
                var type = "order2";
                if (cType == "02") {
                    type = "order4";
                } else if (cType == "04") {
                    type = "order4";
                }
                if (tp == "cgx") { //判断是否为草稿箱跳转
                    type = "order2";
                } else if (tp == "xj") {//判断是否为付款操作跳转
                    type = "order5";
                }
                self.attr("disabled", false);
                var config = {
                    menuUrl: "/openPage?pageName=advert_sales-order-list&type=" + type
                };
                parent.mainConfigUrl(config);
                nums = true;
            } else {
                $("<div class='tips_contants'>").fadeIn(250).html(callBack.msg).delay(3000).fadeOut(250).appendTo('body');
                self.attr("disabled", false);
            }
        }, error: function () {
            $("<div class='tips_contants'>").fadeIn(250).html("添加出错,请联系管理员").delay(3000).fadeOut(250).appendTo('body');
            self.attr("disabled", false);
        }
    });
}
function formatRepo(repo) {
    if (repo.loading) return repo.text;

    var markup = "";

    if (repo.description) {
        markup += "<div class='select2-result-repository__description'>" + repo.description + "</div>";
    }

    return markup;
}

function formatRepoSelection(repo) {
    return repo.description || repo.text;
}

//物料制作说明弹出 组装数据
function requirementMenu(pps) {
    $(".loading_box").removeClass("loadingssss");
    menuLoad();//初始化grid数据
}
function requirementMenu1(pps) {

    //获取服务定价并渲染
    var $firstCategory = $(".ui.tabular.menu");
    $firstCategory.empty();
    pps.each(function (pp, i) {
        var active = ""
        if (i === 0) active = " active"
        var item = $("<a class='item" + active + "' data-tab='" + pp.get("categoryId") + "'>" + pp.get("categoryDesc") + "</a>");
        var tab = $("<div class='ui tab" + active + "' data-tab='" + pp.get("categoryId") + "'></div>");
        tab.data("c", pp);
        $firstCategory.append(item);
        var $secondCategory = tab;
        var $secondCategoryTab = $("<div class='ui blue secondary menu'></div>");
        $secondCategory.append($secondCategoryTab);
        $firstCategory.after($secondCategory);
        var second = pp.get("comProPrices");

        second.each(function (s, j) {
            active = " active";
            if (j !== 0) active = "";
            var item = $("<a class='item" + active + "' data-tab='" + s.get("categoryId") + "'>" + s.get("categoryDesc") + "</a>");
            var tab = $("<div class='ui tab' data-tab='" + s.get("categoryId") + "'></div>");
            $secondCategoryTab.append(item);
            $secondCategoryTab.after(tab);
            var third = s.get("comProPrices");

            item.data("prices", third);
            tab.data("prices", third);

            if (i === 0 && j === 0) {
                cola.model().set("prices", third);
            }
            third.each(function (t, k) {
                t.set("index", k + 1);
                t.set("state", "隐藏");
            });
        });

    });
    $(".tabular.menu .item").tab({
        onVisible: function (tabPath) {
            var prices = $(this).find(".item.active").data("prices");
            cola.model().set("prices", prices || []);
        }
    });
    $(".secondary.menu .item").tab({
        onVisible: function (tabPath) {
            cola.model().set("prices", $(this).data("prices") || []);
        }
    });
}

function seleSales() {
    var valselSale = $("#saleManDp").val();
    var clientsDp = $("#clientsDp").val();
    if (valselSale == "") {
        $("<div class='tips_contants'>").fadeIn(250).html("请选择销售代表").delay(5000).fadeOut(250).appendTo('body');
        return false;
    }
    return true;
}

function returnopt(data, type) {
    var opt = "";
    for (var i = 0; i < data.length; i++) {
        var dt = data[i];
        var dtn = "";
        if (type == 1) {
            dtn = dt.myComShortname == undefined ? "全部供应商" : dt.myComShortname;
            opt += '<option data-s="' + dt.partnerShortname + '" data-n="' + dt.partnerName + '" data-p="' + dt.partnerStatus + '" value="' + dt.partnerKey + '">' + dtn + '</option>';
        }
        if (type == 2) {
            opt += '<option value="' + dt.contacterId + '">' + dt.contacterName + '</option>';
        }
    }
    return opt;
}
function formatState(state) {
    var p = $(state.element).attr("data-p");
    var mark = "";
    var css = "  font-style:normal;font-size: 8px !important;background: #e9dfdf;color: #b89a9a;border-radius: 3px;height: 20px;margin-left: 10px;line-height: 20px;padding: 0 2px;position: absolute;right: 3px;top: 5px;";
    var cs = "   position: absolute;right: 4px;top: 8px;border: 6px solid #f2711c;width: 0;height: 0;border-radius: 50%;";
    if (p == undefined || p == "" || p == null) {
        mark = '';
    } else if (p == "1") {
        mark = '<i  class="tips_sale" >好友</i>';
    }
    var $state = $(
        '<span style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:160px;display: block;">' + state.text + '</span>' + mark

        //                '<span><img src="/' + state.element.value.toLowerCase() + '.png" class="img-flag" /> ' + state.text + '</span>'
    );
    return $state;
}

function closeProReq() {
    $(".window-mask").hide();
    $("#topBarPR").hide();
}
function openFielUp(o, i) {
    $("#uploadNote").html("上传文件数 <span style='color:#ccc;font-size:18px;'> &nbsp;0</span>");
    globVar.con = $(o).parents("tr").index();
    $("#topBar").show();
}
function openProReq(o, i) {
    //没有主键 上述方法会有问题
    globVar.con = $(o).parents("tr").index();
    var partnerKey = $("#clientsDp").val();
    // var businessType =  uploadModelName.substring(5, uploadModelName.length);
    if (partnerKey == undefined || partnerKey == "") {
        $("<div class='tips_contants'>").fadeIn(250).html("请选择客户").delay(2000).fadeOut(250).appendTo('body');
        return false;
    }
    $(".window-mask").show();
    $("#topBarPR").show();
    requirementMenu();
}

function closeUpload() {
    var fileLists = $("#file_div input").val("");
    $("#upload_box ul").children().remove();
    $("#topBar").hide();
}
function saveUploadName() {
    var $tableWrap = $("#tableWrap");
    var uploadBoxLable = $("#upload_box ul li label");
    //首先获取 上传框中的上传信息
    var file_datas = new Array();
    uploadBoxLable.each(function (index, element) {
        var file_name = $(element).text();
        var file_data = util.setOrderData(file_name);
        if (file_data) {

            file_datas.push(file_data);
        }
    });
    if (file_datas.length == 0) {
        $.mytoast({text:"上传文件名格式不符合要求!"});
        return;
    }
    fileUpTable(file_datas);
    // 清空 上传框
    $("#file_div input").val("");
    $("#upload_box ul").eq(0).children().remove();
    $("#upload_box ul").eq(1).children().remove();
    $("#topBar").toggle();
}
function fileUpTable(file_datas) {
    var rowIndex = globVar.con;
    var total = $('#createOrder').datagrid('getRows').length - 1;
    for (var i = 0; i < file_datas.length; i++) {
        var row = file_datas[i];
        if (rowIndex <= total) {
            $('#createOrder').datagrid('updateRow', {
                index: rowIndex, row: {
                    "businessDesc": row.name,
                    "length": row.length,
                    "width": row.width,
                    "quantity": row.number
                }
            });
            formula(rowIndex);
            autocompleteFun();
            rowIndex++;
        } else {
            addFileRow(file_datas[i]);
        }
    }
}

function onLoadS() {
    req_teamsData();
}
function req_teamsData() {
    $.ajax({
        url: pagesearchConConUrl,
        data: { "partnerKey": $("#clientsDp").val() },
        dataType: "json",
        timeout: "8000",
        success: function (data) {
            req_teams = {
                suggestions: $.map(data.suggestions, function (dataItem) {
                    return { value: dataItem.categoryDesc, data: dataItem };
                })
            };
            autocompleteFun();
            priceCount();
        },
        error: function () {
            req_teams = {
                suggestions: {}
            };
            autocompleteFun();
            priceCount();
        }
    });
}
var req_teams = {};
function autocompleteFun() {
    $('.autocomplete').devbridgeAutocomplete({
        lookup: teams,
        minChars: 0,
        readyOn: true,
        onSelect: function (suggestion) {
            var row = $('#createOrder').datagrid("getSelected");
            var rindex = $('#createOrder').datagrid("getRowIndex", row);
            row["priceWay"] = suggestion.data;
            row["priceWayDesc"] = suggestion.value;
            formula(rindex);
            $('#createOrder').datagrid('updateRow', { index: rindex, row: row });
            // $('#createOrder').datagrid('reload');
            // $('#createOrder').datagrid('acceptChanges');
        }

    });
    $('.autocomplete_req').devbridgeAutocomplete({
        lookup: function (query, done) {
            var a = $.grep(req_teams.suggestions, function (n, i) {
                return n.value.toLowerCase().indexOf(query.toLowerCase()) >= 0
            });
            var b = {
                suggestions: a
            };
            done(b);
        },
        minChars: 1,
        minWidth: 300,
        defaultAppend: "<p style='    text-align: center;height: 35px;line-height: 35px;margin:0;border-top: 1px solid #e7e4e4;'>没有想要的服务定价?你可以去<em style='color:#4284d9'>服务</em>功能添加,方便调用</p>",
        formatResult: function (suggestion, value) {
            if (!value) {
                return suggestion.value;
            }
            var item = JSON.stringify(suggestion.data);
            return suggestion.value + "<span onclick='fillAllData(" + item + ");' style='display:none;color:#4284d9;font-size:12px;cursor:pointer;position: absolute;right: 4px;'>全部填充</span>";
        },
        onSelect: function (suggestion) {
            if (!autocompleteAllFill) {
                selReqOnSelect(suggestion, this);
            } else {
                autocompleteAllFill = false;
            }
        }
    });
}
var autocompleteAllFill = false;
function selReqOnSelect(suggestion, o) {
    globReqClick = true;
    console.log(suggestion);
    if (suggestion == null) {
        return;
    }
    var rindex = $(o).parents("tr").index();
    var row = $('#createOrder').datagrid('getRows')[rindex];
    if (row.businessDesc != "") {
        row["requirements"] = suggestion.value;
        row["workingProcedure"] = suggestion.data.workingProcedure;
        row["unit"] = suggestion.data.priceUnitDesc;
        row["priceWay"] = suggestion.data.priceWay;
        row["priceWayDesc"] = suggestion.data.priceWayDesc;
        row["unitPrice"] = suggestion.data.unitPrice;
        $("input.autocomplete")[rindex].value = suggestion.data.priceWayDesc;
        $("input.inputTemplateUnit")[rindex].value = suggestion.data.priceUnitDesc;
        $("input.unitPriceChange")[rindex].value = suggestion.data.unitPrice;
        formula(rindex);
        $('#createOrder').datagrid('updateRow', { index: rindex, row: row });
        // $('#createOrder').datagrid('acceptChanges');
    }
}
function fillAllData(currentItem) {
    if (currentItem == null) { return; }
    // var row=$('#createOrder').datagrid("getSelected");
    // var ind=$('#createOrder').datagrid("getRowIndex",row);
    var ind = $(window.autoCompleteObj).parents("tr").index();
    console.log(ind);
    var total = $('#createOrder').datagrid('getRows').length;
    for (var i = ind; i < total; i++) {
        if ($('#createOrder').datagrid('getRows')[i].businessDesc != "") {
            $("input.autocomplete_req")[i].value = currentItem.categoryDesc;
            $("input.inputTemplateUnit")[i].value = currentItem.priceUnitDesc;
            $("input.unitPriceChange")[i].value = currentItem.unitPrice;
            $('#createOrder').datagrid('updateRow', {
                index: i, row: {
                    "requirements": currentItem.categoryDesc,
                    "workingProcedure": currentItem.workingProcedure,
                    "unit": currentItem.priceUnitDesc,
                    "priceWay": currentItem.priceWay,
                    "priceWayDesc": currentItem.priceWayDesc,
                    "unitPrice": currentItem.unitPrice
                }
            });
            formula(i);
        }
    }
    autocompleteAllFill = true;
    autocompleteFun();
    // $('#createOrder').datagrid('acceptChanges');
    // var ev=arguments.callee.caller.arguments[0] || window.event;
    // ev.stopPropagation();
}
function testHard1(btn) {
    var currentItem = $("#order").datagrid("getSelected");
    if (currentItem == null) { $("<div class='tips_contants'>").fadeIn(250).html("请先选择一条物料制作说明").delay(2000).fadeOut(250).appendTo('body'); return; }

    var rowIndex = globVar.con;
    if ($('#createOrder').datagrid('getRows')[rowIndex].businessDesc != "") {
        $('#createOrder').datagrid('updateRow', {
            index: rowIndex, row: {
                "requirements": currentItem.categoryDesc,
                "workingProcedure": currentItem.workingProcedure,
                "unit": currentItem.priceUnitDesc,
                "priceWay": currentItem.priceWay,
                "priceWayDesc": currentItem.priceWayDesc,
                "unitPrice": currentItem.unitPrice
            }
        });
        autocompleteFun();
        formula(rowIndex);
        // $('#createOrder').datagrid('acceptChanges');
    }

    $(".window-mask").hide();
    $("#topBarPR").hide();
}
function testHard2() {
    var currentItem = $("#order").datagrid("getSelected");
    if (currentItem == null) { $("<div class='tips_contants'>").fadeIn(250).html("请先选择一条物料制作说明").delay(2000).fadeOut(250).appendTo('body'); return; }

    var total = $('#createOrder').datagrid('getRows').length;

    for (var i = globVar.con; i < total; i++) {
        // $('#createOrder').datagrid('updateRow',{index:rowIndex,row:{requirements:currentItem.categoryDesc}});
        if ($('#createOrder').datagrid('getRows')[i].businessDesc != "") {
            $("input.autocomplete_workingProcedure")[i].value = currentItem.workingProcedure;
            $('#createOrder').datagrid('updateRow', {
                index: i, row: {
                    "requirements": currentItem.categoryDesc,
                    "workingProcedure": currentItem.workingProcedure,
                    "unit": currentItem.priceUnitDesc,
                    "priceWay": currentItem.priceWay,
                    "priceWayDesc": currentItem.priceWayDesc,
                    "unitPrice": currentItem.unitPrice
                }
            });
            formula(i);
        }
    }
    $(".window-mask").hide();
    autocompleteFun();
    // $('#createOrder').datagrid('acceptChanges');
    $("#topBarPR").hide();
}
function inputTemplate(v, i, f) {
    var j = 0;
    var arr = ["填写，或读取图片自动填入长宽数量", "例：企业管理规章制度", "例：国家级森林保护区公示牌 80-20-5"];
    if (i < 3) {
        j = i;
    }
    return '<input placeholder="' + arr[j] + '" class="" onkeyup="modifyVal(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text"><i class="iconfont_new contentTemplate" onclick="openFielUp(this,' + i + ')" style="font-size: 14px;color:#ccc">&#xe6ea;</i>'
}

function inputTemplateReq(v, i, row) {
    var j = 0;
    var arr = ["关键字检索，或点击按钮选择", "户外写真KT板包边", "户外黑胶"];
    if (i < 3) {
        j = i;
    }
    // taskStatus workProcedure isUrgent
    return '<input type="hidden" value="" class="autocomplete_workingProcedure" /><input placeholder="' + arr[j] + '" class="autocomplete_req"   style="width: 100%;" value="' + v + '" type="text"><i class="iconfont_new contentTemplate" onclick="openProReq(this,' + i + ')" style="font-size: 14px;color:#ccc">&#xe6eb;</i>'
}
function inputTemplatePrice(v, i, row, f) {
    // onkeyup="modifyValTotalPrice(this,'+i+',\''+f+'\')"
    return '<input class="totalpriceChange" readonly    style="width: 100%;" value="' + v + '" type="text">'
}
function inputTemplateRemarks(v, i, row, f) {
    return '<input placeholder="如:经办人姓名" class="remarksChange" onkeyup="modifyValRemarks(this,' + i + ',\'' + f + '\')"   style="width: 100%;" value="' + v + '" type="text">'
}
function inputTemplateLength(v, i, f) {
    return '<input class="inputTemplateLength" onkeyup="modifyVal(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text">'
}

function inputTemplateWidth(v, i, f) {
    return '<input class="inputTemplateWidth" onkeyup="modifyVal(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text">'
}

function inputTemplateQuantity(v, i, f) {
    return '<input class="inputTemplateQuantity" onkeyup="modifyVal(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text">'
}

function inputTemplateUnit(v, i, f) {

    return '<input class="inputTemplateUnit" onkeyup="modifyValRemarks(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text">'
}
function inputTemplateUnitprice(v, i, f) {

    return '<input data-s="select" class="unitPriceChange" onkeyup="modifyValUP(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text">'
}
function inputTemplateWay(v, i, f) {
    return '<input class="autocomplete" readonly style="width: 100%;" value="' + v + '" type="text"><i class="iconfont_new" style=" cursor: default;  font-size: 14px;line-height:40px;right: 1px;-webkit-transform: scale(.5);position: absolute;color: #ccc;">&#xe68d;</i>'
}
function modifyValUP(o, i, f) {
    var rindex = $(o).parents("tr").index();
    var ev = arguments.callee.caller.arguments[0] || window.event;
    if ($(ev.target).val() == "undefined") { return; }
    var row = {};
    // $('#createOrder').datagrid('updateRow',{index:rindex,row:row});
    $('#createOrder').datagrid('getRows')[rindex].unitPrice = $(ev.target).val();
    formula(rindex);
    autocompleteFun();
}
function modifyVal(o, i, f) {
    var rindex = $(o).parents("tr").index();
    var ev = arguments.callee.caller.arguments[0] || window.event;
    ///    if($(ev.target).val()=="undefined"){return;}
    $('#createOrder').datagrid('getRows')[rindex][f] = $(ev.target).val();
    if (f == "length" || f == "width" || f == "quantity") {
        formula(rindex);
    }
    autocompleteFun();
}
function modifyValRemarks(o, i, f) {
    var rindex = $(o).parents("tr").index();
    var ev = arguments.callee.caller.arguments[0] || window.event;
    ///    if($(ev.target).val()=="undefined"){return;}
    $('#createOrder').datagrid('getRows')[rindex][f] = $(ev.target).val();
}
function modifyValTotalPrice(o, i, f) {
    var rindex = $(o).parents("tr").index();
    var ev = arguments.callee.caller.arguments[0] || window.event;
    // $('#createOrder').datagrid('updateRow',{index:rindex,row:{
    //     "totalPrice":$(ev.target).val()
    // }});
    $('#createOrder').datagrid('getRows')[rindex].totalPrice = $(ev.target).val();
    // autocompleteFun();
    priceCount();
    // $('#createOrder').datagrid('acceptChanges');
}
function formula(rindex) {
    var row = $('#createOrder').datagrid('getRows')[rindex];
    var priceWay = row["priceWay"];
    var length = parseFloat($("input.inputTemplateLength")[rindex].value);
    var width = parseFloat($("input.inputTemplateWidth")[rindex].value);
    var quantity = parseFloat($("input.inputTemplateQuantity")[rindex].value);
    var unitPrice = parseFloat($("input.unitPriceChange")[rindex].value);
    var totalPrice = 0;
    switch (priceWay) {
        case "01":
            totalPrice = length * width * quantity * unitPrice;
            break;
        case "02":
            totalPrice = quantity * unitPrice;
            break;
        case "03":
            totalPrice = length * quantity * unitPrice;
            break;
        case "04":
            totalPrice = width * quantity * unitPrice;
            break;
        case "05":
            if (length > width) {
                totalPrice = length * quantity * unitPrice;
            } else {
                totalPrice = width * quantity * unitPrice;
            }
            break;
        case "06":
            if (length > width) {
                totalPrice = Math.pow(length, 2) * quantity * unitPrice;
            } else {
                totalPrice = Math.pow(width, 2) * quantity * unitPrice;
            }
            break;
        case "07":
            totalPrice = (length + width) * 2 * quantity * unitPrice;
            break;
        default:
            break;
    }
    var tpc = "0.00";
    if (isNaN(totalPrice)) {
        $("input.totalpriceChange")[rindex].value = "0.00";
    } else {
        tpc = Number(totalPrice).toFixed(2);
        $("input.totalpriceChange")[rindex].value = Number(totalPrice).toFixed(2);
    }
    // $($("input.totalpriceChange")[rindex]).trigger("click");

    priceCount();
    // $('#createOrder').datagrid('acceptChanges');
}
function priceCount() {
    var rows = $('#createOrder').datagrid("getRows");
    var tAmount = 0;
    for (var i = 0; i < rows.length; i++) {
        var pr = $.trim($("input.totalpriceChange")[i].value);
        if (isNaN($("input.totalpriceChange")[i].value) || pr == "") {
        } else {
            tAmount = tAmount + parseFloat($("input.totalpriceChange")[i].value);
        }
    }
    $("#priceText").text(accounting.formatNumber(tAmount, 2));
    $("#priceTextVal").val(tAmount);
    priceCountTwo();
}
function priceCountTwo() {
    var tAmount = $("#priceTextVal").val();
    var orderSales = $("#salesCount").val();
    var depositRequested = $("#depositRequested").val();
    var preferentialVal = $("#preferentialVal").val();
    if (isNaN(orderSales) || orderSales == "") {
        // $("<div class='tips_contants'>").fadeIn(250).html("折扣优惠为0-100").delay(500).fadeOut(250).appendTo('body');
        $("#salesCount").val(0);
        // return false;
    }
    globVar.discountRate = orderSales / 100;
    var discount = tAmount * (orderSales / 100);
    $("#discountText").text(accounting.formatNumber(discount, 2));
    $("#discountVal").val(discount);
    if (isNaN(preferentialVal) || preferentialVal == "") {
        $("#preferentialVal").val(0);
    }
    if (isNaN(depositRequested) || depositRequested == "") {
        $("#depositRequested").val(0);
    }
    var pr = parseFloat($("#priceTextVal").val()) - parseFloat($("#discountVal").val()) - parseFloat($("#preferentialVal").val()); //用到的减免金额

    $("#preferentialText").text(accounting.formatNumber($("#preferentialVal").val(), 2));
    $("#depositRequestedText").text(accounting.formatNumber($("#depositRequested").val(), 2));
    $("#totalPriceText").text(accounting.formatNumber(pr, 2));
    $("#totalPriceVal").val(pr);// 订单金额

    var yspr = pr - parseFloat($("#depositRequested").val());//用到的预收金额
    $("#receivablesMoneyVal").val(yspr);
    $("#receivablesMoneyText").text(accounting.formatNumber(yspr, 2));
}
// 合计金额三个文本框填写数字自动计算
function priceBlurCal() {

}

function opeartionDel(index) {
    return '<i class="iconfont_new contentTemplate" onclick="addRow(this)">&#xe6a1;</i>&nbsp;&nbsp;&nbsp;&nbsp;<i class="iconfont_new contentTemplate" onclick="delRow(this)" >&#xe6f2;</i>';
}
// function opeartionCheck(index) {
//     if(true){
//         return ' <div onclick="checkLineJiaji(this)" class="checkbox checkbox-slider--b-flat " style="width:40px;display: inline-block;"><label><input class="inputTemplateJiaji" value="1" checked type="checkbox"><span></span></label></div>'
//     }else{
//         return ' <div onclick="checkLineJiaji(this)" class="checkbox checkbox-slider--b-flat " style="width:40px;display: inline-block;"<label><input class="inputTemplateJiaji"  value="0" type="checkbox"><span></span></label></div>'
//     }
// }
function checkJiaji(o) {

    var pageCheckbox = $('#createOrder').datagrid('getRows');
    for (var i = 0; i < pageCheckbox.length; i++) {
        var f;
        if (!$(o).prop("checked")) {
            f = 0
        } else { f = 1 }
        $('#createOrder').datagrid('updateRow', {
            index: i, row: {
                "isUrgent": f,
                "requirements": $("input.autocomplete_req")[i].value,
                "totalPrice": $("input.totalpriceChange")[i].value
            }
        });
    }

    autocompleteFun();
    // $('#createOrder').datagrid('acceptChanges');

}
function checkLineJiaji(o) {
    var rindex = $(o).parents("tr").index();
    var pageCheckbox = $('#createOrder').datagrid('getRows')[rindex];
    var f;
    if (pageCheckbox.isUrgent == "1") {
        f = 0
    } else { f = 1 }

    $('#createOrder').datagrid('updateRow', {
        index: rindex, row: {
            "isUrgent": f,
            "requirements": $("input.autocomplete_req")[rindex].value,
            "totalPrice": $("input.totalpriceChange")[rindex].value

        }
    });
    autocompleteFun();
    // $('#createOrder').datagrid('acceptChanges');
}
// 根据row追加行
function addFileRow(row) {

    $('#createOrder').datagrid('appendRow', {
        "businessDesc": row.name,
        "businessType": "00",
        "length": row.length,
        "width": row.width,
        "priceWay": "01",
        "priceWayDesc": "按面积",
        "quantity": row.number,
        "requirements": "",
        "totalPrice": "0.00",
        "isUrgent": "0",
        "unit": "",
        "remarks": "",
        "unitPrice": ""

    });
    // $("#createOrder").datagrid("reload");
    autocompleteFun();
    // formula();
}
function addRow(o) {
    var rindex = $(o).parents("tr").index() + 1;
    $('#createOrder').datagrid('insertRow', {
        index: rindex,	// index start with 0
        row: {
            "businessDesc": "",
            "businessType": "00",
            "length": "",
            "width": "",
            "priceWay": "01",
            "priceWayDesc": "按面积",
            "quantity": "",
            "requirements": "",
            "totalPrice": "",
            "isUrgent": "0",
            "unit": "",
            "remarks": "",
            "unitPrice": ""
        }
    });
    autocompleteFun();
}
function delRow(o) {
    var rindex = $(o).parents("tr").index();
    if ($('#createOrder').datagrid("getRows").length > 1) {
        $('#createOrder').datagrid('deleteRow', rindex);
    }


    priceCount();
    // $("#createOrder").datagrid("reload");
}
function copyRow(o) {
    var i = $(o).parents("tr").index();
    var rows = $('#createOrder').datagrid("getRows");
    var row = {};

    row.businessDesc = rows[i].businessDesc;
    row.businessType = "00";
    row.requirements = $("input.autocomplete_req")[i].value;
    row.workingProcedure = rows[i].workingProcedure;
    row.unitPrice = $("input.unitPriceChange")[i].value;
    row.totalPrice = $("input.totalpriceChange")[i].value;
    row.unit = $("input.inputTemplateUnit")[i].value;
    row.isUrgent = rows[i].isUrgent;
    row.priceWay = rows[i].priceWay;
    row.priceWayDesc = rows[i].priceWayDesc;
    row.length = $("input.inputTemplateLength")[i].value;
    row.remarks = $("input.remarksChange")[i].value;
    row.width = $("input.inputTemplateWidth")[i].value;
    row.quantity = $("input.inputTemplateQuantity")[i].value;
    $('#createOrder').datagrid('insertRow', {
        index: i + 1,	// index start with 0
        row: row
    });
    priceCount();
    autocompleteFun();
    // $("#createOrder").datagrid("reload");
}
function fwdjFoward() {

    var config = {
        menuUrl: "/openPage?pageName=advert_service-pricing"
    };
    // icon 必须固定 否则触发不了点击事件
    $("#headerLeftMenu li[data-icon='icon-ydz-menu-base-data']", window.parent.document).click();
    parent.mainConfigUrl(config);
}

var teams = $.map(priceWayAll, function (obj) {
    obj.value = obj.priceWayDesc; // replace name with the property used for the text
    obj.data = obj.priceWay; // replace name with the property used for the text
    return obj;
});



