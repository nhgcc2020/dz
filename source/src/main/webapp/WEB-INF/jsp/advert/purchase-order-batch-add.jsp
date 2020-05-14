<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选择供应商批量创建采购单</title>
        <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
        <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
        <link rel="stylesheet" type="text/css" href="/resources/common/common.css?v=076f5c8c95">
        <link rel="stylesheet" type="text/css" href="/resources/business/dzorder/sales-order/update.css?v=21cb6f191b">
        <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
        <style>

            .ui.calendar.mild .date-table-wrapper .date-table td.selected div.label {
                background: #2e8ae6
            }

            .ui.calendar.mild .date-table-wrapper .date-table > tbody > tr > td:first-child, .ui.calendar.mild .date-table-wrapper .date-table > tbody > tr > td:last-child {
                background: rgba(46, 138, 230, .1)
            }

            .ui.calendar.mild .date-table-wrapper .date-table td:hover:not(.selected) div.label {
                background: rgba(46, 138, 230, .5)
            }

            .ui.positive.button, .ui.positive.buttons .button {
                background-color: #2185D0 !important;
                color: #FFF;
                text-shadow: none;
                background-image: none
            }

            ul li label {
                width: 250px;
                display: inline-block
            }

            .ui.button {
                padding: 0 30px
            }

            .moneyInput input {
                line-height: initial !important;
                height: initial !important
            }

            .ui.input.error input {
                border-width: 1px !important;
                border-radius: 2px !important
            }

            .tips_contants {
                height: 80px;
                line-height: 80px;
                width: 300px;
                text-align: center;
                background: rgba(0, 0, 0, .8);
                color: #fff;
                position: fixed;
                top: 50%;
                margin-top: -150px;
                left: 50%;
                margin-left: -150px;
                border-radius: 5px;
                display: none;
                z-index: 9999
            }

            .ui.input input {
                padding: 0 10px !important
            }

            .add_tips {
                font-size: 12px;
                cursor: pointer;
                position: relative;
                padding: 5px 0 10px 26px;
                color: #999;
                width: 100px
            }

            .add_tips:hover, .add_tips:hover i {
                color: #2e8ae6
            }

            .add_tips i {
                position: absolute;
                left: 0;
                font-size: 1.8rem;
                color: #999;
                top: 4px
            }

            .secondary, .secondary i {
                color: #2e8ae6
            }

            .ui.list-view .items {
                max-width: 215px;
            }

            .ui.segment.custom-table .ui.widget-table table thead th {
                background-color: transparent;
            }
        </style>
    </head>
<body>
<%--这个是加载框，切勿修改--%>
<div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>
<!--头部表单部分 start-->
<div class="ui form">
    <%--<div class="inline fields">--%>
    <%--<div class="field">--%>
    <%--<label style="width: 48px;text-align: center;">供应商</label>--%>
    <%--&lt;%&ndash;<div id="clientsDp" style="width:200px"></div>&ndash;%&gt;--%>
    <%--<select id="clientsDp" style="width:200px" onchange="changeClients(this)" placeholder="选择供应商"> </select>--%>
    <%--</div>--%>
    <%--<div class="field">--%>
    <%--<label style="display: inline-block;margin-left: 30px;">联系姓名</label>--%>
    <%--<select id="contacterDp" style="width:150px">--%>
    <%--</select>--%>
    <%--</div>--%>


    <%--<div class="field">--%>
    <%--<label style="display: inline-block;margin-left: 30px;">订单日期</label>--%>
    <%--<div c-widget="DatePicker;tag:orderDate;width:150px;bind:purchaseOrder.orderDate"></div>--%>
    <%--</div>--%>
    <%--&lt;%&ndash;        <div class="field">--%>
    <%--<label style="display: inline-block;margin-left: 30px;">销售代表</label>--%>
    <%--<div id="saleManDp" style="width:150px"></div>--%>
    <%--</div>&ndash;%&gt;--%>
    <%--</div>--%>
    <div class="inline fields">
        <div class="field">
            <label>项目名称</label>
            <div c-widget="input; placeholder:散单生意可以概要填写，以备后续查询; bind:purchaseOrder.caseDesc;width:955"
                 style="margin-right: 46px"></div>
        </div>
    </div>
</div>

<!--订单分类 start-->
<div id="tagsWrap" style="display: none;">
    添加分类订单
    <div c-repeat="tag in tags" c-class="checked:isRangeChecked(tag.modelName) on ranges.*" class="tag-range">
        <div c-widget="checkbox; bind:{{'ranges.'+tag.modelName}}; label:{{tag.label}}; userData:{{tag}}; change:changeMain;tag:typeBox"
             class="rotating"></div>
    </div>
