<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>创建费用单</title>

    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
    <script src="/resources/business/base_new.js?v=9ac481258d"></script>
    <script type="text/javascript" src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
    <script type="text/javascript" src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1" charset="UTF-8"></script>
    <style>
        .datagrid-row-over,
        .datagrid-header td.datagrid-header-over {
            background: none !important;
            color: #000;
            cursor: default;
        }

        table,
        th,
        td {
            vertical-align: top;
        }

        .ui.items-view table tbody tr:nth-child(even) {
            background: none !important;
        }

        .pagination table {
            height: 40px;
            line-height: 40px;
            float: right;
        }

        .datagrid-header .datagrid-cell {
            height: 50px;
            line-height: 50px;
            /*text-align: center !important;*/
        }
        .datagrid-header td{
            border-color: #eff1f9 !important;
        }
        .btn-primary:hover,
        .btn-primary:focus,
        .btn-primary:active,
        .btn-primary.active,
        .open .dropdown-toggle.btn-primary {
            background-color: #2e8ae6;
            border-color: #2e8ae6;
        }

        .datagrid-header td,
        .datagrid-body td,
        .datagrid-footer td {
            border-style: solid;
            border-color: #eae8e8;
        }

        .datagrid-body td {
            position: relative;
            height: 50px;
        }
        .datagrid-body tr td:nth-last-child(2),.datagrid-body tr td:nth-last-child(1){
            border-width: 0px 0 1px 0;
        }
        .datagrid .panel-body {
            border: none !important;
        }

        table,
        th,
        td {
            vertical-align: middle;
        }

        .h10 {
            clear: both;
            height: 40px;
        }

        .datagrid-body .datagrid-cell {
            padding: 10px 12px;
        }

        .datagrid-header,
        .datagrid-td-rownumber {
            background: #eff1f3;
        }

        .tips_contants {
            position: fixed;
            top: 50%;
            left: 50%;
            z-index: 99999;
            display: none;
            margin-top: -150px;
            margin-left: -150px;
            width: 300px;
            height: 80px;
            border-radius: 5px;
            background: rgba(0, 0, 0, .8);
            color: #fff;
            text-align: center;
            line-height: 80px
        }

        .form-control {
            display: block;
            width: 100%;
            height: 30px;
            padding: 6px 10px 6px 12px;
            font-size: 12px;
            line-height: 1.428571429;
            color: #555;
            vertical-align: middle;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .header {
            padding: 2px 10px;
            /*border: 1px solid #e4e4e4;*/
            font-size: 18px;
            color: #333333;
        }

        .header span {
            margin-left: 16px;
            font-size: 12px;
            color: #666;
        }
        .datagrid-header .datagrid-cell span{
            font-size: 14px;
            color: #666;
        }
        .datagrid .datagrid-pager {
            border-top: 2px solid #2e8ae6;
        }

        .pagination {
            border-radius: 0px;
        }
        .datagrid-cell-c2-payDate,.datagrid-cell-c2-expenseDesc,.datagrid-cell-c2-money,.datagrid-cell-c2-totalMoney{
            padding: 0 12px; 
        }
        .datagrid-cell-c2-totalMoney{
            color:#eb6877;
        }
        .datagrid-header{
            height: 50px !important;
            background: #eff1f9;
            border-width: 0;
        }
        .datagrid-cell-c2-payDate{
            font-size: 14px;
            padding: 0 12px !important;
        }
        #deleteWin{
            border: none;
            z-index: 9999;
            width: 700px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            /*min-height:290px;*/
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
            display: none;
        }
        
    </style>

    <script>
        var pageUrl = "ydz/expensebook/listExpenseBookDetailVOs";// 本页面请求url
        var pageVendorUrl = "ydz/expensebook/listSpender";// 本页面供应商请求url
        var pageAllUrl="/ydz/expensebook/getExpenseTypeForDropdown";
        var rows;

            var method = [{"contacterId": "1", "contacterName": "现金"}, {
                "contacterId": "2",
                "contacterName": "银行转账"
            }, {"contacterId": "3", "contacterName": "信用卡"}, {
                "contacterId": "4",
                "contacterName": "支付宝"
            }, {"contacterId": "5", "contacterName": "微信钱包"}, {"contacterId": "6", "contacterName": "其他"}];
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
        function reload() {
            var url = pageUrl;
            var arrclo = [];
            arrclo.push({
                field: 'payDate',
                title: '付款日期',
                width: 140,
                align: 'left',
                sortable: true,
                fixed:true,
                formatter: function (value, row) {
                    return value + "<br/><span style='display:inline-block; color:#ccc;font-size:12px;margin-top:3px;'>" + row.expenseExplain + "<span/>";
                }
            });
            arrclo.push({field: 'spenderName', title: '支出对象', width: 100,fixed:true, align: 'center'});
            arrclo.push({
                field: 'expenseTypeDesc', width: 100, align: 'center', title: '分类',fixed:true
            });
            arrclo.push({field: 'expenseDesc',fixed:true, width: 300, title: '费用描述'});
            arrclo.push({
                field: 'money', width: 90, align: 'left',fixed:true, formatter: function (value, row) {
                    return accounting.formatNumber(value, 2);
                }, title: '行小计'
            });
            arrclo.push({
                field: 'totalMoney', width: 90, align: 'left',fixed:true, formatter: function (value, row) {
                    return accounting.formatNumber(value, 2);
                }, title: '费用单金额'
            });
            arrclo.push({
                field: 'payType', width: 90, align: 'center',fixed:true, title: '付款方式', formatter: function (value, row) {
                    for (var i = 0; i < method.length; i++) {
                        if (value == method[i].contacterId) {
                            return method[i].contacterName;
                            break;
                        }
                    }
                }
            });
            arrclo.push({field: 'createTime', width: 140,fixed:true, align: 'center', sortable: true, title: '制单时间'});
            arrclo.push({field: 'creatorName', width: 100,fixed:true, align: 'center', title: '制单人'});
            arrclo.push({
                field: 'pur', width: 200, align: 'center',fixed:true, title: '操作方式', formatter: function (value, row) {
                    // var rowStr=JSON.stringify(row);
                    return "<span onclick='similar(" + row.expenseNo + ")' style='color:#4284d9;cursor: pointer;'>创建相似</span>" + "<span onclick='amend(" + row.expenseNo + ")' style='color:#4284d9; padding-left:15px;cursor: pointer;'>修改费用单</span>"+"<span onclick='delet("+ row.expenseNo +")' style='color:#4284d9; padding-left:15px;cursor: pointer;'>删除</span>";
                }
            });
             arrclo.push({field: 'crea', width: 100, align: 'center',resizable:false,});
            $('#order').datagrid({
                url: pageUrl,
                pagination: true,
                columns: [arrclo],
                queryParams: {
                    "spenderKey": $('#customerDat').val(),
                    "endDate": $('#datetimepickere').val(),
                    "searchKey": $('#searchK').val(),
                    "startDate": $('#datetimepickers').val(),
                    "expenseType": 0,
                    "expenseTypeDetail":$('#classify').val()
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
        // debugger;
        function onLoadSuccess(data) {


            if (data.rows.length > 0) {
                var num = 0;
                for (var i = 0; i < data.rows.length; i++) {
                    num += Number(data.rows[i]["money"]);
                }
                $("#order2PagerNum").text(data.total);
                $("#order2PagerPrice").text(accounting.formatNumber(num, 2));

                mergeCellsByField("order", 'payDate,spenderName,totalMoney,payType,createTime,creatorName,pur,crea');
            } else {
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
                        CurTxt = tTable.datagrid("getRows")[i][ColArray[j]] + tTable.datagrid("getRows")[i]["expenseNo"];
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
        function similar(row) {
            var App = window.parent.App;
            var config = {
                path: "/ydz/expensebook/forward-update?expenseType=0&&expenseNo=" + row + "&&type=copyAdd",
            };
            App.open(config.path, config);
        }
        function amend(row) {
            //    console.log(row)
            var App = window.parent.App;
            var config = {
                path: "/ydz/expensebook/forward-update?expenseType=0&&expenseNo=" + row + "&&type=update",
            };
            App.open(config.path, config);
        }
        function openTaxPoint() {
            var App = window.parent.App;
            var config = {
                path: "/ydz/expensebook/forward-add?expenseType=0"
            };
            App.open(config.path, config);
        }
        function delet(row){
            rows = row;
            $("#deleteWin").show();
            $(".window-mask").show();
        }
        function closeTaxPoint (){
            $("#deleteWin").hide();
            $(".window-mask").hide();
        }
        function delOrderConfirm (){
             $.ajax({
                            url: "/ydz/expensebook/delete",
                            type: "POST",
                            data: {"expenseNo":rows},
                            success: function (callBack) {
                                location.reload();
                            }, error: function () {
                               
                            }
                        });
        }
    </script>

</head>

<body class="easyui-layout" style="border:none !important;">
<%--遮罩--%>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div
        id="deleteWin" class=" animated flipInY" style="    padding-top: 5px;
                top: 50%;
                left: 50%;
                margin-left: -125px;
                margin-top: -93px;
                position: absolute;
                width: 330px;
                height: 187px;">
    <p style="    position: relative;
                font-weight: 100;
                text-align: left;
                font-size: 22px;
                margin: 0px auto;
                padding: 5px 20px;
                border-bottom: 1px solid #ccc;">
        提示</p>
    <span id="closetranform" style="    position: absolute;
                top: 20px;
                right: 1px;
                display: block;
                height: 30px;
                width: 30px;
                cursor: pointer;" onclick="closeTaxPoint()"><i
            style="background: url('/images/close_user.png');width:14px;height: 14px;display: block"
            alt="点击关闭"></i></span>
    <div style="    text-align: center;
                margin: 20px auto;">
                        <span class="customerjc" style="    position: relative;
                text-align: center;
                margin: 0 auto;
                font-size: 22px;
                font-weight: normal;
                color: #44ae80;
                height: 30px;
                line-height: 30px;">确定要删除吗？</span>
        <div style="clear: both;margin-top:45px;">
            <button type="button" class="btn  btn-default"  onclick="closeTaxPoint()" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:12px;width:92px;font-size:12px;" onclick="delOrderConfirm(this)">确认</button>
        </div>
    </div>
</div>

<div data-options="region:'north'" style="border:none !important; padding:10px 10px 9px;margin-right: 10px;overflow: hidden;">
    <div c-widget="ButtonGroup;">
        <div class="header">日常支出<span>记录你的支出（差旅报销、办公、人工薪资等）费用，让每笔花销有迹可循</span></div>

        <div class="h10"></div>
        <form role="form">
            <div class="row" style="margin:0;padding-bottom:10px; border-bottom:1px solid #f2f2f2;">
                <div class="col-xs-2" style="width:150px;padding:0 5px 0 0">
                    <select class="form-control input-xs" id="classify">
                        <option value="">全部费用分类</option>
                    </select>
                </div>
                <div class="col-xs-2" style="width:150px;padding:0 5px">
                    <select class="form-control input-xs" id="customerDat">
                        <option value="">全部员工</option>
                    </select>
                </div>
                <div class="col-xs-2 " style="width:150px;padding:0 5px">

                    <div class="">
                        <div class="input-icon-group">
                            <div class="" style="width:100%">
                                <input type="text" class="form-control" id="datetimepickers" data-format="yyyy-MM-dd"
                                       placeholder="付款日期">
                                <%--<span class="glyphicon glyphicon-calendar "></span>--%>
                                <span onclick="$('#datetimepickers').datetimepicker('show');" class="" style="
    position: absolute;
    right: 10px;
    top: 0px;
    height:30px;
    line-height:30px;
    border-left: 1px solid #ccc;
"><i class="iconfont_new" style="padding:0px 10px 0 15px;">&#xe6a6;</i></span>
                                </input>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-2 " style="width:150px;padding:0 5px">
                    <div class="">
                        <div class="input-icon-group">
                            <div class="" style="width:100%">
                                <input type="text" class="form-control" id="datetimepickere" data-format="yyyy-MM-dd"
                                       placeholder="付款日期">
                                <span onclick="$('#datetimepickere').datetimepicker('show');" class="" style="
    position: absolute;
    right: 10px;
    top: 0px;
    height:30px;
    line-height:30px;
    border-left: 1px solid #ccc;
"><i class="iconfont_new" style="padding:0px 10px 0 15px;">&#xe6a6;</i></span>
                                </input>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-2">
                    <div class="input-group" style="width:298px;">
                        <input type="text" class="form-control" id="searchK" placeholder="输入 费用说明 搜索"
                               style="width:208px;border-radius: 15px;padding-left:10px;">
                        <button type="button" id="searchBtn" class="btn btn-primary "
                                style="font-size:12px;height:30px;line-height:1;margin-left:20px;">搜索
                        </button>
                    </div>

                </div>

                <button type="button" class="btn btn-primary pull-right "
                        style="font-size:12px;height:30px;line-height:1;padding:0 15px;"
                        onclick="openTaxPoint()">创建费用单
                </button>
            </div>
        </form>


    </div>
</div>

<div data-options="region:'center'" style="border:none !important;padding:0px 10px 10px;width: 100%;">
    <table id="order" style="width: 100%;" class="easyui-datagrid order" data-options="remoteSort:false,fitColumns:true,
           nowrap:true,singleSelect:false,checkOnSelect:false,onLoadSuccess:onLoadSuccess,fit:true">
    </table>
</div>


<div style="font-weight: bolder;position: fixed;bottom:10px;left:30px; line-height: 40px; overflow: hidden;">
    本页合计 :
    <span style="color: red;margin-right: 15px;" id="order2PagerPrice">0.00</span>
</div>
<script>
    $(function () {
        //
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
        $("#dateDat").select2({
            minimumResultsForSearch: Infinity
        });

        $.ajax({
            url: pageVendorUrl,
            dataType: "json",
            success: function (data) {
                $("#customerDat").append(returnopt(data, 1));
                $("#customerDat").select2({
                    //   样式控制
                    templateResult: formatState
                });
                var classify=   function  (typeDescAl){
                    var opti = "";
                    for(var i = 0; i<typeDescAl.length; i++){
                        opti += '<option value="' + typeDescAl[i].typeCode + '">' + typeDescAl[i].typeDesc + '</option>';
                    }
                    return opti;
                }
                var query={settingClass :"01"};

                $.ajax({
                    url: pageAllUrl,
                    data:jQuery.param(query),
                    dataType: "json",
                    success: function (data) {
                        $("#classify").append(classify(data));
                        $("#classify").select2({
                            templateResult: formatState
                        });

                        reload();
                    }
                    });


            },
            error: function () {
            }
        });


        //全部订单搜索
        $("#searchBtn").click(function () {
            reload();

        })


    });

    function returnopt(data, type) {
        var opt = "";
        for (var i = 0; i < data.data.length; i++) {
            var dt = data.data[i];
            var dtn = "";
            if (type == 1) {
                //                    if(dt.partnerShortname==undefined){continue;}
                dtn = dt.realName == undefined ? "选择经办人" : dt.realName;
                opt += '<option value="' + dt.employeeId + '">' + dtn + '</option>';
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
</script>
</body>

</html>