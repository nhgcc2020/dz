<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="renderer" content="webkit"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta charset="UTF-8">
    <title>创建费用单</title>
    <base href="/">
    <link rel="stylesheet" type="text/css" href="/resources/common/common.css?v=076f5c8c95">
    <link rel="stylesheet" type="text/css" href="/resources/common/custom-widget.css?v=824f9feec4">

    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/animate.css?v=044dba19fd">
    <style>
        #spenderKey,#payType {
            margin: 0em;
            outline: none;
            -webkit-appearance: none;
            tap-highlight-color: rgba(255, 255, 255, 0);
            line-height: 30px;
            padding: 0em 1em;
            height: 30px;
            font-size: 1em;
            background: #FFFFFF;
            border: 1px solid rgba(34, 36, 38, 0.15);
            color: rgba(0, 0, 0, 0.87);
            border-radius: 0.28571429rem;
            box-shadow: 0em 0em 0em 0em transparent inset;
            -webkit-transition: color 0.1s ease, border-color 0.1s ease;
            transition: color 0.1s ease, border-color 0.1s ease;
        }
        .btnGrp {
            margin-top: 5px;
        }

        .btnGrp button {
            margin-left: 6px;
        }

        .contentTemplate:hover {
            color: #4284d9 !important;
        }

        .datagrid-cell-c1-typeDescDesc {
            position: relative;
        }

        .datagrid-cell-c1-typeDescDesc input {
            text-align: center;
        }

        .datagrid-cell-c1-quantity input,
        .datagrid-cell-c1-unitPrice input,
        .datagrid-cell-c1-totalPrice input {
            text-align: left;
        }

        * {
            outline: none;
            outline-color: #fff;
        }

        .ui.segment.custom-table .ui.widget-table table td,
        .ui.segment.custom-table .ui.widget-table table th {
            position: relative;
        }

        .ui.calendar.mild .date-table-wrapper .date-table td.selected div.label {
            background: #2e8ae6
        }

        .ui.calendar.mild .date-table-wrapper .date-table > tbody > tr > td:first-child,
        .ui.calendar.mild .date-table-wrapper .date-table > tbody > tr > td:last-child {
            background: rgba(46, 138, 230, .1)
        }

        .ui.calendar.mild .date-table-wrapper .date-table td:hover:not(.selected) div.label {
            background: rgba(46, 138, 230, .5)
        }

        .ui.positive.button,
        .ui.positive.buttons .button {
            background-color: #2185D0 !important;
            background-image: none;
            color: #FFF;
            text-shadow: none
        }

        ul li label {
            display: inline-block;
            overflow: hidden;
            width: 250px;
            height: 22px;
            line-height: 22px;
        }

        .ui.button {
            padding: 0 30px
        }

        .moneyInput input {
            height: initial !important;
            line-height: initial !important
        }

        .ui.input.error input {
            border-width: 1px !important;
            border-radius: 2px !important
        }

        .ui.input input {
            padding: 0 10px !important
        }

        .ui.segment.custom-table .ui.widget-table table thead th {
            background-color: transparent;
        }

        #tableWrap .datagrid-row-selected {
            background: none !important;
        }

        .v-box,
        .h-box {
            display: -webkit-box;
        }

        /**/

        .new_header {
            margin: 18px 0 30px 30px;
            font-size: 16px;
            color: #4284d9;
        }

        .totalpriceChange::-webkit-input-placeholder,
        textarea::-webkit-input-placeholder {
            text-align: right;
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
        .categoryDescEdit{position:relative;overflow:hidden;margin-right:15px;cursor:pointer}.categoryDescEdit>span{position:absolute;top:1px;right:1px;display:none;cursor:pointer}.categoryDescEdit:hover>span{display:block}.ui.widget-table table tbody td>div{overflow:hidden;padding:.2em .4em}.ui.input input{padding:.5em .3em;text-align:left}.ui.widget-table table thead th{background:#fff}.ui.widget-table>.fixed-footer,.ui.widget-table>.fixed-header{z-index:99}.closeMore{position:absolute;top:0;right:0;width:20px;height:20px;text-indent:0;cursor:pointer}.closeMore:after,.closeMore:before{position:absolute;top:50%;width:20px;height:1px;background-color:#888;content:'';-webkit-transform:rotate(45deg);transform:rotate(45deg)}.closeMore:after{-webkit-transform:rotate(-45deg);transform:rotate(-45deg)}#learnMore .closeMore:hover{-webkit-transform:rotate(90deg)}.partner_tips_2:before{position:relative}.checkbox,.radio{margin:0}.items tr td:nth-child(2) input{text-align:left}.items tr td:nth-child(3) input,.items tr td:nth-child(4) input{border:none}.items tr:nth-child(even) td:nth-child(3) input,.items tr:nth-child(even) td:nth-child(4) input{background:#f5f7fa}.ui.list-view .items{height:260px}.ui.list-view .list.item:hover{background:#4284d9;color:#fff}.btn{font-size:9pt}.btn-default{color:#999}.ui.items-view table tbody tr:nth-child(even){background:0 0!important}.ui.items-view .item{cursor:default}#order .table-wrapper>table thead th:nth-child(1),#order .table-wrapper>table thead th:nth-child(2),#order .table-wrapper>table thead th:nth-child(11),#order .table-wrapper>table thead th:nth-child(12){font-weight:700}.pagination table{float:right;height:50px;line-height:50px}.pagination{border-radius:0}.datagrid .datagrid-pager{border-color:#2e8ae6;border-top-width:2px}.datagrid-header td.datagrid-header-over,.datagrid-row-over{background:none;color:#000;cursor:default}.datagrid-header,.datagrid-td-rownumber{background:#eff1f3}.datagrid-header{border-width:0}.datagrid-header .datagrid-cell span{font-size:12px}.btn-primary,.btn-primary.active,.btn-primary:active,.btn-primary:focus,.btn-primary:hover,.open .dropdown-toggle.btn-primary{border-color:#2e8ae6;background-color:#2e8ae6}.datagrid-row-selected{background:#d6e8f3;color:#000}.datagrid .panel-body,.window .window-body{border:none!important}.window .window-body{padding:50px 10px 0;border-width:0!important;border-radius:0;background:#fff}.datagrid-header,.datagrid-header-row,.datagrid-row{height:40px}.window-shadow{background:0 0}table,td,th{vertical-align:middle}#msgwindow{position:absolute;left:100%;z-index:9999;padding:2%;width:84%;height:100%;border:none;background:#fff;box-shadow:0 0 7px #999;-webkit-transition:all .2s 0s linear;transition:all .2s 0s linear}#taxPointWin{width:700px}#modifyMenuWin,#taxPointWin,.priceDetailWin{position:absolute;z-index:99;display:none;min-height:290px;border:none;background:#fff;box-shadow:1px 3px 10px 2px rgba(0,0,0,.2);-webkit-transition:all .2s 0s linear;transition:all .2s 0s linear}.h10{clear:both;height:10px}select option{margin:5px auto;height:30px;line-height:30px}.btn.smcolor{border-color:#2e8ae6;background-color:#2e8ae6;color:#fff}.tips_contants{position:fixed;top:50%;left:50%;z-index:99999;display:none;margin-top:-150px;margin-left:-150px;width:300px;height:5pc;border-radius:5px;background:rgba(0,0,0,.8);color:#fff;text-align:center;line-height:5pc}.pagination{display:none}.select2-results__options li{position:relative}.datagrid-body .datagrid-cell{padding:0 10px}.datagrid-htable .datagrid-cell{padding-left:10px}.datagrid-header .datagrid-cell span{color:#666}.form-control{display:block;padding:6px 10px 6px 9pt;width:100%;height:30px;background-color:#fff;color:#555;vertical-align:middle;line-height:1.428571429}.form-control,.input-group-addon{border:1px solid #ccc;border-radius:4px;font-size:12px}.input-group-addon{padding:5px 9pt;background-color:transparent!important;text-align:center;font-weight:400;line-height:1}.panel{box-shadow:0 0 0}
    </style>
    <script type="text/javascript" src="/resources/pageConfig.js?v=d1935279f7"></script>
    <script>
        var globDataGrid =
            [
                {
                    "expenseDesc": "",
                    "expenseType": "00",
                    "expenseTypeDesc": "选择分类",
                    "money": ""

                },
                {
                    "expenseDesc": "",
                    "expenseType": "00",
                    "expenseTypeDesc": "选择分类",
                    "money": ""

                }, {
                "expenseDesc": "",
                "expenseType": "00",
                "expenseTypeDesc": "选择分类",
                "money": ""

            }
            ];
    </script>
</head>

<body class="modal-page" ontouchstart="" style="width:900px;">

<div class="new_header">新建费用</div>

<div class="row" style="margin: 0 0 10px 40px;line-height: 30px;">
    <div class="form-group">
        <label style="width: 70px;padding-right:0;" class="col-xs-1 control-label">报销人员 :</label>
        <div class="col-xs-2" style="width:187px">
            <select id="spenderKey" style="width:140px">
                <option></option>
            </select>
        </div>
        <label style="width: 70px;padding-right:0;" class="col-xs-1 control-label">付款方式 :</label>
        <div class="col-xs-2" style="width:190px">
            <select id="payType" style="width:140px;" value="05">
            </select>
        </div>
        <label style="width: 70px;padding-right:0;" class="col-xs-1 control-label">付款日期 :</label>
        <div class="col-xs-2" style="width:160px">
            <input type="text" style="width:140px" data-provide="datetimepicker-inline" name="orderDate"
                   data-format="yyyy-MM-dd" class="form-control"
                   id="orderDate">
            <i onclick="$('#orderDate').datetimepicker('show')" class="iconfont_new" style="    font-size: 18px;
    top: 1px;
    position: absolute;
    right: 15px;">&#xe6a6;</i>
        </div>
    </div>

</div>
<div class="row" style="margin: 0 0 10px 40px;line-height: 30px;">
    <label style="width: 70px;padding-right:0;" class="col-xs-1 control-label">费用说明 :</label>
    <div class="col-xs-5">
        <input id="expenseExplain" class="form-control" style="width: 658px;" type="text">
    </div>

</div>
<!--订单分类 start-->


<!--订单表格 start-->
<div style="margin: 20px 0 0 43px; width:737px;" id="tableWrap">
    <table id="createOrder" data-options="remoteSort:false,
fitColumns : true,
           nowrap:true,singleSelect:true,checkOnSelect:false,
          scrollbarSize:0,
          data:globDataGrid,
          <%--onClickCell:onClickCell,--%>
          <%--onClickRow:onClickRow,--%>
          onLoadSuccess:onLoadS" class="easyui-datagrid" style="width:100%;height:auto;">
        <thead>
        <tr>
            <th field="btn" data-options="formatter: function(value,row,index){
            return opeartionDel(index) }" width="50">操作
            </th>
            <th field="expenseDesc" data-options="formatter: function(value,row,index){
            return inputTemplate(value,index,'expenseDesc') }" width="150">费用描述
            </th>
            <th field="money" data-options="formatter: function(value,row,index){
            return inputTemplatePrice(value,index,row,'money') }" width="50">金额
            </th>

            <th field="expenseTypeDesc" data-options="align:'center',formatter: function(value,row,index){
            return inputTemplateWay(value,index,'expenseTypeDesc') }" width="50">费用分类
            </th>

        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
    <div style="border-top:1px solid #ccc;margin-top:20px;"></div>