</div>

<!--订单表格 start-->
<div id="tableWrap"></div>

<!--金额结算部分 start-->
<div id="bottomBox" class="show-on-ready">
    <%--<div class="h-box">--%>
    <%--<div class="flex-box">--%>
    <%--<div class="v-box">--%>
    <%--<div class="flex-box">--%>
    <%--<div class="remark-container">--%>
    <%--<div id="remarkBtn" class="iconfont add_tips" c-onclick="showRemark(this)"><i--%>
    <%--class="iconfont_new">&#xe6ca;</i>添加备注--%>
    <%--</div>--%>
    <%--<div id="remarkInput" style="display:none"></div>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="box right-summary">--%>
    <%--<div class="h-box">--%>
    <%--<div class="box">合计金额</div>--%>
    <%--<div class="flex-box">--%>
    <%--<div>--%>
    <%--<div name="sales" class="sales-btn font-btn active">折</div>--%>
    <%--<div name="minus" class="minus-btn font-btn active">减</div>--%>
    <%--<div name="earnest" class="earnest-btn font-btn active">预</div>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="box price"><span c-bind="formatNumber(purchaseOrder.price,'#,##0.00')"></span></div>--%>
    <%--</div>--%>
    <%--<div style="" class="h-box sales-box">--%>
    <%--<div class="box">折扣优惠</div>--%>
    <%--<div class="flex-box">--%>
    <%--<div>--%>
    <%--<div class="moneyInput" c-widget="input; icon:percent;width:80px;bind:order.sales;"--%>
    <%--c-watch="discountChange on order.sales"></div>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="box price"><span c-bind="formatNumber(purchaseOrder.discount,'-#,##0.00')"></span>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div style="" class="h-box minus-box">--%>
    <%--<div class="box">减免金额</div>--%>
    <%--<div class="flex-box">--%>
    <%--<div>--%>
    <%--<div class="moneyInput" c-widget="input;width:80px; bind:purchaseOrder.preferential"></div>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="box price"><span c-bind="formatNumber(purchaseOrder.preferential,'-#,##0.00')"></span></div>--%>
    <%--</div>--%>
    <%--<div class="h-box">--%>
    <%--<div class="box">订单金额</div>--%>
    <%--<div class="flex-box"></div>--%>
    <%--<div class="box price"><span--%>
    <%--c-bind="bindChange(purchaseOrder.price * (100 - order.sales)/100 - purchaseOrder.preferential,'totalPrice')"></span>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="ui divider"></div>--%>
    <%--<div style="" class="h-box earnest-box">--%>
    <%--<div class="box">预付金额</div>--%>
    <%--<div class="flex-box">--%>
    <%--<div>--%>
    <%--<div class="moneyInput"--%>
    <%--c-widget="input; width:80px;  bind:purchaseOrder.depositRequested"></div>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="box price" c-bind="formatNumber(purchaseOrder.depositRequested,'-#,##0.00')"><span></span>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="h-box">--%>
    <%--<div class="box">应付金额</div>--%>
    <%--<div class="flex-box"></div>--%>
    <%--<div class="box price"--%>
    <%--c-bind="bindChange(purchaseOrder.totalPrice - purchaseOrder.depositRequested,'receivablesMoney')">--%>
    <%--<span></span></div>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="ui divider"></div>--%>
    <div class="h-box actions">
        <div class="flex-box"></div>
        <div class="box">
            <div class="ui segment basic">
                <div id="status01_btn_group" style="display: none">

                    <c-button caption="创建订单并收款" color="orange" onclick="ifSaveCash"></c-button>
                    <c-button caption="创建订单" class=" primary" onclick="saveAll" userData="1"></c-button>
                </div>
                <div id="status04_btn_group" style="display: none;">

                    <c-button caption="保存订单" class=" primary" onclick="saveAll" userData="1"></c-button>
                </div>

                <%--<c-button caption="保存并新增" class="mini primary" onclick="saveAll" userData="2"></c-button>--%>
            </div>
        </div>
    </div>
</div>

