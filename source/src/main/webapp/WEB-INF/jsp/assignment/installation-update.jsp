<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>修改安装工单</title>
    <base href="/">
    <link rel="stylesheet" type="text/css" href="/resources/common/custom-widget.css?v=824f9feec4">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <style>
        body {
            padding: 1em 42px !important;
        }

        .totalpriceChange,
        #priceText,
        #totalPriceText,
        #receivablesMoneyText {
            color: #ff2f02;
        }

        .contentTemplate {
            -webkit-user-select: none;
        }

        .autocomplete-suggestions {
            max-height: 270px !important;
        }

        .btnGrp {
            margin-top: 13px;
        }

        .datagrid-cell-c1-priceWayDesc:hover input {
            color: #4284d9;
        }

        .select2-container {
            margin-top: -3px;
        }

        .btnGrp button {
            margin-left: 6px;
        }

        .contentTemplate:hover {
            color: #4284d9 !important;
        }

        .datagrid-cell-c1-priceWayDesc input:before {
            background: #ffffcc !important;
            border-color: #ffcc00;
            box-shadow: 1px 1px 0px 0px #ffcc00;
            content: '';
            width: 0.75em;
            position: absolute;
            height: 0.75em;
            background: #FFFFFF;
            -webkit-transform: rotate(225deg);
            z-index: 2;
            left: 48%;
            top: 3px;
        }



        .datagrid-cell-c1-priceWayDesc {
            position: relative;
        }

        .datagrid-cell-c1-priceWayDesc input {
            text-align: center;
            cursor: pointer;
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

        .ui.calendar.mild .date-table-wrapper .date-table>tbody>tr>td:first-child,
        .ui.calendar.mild .date-table-wrapper .date-table>tbody>tr>td:last-child {
            background: rgba(46, 138, 230, .1)
        }

        .ui.calendar.mild .date-table-wrapper .date-table td:hover:not(.selected) div.label {
            background: rgba(46, 138, 230, .5)
        }

        .ui.positive.button,
        .ui.positive.buttons .button {
            background-color: #2185D0!important;
            background-image: none;
            color: #FFF;
            text-shadow: none
        }

        ul li label {
            display: inline-block;
            overflow: hidden;
            width: 250px;
            height: 22px;
            line-height: 22px
        }

        .ui.button {
            padding: 0 30px
        }

        .moneyInput input {
            height: initial!important;
            line-height: initial!important
        }

        .ui.input.error input {
            border-width: 1px!important;
            border-radius: 2px!important
        }

        .tips_contants {
            position: fixed;
            top: 50%;
            left: 50%;
            z-index: 9999;
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

        .ui.input input {
            padding: 0 10px!important
        }

        .add_tips {
            position: relative;
            padding: 10px 0 10px 26px;
            width: 100px;
            color: #999;
            font-size: 12px;
            cursor: pointer
        }

        .add_tips:hover,
        .add_tips:hover i {
            color: #2e8ae6
        }

        .add_tips i {
            position: absolute;
            top: 4px;
            left: 0;
            color: #999;
            font-size: 1.8rem
        }

        .secondary,
        .secondary i {
            color: #2e8ae6
        }

        .ui.list-view .items {
            max-width: 215px;
        }

        .ui.segment.custom-table .ui.widget-table table thead th {
            background-color: transparent;
        }

        #clientsDp,
        #contacterDp,
        #saleManDp {
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

        #tableWrap .datagrid-row-selected {
            background: none !important;
        }

        .datagrid-cell-c1-businessDesc,
        .datagrid-cell-c1-requirements {
            padding: 0 20px 0 10px !important;
        }

        .topbarCss {
            display: none;
            position: absolute;
            top: 0px;
            left: 0px;
            background: rgb(255, 255, 255);
            min-height: 550px;
            border-bottom: 1px solid rgb(204, 204, 204);
            width: 100%;
            box-shadow: 0px 0px 20px rgba(34, 36, 38, 0.15);
        }

        .topbarPrCss {
            display: none;
            position: absolute;
            top: 0px;
            left: 0px;
            z-index: 999;
            background: rgb(255, 255, 255);
            height: 100%;
            border-bottom: 1px solid rgb(204, 204, 204);
            /*overflow: hidden;*/
            width: 100%;
            box-shadow: rgba(34, 36, 38, 0.14902) 0px 0px 20px;
            box-sizing: border-box;
        }

        #createOrderPop {
            display: none;
            z-index: 99999;
            width: 660px;
            height: 480px;
            position: absolute;
            top: 50%;
            left: 50%;
            background: #fff;
            margin-top: -120px;
            margin-left: -330px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
        }

        .v-box,
        .h-box {
            display: -webkit-box;
        }

        .datagrid-body td:first-child,
        .datagrid-header td:first-child {
            border-left-width: 1px;
        }

        #file_div>div {
            padding-top: 4px;
        }

        .header {
            margin: 11px 0 36px -10px;
            font-size: 16px;
            color: #ff3333;
            height: 30px;
            line-height: 40px;
        }

        .header>img {
            margin-top: -10px;
            margin-right: 10px;
        }

        .col-xs-2 {
            margin-left: -8px;
        }

        .right-summary>.h-box {
            padding-left: 14px;
        }

        .col-xs-1 {
            color: #666 !important;
        }

        input::-webkit-input-placeholder,
        textarea::-webkit-input-placeholder {
            color: #ccc !important;
        }

        .datagrid-cell-c1-priceWay{  position:relative;  }
    </style>
    <style>

        .categoryDescEdit{position:relative;overflow:hidden;margin-right:15px;cursor:pointer}.categoryDescEdit>span{position:absolute;top:1px;right:1px;display:none;cursor:pointer}.categoryDescEdit:hover>span{display:block}.ui.widget-table table tbody td>div{overflow:hidden;padding:.2em .4em}.ui.input input{padding:.5em .3em;text-align:left}.ui.widget-table table thead th{background:#fff}.ui.widget-table>.fixed-footer,.ui.widget-table>.fixed-header{z-index:99}.closeMore{position:absolute;top:0;right:0;width:20px;height:20px;text-indent:0;cursor:pointer}.closeMore:after,.closeMore:before{position:absolute;top:50%;width:20px;height:1px;background-color:#888;content:'';-webkit-transform:rotate(45deg);transform:rotate(45deg)}.closeMore:after{-webkit-transform:rotate(-45deg);transform:rotate(-45deg)}#learnMore .closeMore:hover{-webkit-transform:rotate(90deg)}.partner_tips_2:before{position:relative}.checkbox,.radio{margin:0}.items tr td:nth-child(2) input{text-align:left}.items tr td:nth-child(3) input,.items tr td:nth-child(4) input{border:none}.items tr:nth-child(even) td:nth-child(3) input,.items tr:nth-child(even) td:nth-child(4) input{background:#f5f7fa}.ui.list-view .items{height:260px}.ui.list-view .list.item:hover{background:#4284d9;color:#fff}.btn{font-size:9pt}.btn-default{color:#999}.ui.items-view table tbody tr:nth-child(even){background:0 0!important}.ui.items-view .item{cursor:default}#order .table-wrapper>table thead th:nth-child(1),#order .table-wrapper>table thead th:nth-child(2),#order .table-wrapper>table thead th:nth-child(11),#order .table-wrapper>table thead th:nth-child(12){font-weight:700}.pagination table{float:right;height:50px;line-height:50px}.pagination{border-radius:0}.datagrid .datagrid-pager{border-color:#2e8ae6;border-top-width:2px}.datagrid-header td.datagrid-header-over,.datagrid-row-over{background:none;color:#000;cursor:default}.datagrid-header,.datagrid-td-rownumber{background:#eff1f3}.datagrid-header{border-width:0}.datagrid-header .datagrid-cell span{font-size:12px}.btn-primary,.btn-primary.active,.btn-primary:active,.btn-primary:focus,.btn-primary:hover,.open .dropdown-toggle.btn-primary{border-color:#2e8ae6;background-color:#2e8ae6}.datagrid .panel-body,.window .window-body{border:none!important}.window .window-body{padding:50px 10px 0;border-width:0!important;border-radius:0;background:#fff}.datagrid-header,.datagrid-header-row,.datagrid-row{height:40px}.window-shadow{background:0 0}table,td,th{vertical-align:middle}#msgwindow{position:absolute;left:100%;z-index:9999;padding:2%;width:84%;height:100%;border:none;background:#fff;box-shadow:0 0 7px #999;-webkit-transition:all .2s 0s linear;transition:all .2s 0s linear}#taxPointWin{width:700px}#modifyMenuWin,#taxPointWin,.priceDetailWin{position:absolute;z-index:99;display:none;min-height:290px;border:none;background:#fff;box-shadow:1px 3px 10px 2px rgba(0,0,0,.2);-webkit-transition:all .2s 0s linear;transition:all .2s 0s linear}.h10{clear:both;height:10px}select option{margin:5px auto;height:30px;line-height:30px}.btn.smcolor{border-color:#2e8ae6;background-color:#2e8ae6;color:#fff}.tips_contants{position:fixed;top:50%;left:50%;z-index:99999;display:none;margin-top:-150px;margin-left:-150px;width:300px;height:5pc;border-radius:5px;background:rgba(0,0,0,.8);color:#fff;text-align:center;line-height:5pc}.pagination{display:none}.select2-results__options li{position:relative}.datagrid-body .datagrid-cell{padding:0 10px}.datagrid-htable .datagrid-cell{padding-left:10px}.datagrid-header .datagrid-cell span{color:#666}.form-control{display:block;padding:6px 10px 6px 9pt;width:100%;height:30px;background-color:#fff;color:#555;vertical-align:middle;line-height:1.428571429}.form-control,.input-group-addon{border:1px solid #ccc;border-radius:4px;font-size:12px}.input-group-addon{padding:5px 9pt;background-color:transparent!important;text-align:center;font-weight:400;line-height:1}.panel{box-shadow:0 0 0}
        .conTbText .datagrid-body td:first-child, .conTbText .datagrid-header td:first-child{
            border-left: none;
        }
    </style>
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <script src="/resources/easyui/pace.min.js?v=cdbdd88ddf"></script>
    <script src="/resources/pageConfig.js?v=d1935279f7"></script>
    <script src="/resources/easyui/jquery.autocomplete.js?v=88de880408"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
    <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1"></script>
    <script src="/resources/business/base_new.js?v=9ac481258d"></script>
    <script >
        var globVar={},globReqClick=false;//区别物料说明两个事件
        var contactListUrl="/system/partner/listPartnerContacter";// 获取联系人下拉框
        var customerListUrl="/ydz/purchaseorder/supplier";// 获取供应商下拉框
        var pageListSaleConUrl="/ydz/salesorder/listSalesMan"; //销售代表下拉框
        var pageDefaultSaleConUrl="/ydz/salesorder/getDefaultSalesMan"; //销售代表默认值
        var pageTbUrl = "/ydz/salesorder/listPageTotalDetailByOrder";// 选择的业务明细
        var pagesearchConConUrl="/company/dropdownComProPriceByDesc"; //搜索服务内容
        var pageUrl="/order/installation/listInstallStandingBy";
        var req_teams={};
        var autocompleteAllFill=false;
        var pageSaveOrderConUrl="/order/installation/update"; //保存订单
        var installationNo="${installationNo}";
        var pageDetailConConUrl="/order/installation/orderAndDetailSimple?installationNo=" + installationNo;
        var globDataGrid = [

        ];
        var arrclo_addList = [];




        var teams = $.map(priceWayAll, function (obj) { obj.value = obj.priceWayDesc; // replace name with the property used for the text
            obj.data = obj.priceWay; // replace name with the property used for the text
            return obj; });
        var salesOrder={
            "salesNo":"",
            "salescheckingNo":"",
            "purchaseNo":"",
            "comKey":"",
            "comName":"",
            "creator":"",
            "creatorName":"",
            "industryId":"",
        };
        arrclo_addList.push({
            field: 'businessDesc', width: 150, title: '业务内容', formatter: function (value, row, index) {
                return installionAddFun.inputTemplate(value, index, 'businessDesc')
            }
        });
        arrclo_addList.push({
            field: 'length',
            title: '长(米)',
            width: 50,
            formatter: function (value, row, index) {
                return installionAddFun.inputTemplateLength(value, index, 'length')
            }
        });
        arrclo_addList.push({
            field: 'width',
            title: '宽(米)',
            width: 50,
            formatter: function (value, row, index) {
                return installionAddFun.inputTemplateWidth(value, index, 'width')
            }
        });
        arrclo_addList.push({
            field: 'priceWay',
            title: '计价方式',
            width: 50,
            align: 'center', formatter: function (value, row, index) {

                return installionAddFun.inputTemplateWay(installionAddFun.mapPricewayAll(value), index, 'priceWayDesc')
            }
        });
        arrclo_addList.push({
            field: 'quantity',
            title: '数量',
            width: 50,
            formatter: function (value, row, index) {
                return installionAddFun.inputTemplateQuantity(value, index, 'quantity')
            }
        });
        arrclo_addList.push({
            field: 'unit',
            title: '单位',
            width: 50,
            formatter: function (value, row, index) {
                return installionAddFun.inputTemplateUnit(value, index, 'unit')
            }
        });
        arrclo_addList.push({
            field: 'unitPrice',
            title: '费用单价',
            width: 50,
            formatter: function (value, row, index) {
                return installionAddFun.inputTemplateUnitprice(value, index, 'unitPrice')
            }
        });
        arrclo_addList.push({
            field: 'totalPrice',
            title: '行小计',
            width: 50,
            formatter: function (value, row, index) {
                return installionAddFun.inputTemplatePrice(value, index, row, 'totalPrice')
            }
        });
        arrclo_addList.push({
            field: 'btn',
            title: '操作',
            align:'center',
            width: 50,
            formatter: function (value, row, index) {
                return '<i class="iconfont_new contentTemplate" title="增加" onclick="installionAddFun.addRow(this)">&#xe6a1;</i>' +
//                    '&nbsp;<i title="复制" class="iconfont_new contentTemplate" onclick="copyRow(this)" >&#xe69d;</i>' +
                    '&nbsp;<i title="删除" class="iconfont_new contentTemplate" onclick="installionAddFun.delRow(this)" >&#xe6f2;</i>';
            }
        });

        var installionAddFun={
            saleManDp: function (){
                $.ajax({
                    url:pageListSaleConUrl,
                    dataType:"json",
                    timeout:"8000",
                    success:function(dt){
                        // dt=[];
                        // $("#saleManDp").html( returnopt(data,2));
                        var dtall = $.map(dt, function (obj) {
                            obj.text = obj.realName; // replace name with the property used for the text
                            obj.id = obj.employeeId; // replace name with the property used for the text
                            return obj;
                        });
                        $("#saleManDp").select2({     data:dtall,minimumResultsForSearch: Infinity});
                    },
                    error:function(){
                    }
                })
            },
            initPageDataUPdate:  function () {

                $.ajax({
                    url:pageDetailConConUrl,
                    dataType:"json",
                    timeout:"8000",
                    success:function(data){
                        installionAddFun.initPageTwoData(data);
                    },
                    error:function(){
                    }
                });

            },
            initPageTwoData:function (salesOrderDetail){
                $("#remarkBtn").click();
                $("#createOrder").datagrid("loadData",salesOrderDetail.details);

                var order=salesOrderDetail.order;
                $("#orderDate").val(order.orderDate);
                $("#caseDesc").val(order.caseDesc);
                $("#remarkInput").val(order.remarks);
                $("#salesCount").val(Number(order.discountRate)*100);
                $("#preferentialVal").val(order.preferential);
                $("#depositRequested").val(order.prepayPrice);
                $.ajax({
                    url:customerListUrl,
                    dataType:"json",
                    success:function(data){
                        $("#clientsDp").html( installionAddFun.returnopt(data,1)).val(order.partnerKey).trigger("change");
                        $("#clientsDp").select2({
                            templateResult: installionAddFun.formatState
                        });
                    }
                });
                installionAddFun.onLoadS();
                $("[data-toggle='popover']").popover();
            },
            readyData:function () {

                var rows=$('#createOrder').datagrid("getRows");

                for(var i=0;i<rows.length;i++){
                    rows[i].unitPrice=$("input.unitPriceChange")[i].value;
                    rows[i].totalPrice=$("input.totalpriceChange")[i].value;
                    rows[i].unit=$("input.inputTemplateUnit")[i].value;
                    rows[i].createTime=null;
                    rows[i].installCreateTime=null;
                    rows[i].salesCreateTime=null;
                    rows[i].length=parseFloat($("input.inputTemplateLength")[i].value);
                    rows[i].width=parseFloat($("input.inputTemplateWidth")[i].value);
                    rows[i].quantity=parseFloat($("input.inputTemplateQuantity")[i].value);
                }

                var saveData = {};
                saveData.details = rows;
                var order= {
                    "installationNo":installationNo,
                    "caseDesc": $("#caseDesc").val(),
                    "orderDate": new Date($("#orderDate").val()),
                    "partnerShortname": $("#clientsDp").find("option:selected").attr("data-s"),
                    "partnerKey": $("#clientsDp").val(),
                    "partnerName": $("#clientsDp").find("option:selected").attr("data-n"),
                    "contactId": $("#contacterDp").val(),
                    "contactName": $("#contacterDp").find("option:selected").text(),
                    "remarks":$("#remarkInput").val(),
                    "totalPrice": $("#priceTextVal").val(),//合计金额
                    "discountRate": globVar.discountRate,//折扣优惠
                    "discount": $("#discountVal").val(),//折扣金额
                    "preferential": $("#preferentialVal").val(),// 减免金额
                    "installationPrice": $("#totalPriceVal").val(),// 订单金额
                    "prepayPrice": $("#depositRequested").val(),//预付金额
                    "payablePrice": $("#receivablesMoneyVal").val()//应付金额
                };

                saveData.order =order;
                return saveData;
            },
            showRemark:function  () {
                var hasClass;
                var self = $("#remarkBtn");
                hasClass = self.hasClass("secondary");
                self.toggleClass("secondary", !hasClass);
                if (hasClass) {
                    self.html("<i class='iconfont_new'>&#xe6ca;</i>添加备注").css("padding","10px 0px 10px 26px");
                    $("#remarkInput").val("").hide();
                } else {
                    self.html("备注").css("padding","5px 0px 10px 0px");
                    return $("#remarkInput").show();
                }
            },
            saveAll:function (self) {
                var clientsDpValue = $("#clientsDp").val();
                if(clientsDpValue == "temp-customer"){
                    $("<div class='tips_contants'>").fadeIn(250).html("过路客不能保存为账期订单").delay(1500).fadeOut(250).appendTo('body');
                    return false;
                }
                installionAddFun.saveOrder(self,pageSaveOrderConUrl,"dd");
            },
            back: function  (self){
                var config = {
                    menuUrl: "/openPage?pageName=assignment_installation-list"
                };
                parent.mainConfigUrl(config);
            },
            saveOrder:function (o,url,tp) {

                if(!installionAddFun.seleSales()){
                    return;
                }
                var self=$(o);
                self.attr("disabled",true);
                $.ajax({
                    url: url,
                    type: "post",
                    data: JSON.stringify(installionAddFun.readyData()),
                    dataType: "json",
                    contentType: "application/json",
                    success: function (callBack) {
                        if (callBack.code == '1') {
                            self.attr("disabled",false);
                            var config = {
                                menuUrl:  "/openPage?pageName=assignment_installation-list&type="
                            };
                            parent.mainConfigUrl(config);
                        }else{
                            $("<div class='tips_contants'>").fadeIn(250).html(callBack.msg).delay(3000).fadeOut(250).appendTo('body');
                            self.attr("disabled",false);
                        }
                    }, error: function () {
                        $("<div class='tips_contants'>").fadeIn(250).html("添加出错,请联系管理员").delay(3000).fadeOut(250).appendTo('body');
                        self.attr("disabled",false);
                    }
                });
            },
            seleSales: function () {
                var clientsDp=$("#clientsDp").val();
                if(clientsDp=="" || clientsDp==null){
                    $("<div class='tips_contants'>").fadeIn(250).html("请选择供应商").delay(5000).fadeOut(250).appendTo('body');
                    return false;
                }
                return true;
            },
            changeClients: function (o){
                $.ajax({
                    url:contactListUrl,
                    dataType:"json",
                    data:{"partnerKey": $(o).val()},
                    timeout:"8000",
                    success:function(data){
                        $("#contacterDp").html( installionAddFun.returnopt(data,2));
                        $("#contacterDp").select2({

                            minimumResultsForSearch: Infinity});
                    },
                    error:function(){
                    }
                })
            },
            returnopt:function  (data,type) {
                var opt="";
                var partner="";
                // if(type=="1"){opt='<option  value="ALL">全部供应商</option>'}
                for(var i=0;i<data.length;i++){
                    var dt=data[i];
                    var dtn ="";
                    if(type ==1){

                        // if(dt.partnerComKey==undefined){partner="";}else{partner=dt.partnerComKey};
                        dtn =dt.myComShortname==undefined?"全部供应商":dt.myComShortname;
                        opt +='<option data-s="'+dt.partnerShortname+'" data-n="'+dt.partnerName+'" data-p="'+dt.partnerStatus+'" value="'+dt.partnerKey+'">'+dtn+'</option>';
                    }
                    if(type ==2){
                        opt +='<option value="'+dt.contacterId+'">'+dt.contacterName+'</option>';
                    }
                }
                return opt;
            },
            formatState: function  (state) {
                var p=$(state.element).attr("data-p");
                var mark="";
                var css="  font-style:normal;font-size: 8px !important;background: #e9dfdf;color: #b89a9a;border-radius: 3px;height: 20px;margin-left: 10px;line-height: 20px;padding: 0 2px;position: absolute;right: 3px;top: 5px;";
                var cs="   position: absolute;right: 4px;top: 8px;border: 6px solid #f2711c;width: 0;height: 0;border-radius: 50%;";
                if(p==undefined || p=="" ||p==null){
                    mark='';
                }else if(p=="1"){
                    mark='<i  class="tips_sale" >好友</i>';
                }
                var $state = $(
                    '<span style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:160px;display: block;">'+state.text + '</span>' +mark

//                '<span><img src="/' + state.element.value.toLowerCase() + '.png" class="img-flag" /> ' + state.text + '</span>'
                );
                return $state;
            },
            closeProReq:function () {
                $(".window-mask").hide();
                $("#topBarPR").hide();
            },
            openProReq: function   (o,i) {
                //没有主键 上述方法会有问题
                globVar.con=$(o).parents("tr").index();
                var partnerKey = $("#clientsDp").val();
                // var businessType =  uploadModelName.substring(5, uploadModelName.length);
                if(partnerKey == undefined || partnerKey==""){
                    $("<div class='tips_contants'>").fadeIn(250).html("请选择客户").delay(2000).fadeOut(250).appendTo('body');
                    return false;
                }
                $(".window-mask").show();
                $("#topBarPR").show();
                installionAddFun.menuSecLoad();
            },
            onLoadS:function () {
                installionAddFun.autocompleteFun();
                installionAddFun.priceCount();
            },

            autocompleteFun:function (){
                $('.autocomplete').devbridgeAutocomplete({
                    lookup: teams,
                    minChars: 0,
                    readyOn:true,
                    onSelect: function (suggestion) {
                        var row=$('#createOrder').datagrid("getSelected");
                        var rindex=$('#createOrder').datagrid("getRowIndex",row);
                        row["priceWay"]=suggestion.data;
                        row["priceWayDesc"]=suggestion.value;
                        installionAddFun.formula(rindex);
                        $('#createOrder').datagrid('updateRow',{index:rindex,row:row});
                        // $('#createOrder').datagrid('reload');
                        // $('#createOrder').datagrid('acceptChanges');
                    }

                });
            },
            selReqOnSelect:function  (suggestion,o) {
                globReqClick=true;
                console.log(suggestion);
                if(suggestion==null){
                    return;
                }
                var rindex=  $(o).parents("tr").index();
                var row=$('#createOrder').datagrid('getRows')[rindex];
                if(row.businessDesc !="") {
                    row["requirements"] = suggestion.value;
                    row["workingProcedure"] =suggestion.data.workingProcedure;
                    row["unit"] = suggestion.data.priceUnitDesc;
                    row["priceWay"] = suggestion.data.priceWay;
                    row["priceWayDesc"] = suggestion.data.priceWayDesc;
                    row["unitPrice"] = suggestion.data.unitPrice;
                    $("input.autocomplete")[rindex].value = suggestion.data.priceWayDesc;
                    $("input.inputTemplateUnit")[rindex].value = suggestion.data.priceUnitDesc;
                    $("input.unitPriceChange")[rindex].value = suggestion.data.unitPrice;
                    installionAddFun.formula(rindex);
                    $('#createOrder').datagrid('updateRow', {index: rindex, row: row});
                    // $('#createOrder').datagrid('acceptChanges');
                }
            },
            fillAllData:function (currentItem) {
                if(currentItem==null){return;}
                // var row=$('#createOrder').datagrid("getSelected");
                // var ind=$('#createOrder').datagrid("getRowIndex",row);
                var ind=  $(window.autoCompleteObj).parents("tr").index();
                console.log(ind);
                var total=$('#createOrder').datagrid('getRows').length;
                for(var i = ind;i<total;i++){
                    if($('#createOrder').datagrid('getRows')[i].businessDesc !="") {
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
                        installionAddFun.formula(i);
                    }
                }
                autocompleteAllFill=true;
                installionAddFun.autocompleteFun();

            },
            mapPricewayAll:function (way) {

                for(var i=0;i<priceWayAll.length;i++){
                    if(priceWayAll[i].priceWay==way){
                        return priceWayAll[i].priceWayDesc;
                        break;
                    }
                }
            },
            testHard1:function  () {
                var currentItems = $("#order").datagrid("getChecked");
                if(currentItems==null){  $("<div class='tips_contants'>").fadeIn(250).html("请先选择一条物料制作说明").delay(2000).fadeOut(250).appendTo('body');return;}

                var total=currentItems.length;
                var rindex=  globVar.con;
                for(var i =0;i<total;i++){
                    // $('#createOrder').datagrid('updateRow',{index:rowIndex,row:{requirements:currentItem.categoryDesc}});
                    var currentItem=currentItems[i];
                    $('#createOrder').datagrid('insertRow', {
                        index: i+rindex,
                        row: {
                            "businessDesc": currentItem.businessDesc,
                            "businessType": "00",
                            "length": currentItem.length,
                            "workingProcedure": currentItem.workingProcedure,
                            "width": currentItem.width,
                            "priceWay": currentItem.priceWay,
                            "priceWayDesc": installionAddFun.mapPricewayAll(currentItem.priceWay),
                            "quantity": "1",
//                            "requirements": currentItem.requirements,
                            "totalPrice": "",
                            "unit": currentItem.unit,
                            "unitPrice": currentItem.unitPrice
                        }
                    });
                    installionAddFun.formula(i+rindex);
                }
                $(".window-mask").hide();
                installionAddFun.autocompleteFun();
                $("#topBarPR").hide();
            },
            inputTemplate:function (v,i,f){
                return '<input class="" onkeyup="installionAddFun.modifyVal(this,'+i+',\''+f+'\')" style="width: 100%;" value="'+v+'" type="text">'
            },
            inputTemplatePrice:function (v,i,row,f){
                return '<input class="totalpriceChange" readonly    style="width: 100%;" value="'+v+'" type="text">'
            },
            inputTemplateLength:function (v,i,f){
                return '<input class="inputTemplateLength" onkeyup="installionAddFun.modifyVal(this,'+i+',\''+f+'\')" style="width: 100%;" value="'+v+'" type="text">'
            },
            inputTemplateWidth:function (v,i,f){
                return '<input class="inputTemplateWidth" onkeyup="installionAddFun.modifyVal(this,'+i+',\''+f+'\')" style="width: 100%;" value="'+v+'" type="text">'
            },
            inputTemplateQuantity:function (v,i,f){
                return '<input class="inputTemplateQuantity" onkeyup="installionAddFun.modifyVal(this,'+i+',\''+f+'\')" style="width: 100%;" value="'+v+'" type="text">'
            },
            inputTemplateUnit:function (v,i,f){

                return '<input class="inputTemplateUnit" onkeyup="installionAddFun.modifyValRemarks(this,'+i+',\''+f+'\')" style="width: 100%;" value="'+v+'" type="text">'
            },
            inputTemplateUnitprice:function (v,i,f){

                return '<input data-s="select" class="unitPriceChange" onkeyup="installionAddFun.modifyValUP(this,'+i+',\''+f+'\')" style="width: 100%;" value="'+v+'" type="text">'
            },
            inputTemplateWay:function (v,i,f){
                return '<input class="autocomplete" readonly style="width: 100%;" value="'+v+'" type="text"><i class="iconfont_new" style=" cursor: default;  font-size: 14px;right: 1px;-webkit-transform: scale(.5);position: absolute;color: #ccc;">&#xe68d;</i>'
            },
            modifyValUP:function  (o,i,f) {
                var rindex=  $(o).parents("tr").index();
                var ev=arguments.callee.caller.arguments[0] || window.event;
                if($(ev.target).val()=="undefined"){return;}
                var row={};
                // $('#createOrder').datagrid('updateRow',{index:rindex,row:row});
                $('#createOrder').datagrid('getRows')[rindex].unitPrice=$(ev.target).val();
                installionAddFun.formula(rindex);
                installionAddFun.autocompleteFun();
            },
            modifyVal:function  (o,i,f) {
                var rindex=  $(o).parents("tr").index();
                var ev=arguments.callee.caller.arguments[0] || window.event;
///    if($(ev.target).val()=="undefined"){return;}
                $('#createOrder').datagrid('getRows')[rindex][f]=$(ev.target).val();
                if(f=="length"||f=="width"||f=="quantity" ){
                    installionAddFun.formula(rindex);
                }
                installionAddFun.autocompleteFun();
            },
            modifyValRemarks:function  (o,i,f) {
                var rindex=  $(o).parents("tr").index();
                var ev=arguments.callee.caller.arguments[0] || window.event;
///    if($(ev.target).val()=="undefined"){return;}
                $('#createOrder').datagrid('getRows')[rindex][f]=$(ev.target).val();
            },
            formula:function (rindex){
                var row= $('#createOrder').datagrid('getRows')[rindex];
                var priceWay = row["priceWay"];
                var length =parseFloat($("input.inputTemplateLength")[rindex].value);
                var width = parseFloat($("input.inputTemplateWidth")[rindex].value);
                var quantity = parseFloat($("input.inputTemplateQuantity")[rindex].value);
                var unitPrice =parseFloat($("input.unitPriceChange")[rindex].value);
                var totalPrice = 0;
                switch (priceWay){
                    case "01" :
                        totalPrice = length * width * quantity * unitPrice;
                        break;
                    case "02" :
                        totalPrice = quantity * unitPrice;
                        break;
                    case "03" :
                        totalPrice = length * quantity * unitPrice;
                        break;
                    case "04" :
                        totalPrice = width * quantity * unitPrice;
                        break;
                    case "05" :
                        if(length > width){
                            totalPrice = length * quantity * unitPrice;
                        }else{
                            totalPrice = width * quantity * unitPrice;
                        }
                        break;
                    case "06" :
                        if(length > width){
                            totalPrice = Math.pow(length,2) * quantity * unitPrice;
                        }else{
                            totalPrice = Math.pow(width,2)  * quantity * unitPrice;
                        }
                        break;
                    case "07" :
                        totalPrice = (length + width) * 2 * quantity * unitPrice;
                        break;
                    default :
                        break;
                }
                var tpc="0.00";
                if(isNaN(totalPrice)){
                    $("input.totalpriceChange")[rindex].value="0.00";
                }else{
                    tpc=Number(totalPrice).toFixed(2);
                    $("input.totalpriceChange")[rindex].value=Number(totalPrice).toFixed(2);
                }
                // $($("input.totalpriceChange")[rindex]).trigger("click");

                installionAddFun.priceCount();
                // $('#createOrder').datagrid('acceptChanges');
            },
            priceCount:function () {
                var rows=$('#createOrder').datagrid("getRows");
                var tAmount = 0;
                for(var i=0;i<rows.length;i++){
                    var pr=$.trim($("input.totalpriceChange")[i].value);
                    if(isNaN($("input.totalpriceChange")[i].value) || pr==""){
                    }else{
                        tAmount=tAmount+parseFloat($("input.totalpriceChange")[i].value);
                    }
                }
                $("#priceText").text(accounting.formatNumber(tAmount,2));
                $("#priceTextVal").val(tAmount);
                installionAddFun.priceCountTwo();
            },
            priceCountTwo:function () {
                var tAmount= $("#priceTextVal").val();
                var orderSales = $("#salesCount").val();
                var depositRequested = $("#depositRequested").val();
                var preferentialVal = $("#preferentialVal").val();
                if(isNaN(orderSales) || orderSales==""){
                    // $("<div class='tips_contants'>").fadeIn(250).html("折扣优惠为0-100").delay(500).fadeOut(250).appendTo('body');
                    $("#salesCount").val(0);
                    // return false;
                }
                globVar.discountRate=orderSales/100;
                var discount =tAmount * (orderSales/100);
                $("#discountText").text(accounting.formatNumber(discount,2));
                $("#discountVal").val(discount);
                if(isNaN(preferentialVal) || preferentialVal==""){
                    $("#preferentialVal").val(0);
                }
                if(isNaN(depositRequested) || depositRequested==""){
                    $("#depositRequested").val(0);
                }
                var pr=parseFloat($("#priceTextVal").val())-parseFloat($("#discountVal").val())-parseFloat($("#preferentialVal").val()); //用到的减免金额

                $("#preferentialText").text(accounting.formatNumber($("#preferentialVal").val(),2));
                $("#depositRequestedText").text(accounting.formatNumber($("#depositRequested").val(),2));
                $("#totalPriceText").text(accounting.formatNumber(pr,2));
                $("#totalPriceVal").val(pr);// 订单金额

                var yspr=pr-parseFloat($("#depositRequested").val());//用到的预收金额
                $("#receivablesMoneyVal").val(yspr);
                $("#receivablesMoneyText").text(accounting.formatNumber(yspr,2));
            },
            addRow:function (o) {
                installionAddFun.openProReq(o);
                $("#searchKey").val("");
            },
            delRow:function (o){
                var rindex=  $(o).parents("tr").index();
                if($('#createOrder').datagrid("getRows").length>1){
                    $('#createOrder').datagrid('deleteRow',rindex);
                }
                installionAddFun.priceCount();
            },
            menuSecLoad:function () {

                installionAddFun.reload();
            },
            reload:function () {

                var pageSize = 30;
                var pageList = [30, 40];

                $('#order').datagrid({
                    url: pageTbUrl,
                    fit: true,
                    onLoadSuccess: installionAddFun.onLoadSuccess,
                    pagination: true,
                    pageSize: pageSize,
                    pageList: pageList,
                    queryParams: {
                        "searchKey":$("#searchKey").val()
                    }
                });
                var pager = $('#order').datagrid('getPager');	// get the pager of datagrid
                pager.pagination({
                    layout: ['first', 'links', 'last'],
                    showRefresh: false,
                    displayMsg: ''
                });
                $(".pagination").show();
            },
            onLoadSuccess:function (data){
                try{
                    if (data.rows.length > 0 ) {
                        $(".conTbText").show();
                        $("#tbOrder").show();
                    }else{
                        $("#tbOrder").show();
                        $(".conTbText").show();
                        // $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
                    }
                }catch(e){
                }

            }
        };
        $(function () {


            installionAddFun.initPageDataUPdate();
            //折扣优惠
            $(".sales-btn").on("click", function () {
                $("#salesCount").val(0);
                $("#discountText").text("0.00");
                installionAddFun.priceCountTwo();
            });
            //减免金额
            $(".minus-btn").on("click", function () {
                //          model.set("salseOrder.preferential",0);
                $("#preferentialVal").val(0);
                $("#preferentialText").text("0.00");
                installionAddFun.priceCountTwo();
            });
            //预收金额
            $(".earnest-btn").on("click", function () {
                //          model.set("salseOrder.depositRequested",0);
                $("#depositRequested").val(0);
                $("#depositRequestedText").text("0.00");
                installionAddFun.priceCountTwo();
            });

            $("#bottomBox").find(".font-btn").on("click", function () {
                var $dom, box, boxClass, isActive, name;
                $dom = $(this);
                isActive = $dom.hasClass("active");
                name = $dom.attr("name");
                boxClass = "." + name + "-box";
                box = $("#bottomBox").find(boxClass);
                $dom.toggleClass("active", !isActive);
                if (isActive) {
                    return box.hide();
                } else {
                    return box.show();
                }
            });
            $('[data-toggle="popover"]').popover();
        });
    </script>
</head>

<body >

<div class="header">
    <img src="/images/picture.png" alt="">修改工单
</div>


<div class="window-mask" style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>


<div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>



<div class="row" style="margin-bottom: 20px;line-height: 30px;">
    <label style="width: 60px;padding-right:0;" class="col-xs-1 control-label">供应商 :</label>
    <div class="col-xs-2" style="width:200px">
        <select id="clientsDp" style="width:180px;" onchange="installionAddFun.changeClients(this)">
            <option></option>
        </select>
    </div>
    <label style="width: 50px;;padding-right:0;" class="col-xs-1 control-label">姓名 :</label>
    <div class="col-xs-2" style="width:100px">
        <select disabled id="contacterDp" style="width:80px">
        </select>
    </div>
    <label style="width: 73px;padding-right:0;" class="col-xs-1 control-label">订单日期 :</label>
    <div class="col-xs-2" style="width:140px">
        <input type="text" style="width:120px" data-provide="datetimepicker-inline" name="orderDate" data-format="yyyy-MM-dd" class="form-control"
               id="orderDate">
        <i onclick="$('#orderDate').datetimepicker('show')" class="iconfont_new" style="    font-size: 18px;
    top: 1px;
    position: absolute;
    right: 15px;">&#xe6a6;</i>
    </div>
    <label style="width: 50px;padding-right:0;" class="col-xs-1 control-label">概要 :</label>
    <div class="col-xs-2" style="margin-left:-8px;">
        <input maxlength="15" id="caseDesc" class="form-control" style="width: 300px;border-color: #d7d7d7;" type="text" placeholder="散单内容简述">
    </div>
</div>

<div id="tableWrap" style="margin-top: 11px" >
    <table id="createOrder" data-options="remoteSort:false,
fitColumns : true,
           nowrap:true,singleSelect:true,checkOnSelect:false,
          scrollbarSize:0,
           columns: [arrclo_addList],
          data:globDataGrid,
          onLoadSuccess:installionAddFun.onLoadS" class="easyui-datagrid" style="width:100%;height:auto;">
        <thead>


        </thead>
        <tbody>

        </tbody>

    </table>
</div>
<!--金额结算部分 start-->
<div id="bottomBox">
    <div class="h-box" style="height:204px;">
        <div class="flex-box">
            <div class="v-box">
                <div class="flex-box">
                    <div class="remark-container">
                        <div id="remarkBtn" class="add_tips" onclick="installionAddFun.showRemark(this)"><i class="iconfont_new">&#xe6ca;</i>添加备注</div>
                        <textarea placeholder="备注……" id="remarkInput"  class="form-control" style="resize:none;max-width:669px;height: 60px;display:none;border-color:#d7d7d7;"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="box right-summary" style="width:300px;">
            <div class="h-box">
                <div class="box">合计金额</div>
                <div class="flex-box">
                    <div>
                        <div name="sales" class="sales-btn font-btn active">折</div>
                        <div name="minus" class="minus-btn font-btn active">减</div>
                        <div name="earnest" class="earnest-btn font-btn active">预</div>
                    </div>
                </div>
                <div class="box price">
                    <span id="priceText">0.00</span>
                    <input type="hidden" id="priceTextVal" value="0">
                </div>
            </div>
            <div class="h-box sales-box">
                <div class="box">折扣优惠</div>
                <div class="flex-box">
                    <div>

                        <div class="moneyInput ui input icon" style="width: 80px;"><input id="salesCount" maxlength="4" value="0" onkeyup="installionAddFun.priceCountTwo()" type="text"><i class="percent icon"></i></div>
                    </div>
                </div>
                <div class="box price">-<span id="discountText">0.00</span>
                    <input type="hidden" id="discountVal" value="0">
                </div>
            </div>
            <div style="height:30px" class="h-box minus-box">
                <div class="box">减免金额</div>
                <div class="flex-box">
                    <div>

                        <div class="moneyInput ui input" style="width: 80px;"><input id="preferentialVal" value="0" onkeyup="installionAddFun.priceCountTwo()" type="text"></div>
                    </div>
                </div>
                <div class="box price">
                    -<span id="preferentialText">0.00</span>

                </div>
            </div>
            <div class="h-box">
                <div class="box">安装金额</div>
                <div class="flex-box"></div>
                <div class="box price">
                    <span id="totalPriceText">0.00</span>
                    <input type="hidden" id="totalPriceVal" value="0">
                </div>
            </div>
            <div class="ui divider" style="border-color:#f2f2f2;border-bottom:none;"></div>
            <div  class="h-box earnest-box">
                <div class="box">预付金额</div>
                <div class="flex-box">


                    <div class="moneyInput ui input" style="width: 80px;">
                        <input onkeyup="installionAddFun.priceCountTwo()" value="0" id="depositRequested" type="text"></div>
                </div>
                <div class="box price">-<span id="depositRequestedText">0.00</span></div>
            </div>
            <div class="h-box">
                <div class="box">应付金额</div>
                <div class="flex-box"></div>
                <input type="hidden" id="receivablesMoneyVal" value="0">

                <div class="box price" id="receivablesMoneyText">0.00</div>
            </div>
        </div>
    </div>
    <div class="ui divider" style="border-color:#e4e4e4;"></div>
    <div class="h-box actions">
        <div class="flex-box"></div>
        <div class="box">
            <div class="btnGrp ui segment basic">


                <div style="width: 35px; display:inline-block; cursor: pointer;color:#999;" onclick="installionAddFun.back(this)">取消</div>
                <button type="button" style="width: 100px" userdata="1" onclick="installionAddFun.saveAll(this)" class="btn btn-primary">保存工单</button>

            </div>
        </div>
    </div>
</div>

<!--物料/制作/说明弹出框 start-->
<div id="topBarPR" class="topbarPrCss" style="height: 600px">
    <%--这个是加载框，切勿修改--%>
    <article style="text-align: center;font-size: 1.25rem;padding: 1.2rem 0">
        勾选需要安装的业务明细
        <%--请选择本次订单的物料/制作/说明<span style="color: #ff0000; font-size: 12px; margin-left: 15px;">(需要预先在基础资料里进行价格编辑)</span>--%>
    </article>




    <div class="orderTbText" style="width: 100%;
    height: 100%;
    /*padding: 0 0 0 185px;*/
">
        <div id="tbOrder" style="display: none; padding:0 10px 10px 10px;
    ">
            <form role="form">
                <div class="row " style="margin:0;">

                    <div class="col-xs-6" style="padding-left:1px;">
                        <div class="input-group">
                            <input type="text" class="form-control" onkeypress="if(event.keyCode == 13) {installionAddFun.reload();return false;}" id="searchKey" placeholder="搜索业务内容"
                                   style="      width: 282px;
    border-radius: 30px;
    color: #b3b3b3;
    font-size: 12px;
    padding-right: 30px;">
                            <span class=" iconfont_new" id="searchBtn" onclick="installionAddFun.reload()" style="        cursor: pointer;
    position: absolute;
    top: 2px;
    width: 20px;
    right: 8px;
    font-size: 20px;
    transform: rotate(-5deg);
    color: #b3b3b3;">&#xe6df;</span>
                        </div>
                    </div>
                    <div class="col-xs-6 pull-right" style="text-align: right">
                        <button type="button" class="btn " onclick="installionAddFun.closeProReq()" style="background: #DEE1E2;">取消</button>
                        <button type="button" class="btn btn-primary" onclick="installionAddFun.testHard1()">确定</button>
                    </div>

                </div>
            </form>
        </div>
        <div class="conTbText" style="padding: 0 10px;">
            <table id="order" style=" width: 100%;margin-top:50px;height: 500px;" class="easyui-datagrid " data-options="remoteSort:false,
fitColumns : true,
           nowrap:true,
          onLoadSuccess:installionAddFun.onLoadSuccess">
                <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true,width:28"></th>
                    <th data-options="field:'partnerShortname',width:100,align:'left'">客户</th>
                    <th data-options="field:'businessDesc',width:200,align:'left'">业务内容</th>
                    <th data-options="field:'length',width:100,align:'left'">长(米)</th>
                    <th data-options="field:'width',width:100,align:'left'">宽(米)</th>
                    <th data-options="field:'quantity',width:80,align:'left'">数量</th>
                    <th data-options="field:'unit',width:80,align:'left'">单位</th>
                    <th data-options="field:'salesNo',width:100,align:'left'">销售单号</th>

                </thead>
            </table>
        </div>
    </div>
    <div style="    position: absolute;
    width: 100%;
    bottom: 0;
">
        <%--<div style="display: inline-block;--%>
        <%--float: left;">--%>
        <%--<article><span style="color: #ff0000;">单行 : </span>仅为当前明细行使用的物料/制作/说明 <span style="color: #ff0000;">全选 : </span> 仅为当前明细行及以下本类所有明细行使用该物料/制作/说明</article>--%>
        <%--</div>--%>


    </div>
</div>


</body>

</html>