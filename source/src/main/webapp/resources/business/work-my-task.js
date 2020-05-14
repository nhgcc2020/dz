var pageCtWkUrl = "/order/workingassigntask/listAssignWorkingTaskAndDetails"; //工序列表空间url
var pageAssignWkUrl = "/order/workingassigntask/assignTask"; //完工
var selectItemWk;
var types = 0;
var orderTableWs = {
    closeTaxPoint: function () {
        $(".window-mask").hide();
        $("#taxPointWin").css({display: 'none'});
    },

    relateWkShop: function (row) {
        return '<span class="labelCon">写作工序</span>' +
            '<span class="labelCon">写作工序</span>'
    },
    saveTable: function () {
        if (types == 0) {
            var url = pageAssignWkUrl;
            var queryParams;
            queryParams = selectItemWk;
            queryParams.orderDate = null;
            $.ajax({
                url: url,
                type: 'post',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                data: queryParams,
                dataType: "json",
                success: function (dt) {
                    orderTableWs.closeTaxPoint();
                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
                    reloadWk();
                },
                error: function () {
                    $("<div class='tips_contants'>").fadeIn(250).html("保存失败").delay(1000).fadeOut(250).appendTo('body');
                }
            })
        } else {
            var numbers = $('#orderWk').datagrid('getChecked')
            var url = pageAssignWkUrl;
            for (var i = 0; i < numbers.length; i++) {
                $.ajax({
                    url: url,
                    type: 'post',
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    data: numbers[i],
                    dataType: "json",
                    success: function (dt) {
                        orderTableWs.closeTaxPoint();
                        $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
                        reloadWk();
                    },
                    error: function () {
                        $("<div class='tips_contants'>").fadeIn(250).html("保存失败").delay(1000).fadeOut(250).appendTo('body');
                    }
                })
            }
        }
    },
    finishTaskPrt: function () {

        if (types == 0) {
            orderTableWs.saveTable();
            window.open("../../../print/working-assign-label-print.html?uid=" + [selectItemWk.uid] + "&partnerKey=" + selectItemWk.partnerKey)
        } else {
            orderTableWs.saveTable();
            var numbertwo = $('#orderWk').datagrid('getChecked')
            var arrone = [];
            for (var i = 0; i < numbertwo.length; i++) {
                arrone.push(numbertwo[i].uid)
            }


            window.open("../../../print/working-assign-label-print.html?uid=" + arrone + "&partnerKey=" + numbertwo[0].partnerKey)
        }

    }
}
function delOrder() {
    var order4ItemsArr = $('#orderListPr').datagrid('getChecked');
    var partnerMod = order4ItemsArr[0];
    if (order4ItemsArr.length > 1) {
        $("<div class='tips_contants'>").fadeIn(250).html("每次只可删除单个生意伙伴").delay(3000).fadeOut(250).appendTo('body');
        return false;
    }
    if (order4ItemsArr.length == 0) {
        $("<div class='tips_contants'>").fadeIn(250).html("请勾选你需要删除的生意伙伴").delay(3000).fadeOut(250).appendTo('body');
        return false;
    }
    if (partnerMod["partnerKey"] == "temp-customer") {
        $("<div class='tips_contants'>").fadeIn(250).html("过路客不可删除").delay(3000).fadeOut(250).appendTo('body');
        return false;
    }

    if (partnerMod["partnerStatus"] != "5") {
        $("<div class='tips_contants'>").fadeIn(250).html("只可删除待邀请状态的生意伙伴").delay(3000).fadeOut(250).appendTo('body');
        return false;
    }
    $('#myModal').modal('show');
}
function delOrderConfirm() {
    var order4ItemsArr = $('#orderListPr').datagrid('getChecked');
    var partnerMod = order4ItemsArr[0];

    $.ajax({
        type: "POST",
        url: "<c:url value='/system/partner/delPartner'/>",
        data: {partnerKey: partnerMod["partnerKey"]},
        dataType: "json",
        success: function (callback) {
            if (callback.state == "1") {
                $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(2000).fadeOut(250).appendTo('body');
                setTimeout(function () {
                    window.location.reload();
                }, 2000);
            } else {
                $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(2000).fadeOut(250).appendTo('body');
            }
        }
    })
}
function closeProReq() {
    $(".window-mask").hide();
    $("#topBarPR").hide();
}