<!--文件弹出框 start-->
<div id="topBar" c-widget="Sidebar; direction:top;size:450;dimmerClose:false" class="segment show-on-ready">
    <div style="width: 1100px;margin: 0 auto">
        <article style="text-align: center;border-bottom: 1px solid grey;font-size: 1.25rem;padding: 1.2rem 0">
            读取文件名
        </article>

        <div style="margin:0 auto;">
            <div id="file_div" style="margin-top: 2rem;display: inline-block;">
                注意事项:<br>
                <div>
                    &nbsp;&nbsp;&nbsp;&nbsp;1.设置好文件名，系统可以自动获取长/宽/数量，极大提升记账效率。
                </div>
                <div>
                    &nbsp;&nbsp;&nbsp;&nbsp;2.支持一次读取多个文件。
                </div>
                <div>
                    &nbsp;&nbsp;&nbsp;&nbsp;3.文件名的格式要求：长宽的单位必须是厘米。
                </div>
                <div>
                    &nbsp;&nbsp;&nbsp;&nbsp;4.长/宽/数量三个数字的连接符号可以是杠（-）乘（X或x）星号（*）或空格。
                </div>
                <div>
                    &nbsp;&nbsp;&nbsp;&nbsp;例如：110-120x5或110-120-5或110x120 5等自由组合。
                </div>
                <br>
                <div c-widget="button; class:basic; color:blue; caption:上传文件;click:openHideUpload"></div>
                <span c-bind="uploadNote"></span>
                <!--<button>上传</button>-->
                <input type="file" id="fileButton" style="display: none" multiple="multiple"
                       c-onchange="preview(this)"/><br>
            </div>
            <div id="upload_box" style="margin-top: 2rem;margin-left: 1rem;display: inline-block;vertical-align: top">
                <ul style="margin: 0;padding: 0;list-style: none;display: inline-block">
                </ul>
                <ul style="margin:0 0 0 20px;padding: 0;list-style: none;display: inline-block;vertical-align: top">
                </ul>
            </div>
        </div>

        <div style="margin-top: 3rem;text-align: right">
            <div c-widget="button; caption:取消;click:closeUpload" style="background: #DEE1E2;"></div>
            <div c-widget="button;class:blue;caption:确定;click:saveUploadName"></div>
        </div>
    </div>
</div>

<!--物料/制作/说明弹出框 start-->
<div id="topBarPR" c-widget="Sidebar; direction:top;size:650;" class="segment show-on-ready">


    <article style="text-align: center;border-bottom: 1px solid grey;font-size: 1.25rem;padding: 1.2rem 0">
        请选择本次订单的物料/制作/说明 <span style="color: #ff0000; font-size: 12px; margin-left: 15px;">(需要预先在基础资料里进行价格编辑)</span>
    </article>
    <div class="ui tabular menu"></div>
    <div id="priceTable"></div>
    <div style="margin-top: 2rem">
        <div style="display: inline-block">
            <article><span style="color: #ff0000;">单行 : </span>仅为当前明细行使用的物料/制作/说明 <span
                    style="color: #ff0000;">全选 : </span> 仅为当前明细行及以下本类所有明细行使用该物料/制作/说明
            </article>
        </div>
        <div style="float: right">
            <div c-widget="button; caption:取消;click:closeProReq" style="background: #DEE1E2;"></div>
            <div c-widget="button;class:blue;caption:单行;click:testHard1"></div>
            <div c-widget="button;class:blue;caption:全选;click:testHard2"></div>
        </div>
    </div>
</div>
<%--点击“创建订单并收款”弹出确认页面--%>
<div class="ui  modal " id="createOrderPop" style="width: 660px;height: 480px;">
    <div class="header" style="font-size: 18px;color:#333;font-weight: normal;">
        创建订单并收款
    </div>
    <%--<div  style="text-align: center;margin:0 auto;" data-id="content">--%>
    <div style="    width: 500px;height: 30px;line-height: 30px;margin: 20px auto;border: 1px solid #ffcc00;font-size: 12px;color: #666;background-color: #ffffcc;text-align: center;">
        一次付清货款，“应收金额”即“实收金额”，系统直接生成已收款对账单
    </div>

    <p style="width: 360px; margin: 70px auto 20px; height: 30px; position: relative; text-align: right;">
        <span style="float:left;color:#666;font-size:14px;font-weight: 700;">订单金额：</span>
        <span style="    color: #666;font-size: 26px;font-family: arial;" id="orderMoney"></span>
        <input type="hidden" id="orderMoneyActual" value="">

        <i style="    color: #2e8ae6;font-size: 12px;margin-left: 10px;position: absolute;right: -66px;font-style: normal;cursor: pointer;"
           onclick="addShuiDian(this)">添加税点</i>
    </p>

    <div id="shuiDianCtrl"
         style="border: 1px solid rgb(204, 204, 204);width: 400px;padding: 20px 20px 0px;margin: 0px auto 20px;display: none;">
        <p style="    width: 360px;margin: 0 auto;height: 40px;"><span
                style="float:left;color:#666;font-size:14px;text-indent: 10px;">税率：</span><span
                style="float:right;color:#666;font-size:26px;">
                    <input type="text"
                           style="    font-size: 14px;border: 1px solid #ccc;text-indent: 10px;border-radius: 2px;width: 40px;height: 20px;vertical-align: middle;"
                           onkeyup="inputCalMoney(this)" maxlength="2"
                           id="rateNum" value="0"><i
                style="margin-left:5px;font-size: 16px;font-family: Arial;">%</i></span></p>
        <p style="width: 360px;margin: 0 auto;height: 40px;text-align: right;"><span
                style="float:left;color:#666;font-size:14px;text-indent: 10px;">税额：</span><span id="rateAmount"
                                                                                                style="color:#666;font-size:16px;">..</span>
        </p>
    </div>

    <p style="    width: 360px;border-top:1px solid #ccc; margin: 0 auto 74px; padding-top: 30px; height: 30px;"
       id="payAmoutBd"><span style="float:left;color:#666;font-size:14px;font-weight: 700;">应收金额：</span>
        <span id="payAmout" style="font-family:arial;float:right;color:#ff0000;font-size:26px;"></span></p>
    <div class="actions"
         style="padding-bottom:30px;padding-right: 82px;background: none;border-top:none;position: absolute; right: 0; bottom: 0;">
        <div class="ui deny button">
            取消
        </div>
        <div class="ui primary approve button">
            创建
        </div>
    </div>
