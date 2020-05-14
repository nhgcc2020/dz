<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="renderer" content="webkit" />
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <title>创建销售订单</title>
        <%--<base href="/">--%>
        <link rel="stylesheet" type="text/css" href="/resources/common/common.css?v=076f5c8c95">
        <link rel="stylesheet" type="text/css" href="/resources/common/custom-widget.css?v=824f9feec4">
        <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
        <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
        <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">

        <style>



            .datagrid-cell input {
                line-height: 35px;
                height: 35px;
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

            .cover {
                display: none;
                position: fixed;
                top: 0;
                width: 100%;
                height: 100%;
                background: #000;
                opacity: 0.7;
                z-index: 1000;
            }

            .alart_one {
                display: none;
                position: fixed;
                top: 50%;
                z-index: 2000;
                width: 930px;
                margin-top: -270px;
                left: 55%;
                margin-left: -550px;
                background: #fff;
            }

            .alart_img {
                width: 300px;
                height: 201px;
                position: absolute;
                top: 0;
                left: -80px;
            }

            .official {
                width: 68%;
                margin: 40px auto 40px;
                font-size: 15px;
            }

            .official li {
                margin: 35px 0;
            }

            .alart_last {
                width: 310px;
                height: 45px;
                margin: 0 auto!important;
                line-height: 45px;
                text-align: center;
                background: #ff3300;
                border-radius: 5px;
                color: #fff;
                cursor: pointer;
            }

            .callback {
                font-size: 45px;
                right: 0px;
                top: 2px;
                position: absolute;
                color: #a5a5a5;
                cursor: pointer;
            }
        </style>
        <script type="text/javascript">
            var salesNo = '';
        </script>
        <script>
            var globDataGrid =
                [
                    {
                        "businessDesc": "",
                        "businessType": "00",
                        "length": "",
                        "width": "",
                        "priceWay": "01",
                        "priceWayDesc": "按面积",
                        "quantity": "",
                        "requirements": "",
                        "totalPrice": "",
                        "unit": "",
                        "isUrgent": "0",
                        "isChecked": "1",
                        "remarks": "",
                        "unitPrice": ""

                    },
                    {
                        "businessDesc": "",
                        "businessType": "00",
                        "length": "",
                        "width": "",
                        "priceWay": "01",
                        "isUrgent": "0",
                        "priceWayDesc": "按面积",
                        "quantity": "",
                        "requirements": "",
                        "totalPrice": "",
                        "unit": "",
                        "isChecked": "1",
                        "remarks": "",
                        "unitPrice": ""

                    }, {
                        "businessDesc": "",
                        "businessType": "00",
                        "length": "",
                        "width": "",
                        "isUrgent": "0",
                        "priceWay": "01",
                        "priceWayDesc": "按面积",
                        "quantity": "",
                        "requirements": "",
                        "totalPrice": "",
                        "unit": "",
                        "isChecked": "1",
                        "remarks": "",
                        "unitPrice": ""

                    }
                ];
        </script>
        <script>
            var arrclo_addList = [];
            arrclo_addList.push({
                field: 'businessDesc', width: 150, title: '业务内容', formatter: function (value, row, index) {
                    return inputTemplate(value, index, 'businessDesc')
                }
            });
            arrclo_addList.push({
                field: 'requirements',
                title: '物料/制作/说明',
                width: 150,
                formatter: function (value, row, index) {
                    return inputTemplateReq(value, index, row)
                }
            });
            arrclo_addList.push({
                field: 'length',
                title: '长(米)',
                width: 40,
                formatter: function (value, row, index) {
                    return inputTemplateLength(value, index, 'length')
                }
            });
            arrclo_addList.push({
                field: 'width',
                title: '宽(米)',
                width: 40,
                formatter: function (value, row, index) {
                    return inputTemplateWidth(value, index, 'width')
                }
            });
            arrclo_addList.push({
                field: 'priceWayDesc',
                title: '计价方式',
                width: 50,
                align: 'center', formatter: function (value, row, index) {
                    return inputTemplateWay(value, index, 'priceWayDesc')
                }
            });
            arrclo_addList.push({
                field: 'quantity',
                title: '数量',
                width: 50,
                formatter: function (value, row, index) {
                    return inputTemplateQuantity(value, index, 'quantity')
                }
            });
            arrclo_addList.push({
                field: 'unit',
                title: '单位',
                width: 50,
                formatter: function (value, row, index) {
                    return inputTemplateUnit(value, index, 'unit')
                }
            });
            arrclo_addList.push({
                field: 'unitPrice',
                title: '单价',
                width: 50,
                formatter: function (value, row, index) {
                    return inputTemplateUnitprice(value, index, 'unitPrice')
                }
            });
            arrclo_addList.push({
                field: 'totalPrice',
                title: '行小计',
                width: 50,
                formatter: function (value, row, index) {
                    return inputTemplatePrice(value, index, row, 'totalPrice')
                }
            });
            arrclo_addList.push({
                field: 'remarks',
                title: '备注',
                width: 50,
                formatter: function (value, row, index) {
                    return inputTemplateRemarks(value, index, row, 'remarks')
                }
            });
            arrclo_addList.push({
                field: 'btn',
                title: '操作',
                width: 70,
                formatter: function (value, row, index) {
                    return '<i class="iconfont_new contentTemplate" title="增加" onclick="addRow(this)">&#xe6a1;</i>&nbsp;<i title="复制" class="iconfont_new contentTemplate" onclick="copyRow(this)" >&#xe69d;</i>&nbsp;<i title="删除" class="iconfont_new contentTemplate" onclick="delRow(this)" >&#xe6f2;</i>';
                }
            });
            arrclo_addList.push({
                field: 'isUrgent',
                title: '加急',
                width: 50,
                align: 'center', formatter: function (value, row, index) {
                    if (value && value == "1") {
                        return ' <div onclick="checkLineJiaji(this)" class="checkbox checkbox-slider--b-flat " style="width:40px;display: inline-block;"><label><input  class="inputTemplateJiaji" value="1" checked type="checkbox"><span></span></label></div>'
                    } else {
                        return ' <div onclick="checkLineJiaji(this)" class="checkbox checkbox-slider--b-flat " style="width:40px;display: inline-block;"<label><input   class="inputTemplateJiaji"  value="0" type="checkbox"><span></span></label></div>'
                    }
                }
            });
        </script>

        <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
        <script src="/resources/easyui/pace.min.js?v=cdbdd88ddf"></script>
        <script src="/resources/pageConfig.js?v=d1935279f7"></script>
        <script src="/resources/easyui/jquery.autocomplete.js?v=88de880408"></script>
        <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
        <script src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
        <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1"></script>
        <script src="/resources/business/base_new.js?v=9ac481258df"></script>
        <script src="/resources/business/dzorder/sales-order/add.js?v=1b9139a5fd245"></script>
        <script>
            $(function () {
                //折扣优惠
                $(".sales-btn").on("click", function () {
                    $("#salesCount").val(0);
                    $("#discountText").text("0.00");
                    priceCountTwo();
                });
                //减免金额
                $(".minus-btn").on("click", function () {
                    //          model.set("salseOrder.preferential",0);
                    $("#preferentialVal").val(0);
                    $("#preferentialText").text("0.00");
                    priceCountTwo();
                });
                //预收金额
                $(".earnest-btn").on("click", function () {
                    //          model.set("salseOrder.depositRequested",0);
                    $("#depositRequested").val(0);
                    $("#depositRequestedText").text("0.00");
                    priceCountTwo();
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
                // 关闭弹出框
                $(".callback").click(function(){
                    $(".alart_one").hide();
                    $(".cover").hide();
                })
                $(".alart_last").click(function(){
                     window.location = "/openPage?pageName=c_payment/priceList";
                })


            });
            // 税点控制
            function addShuiDian(o) {
                if ($(o).text() == "添加税点") { $("#shuiDianCtrl").slideDown(); $(o).text("撤销税点"); $("#payAmoutBd").css("border", "none") } else if ($(o).text() == "撤销税点") {
                    $("#rateAmount").text("0");
                    $("#rateNum").val("0");
                    $("#payAmoutBd").css("border-top", "1px solid #ccc");
                    $("#payAmout").text(accounting.formatNumber($("#orderMoneyActual").text(), 2));
                    $("#shuiDianCtrl").slideUp(); $(o).text("添加税点")
                }
            }
            function inputCalMoney(o) {
                if (isNaN($(o).val())) {
                    $("#rateAmount").text("0");
                    $("#rateNum").val("0");
                    $("#payAmout").text(accounting.formatNumber($("#orderMoneyActual").text(), 2));
                    return;
                }
                $("#rateAmount").text(accounting.formatNumber((Number($("#rateNum").val()) * Number($("#orderMoneyActual").text())).toFixed(0) / 100, 2));
                $("#payAmout").text(accounting.formatNumber(Number($("#orderMoneyActual").text()) * (1 + Number($("#rateNum").val()) / 100), 2));
            }
        </script>
        <%--此文件引用是做物料制作说明调用. 其他页面请勿调用--%>
            <script src="/resources/business/dzorder/sales-order/menu.js?v=0ed24441e6"></script>
    </head>

    <body class="modal-page" style="padding:0!important;">
        <div class="cover"></div>
        <div class="alart_one">
            <div class="callback iconfont_new">&#xe6a0;</div>
            <img class="alart_img" src="../../images/service.png" alt="">
            <ul class="official">
                <li>亲爱的用户朋友：</li>
                <li>&#X3000;&#X3000;&#X3000;本着互相支持、长期共赢的诚意，我们提供了<span style="color:#ff3300;"><span class="stroke">50</span>笔销售订单</span>的免费体验开单额度，</li>
                <li>&#X3000;&#X3000;以便让您对我们的软件有更好的功能了解和操作熟悉。</li>
                <li>&#X3000;&#X3000;&#X3000;贵公司的开单额度<span style="color:#ff3300;">即将超过<span class="stroke">50</span>笔</span>（系统自动累计，本单开始倒计<span class="stroke_count" style="color:#ff3300;">5</span>笔），需要您付费来</li>
                <li>&#X3000;&#X3000;支持我们未来有更大财力投入产品开发和客户服务！</li>
                <li>&#X3000;&#X3000;&#X3000;欢迎您不断将您的需求告知我们，我们必定不断的革新，助您在商业舞台上一展宏图。</li>
                <li>&#X3000;&#X3000;&#X3000;如有疑问，请咨询 <span style="color:#ff3300;">186-2158-0723</span></li>
                <li class="alart_last">立即去付费支持我们！</li>
            </ul>
        </div>
        <div style="padding: 1em 42px !important;">
            <div class="header">
                <img src="../../images/picture.png" alt="">销售开单
            </div>
            <div class="window-mask" style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
            <div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>

            <div class="row" style="margin-bottom: 20px;line-height: 30px;">
                <label style="width: 50px;padding-right:0;" class="col-xs-1 control-label">客户 :</label>
                <div class="col-xs-2" style="width:220px">
                    <select id="clientsDp" style="width:200px;" >
            <option></option>
        </select>
                </div>
                <label style="width: 50px;;padding-right:0;" class="col-xs-1 control-label">姓名 :</label>
                <div class="col-xs-2" style="width:160px">
                    <select id="contacterDp" style="width:140px">
        </select>
                </div>
                <label style="width: 73px;padding-right:0;" class="col-xs-1 control-label">订单日期 :</label>
                <div class="col-xs-2" style="width:160px">
                    <input type="text" style="width:140px" data-provide="datetimepicker-inline" name="orderDate" data-format="yyyy-MM-dd" class="form-control"
                        id="orderDate">
                    <i onclick="$('#orderDate').datetimepicker('show')" class="iconfont_new" style="    font-size: 18px;
    top: 1px;
    position: absolute;
    right: 15px;">&#xe6a6;</i>
                </div>
                <label style="width: 73px;padding-right:0;" class="col-xs-1 control-label">销售代表 :</label>
                <div class="col-xs-2 " style="width:170px">
                    <select id="saleManDp" style="width:140px">
        </select>
                </div>
            </div>
            <div class="row" style="line-height: 30px;">
                <label style="width: 50px;padding-right:0;" class="col-xs-1 control-label">概要 :</label>
                <div class="col-xs-4" style="width: 431px;margin-left:-8px;">
                    <input maxlength="15" id="caseDesc" class="form-control" style="width: 402px;border-color: #d7d7d7;" type="text" placeholder="散单内容简述">
                </div>
                <div class="col-xs-6" style="padding-left: 5px;">
                    <%--<span  class="iconfont_new" style="position: relative;top:-1px;vertical-align: middle;font-size: 20px">&#xe6b8;</span>--%>
                        <label style="width: 80px;padding-right:0;" class="hide onPaiGongLabel">启用制作派工</label>
                        <div class="checkbox checkbox-slider--b-flat hide onPaiGongLabel" style="display: inline-block;margin-top: 6px;padding-left: 5px;"><label><input class="onPaiGong "  value="1"  type="checkbox"><span></span></label></div>
                        <div class="iconfont_new hide onPaiGongLabel" style="color: #ff9900;display:inline-block;font-size:25px;position: relative;top:5px;left:-5px;"
                            data-toggle="popover" data-container="body" data-trigger="hover" data-placement="bottom" data-html="true"
                            data-content="如果不需要制作派工<br>可在派工--制作--工序配置页顶部，把启用默认制作派工关闭">&#xe6b8;</div>
                        <label style="width: 80px;padding-right:0;" class="hide onPaiGongDesignLabel">启用设计派工</label>
                        <div class="checkbox checkbox-slider--b-flat hide onPaiGongDesignLabel" style="display: inline-block;margin-top: 6px;padding-left: 5px;"><label><input class="  onPaiGongDesign"  value="1"  type="checkbox"><span></span></label></div>
                        <div class="iconfont_new hide onPaiGongDesignLabel" style="color: #ff9900;display:inline-block;font-size:25px;position: relative;top:5px;left:-5px;"
                            data-toggle="popover" data-container="body" data-trigger="hover" data-placement="bottom" data-html="true"
                            data-content="如不需要设计派工<br>可在派工--设计--任务分派页，把启用默认设计派工关闭">&#xe6b8;</div>
                        <label style="width: 50px;padding-right:0;" class="">优先加急</label>
                        <div class="checkbox checkbox-slider--b-flat " style=" display: inline-block;margin-top: 6px;padding-left: 0"><label><input class="onJiaji" onclick="checkJiaji(this)" value="1"  type="checkbox"><span></span></label></div>
                        <div class="iconfont_new" style="color: #ff9900;display:inline-block;font-size:25px;position: relative;top:5px;left:-3px;"
                            data-toggle="popover" data-container="body" data-trigger="hover" data-placement="bottom" data-html="true"
                            data-content="选择整单加急<br>派工所有任务处于优先制作状态，制作工会优先制作这张订单">&#xe6b8;</div>
                </div>

            </div>

            <div style="margin-top: 11px" id="tableWrap">
                <table id="createOrder" data-options="remoteSort:false,
fitColumns : true,
           nowrap:true,singleSelect:true,checkOnSelect:false,
          scrollbarSize:0,
           columns: [arrclo_addList],
          data:globDataGrid,
          onLoadSuccess:onLoadS" class="easyui-datagrid" style="width:100%;height:auto;">
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
                                    <div id="remarkBtn" class="add_tips" onclick="showRemark(this)"><i class="iconfont_new">&#xe6ca;</i>添加备注</div>
                                    <textarea placeholder="备注……" id="remarkInput" class="form-control" style="resize:none;max-width:669px;height: 60px;display:none;border-color:#d7d7d7;"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box right-summary" style="width:300px;">
                        <div class="h-box">
                            <div class="box">合计金额</div>
                            <div class="flex-box">
                                <div>
                                    <div name="sales" class="sales-btn font-btn">折</div>
                                    <div name="minus" class="minus-btn font-btn">减</div>
                                    <div name="earnest" class="earnest-btn font-btn">预</div>
                                </div>
                            </div>
                            <div class="box price">
                                <span id="priceText">0.00</span>
                                <input type="hidden" id="priceTextVal" value="0">
                            </div>
                        </div>
                        <div style="display:none" class="h-box sales-box">
                            <div class="box">折扣优惠</div>
                            <div class="flex-box">
                                <div>

                                    <div class="moneyInput ui input icon" style="width: 80px;"><input id="salesCount" maxlength="4" value="0" onkeyup="priceCountTwo()" type="text">
                                        <i class="percent icon"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="box price">-<span id="discountText">0.00</span>
                                <input type="hidden" id="discountVal" value="0">
                            </div>
                        </div>
                        <div style="height:30px;display:none" class="h-box minus-box">
                            <div class="box">减免金额</div>
                            <div class="flex-box">
                                <div>

                                    <div class="moneyInput ui input" style="width: 80px;"><input id="preferentialVal" value="0" onkeyup="priceCountTwo()" type="text"></div>
                                </div>
                            </div>
                            <div class="box price">
                                -<span id="preferentialText">0.00</span>

                            </div>
                        </div>
                        <div class="h-box">
                            <div class="box">订单金额</div>
                            <div class="flex-box"></div>
                            <div class="box price">
                                <span id="totalPriceText">0.00</span>
                                <input type="hidden" id="totalPriceVal" value="0">
                            </div>
                        </div>
                        <div class="ui divider" style="border-color:#f2f2f2;border-bottom:none;"></div>
                        <div style="display:none" class="h-box earnest-box">
                            <div class="box">预收金额</div>
                            <div class="flex-box">


                                <div class="moneyInput ui input" style="width: 80px;">
                                    <input onkeyup="priceCountTwo()" value="0" id="depositRequested" type="text"></div>
                            </div>
                            <div class="box price">-<span id="depositRequestedText">0.00</span></div>
                        </div>
                        <div class="h-box">
                            <div class="box">应收金额</div>
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


                            <div style="width: 35px; display:inline-block; cursor: pointer;color:#999;" onclick="back(this)">取消</div>
                            <button type="button" dat="0" style="width: 104px;border-color:#d7d7d7;color:#999;" onclick="saveDraft(this)" class="btn btn-info">保存至草稿箱</button>
                            <button type="button" dat="0" style="width: 118px;margin-left:7px;" id="saveCashPg" onclick="ifSaveCash(this)" class="btn  btn-warning">创建订单并收款</button>
                            <button type="button" dat="0" style="width: 100px" userdata="1" onclick="saveAll(this)" class="btn btn-primary">创建订单</button>

                        </div>
                    </div>
                </div>
            </div>
            <!--文件弹出框 start-->
            <div id="topBar" class="topbarCss">
                <div style="width: 1100px;margin: 0 auto">

                    <article style="text-align: center;border-bottom: 1px solid grey;font-size: 1.25rem;padding: 1.2rem 0">
                        上传制作文件，系统自动获取文件名中的业务、长、宽、数量，开单时无需逐个填写
                    </article>

                    <div style="margin:0 auto;position:relative;">
                        <div id="file_div" style="margin-top: 2rem;font-size:14px;display: inline-block;">
                            <i class="iconfont_new" style="font-size:30px;position:absolute;left:-1px;top:15px;">&#xe6ed;</i>
                            <div style="margin-left:40px;">
                                文件名格式 : </div>
                            <div style="margin-left:40px;">业务内容 长-宽-数量，例 : 安全驾驶公益广告 110-120-5</div>
                            <div style="margin-left:40px;">
                                1.系统会将文件名中最开始的第一个数字作为长，依次读取。
                            </div>
                            <div style="margin-left:40px;">
                                2.长、宽必须为厘米。
                            </div>
                            <div style="margin-left:40px;">
                                3.长、宽、数量间隔可以用，杠 (-) 乘 (X或x) 星号 (*) 或空格。
                            </div>
                            <br>
                            <button onclick="openHideUpload()" type="button" class="btn btn-success" style="margin:23px 20px 23px 0;font-size:14px;">方法一：选用文件上传</button>
                            <span id="uploadNote" style="    color: #000;
    float: right;
    font-size: 14px;
    margin: 23px 20px 23px 0;">上传文件数 <span style="color:#ccc;font-size:20px;margin-left:50px;">&nbsp;0</span></span>
                            <!--<button>上传</button>-->
                            <input type="file" accept=".tif,.jpg,.jpeg,.png,.txt,.doc,.docx,.xls,.xlsx,.pdf" id="fileButton" style="display: none" multiple="multiple"
                                onchange="preview(this)" /><br>
                        <div id="fileSpanNew" style="    display: inline-block;
    width: 418px;
    background: url('/images/fileup.png') center center no-repeat;
    height: 170px;
    border: 2px dashed #ccc;
    text-align: center;
    line-height: 150px;"></div>
                        </div>
                        <div id="upload_box" style="margin-top: 2rem;margin-left: 1rem;display: inline-block;vertical-align: top">
                            <ul style="margin: 0;padding: 0;list-style: none;display: inline-block">
                            </ul>
                            <ul style="margin:0 0 0 20px;padding: 0;list-style: none;display: inline-block;vertical-align: top">
                            </ul>
                        </div>
                    </div>

                    <div style="margin: 1rem 0;text-align: right">
                        <button type="button" onclick="closeUpload()" class="btn ">取消</button>&#x3000;
                        <button type="button" onclick="saveUploadName()" class="btn btn-primary">确定</button>
                    </div>
                </div>
            </div>
            <!--物料/制作/说明弹出框 start-->
            <div id="topBarPR" class="topbarPrCss" style="height: 600px">
                <%--这个是加载框，切勿修改--%>
                    <article style="text-align: center;font-size: 1.25rem;padding: 1.2rem 0">
                        请先选中一条物料制作内容，然后再点击“填充单行”或“填充全部”
                        <%--请选择本次订单的物料/制作/说明<span style="color: #ff0000; font-size: 12px; margin-left: 15px;">(需要预先在基础资料里进行价格编辑)</span>--%>
                    </article>



                    <div style="    width: 174px;
    height: 100%;
    position: absolute;">
                        <div class="west westl" style="position: absolute;left: 0;">
                            <h1 class="westH1Left">类目</h1>
                            <ul id="leftMenu">

                            </ul>
                        </div>
                        <%--<div  class="west westr" style="position: absolute;right: 0;"><h1 class="westH1Right">二级类目</h1>--%>

                            <%--<ul id="rightMenu">--%>
                                <%--</ul>--%>
                                    <%--</div>--%>
                    </div>

                    <div class="orderTbText" style="width: 100%;
    height: 100%;
    padding: 0 0 0 185px;">
                        <div id="tbOrder" style="display: none; padding:0 10px 10px 10px;
    ">
                            <form role="form">
                                <div class="row " style="margin:0;">

                                    <div class="col-xs-6" style="padding-left:1px;">
                                        <div class="input-group">
                                            <input type="text" class="form-control" onkeypress="if(event.keyCode == 13) {reload('');return false;}" id="searchKey" placeholder="查找当前类目服务定价"
                                                style="      width: 282px;
    border-radius: 30px;
    color: #b3b3b3;
    font-size: 12px;
    padding-right: 30px;">
                                            <span class=" iconfont_new" id="searchBtn" onclick="reload()" style="        cursor: pointer;
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
                                        <button type="button" class="btn " onclick="closeProReq()" style="background: #DEE1E2;">取消</button>
                                        <button type="button" class="btn btn-primary" onclick="testHard1()">填充单行</button>
                                        <button type="button" class="btn btn-primary" onclick="testHard2()">填充全部</button>
                                    </div>

                                </div>
                            </form>
                        </div>
                        <div class="conTbText">
                            <table id="order" style=" width: 100%;margin-top:50px;height: 500px;" class="easyui-datagrid " data-options="remoteSort:false,
fitColumns : true,
           nowrap:true,singleSelect:true,checkOnSelect:false,
          onLoadSuccess:onLoadSuccess">
                                <thead>
                                    <tr>
                                        <th data-options="field:'index',width:50,align:'center',formatter:function(val,row,index){
                return index+1;
                }">
                                            序号
                                        </th>
                                        <th data-options="field:'categoryDesc',width:200,align:'left',editor:{type:'validatebox',options:{required:true,validType:'length[1,5]'}}">物料制作说明</th>
                                        <th data-options="field:'unitPrice',width:100,formatter: function(value, row) {
            return accounting.formatNumber(value,2);
        }">单价</th>

                                        <th data-options="field:'priceWay',formatter:priceWayAllFormatter,width:100,editor:{type:'combobox',options:{
                                valueField:'priceWay',
                                textField:'priceWayDesc',
                                data:priceWayAll,
                                required:true
                            }}">计价方式</th>
                                        <th data-options="field:'priceUnit',width:100,formatter:priceUnitAllFormatter,width:100,editor:{type:'combobox',options:{
                                valueField:'priceUnit',
                                textField:'priceUnitDesc',
                                data:priceUnitAll,
                                required:true
                            }}">计价单位</th>

                                    </tr>
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
            <%--点击“创建订单并收款”弹出确认页面--%>
                <div class="animated flipInY" id="createOrderPop">
                    <p style="position:relative;font-weight: 100; text-align: left; font-size: 22px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;"
                        id="menuTitle">创建订单并收款</p>
                    <span id="closetranform" style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
                        onclick="hideOrderPop()"><i style="background: url('../../images/close_user.png');width:14px;height: 14px;display: block" alt="点击关闭"></i></span>
                    <%--<div  style="text-align: center;margin:0 auto;" data-id="content">--%>
                        <div style="    width: 500px;height: 30px;line-height: 30px;margin: 20px auto;border: 1px solid #ffcc00;font-size: 12px;color: #666;background-color: #ffffcc;text-align: center;">一次付清货款，“应收金额”即“实收金额”，系统直接生成已收款对账单</div>

                        <p style="width: 360px; margin: 70px auto 20px; height: 30px; position: relative; text-align: right;">
                            <span style="float:left;color:#666;font-size:14px;font-weight: 700;">订单金额：</span>
                            <span style="    color: #666;font-size: 26px;font-family: arial;" id="orderMoney"></span>
                            <input type="hidden" id="orderMoneyActual" value="">

                            <i style="    color: #2e8ae6;font-size: 12px;margin-left: 10px;position: absolute;right: -66px;font-style: normal;cursor: pointer;"
                                onclick="addShuiDian(this)">添加税点</i>
                        </p>

                        <div id="shuiDianCtrl" style="border: 1px solid rgb(204, 204, 204);width: 400px;padding: 20px 20px 0px;margin: 0px auto 20px;display: none;">
                            <p style="    width: 360px;margin: 0 auto;height: 40px;"><span style="float:left;color:#666;font-size:14px;text-indent: 10px;">税率：</span><span style="float:right;color:#666;font-size:26px;">
                    <input type="text" style="    font-size: 14px;border: 1px solid #ccc;border-radius: 2px;width: 40px;height: 20px;vertical-align: middle;"
                           onkeyup="inputCalMoney(this)"
                           id="rateNum"  value="0"><i style="margin-left:5px;font-size: 16px;font-family: Arial;">%</i></span></p>
                            <p style="width: 360px;margin: 0 auto;height: 40px;text-align: right;"><span style="float:left;color:#666;font-size:14px;text-indent: 10px;">税额：</span><span id="rateAmount"
                                    style="color:#666;font-size:16px;">..</span></p>
                        </div>

                        <p style="    width: 360px;border-top:1px solid #ccc; margin: 0 auto 74px; padding-top: 30px; height: 30px;" id="payAmoutBd"><span style="float:left;color:#666;font-size:14px;font-weight: 700;">应收金额：</span>
                            <span id="payAmout" style="font-family:arial;float:right;color:#ff0000;font-size:26px;"></span></p>
                        <div class="actions" style="padding-bottom:30px;padding-right: 82px;background: none;border-top:none;position: absolute; right: 0; bottom: 0;">
                            <button onclick="hideOrderPop()" type="button" class="btn " style="width: 100px">
            取消
        </button>
                            <button type="button" class="btn btn-primary" style="margin-left:15px;width: 100px" onclick="saveCash(this)">创建
        </button>
                        </div>
                </div>
        </div>
    </body>

    </html>