</div>


<!--金额结算部分 start-->

<div id="bottomBox" style="margin-top:22px;">
    <div style="float:right; margin-right:95px;">
        <div>合计 :<span id="heji" style="margin-left:95px;font-size:18px; font-weight: 700;">0.00</span></div>
        <div style="float:right;">
            <button type="button" style="width: 80px;margin-top:60px;" onclick="saveDraft(this)" class="btn btn-info">
                取消
            </button>
            <button type="button" style="width: 80px;margin:60px 0 0 10px;" userdata="1" onclick="saveAll(this)"
                    class="btn btn-primary">创建
            </button>
        </div>

    </div>
</div>

<script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
<script src="/resources/easyui/pace.min.js?v=cdbdd88ddf"></script>
<script src="/resources/jquery/jquery.cookie.js?v=1bf09dac64"></script>
<script src="/resources/common/common.js?v=4df22f7427"></script>
<script src="/resources/business/base_new.js?v=9ac481258d"></script>
<script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
<script src="/resources/easyui/locale/easyui-lang-zh_CN.js?v=af8a82977a"></script>
<script type="text/javascript" src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
<script type="text/javascript" src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1" charset="UTF-8"></script>
<script type="text/javascript" src="/resources/easyui/jquery.autocomplete.js?v=88de880408"></script>
<script>
    var pageSaveOrderConUrl = "/ydz/expensebook/insert";// 发送请求存储数据
    var customerListUrl = "/ydz/expensebook/listSpender";// 获取所有员工
    var numberArr = [];
    var pageAllUrl="/ydz/expensebook/getExpenseTypeForDropdown";
    $(function () {
        $("#orderDate").val(new Date().Format("yyyy-MM-dd"));
        $.ajax({
            url: customerListUrl,
            dataType: "json",
            success: function (data) {
                numberArr = data.data;
                $("#spenderKey").html(returnopt(data, 1)).val("");
                $("#spenderKey").select2({
                    templateResult: formatState
                });
            },
            error: function () {
            }
        });
        changeClients();
    })
    function formatState(state) {
        var p = $(state.element).attr("data-p");
        var mark = "";
        var css = "  font-style:normal;font-size: 8px !important;background: #e9dfdf;color: #b89a9a;border-radius: 3px;height: 20px;margin-left: 10px;line-height: 20px;padding: 0 2px;position: absolute;right: 3px;top: 5px;";
        var cs = "   position: absolute;right: 4px;top: 8px;border: 6px solid #f2711c;width: 0;height: 0;border-radius: 50%;";
        var $state = $(
            '<span style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:120px;display: block;">' + state.text + '</span>'
            //                '<span><img src="/' + state.element.value.toLowerCase() + '.png" class="img-flag" /> ' + state.text + '</span>'
        );
        return $state;
    }
    function changeClients() {
        var data = {
            "data": [{"contacterId": "1", "contacterName": "现金"}, {
                "contacterId": "2",
                "contacterName": "银行转账"
            }, {"contacterId": "3", "contacterName": "信用卡"}, {
                "contacterId": "4",
                "contacterName": "支付宝"
            }, {"contacterId": "5", "contacterName": "微信钱包"}, {"contacterId": "6", "contacterName": "其他"}]
        }
        $("#payType").html(returnopt(data, 2));
        $("#payType").select2({
            minimumResultsForSearch: Infinity
        });
    }
    function returnopt(data, type) {
        var opt = "";
        var partner = "";
        // if(type=="1"){opt='<option  value="ALL">全部供应商</option>'}
        for (var i = 0; i < data.data.length; i++) {
            var dt = data.data[i];
            var dtn = "";
            if (type == 1) {
                // if(dt.partnerComKey==undefined){partner="";}else{partner=dt.partnerComKey};
                dtn = dt.realName;
                opt += '<option value="' + dt.employeeId + '">' + dtn + '</option>';
            }
            if (type == 2) {
                opt += '<option value="' + dt.contacterId + '">' + dt.contacterName + '</option>';
            }
        }
        return opt;
    }
    function opeartionDel(index) {
        return '<i class="iconfont_new contentTemplate" onclick="addRow(this)" style="color:#4d86ce;font-weight:900;">&#xe6a1;</i><i class="iconfont_new contentTemplate" onclick="delRow(this)" style="color:#4d86ce;font-weight:900;">&#xe6f2;</i>';
    }
    function inputTemplate(v, i, f) {
        var j;
        var arr = ["例 ：5月20日加班餐费", "例 ：5月20日加班车费", "例 ：5月20日到江苏外出费用"];
        if (i < 3) {
            j = i;
        } else {
            j = 0;
        }
        return '<input class="autocomplete_req" style="width: 100%;" placeholder="' + arr[j] + '" value="' + v + '" type="text">';
    }
    function inputTemplatePrice(v, i, row, f) {
        return '<input class="totalpriceChange" placeholder="0.00"  style="width: 100%;text-align:right;" onkeyup="modifyValTotalPrice(this,' + i + ',\'' + f + '\')" value="' + v + '" type="text">';
    }
    function inputTemplateWay(v, i, f) {
        return '<input class="autocomplete" readonly style="width: 100%;color:#4d86ce; cursor: pointer;text-align:center;" value="' + v + '" type="text"><i class="iconfont_new" style="font-size: 4px;right: 25px;position: absolute;color: #4d86ce; font-weight:900; ">&#xe68a;</i>';

    }
    function addRow(o) {
        var rindex = $(o).parents("tr").index() + 1;
        $('#createOrder').datagrid('insertRow', {
            index: rindex,	// index start with 0
            row: {
                "expenseDesc": "",
                "expenseType": "00",
                "expenseTypeDesc": "选择分类",
                "money": ""
            }
        });
        autocompleteFun();
    }
    function autocompleteFun() {
        $('.autocomplete').devbridgeAutocomplete({
            lookup: teams,
            minChars: 0,
            readyOn: true,
            onSelect: function (suggestion) {
                // debugger;
                var row = $('#createOrder').datagrid("getSelected");
                var rindex = $('#createOrder').datagrid("getRowIndex", row);
                row["expenseType"] = suggestion.data;
                row["expenseTypeDesc"] = suggestion.value;
                $('#createOrder').datagrid('updateRow', {index: rindex, row: row});
                // $('#createOrder').datagrid('reload');
            }

        })
    }
    function delRow(o) {
        var rindex = $(o).parents("tr").index();
        var delects = $('#createOrder').datagrid('getRows', rindex), num2 = 0;
        if ($('#createOrder').datagrid("getRows").length > 1) {
            $('#createOrder').datagrid('deleteRow', rindex);
        }
        for (var i = 0; i < delects.length; i++) {
            if (!delects[i].money) {
                delects[i].money = 0;
            }
            num2 += parseFloat(delects[i].money);
        }
        $('#heji').html(accounting.formatNumber(num2, 2));
    }
    function modifyValTotalPrice(o, i, f) {
        var rindex = $(o).parents("tr").index();
        var ev = arguments.callee.caller.arguments[0] || window.event;
        $('#createOrder').datagrid('getRows')[rindex].money = $(ev.target).val();
        var arr = $('#createOrder').datagrid('getRows'), num1 = 0;
        for (var i = 0; i < arr.length; i++) {
            var nu = arr[i].money;
            if (isNaN(nu) || nu == "") {
                nu = 0
            }
            ;
            num1 += parseFloat(nu);
        }
        $('#heji').html(accounting.formatNumber(num1, 2));

    }
    function onLoadS() {
//        autocompleteFun()
        req_teamsData();
    }



    var teams={};
    function req_teamsData() {   var query={settingClass :"01"};

        $.ajax({
            url: pageAllUrl,
            data:jQuery.param(query),
            dataType: "json",
            success: function (data) {
                teams  = $.map(data, function (obj) {
                    obj.data = obj.typeCode; // replace name with the property used for the text
                    obj.value = obj.typeDesc; // replace name with the property used for the text
                    return obj;
                });
                autocompleteFun();
            },
            error:function () {
                req_teams={
                    suggestions:{}
                };
                autocompleteFun();
            }
        });
    }



    function saveAll(self) {
        saveOrder(self, pageSaveOrderConUrl);
    }
     function saveOrder(o, url) {
        var self = $(o);
        var sent = false;
        self.attr("disabled", true);

        if ($("#spenderKey").val() == "" || $("#spenderKey").val() == null) {
            $("<div class='tips_contants'>").fadeIn(250).html("请填写报销人").delay(1500).fadeOut(250).appendTo('body');
            setTimeout(function () {
                self.attr("disabled", false);
            }, 2000)
        } else {
            for (var i = 0; i < readyData().details.length; i++) {
                if (readyData().details[i].expenseDesc && readyData().details[i].expenseDesc !== " ") {
                    // if (i == readyData().details.length - 1) {
                    // }
                     sent = true;

                }else if(readyData().details[i].money){
                    $("<div class='tips_contants'>").fadeIn(250).html("请填写费用描述").delay(1500).fadeOut(250).appendTo('body');
                    sent = false;
                     setTimeout(function () {
                        self.attr("disabled", false);
                    }, 2000);
                    break;
                }
                if(i == readyData().details.length - 1 && sent == true){
                    $.ajax({
                            url: url,
                            type: "post",
                            data: JSON.stringify(readyData()),
                            dataType: "json",
                            contentType: "application/json",
                            success: function (callBack) {
                                var config = {
                                    menuUrl: "/openPage?pageName=expense_expense-list"
                                };
                                parent.mainConfigUrl(config);
                            }, error: function () {
                                $("<div class='tips_contants'>").fadeIn(250).html("添加出错,请联系管理员").delay(3000).fadeOut(250).appendTo('body');
                                self.attr("disabled", false);
                            }
                        });
                }else if(i == readyData().details.length - 1){
                    $("<div class='tips_contants'>").fadeIn(250).html("请填写费用描述").delay(1500).fadeOut(250).appendTo('body');
                    setTimeout(function () {
                        self.attr("disabled", false);
                    }, 2000)
                }
            }

        }
    }

    function readyData() {
        var rows = $('#createOrder').datagrid("getRows");
        var expenseBook = {};
        var spenderName;
        for (var i = 0; i < numberArr.length; i++) {
            if ($("#spenderKey").val() == numberArr[i].employeeId) {
                spenderName = numberArr[i].realName;
                break;
            }
        }
        var order = {
            "spenderKey": $("#spenderKey").val(),
            "spenderName": spenderName,
            "payType": $("#payType").val(),
            "payDate": new Date($("#orderDate").val()),
            "expenseExplain": $("#expenseExplain").val(),
            "expenseType":0
        };
        expenseBook = order;
        for (var i = 0; i < rows.length; i++) {
            rows[i].expenseDesc = $("input.autocomplete_req")[i].value;
            rows[i].money = $("input.totalpriceChange")[i].value;
            if(rows[i].expenseTypeDesc=="选择分类"){
                rows[i].expenseTypeDesc = "";
            }
        }
        expenseBook.details = rows;
        return expenseBook;
    }
    function saveDraft(self) {
        var config = {
            menuUrl: "/openPage?pageName=expense_expense-list"
        };
        parent.mainConfigUrl(config);
    }
</script>
</body>

</html>