</div>

<script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
<script src="/resources/business/base_new.js?v=9ac481258d"></script>
<script src="/resources/easyui/pace.min.js?v=cdbdd88ddf"></script>
<script src="/resources/jquery/jquery.cookie.js?v=1bf09dac64"></script>
<script src="/resources/cola-ui/3rd.min.js?v=59f8ac5b1a"></script>
<script src="/resources/cola-ui/semantic.min.js?v=ce263d5009"></script>
<script src="/resources/cola-ui/cola.min.js?v=96274d219a" charset="UTF-8"></script>
<script src="/resources/common/common.js?v=4df22f7427"></script>
<script src="/resources/pageConfig.js?v=d1935279f7"></script>
<%--请保持下面两个js文件加载顺序--%>
<script type="text/javascript">
    var purchaseNo = '${purchaseNo}';
    cola.purchaseNo = purchaseNo;
    var salesNo = getRequestParam.GetRequest().salesNo;
    if (!salesNo) {
        // 测试数据
        salesNo = "";
    }
</script>
<script src="/resources/business/dzorder/purchase-order/update_wx.js?v=07d3ad46ab"></script>
<script>
    function addShuiDian(o) {
        if ($(o).text() == "添加税点") {
            $("#shuiDianCtrl").slideDown();
            $(o).text("撤销税点");
            $("#payAmoutBd").css("border", "none")
        } else if ($(o).text() == "撤销税点") {
            $("#rateAmount").text("0");
            $("#rateNum").val("0");
            $("#payAmoutBd").css("border-top", "1px solid #ccc");
            $("#payAmout").text(accounting.formatNumber($("#orderMoneyActual").text(), 2));
//            $("#payAmout").text(Number($("#orderMoney").text()).toFixed(2));
            $("#shuiDianCtrl").slideUp();
            $(o).text("添加税点")
        }
    }
    function inputCalMoney(o) {
        if (isNaN($(o).val())) {
            $("#rateAmount").text("0");
            $("#rateNum").val("0");
//            $("#payAmout").text(Number($("#orderMoney").text()).toFixed(2));
            $("#payAmout").text(accounting.formatNumber($("#orderMoneyActual").text(), 2));
            return;
        }

        $("#rateAmount").text(accounting.formatNumber((Number($("#rateNum").val()) * Number($("#orderMoneyActual").text())).toFixed(0) / 100, 2));
//        $("#rateAmount").text(Number(Number($("#rateNum").val())*Number($("#orderMoney").text())).toFixed(0)/100);
        $("#payAmout").text(accounting.formatNumber(Number($("#orderMoneyActual").text()) * (1 + Number($("#rateNum").val()) / 100), 2));
//        $("#payAmout").text(Number(Number($("#orderMoney").text())+Number($("#rateAmount").text())).toFixed(2));
    }
    cola(function (model) {
        //折扣优惠
        $(".sales-btn").on("click", function () {
            model.set("order.sales", 0);
        });
        //减免金额
        $(".minus-btn").on("click", function () {
            model.set("purchaseOrder.preferential", 0);
        });
        //预收金额
        $(".earnest-btn").on("click", function () {
            model.set("purchaseOrder.depositRequested", 0);
        });
    });
</script>
</body>
</html>