function testHard1(btn) {
    var currentItem = $("#order").datagrid("getSelected");
    if (currentItem == null) {
        $("<div class='tips_contants'>").fadeIn(250).html("请先选择一条物料制作说明").delay(2000).fadeOut(250).appendTo('body');
        return;
    }

    var rowIndex = globVar.con;
    if ($('#createOrder').datagrid('getRows')[rowIndex].businessDesc != "") {
        $('#createOrder').datagrid('updateRow', {
            index: rowIndex, row: {
                "requirements": currentItem.categoryDesc,
                "unit": currentItem.priceUnitDesc,
                "priceWay": currentItem.priceWay,
                "priceWayDesc": currentItem.priceWayDesc,
                "unitPrice": currentItem.unitPrice
            }
        });
        autocompleteFun();
        formula(rowIndex);
    }

    $(".window-mask").hide();
    $("#topBarPR").hide();
}
function requirementMenu() {
    $(".loading_box").removeClass("loadingssss");
    menuLoad();//初始化grid数据
}
function openProReq() {

    $(".window-mask").show();
    $("#topBarPR").show();
    requirementMenu();
}
function msg(content) {
    $("#msgwindow").html(content).addClass("activ");
}
function showOverFlow(obj) {
    //        partnerName  partnerAttr tel1  contacterName partnerKey
    //        data-kid='+row.partnerKey+'data-pid='+row.tel1+' data-cid='+row.contacterName+' data-id='+row.partnerName+' data-did='+row.partnerAttr+';
    var partner = $(obj);
    var partnerAttr = partner.data("did");
    //1 公司 
    if (partnerAttr == "1") {
        $("#inviteCom").html(partner.data("id"));
    } else {
        $("#inviteCom").html("个人伙伴");
    }
    $("#sendPhone").html(partner.data("pid"));
    $("#inviteName").html(partner.data("cid"));
    $("#partnerKeyPop").val(partner.data("kid"));
    $("#orderProcedure").css({display: 'block'});
    //        $("#orderProcedure").addClass(" flipInY").removeClass("flipOutY");
    $(".window-mask").show();
    //        flipInY flipOutY
}
function closeOverFlow() {
    //        $("#orderProcedure").addClass(" flipOutY").removeClass("flipInY");//css({display:'none'});
    $("#orderProcedure").css({display: 'none'});//css({display:'none'});
    $("#sendPhone").val("");
    $("#partnerKeyPop").val("");
    $("#sendMsgBtn").prop("disabled", true);
    $(".window-mask").hide()
}
function onLoadSuc(data) {
    try {
        if (data.rows.length > 0) {
            $("[data-toggle='tooltip']").tooltip();
        } else {
            $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
        }
    } catch (e) {

    }

}

function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
}

