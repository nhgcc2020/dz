var pageUrl="/ydz/purchaseorder/listPagePurchaseOrder";// 本页面请求url
var pageVendorUrl="/system/partner/dropdownPartner?partnerType=2";// 本页面供应商请求url
var pageBillReqUrl="/ydz/purchaseorder/generateBill";// 本页面生成对账单请求地址
$(function () {
    var dateObj = orderUtil.dpDateCompute("ld", 30);
    $('#datetimepickers').datetimepicker({ format: 'yyyy-mm-dd', language:  'zh-CN',   autoclose: true,
        minView:'month'}).on("click",function(){
        $("#datetimepickers").datetimepicker("setEndDate",$("#datetimepickere").val())
    });
    $('#datetimepickere').datetimepicker({ format: 'yyyy-mm-dd', language:  'zh-CN',     autoclose: true,
        minView:'month'}).on("click",function(){
        $("#datetimepickere").datetimepicker("setStartDate",$("#datetimepickers").val())
    });
    $("#datetimepickers").val(dateObj.beforeDate);
    $("#datetimepickere").val(dateObj.nowDate);
    $("#dateDat").html( returnopt(orderUtil.dateConfig,2)).change(function(){
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
        url:pageVendorUrl,
        dataType:"json",
        timeout:"8000",
        success:function(data){
            $("#customerDat").html( returnopt(data,1));
            $("#customerDat").select2({
//                        maximumInputLength:2,
                templateResult: formatState
            });
            var showNum = "order4";
            var type = GetRequest().type;
            if (type != "" && type != undefined) {
                showNum = type;
            }
            $("#btnGrpOp").find("."+showNum).addClass("smcolor").siblings().removeClass("smcolor");

            var status=$("#btnGrpOp").find("."+showNum).attr("data-s");
            reload(status);
        },
        error:function(){
        }
    });

        //全部订单搜索
        $("#searchBtn").click(function () {
            var status= $("#btnGrpOp").find(".btn.smcolor").attr("data-s");
            reload(status);

        })


});
function  returnopt(data,type) {
    var opt="";
    for(var i=0;i<data.length;i++){
        var dt=data[i];
        var dtn ="";
        if(type ==1){
//                    if(dt.partnerShortname==undefined){continue;}
            dtn =dt.myComShortname==undefined?"全部供应商":dt.myComShortname;
            opt +='<option value="'+dt.partnerKey+'">'+dtn+'</option>';
        }
        if(type ==2){
            dtn =dt.show;
            opt +='<option value="'+dt.key+'">'+dtn+'</option>';
        }
    }
    return opt;
}
function formatState (state) {
    var $state = $(
        '<span >'+state.text + '</span>'
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
function cgx(o) {
    hideMsg();
    $(o).addClass("smcolor").siblings().removeClass("smcolor");
    var status=$(o).attr("data-s");
    reload(status);
}
function reload(status) {
//        var url='test.json';
    var url=pageUrl;
    var arrclo=[];

    arrclo.push({field:'ck',checkbox:true});
    arrclo.push({field:'orderDate',title:'订单日期',width:140,align:'center',sortable:true,formatter: function(value, row) {
        return '<a data-id='+row.purchaseNo+' data-did='+row.industryId+' href=\'##\' onclick=openDt(this)>'+row.orderDate + '<span style="margin-left:26px;">详情</span></a>' ;
    }});
    arrclo.push({field:'partnerShortname',title:'供应商',width:180});
    arrclo.push({field:'contactName',width:80,align:'left',title:'联系人'});
    arrclo.push({field:'caseDesc',width:200,title:'项目名称'});
    arrclo.push({field:'workingStatus',width:150,title:'制作进度', formatter: function (value, row) {

        var urgent="";
        if (row.isUrgent=="1") { //加急
            urgent= '<p class="plistmarkSale" style="background: #FF5858;color:#fff;transform: scale(0.9);">加急</p>';
        }
        if(value=="制作中"){
            return '<span data-id="'+row.salesNo+'" onclick="openDtPg(this)" style="cursor:pointer;color:#ff9900;">' + value + '</span>'+urgent;
        }else if(value=="完工") {
            return '<span data-id="'+row.salesNo+'" onclick="openDtPg(this)" style="cursor:pointer;color:#44ae80;">' + value + '</span>'+urgent;
        }else {
            return '<div data-id="'+row.salesNo+'" onclick="openDtPg(this)" style="cursor:pointer;color:#ff9900;">' + value + '</div>'+urgent;
        }
    }});
    arrclo.push({field:'detailNum',width:55,title:'明细行'});
    arrclo.push({field:'depositRequested',width:120,align:'right',formatter: function(value, row) {
        return accounting.formatNumber(value,2);
    },title:'预付'});
    arrclo.push({field:'totalPrice',width:120,align:'right',formatter: function(value, row) {
        return accounting.formatNumber(value,2);
    },title:'订单金额'});
    arrclo.push({field:'remarks',width:200,align:'right',title:'备注'});
    arrclo.push({field:'createTime',width:140,align:'center',title:'制单时间'});
    arrclo.push({field:'purchaseNo',width:180,align:'center',title:'订单号',formatter: function(value, row) {
        if(row.salesNo !=''){
            return value+'<p class="plistmarkSale">协</p>';
        }
        return value;
    }});
    /*           var ardata={};
     $.ajax({
     url:pageUrl,
     async: "false",
     dataType: "json",
     data:"partnerKey="+$('#customerDat').val()+"&endTime="+$('#datetimepickere').val()+"&searchKey="+$('#searchK').val()+"&startTime="+$('#datetimepickers').val(),
     success:function(d){
     ardata=d.$data;
     }});*/

    if(status==""){
        $(".modifyOrder,.generatorBill").addClass("hide");
        $('#order').datagrid({
            url : pageUrl,
            pagination:true,
            columns:[arrclo],
            queryParams : {
                "partnerKey":$('#customerDat').val(),
                "endTime":$('#datetimepickere').val(),
                "searchKey":$('#searchK').val(),
                "startTime" : $('#datetimepickers').val()
            }
        });
    }else{
        if(status=="01"){
            $(".modifyOrder").removeClass("hide");
            $(".generatorBill").addClass("hide");
        }else if(status=="04"){
            $(".modifyOrder,.generatorBill").removeClass("hide");
        }else{
            $(".modifyOrder,.generatorBill").addClass("hide");
        }
        $('#order').datagrid({
            url : pageUrl,
            pagination:true,
            onLoadSuccess:onLoadSuccess,
            columns:[arrclo],
            queryParams : {
                "orderStatus":status,
                "partnerKey":$('#customerDat').val(),
                "endTime":$('#datetimepickere').val(),
                "searchKey":$('#searchK').val(),
                "startTime" : $('#datetimepickers').val()
            }
        });
    }

    var pager = $('#order').datagrid('getPager');	// get the pager of datagrid
    pager.pagination({
        layout:['first','links','last'],
        showRefresh:false,
        displayMsg:''
    });
    $(".pagination").show();
}

function openDtPg(obj) {
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
    var  queryParams={
        "partnerKey": "ALL",
        "salesNo": salesno,
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
function openDt(obj){
    var url = "/ydz/purchaseorder/detail?purchaseNo=" +$(obj).attr("data-id") + "&industryId=" + $(obj).attr("data-did");
    showMessageDialog(url,"","84%","100%",true);
}
function msg(content){
    $("#msgwindow").html(content).addClass("activ");
}
function hideMsg() {
    $(".window-mask").hide();
    $("#msgwindow").css({left:"100%"}).removeClass("activ");
}
function showMessageDialog(url, title, width, height, shadow) {
    var content = '<iframe id="msgF" src="'+url+'" width="100%" height="99%" frameborder="0" scrolling="yes"></iframe>';
    $("#msgwindow").empty();
    $("#msgwindow").css({left:"16%"});
    $(".window-mask").hide();
    var last = Date.now();
    setTimeout(function(){
        // 监听动画完成时间
        if($("#msgwindow").hasClass("activ")){
            msg(content);
        }else{
            $("#msgwindow")[0].addEventListener('webkitTransitionEnd', function(){
                if(Date.now() - last < 3000){
                    msg(content);
                }
            }, false);
        }

    }, 0);
}
function onLoadSuccess(data){
    console.log(data);
    if (data.rows.length > 0 ) {

        var num=0;
        for(var i=0;i<data.rows.length;i++){
            num +=Number(data.rows[i]["totalPrice"]);
        }
        $("#order2PagerNum").text(data.total);
        $("#order2PagerPrice").text(accounting.formatNumber(num,2));

        mergeCellsByField("order", 'ck,orderDate,purchaseNo,partnerShortname,contactName,createTime,totalPriceOrder');
    }else{
        $("#order2PagerNum").text(0);
        $("#order2PagerPrice").text("0.00");
        $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
    }
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
                CurTxt = tTable.datagrid("getRows")[i][ColArray[j]]+tTable.datagrid("getRows")[i]["purchaseNo"];
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
    var order4ItemsArr =$('#order').datagrid('getChecked');
    console.log(order4ItemsArr);
    var cols=[];
    var checkRow="";
    for(var i=0;i<order4ItemsArr.length;i++){
        if(i==0){
            checkRow=order4ItemsArr[i].purchaseNo;
            cols.push(order4ItemsArr[i]);
        }else{
            if(order4ItemsArr[i].purchaseNo==checkRow){
                continue;
            }else{
                checkRow=order4ItemsArr[i].purchaseNo;
                cols.push(order4ItemsArr[i]);
            }
        }
    }
    $.each(cols, function(index, item){

        modifyRow.push(item);
    });


    if (modifyRow.length == 1) {
        //查询订单状态
        var saleOrderNo = modifyRow[0].purchaseNo;
        if (modifyRow[0].salesNo !="") {
            $("<div class='tips_contants'>").fadeIn(250).html("此单为协同订单，只能由销售方进行修改").delay(4000).fadeOut(250).appendTo('body');
            return false;
        } else {
            var App = window.parent.App;
            var config = {
                path: "/ydz/purchaseorder/updatePage?purchaseNo=" + modifyRow[0].purchaseNo
            };
            App.open(config.path, config);
        }
    } else {
        if($(".tips_contants").length>0){
            $(".tips_contants").remove();
            $("<div class='tips_contants'>").fadeIn(250).html("只可修改单笔订单").delay(3000).fadeOut(250).appendTo('body');}else{$("<div class='tips_contants'>").fadeIn(250).html("只可修改单笔订单").delay(3000).fadeOut(250).appendTo('body');}
    }


}
function openTaxPoint() {
//        var order4ItemsArr =$('#order').datagrid('getSelections');
    var order4ItemsArr =$('#order').datagrid('getChecked');
    console.log(order4ItemsArr);
    var order4Items=[];
    var checkRow="";
    for(var i=0;i<order4ItemsArr.length;i++){
        if(i==0){
            checkRow=order4ItemsArr[i].purchaseNo;
            order4Items.push(order4ItemsArr[i]);
        }else{
            if(order4ItemsArr[i].purchaseNo==checkRow){
                continue;
            }else{
                checkRow=order4ItemsArr[i].purchaseNo;
                order4Items.push(order4ItemsArr[i]);
            }
        }
    }

    var partnetKey,partnerShortname;
    var flag = false;
    var numIndex = 0,partnerIndex=0;
    $.each(order4Items,function (index, element) {
        //判断是否同一用户
        if (numIndex == 0) {
            partnetKey = element.partnerKey;
            partnerShortname = element.partnerShortname;
        } else if (partnetKey != element.partnerKey) {
            $("<div class='tips_contants'>").fadeIn(250).html("请选择相同供应商").delay(3000).fadeOut(250).appendTo('body');
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

    $.each(order4Items,function (index, element) {
        if (element.salesNo != "" ) {
            $("<div class='tips_contants' >").fadeIn(250).html("此单为协同订单，只能由销售方来生成对账单").delay(3000).fadeOut(250).appendTo('body');
            flag = true;
            return false;
        }
    });
    if (flag) {
        return false;
    }

    var totalPrice = 0,depositRequested=0,receivePrice=0;
    var purchaseNos = new Array();
    $.each(order4Items,function (index, element) {
        purchaseNos.push(element.purchaseNo);
        totalPrice = totalPrice + element.totalPrice;
        depositRequested = depositRequested + element.depositRequested;
    });
    if (purchaseNos.length == 0) {
        $("<div class='tips_contants'>").fadeIn(250).html("请选择需要对账的订单").delay(3000).fadeOut(250).appendTo('body');
    } else {
        $("#depositRequestedHid").val(depositRequested);
        $("#totalPriceHid").val(totalPrice);
//            $("#totalPriceWithTaxHid").val(totalPrice);
//            $("#taxPriceHid").val(0);


        //depositRequested 没有返回
        receivePrice=Number(totalPrice)-Number(depositRequested);
        totalPrice = accounting.formatNumber(totalPrice,2);
        depositRequested = accounting.formatNumber(depositRequested,2);

        receivePrice = accounting.formatNumber(receivePrice,2);


        $("#receivePriceHid").val(receivePrice);
        $("#totalPrice").text(totalPrice);//销售价格
        $("#numIndex").text(numIndex);//订单笔数
        $("#partnerShortname").text(partnerShortname);//供应商简称
        $("#depositRequested").text(depositRequested);//预付金额

        //需要变换的值
        $("#taxRateView").val(0);//税率赋值0
        $("#totalPriceWithTax").text(totalPrice);//默认价格
        $("#taxPrice").text(0.00);//默认税额
        $("#receivePrice").text(receivePrice);//应付金额
        $(".window-mask").show();
        $("#taxPointWin").css({display:'block'});
    }
}
function addShuiDian(o) {
//        model.set("taxObj.taxRateView", 0);
    if($("#shuidainBtn").text()=="添加税点"){$("#shuiDianCtrl").slideDown();$("#shuidainBtn").text("撤销税点")}
    else if($("#shuidainBtn").text()=="撤销税点"){
        $("#taxRateView").val(0);//税率赋值0
        $("#totalPriceWithTax").text($("#totalPrice").text());//默认价格
        $("#taxPrice").text(0.00);//默认税额
        $("#receivePrice").text($("#receivePriceHid").val());//应付金额

//            $("#totalPriceWithTaxHid").val($("#receivePriceHid").val());
//            $("#taxPriceHid").val(0);

        $("#shuiDianCtrl").slideUp();$("#shuidainBtn").text("添加税点")}
}
function inputCalMoney(o) {
    if(isNaN($(o).val())){
        $("#taxRateView").val(0);//税率赋值0
        $("#totalPriceWithTax").text($("#totalPrice").text());//默认价格
        $("#taxPrice").text(0.00);//默认税额
        $("#receivePrice").text($("#receivePriceHid").val());//应付金额

        $("#totalPriceWithTaxHid").val($("#receivePriceHid").val());
        $("#taxPriceHid").val(0);

        return;
    }
//        $("#totalPriceWithTaxHid").val(Number($("#totalPriceHid").val())*(1+Number($("#taxRateView").val())/100));
//        $("#taxPriceHid").val((Number($("#taxRateView").val())*Number($("#totalPriceHid").val())).toFixed(2));

    $("#taxPrice").text(accounting.formatNumber((Number($("#taxRateView").val())*Number($("#totalPriceHid").val())).toFixed(0)/100, 2));
    $("#totalPriceWithTax").text(accounting.formatNumber(Number($("#totalPriceHid").val())*(1+Number($("#taxRateView").val())/100), 2));
    $("#receivePrice").text(accounting.formatNumber((Number($("#totalPriceHid").val())*(1+Number($("#taxRateView").val())/100))-Number($("#depositRequestedHid").val()), 2));
}

function closeTaxPoint() {
    $(".window-mask").hide();
    $("#taxPointWin").css({display:'none'});
    $("#taxRateView").val(0);//税率赋值0
    $("#totalPriceWithTax").text($("#totalPrice").text());//默认价格
    $("#taxPrice").text(0.00);//默认税额

//         $("#totalPriceWithTaxHid").val($("#receivePriceHid").val());
//         $("#taxPriceHid").val(0);
    $(".generatorBill").attr("disabled", false);
    $("#receivePrice").text($("#receivePriceHid").val());//应付金额
    $("#shuiDianCtrl").slideUp();$("#shuidainBtn").text("添加税点")
}
function  batchGenerateBill(btn) {
    $(btn).attr("disabled", true);
    var order4ItemsArr =$('#order').datagrid('getChecked');
    var order4Items=[];
    var checkRow="";
    for(var i=0;i<order4ItemsArr.length;i++){
        if(i==0){
            checkRow=order4ItemsArr[i].purchaseNo;
            order4Items.push(order4ItemsArr[i]);
        }else{
            if(order4ItemsArr[i].purchaseNo==checkRow){
                continue;
            }else{
                checkRow=order4ItemsArr[i].purchaseNo;
                order4Items.push(order4ItemsArr[i]);
            }
        }
    }
    var purchaseNos = new Array();
    var partnetKey;
    var flag = false;
    var numIndex = 0;
    $.each(order4Items,function (index,element) {
        purchaseNos.push(element.purchaseNo);
        //判断是否同一用户
        if (numIndex == 0) {
            partnetKey = element.partnerKey;
        } else if (partnetKey != element.partnerKey) {
            $(btn).attr("disabled", false);
            $("<div class='tips_contants'>").fadeIn(250).html("请选择相同供应商").delay(3000).fadeOut(250).appendTo('body');
            flag = true;
            return false;
        }
        numIndex++;

    });
    if (flag) {
        return false;
    }

    var parse={};
    parse.purchaseNos=JSON.stringify(purchaseNos);
    parse.taxRateView = Number($("#taxRateView").val())/100;
    parse.taxRate = Number($("#taxRateView").val())/100;

    parse.totalPrice = accounting.unformat($("#totalPrice").text());
    parse.taxPrice = accounting.unformat($("#taxPrice").text());
    parse.totalPriceWithTax = accounting.unformat($("#totalPriceWithTax").text());
    $.ajax({
        type: "POST",
        url: pageBillReqUrl,
        data: jQuery.param(parse),
        async: "false",
        dataType: "json",
        success: function (callback) {
            if (callback.status == "1") {
                closeTaxPoint();
                $(btn).attr("disabled", false);
                $("<div class='tips_contants'  style='line-height: 40px'>").fadeIn(250).html("已成功生成对账单</br>请到【采购对账单】---【待付款对账单】查看").delay(3000).fadeOut(250).appendTo('body');
                setTimeout(function () {
                    $("#order").datagrid('reload');
                }, 2500);

            } else {
                closeTaxPoint();
                $(btn).attr("disabled", false);
                $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(3000).fadeOut(250).appendTo('body');
            }
        },
        error: function () {
            $(btn).attr("disabled", false);
            $("<div class='tips_contants'>").fadeIn(250).html("开票失败").delay(3000).fadeOut(250).appendTo('body');
        }
    })
}