function arrFunDetail() {
    var arrclo = [];
    if ($('#navCondition li.active').attr("data-s") == "2" || $('#navCondition li.active').attr("data-s") == "c") {
        $("#complete").hide();
    } else {
        $("#complete").show();
        arrclo.push({field: 'ck', checkbox: true});
    }
    arrclo.push({
        field: 'cz',
        title: '操作',
        width: 140,
        align: 'center',

        formatter: function (value, row) {
            // + '<span onclick="modifyWk(3)" class="namebdsml">反完工</span>'
            var item = JSON.stringify(row);
            if (row.status == "C") {
                return "<span class='nameb' onclick='modifyWk(2," + item + ")'>打印标签</span>";
            } else if (row.status == 5) {
                return "<span class='nameb' onclick='modifyWk(1," + item + ")'>完工</span>";
            } else {
                return "<span class='namebd' onclick='modifyWk(1," + item + ")'>完工</span>" + "<span class='namebd' onclick='modifyWk(2," + item + ")'>打印标签</span>";
            }

        }
    });
    arrclo.push({
        field: 'partnerShortname', sortable: true, align: 'center', title: '客户', width: 100
    });
    arrclo.push({field: 'businessDesc', width: 280, align: 'left', title: '业务内容'});
    arrclo.push({
        field: 'requirements', width: 218, align: 'left', title: '物料/制作/说明', formatter: function (value, row) {
            if (row.isUrgent == "1") { //加急
                return value + '<p class="plistmarkSale" style="background: #FF5858;color:#fff;transform: scale(0.9);">加急</p>';
            }
            return value;
        }
    });
    arrclo.push({field: 'length', width: 100, align: 'center', sortable: true, title: '长度 ( m )'});
    arrclo.push({field: 'width', width: 100, align: 'center', sortable: true, title: '宽度 ( m )'});
    arrclo.push({field: 'quantity', width: 60, align: 'center', title: '数量'});
    // arrclo.push({field: 'totalArea', width: 80, align: 'center', title: '面积(㎡)'});
    // ,      formatter: function (value, row) {
    //         return '<div style="color:#d80000">' +value + '</div>';
    //     }
    arrclo.push({field: 'orderDate', width: 140, align: 'center', title: '订单日期'});
    arrclo.push({
        field: 'salesNo', width: 160, align: 'center', title: '单号', formatter: function (value, row) {
            // if (row.purchaseNo != '') {
            //     return value + '<p class="plistmarkSale">协</p>';
            // }
            return value;
        }
    });


    return arrclo;
}
function reloadWk() {
    var queryParams = {
        "partnerKey": $('#customerDat').val(),
        "startDate": $('#datetimepickers').val(),
        "endDate": $('#datetimepickere').val(),
        "searchKey": $('#searchK').val(),
        "workingProcedure": workingProcedure,
        "status": $('#navCondition li.active').attr("data-s")
    };
    $('#orderWk').datagrid({
        url: pageCtWkUrl,
        columns: [arrFunDetail()],
        queryParams: queryParams,
        pagination: true,
        // pageSize:310,
        // pageList:[300,310],
        remoteSort: false


    });
    var pager = $('#orderWk').datagrid('getPager');	// get the pager of datagrid
    // console.log(pager);
    pager.pagination({
        layout: ['first', 'links', 'last'],
        showRefresh: false,
        displayMsg: ''
    });
    $(".pagination").show();
}

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
$(function () {
    var dateObj = {};
    //昨天的时间
    var day1 = new Date();
    day1.setDate(day1.getDate() - 1);
    dateObj.beforeDate = day1.Format("yyyy-MM-dd");
    //前天的时间
    var day2 = new Date();
    dateObj.nowDate = day2.Format("yyyy-MM-dd");

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
    $("#makeProcess").select2({
        placeholder: "",
        minimumResultsForSearch: Infinity,
        data: makeProcessType
    }).val("01").trigger("change");
    $("#searchBtn").click(function () {
        var status = $("#navCondition").find(".active").attr("data-s");
        reloadWk(status);
    })
    $("#complete").click(function () {
        types = 1;
        var message = $('#orderWk').datagrid('getChecked');
        var partnetKey, partnerShortname;
        var flag = false;
        var numIndex = 0, partnerIndex = 0;
        $.each(message, function (index, element) {
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
        if (flag) {
            return;
        }


        if (message.length > 10) {
            $("<div class='tips_contants'>").fadeIn(250).html("最多只可勾选10个任务").delay(1000).fadeOut(250).appendTo('body');
        } else {
            $(".window-mask").show();
            $("#taxPointWin").css({display: 'block'});
            $("#wangong").html("<p style='text-align:center;font-size:16px;margin-top:100px;'>已勾选&nbsp;&nbsp;<span style='color:#4284d9'>" + message.length + "个</span>&nbsp;&nbsp;任务</p>")
        }
    })
    $.ajax({

        url: "/system/partner/dropdownPartner?partnerType=1",
        dataType: "json",
        timeout: "8000",
        success: function (data) {
            $("#customerDat").html(returnopt(data, 1));
            $("#customerDat").select2({
                templateResult: formatState
            });
            var status = $("#navCondition").find(".active").attr("data-s");
            reloadWk("");
        },
        error: function () {
        }
    });
    $.map(wkListType, function (val) {
        if (workingProcedure == val.id) {
            $(".header_text").html(val.text)
        }
    });
});
function modifyWk(type, item) {
    types = 0;
    if (type == "1") {
        $(".window-mask").show();
        $("#taxPointWin").css({display: 'block'});
        selectItemWk = item;
        $.ajax({
            url: '/order/workingassigntask/workingTaskLabel',
            data: {"uidIns": item.uid, "partnerKey": item.partnerKey, "contacterId": item.contactId},
            type: 'post',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            dataType: "json",
            success: function (dat) {

                var html = template('tpl-wangong', dat.data[0]);
                document.getElementById("wangong").innerHTML = html;
                if (dat.data[0].taskurl) {
                    $('#qrCodeDataMid').qrcode({width: 100, height: 100, text: dat.data[0].taskurl});
                }
            }
        })
    } else if (type == "2") {
        window.open("../../../print/working-assign-label-print.html?uid=" + [item.uid] + "&partnerKey=" + item.partnerKey)
    }

}

