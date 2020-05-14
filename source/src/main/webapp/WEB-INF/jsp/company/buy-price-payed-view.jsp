<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
 <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
 <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
 <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
 <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
 <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <link rel="stylesheet" type="text/css" href="/resources/business/order-table.css?v=7367cb39d5">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">         <%--//全局图标样式--%>
    <style>
        .ui.buttons.tiny{
            border:1px solid #e4e4e4;
            border-radius: 3px;
        }
        .ui.button{
            background: none !important;
            font-size:12px;
            font-weight:normal;
            border-left:1px solid #e4e4e4;
        }
        .ui.blue.active.button{
            background: #2e8ae6 !important;
        }
        .ui.button:hover{
            color: #2e8ae6 !important;
        }
    </style>

    <script type="text/javascript">
        cola(function (model) {

            model.describe("rentalPeriod",{
                provider:"<c:url value="/payment/getRentalEndTime"/>"
            })

            $(".ui.dropdown").dropdown();
            model.set("shouldPay","￥0.00");
            model.set("discount","￥0.00");
            model.set("actualPay","￥0.00");
            model.describe("countries", {
                provider: "<c:url value="/json/countries.json"/>"
            });
            //业务代码组
            var businessCode;
            //使用时长
            var duration = 6;
            //抵用卷代码
            var voucherNo;

            //table1的总和
            var table1Num;
            //table1的总和
            var table2Num;
            //两项总计
            var totalNum;
            //半年费用
            var halfYear;
            //1年费用
            var oneYear;
            //2年费用
            var twoYear;
            //3年费用
            var threeYear;
            //获取业务定价具体数据
            model.describe("bp", {

                provider: "<c:url value="/json/businessPriceCom.json"/>"
            });
            //

            //计算两项的总和
            function totalSum(){

                totalNum = (parseFloat(table1Num) + parseFloat(table2Num)).toFixed(2);
                $("#allNumView").text("￥"+totalNum);
            }

            //table1的总和
            function table1Sum() {
                var cols = $("td[name='table1Price']");
                var table1NumC = 0;
                cols.each(function (index) {
                    var num = $(this).text();
                    if(!isNaN(num) && num != undefined && $.trim(num) != ""){
                        var count = parseFloat(num);
                        table1NumC = table1NumC + count;
                    }
                })
                var  table1NumC = table1NumC.toFixed(2)
                table1Num = table1NumC;
                $("#table1Num").val(table1Num);
                $("#table1NumView").text("￥："+table1Num);
            }

            //table2的总和
            function table2Sum() {
                var operations2 = parseFloat($("td[name='operations2']").text());
                var operations3 = parseFloat($("td[name='operations3']").text());

                var  table1NumC = operations2+operations3;
                table2Num = table1NumC.toFixed(2);
                $("#table2Num").val(table2Num);
                $("#table2NumView").text("￥："+table2Num);
            }


            model.get("bp",function (bp) {

                var tbody = $("#table1 tbody");
                var table2 = $("#table2");
                var tbody2 = $("<tbody></tbody>");
                table2.append(tbody2);
                bp.each(function(b,i){
                    //获取 添加的客户数  和 可使用系统的客户数
                    if(i > 2){

                        var businessName = b.get("businessName");
                        //todo
                        var businessPriceInits = b.get("busiPriceComVos");
                        var businessUnit = b.get("businessUnit");
                        var tr  = $("<tr></tr>");
                        var td1 = $('<td style="color: black">'+businessName+'</td>');
                        tr.append(td1);
                        //
                        var td2 = $('<td></td>');
                        var buttongroup = $(cola.xRender("<div c-widget='ButtonGroup; size:tiny;tag:table2Tag'>"));
                        td2.append(buttongroup);
                        var tagNum;
                        var operations;
                        businessPriceInits.each(function (bpi,j) {
                            var businessCode = bpi.get("businessCode");
                            var businessName  = bpi.get("businessName");
                            var businessPrice = bpi.get("businessPrice");
                            var viewBB = businessName+"(￥:"+businessPrice+")";
                            var fragment

                            if(i==3){
                                tagNum = "op2";
                                operations = "operations2";
                            }
                            if(i==4){
                                tagNum = "op3";
                                operations = "operations3";
                            }
                            var buttonData ={
                                businessCode : businessCode,
                                businessPrice : businessPrice
                            };

                            if(j==0){
                                fragment = cola.xRender("<div c-widget='#"+operations+"; caption:"+viewBB+";userData:"+ JSON.stringify(buttonData)+";color:grey;class:active blue;tag:"+tagNum+"'data-value="+businessCode+">", model);
                            }else{
                                fragment = cola.xRender("<div c-widget='#"+operations+"; caption:"+viewBB+";userData:"+ JSON.stringify(buttonData)+";tag:"+tagNum+"' data-value="+businessCode+">", model);
                            }
                            buttongroup.append(fragment);
                        })
                        tr.append(td2);
                        var td3 = $('<td class="center aligned" style="color: black">'+businessUnit+'单价</td>');
                        tr.append(td3);

                        var td4 = $('<td class="center aligned"><i class="red check circle icon large"></i></td>');
                        tr.append(td4);

                        var td5 = $('<td class="center aligned" style="color: #00B5AD" name="'+operations+'">5</td>');
                        tr.append(td5);
                        tbody2.append(tr);
                    }else{

                        var businessName = b.get("businessName");
                        //todo
                        var businessPriceInits = b.get("busiPriceComVos");
                        var businessDesc = b.get("businessDesc");
                        businessPriceInits.each(function(bpi,j){
                            var tr  = $("<tr></tr>");
                            //

                            if(j==0){
                                var entityCount = businessPriceInits.entityCount;
                                var td1 = $('<td rowspan="'+entityCount+'" style="color: black">'+businessName+'<br/>--'+businessDesc+'</td>');
                                tr.append(td1);
                            }
                            var td2 = $('<td>'+bpi.get("businessName")+'<span style="margin-left: 40px">'+bpi.get("businessDesc")+'</span></td>');
                            tr.append(td2);
                            var td3 = $('<td class="center aligned">'+bpi.get("businessPrice")+'</td>');
                            tr.append(td3);
                            //<i class="red check circle icon large"></i>
                            var td4 = $('<td class="center aligned"></td>');
                            var checkbox;
                            if(bpi.get("isChecked") == "1"){
                                checkbox = $(cola.xRender("<div c-widget='#checkbox;checked:true;tag:table1Tag;disabled:true;userData:"+bpi.get("businessCode")+"'>", model));
                            }else{
                                checkbox = $(cola.xRender("<div c-widget='#checkbox;tag:table1Tag;disabled:true;userData:"+bpi.get("businessCode")+"'>", model));
                            }


                            td4.append(checkbox);
                            tr.append(td4);
                            var td5 = $('<td class="center aligned" style="color: #00B5AD" name="table1Price">'+bpi.get("businessPrice")+'</td>');
                            tr.append(td5);
                            tbody.append(tr);

                        })
                    }
                })
                table1Sum();
                table2Sum();
                totalSum();
            });


            model.widgetConfig({
                operations: {
                    $type: "button",
                    click: function(self, arg) {
                        var ops = cola.tag("op")
                        for(var i = 0; i < ops.length; i++) {
                            var op = ops[i]
                            op.get$Dom().removeClass("active blue")
                        }

                        self.get$Dom().addClass("active blue")
                    }

                },
                operations2: {
                    $type: "button",
                    click: function(self, arg) {

                    }

                },
                operations3: {
                    $type: "button",
                    click: function(self, arg) {

                    }
                },
                operations4: {
                    $type: "button",
                    click: function(self, arg) {
                        var ops = cola.tag("op4")
                        for(var i = 0; i < ops.length; i++) {
                            var op = ops[i]
                            op.get$Dom().removeClass("active");
                            op.get$Dom().addClass("basic");

                        }

                        var userData = eval("("+self._userData+")");
                        duration = userData.month;
                        var count = parseFloat(userData.money).toFixed(2);

                        model.set("shouldPay","￥"+count);
                        //去掉￥
                        var discount = model.get("discount");
                        var discountNum = discount.substr(1,discount.length);
                        model.set("actualPay","￥"+(count - discountNum).toFixed(2));

                        self.get$Dom().removeClass("basic");
                        self.get$Dom().addClass("active");
                    }
                },
                checkbox: {
                    $type: "checkbox",
                    change: function(self, arg) {
                        if (arg.value) {
                            self.get$Dom().parent("td").next().text( self.get$Dom().parent("td").prev().text());
                        } else {
                            self.get$Dom().parent("td").next().text("0");
                        }
                        table1Sum();
                        totalSum();
                    }
                },
                dropdownDrop: {
                    $type: "dropdown",
                    items: "{{country in countries}}",
                    openMode: "drop"
                }
            });
            model.action({
                pay:function(){
                    var table1Tags = cola.tag("table1Tag");
                    var table2Tags = cola.tag("table2Tag");

                    $(table1Tags).each(function (i) {
                        var bCode = this.get("userData");
                        if(bCode == null || bCode== undefined || bCode == "" || !this.get("checked")){
                            return;
                        }
                        if(i==0){
                            businessCode = bCode;
                        }else{
                            businessCode = businessCode + "," + bCode;
                        }

                    })

                    $(table2Tags).each(function(i){
                        var bntGroup = this.get$Dom();
                        var bnt =  bntGroup.find("div.active");

                        businessCode = businessCode +","+bnt.data("value");

                    })


                    //model.set("actualPay","￥"+(discountNum - discount).toFixed(2));
                    var shouldPay = model.get("shouldPay");
                    var discountNum = shouldPay.substr(1,shouldPay.length);
                    var actualPayStr = model.get("actualPay");
                    var actualPayNum = actualPayStr.substr(1,actualPayStr.length);


                    var postUrl = "<c:url value="/payment/renewPay"/>";//提交地址
                    //var comKey = comList[0].comKey;//第一个数据
                    var ExportForm = document.createElement("FORM");
                    document.body.appendChild(ExportForm);
                    ExportForm.method = "POST";
                    var newElement1 = document.createElement("input");
                    newElement1.setAttribute("name", "duration");
                    newElement1.setAttribute("type", "hidden");
                    ExportForm.appendChild(newElement1);
                    newElement1.value = duration;

                    var newElement2 = document.createElement("input");
                    newElement2.setAttribute("name", "businessCodeIn");
                    newElement2.setAttribute("type", "hidden");
                    ExportForm.appendChild(newElement2);
                    newElement2.value = businessCode;

                    var newElement3 = document.createElement("input");
                    newElement3.setAttribute("name", "voucherNo");
                    newElement3.setAttribute("type", "hidden");
                    ExportForm.appendChild(newElement3);
                    newElement3.value = voucherNo;

                    var newElement4 = document.createElement("input");
                    newElement4.setAttribute("name", "rentalMoney");
                    newElement4.setAttribute("type", "hidden");
                    ExportForm.appendChild(newElement4);
                    newElement4.value = discountNum;

                    var newElement5 = document.createElement("input");
                    newElement5.setAttribute("name", "actualPayNum");
                    newElement5.setAttribute("type", "hidden");
                    ExportForm.appendChild(newElement5);
                    newElement5.value = actualPayNum;

                    var newElement6 = document.createElement("input");
                    newElement6.setAttribute("name", "rentalKey");
                    newElement6.setAttribute("type", "hidden");
                    ExportForm.appendChild(newElement6);
                    newElement6.value = model.get("rentalKey");

                    ExportForm.action = postUrl;
                    ExportForm.submit();


                },
                payDailog: function() {
                    //获取每月的总计
                    //totalNum
                    //半年
                    halfYear = totalNum*6;
                    //1年费用
                    oneYear = totalNum*12*0.95;
                    //2年费用
                    twoYear = totalNum*12*2*0.9;
                    //3年费用
                    threeYear = totalNum*12*3*0.85;
                    $("#diaTotalSum").text("每月"+totalNum+"元");
                    var dbgl = $("#diaBtnGroup");
                    dbgl.text("");
                    var lable = $("<label>选择以下一种进行支付</label>");
                    dbgl.append(lable);
                    var buttongroup = $(cola.xRender("<div c-widget='ButtonGroup;'>"));
                    lable.append(buttongroup);
                    dbgl.append(buttongroup);

                    //#operations4
                    var fragment1 = $(cola.xRender("<div c-widget='#operations4;class:active;color:blue;caption:"+halfYear+"元/半年;userData:{money:"+halfYear+",month:6};width:200px;tag:op4;'>"));
                    var fragment2 = $(cola.xRender("<div c-widget='#operations4;class:basic;color:blue;caption:"+oneYear+"元/1年(95折);userData:{money:"+oneYear+",month:12};width:200px;tag:op4'>"));
                    var fragment3 = $(cola.xRender("<div c-widget='#operations4;class:basic;color:blue;caption:"+twoYear+"元/2年（9折）;userData:{money:"+twoYear+",month:24};width:200px;tag:op4'>"));
                    var fragment4 = $(cola.xRender("<div c-widget='#operations4;class:basic;color:blue;caption:"+threeYear+"元/3年（85折）;userData:{money:"+threeYear+",month:36};width:200px;tag:op4'>"));
                    model.set("shouldPay","￥"+halfYear.toFixed(2));
                    buttongroup.append(fragment1);
                    buttongroup.append(fragment2);
                    buttongroup.append(fragment3);
                    buttongroup.append(fragment4);


                    var voucherList =  $("#voucherList");
                    var voucherLable = $("");
                    voucherList.append(voucherLable);

                    var sltMenu = $(".ui.dropdown").find(".menu");
                    model.get("countries",function (vouchers) {

                        voucherList.find("label").find("span").text(vouchers.entityCount);
                        vouchers.each(function(vou,i){
                            var mDiv =$('<div class="item" data-value="'+vou.get("value")+'">'+vou.get("text")+'</div>');
                            sltMenu.append(mDiv);
                        })
                    });


                    $("#payDialog").modal("show");
                },
                change:function(){
                    alert("sss");
                }




            });
            var sltMenu2 = $(".ui.dropdown").find(".menu");
            sltMenu2.on("click",function(a){
                var discount =  a.toElement.dataset.value;
                var voucherNoStr = a.toElement.innerText;
                voucherNo = voucherNoStr.substr(0,voucherNoStr.indexOf("，"));

                model.set("discount","￥"+discount);

                var shouldPay = model.get("shouldPay");
                var discountNum = shouldPay.substr(1,shouldPay.length);
                model.set("actualPay","￥"+(discountNum - discount).toFixed(2));


            })

        });
    </script>
    
<title>已购产品使用中的查看</title>
</head>
<body style="padding: 10px;overflow-x: auto">


<div class="ui form">
    <%--<div class="ui fields">--%>
        <%--<div class="ui field">--%>
            <%--<h4>您现在处于：<span style="color: #FFA466;">付费期        </span></h4>--%>
        <%--</div>--%>
        <%--<div class="ui field">--%>
            <%--<h4 style="margin-left: 30px">许可到期时间：<span style="color: #FFA466;" c-bind="rentalPeriod.endDate"></span></h4>--%>
        <%--</div>--%>
        <%--<div class="ui field">--%>
            <%--<h4 style="margin-left: 30px">可用功能：<span style="color: #FFA466;">勾选的功能      </span></h4>--%>
        <%--</div>--%>
        <%--&lt;%&ndash; <div class="ui field">--%>
             <%--<h4 style="margin-left: 30px">提示：您可以直接为当前功能配置续费，也可以修改配置后再续费。</h4>--%>
         <%--</div>&ndash;%&gt;--%>
    <%--</div>--%>
    <%--<div class="ui divider"></div>--%>
    <%--<div style="color: #999999">--%>
        <%--提示：您可以直接为当前功能配置续费，也可以修改配置后再续费。--%>
    <%--</div>--%>
<%--</div>--%>

<%--<h4>--%>
    <%--管理功能选择组合--%>
<%--</h4>--%>

<div class="all-pay">
    您现在处于:  <span>付费期</span>
    许可到期时间:  <span c-bind="rentalPeriod.endDate"></span>
    可用功能:  <span>勾选的功能</span>
</div>


<div class="all-pay">
    <p>提示：您可以直接为当前功能配置续费，也可以修改配置后再续费。</p>
    管理功能选择组合
</div>


<table id="table1" class="ui celled structured table">
    <thead>
    <tr>
        <th style="color: black">业务分类/描述（一级菜单）</th>
        <th style="color: black">功能分类/功能描述（二级菜单）</th>
        <th class="center aligned" width="100px">月单价</th>
        <th class="center aligned" width="100px">请勾选</th>
        <th class="center aligned" width="100px">单项费用</th>
    </tr>
    </thead>
    <tbody>

    </tbody>
</table>



<div style="float:right;font-weight: bolder">
    <input id="table1Num" type="hidden" value=""/>
    <table>
        <tr>
            <td style="width: 90px;text-align: right">小计/每月</td>
            <td id="table1NumView" style="width: 120px;text-align: right">¥90.00</td>

        </tr>
    </table>
    <div class="ui divider"></div>
</div>


<h4 style="margin-top: 60px">
    管理功能选择组合
</h4>
<table id="table2" class="ui table">
</table>

<div style="float:right;font-weight: bolder">
    <input id="table2Num" type="hidden"/>
    <input id="allNum" type="hidden"/>
    <table>
        <tr>
            <td style="width: 90px;text-align: right">小计/每月</td>
            <td id="table2NumView" style="width: 120px;text-align: right">¥10.00</td>
        </tr>
    </table>
    <div class="ui divider"></div>
    <table style="font-weight: bolder">
        <tr>
            <td style="width: 90px;text-align: right">两项合计/每月</td>
            <td id="allNumView" style="width: 120px;text-align: right">¥140.00</td>
        </tr>
    </table>
    <div class="ui divider"></div>
    <div style="margin-top:120px; padding-bottom: 30px">
        <div c-widget="button; caption:更改功能再继费; class:orange right floated;width:182" style="background:#2e8ae6 !important;"
             onclick="window.location.href='<c:url value="/payment/changeFunction"/>'"></div>

        <div c-widget="button; caption:当前功能配置直接继费; class:green right floated; click:payDailog" style="margin-right: 10px; background:#2e8ae6 !important;"></div>
    </div>

</div>



<!--支付对话框-->
<div id="payDialog" class="ui test long scrolling medium modal">
    <div class="header">
        费用支付
    </div>
    <div class="content" style="height: 580px">
        <div class="ui form">
            <div class="field">
                <label>您刚才选择的功能合计<span style="color:#ff9812; font-size: 1.1em" id="diaTotalSum">每月120元</span></label>
            </div>
            <div id="diaBtnGroup" class="field">

            </div>
            <div id="voucherList" class="field">
                <label>使用代金券 <span>0</span>张可用</label>

                <div class="ui selection dropdown" style="width: 300px">
                    <input type="hidden" name="range">
                    <i class="dropdown icon"></i>
                    <div class="default text" data-value=""></div>
                    <div class="menu"></div>
                </div>



            </div>
            <div class="field">
                <label>费用总计</label>
                <div style="width:220px; border: 1px solid #CEA489; padding: 10px; background-color: #FBE6E6">
                    <table>
                        <tr>
                            <td style="width: 76px">应付费用</td>
                            <td style="width: 120px;text-align: right" c-bind="shouldPay"></td>
                        </tr>
                        <tr>
                            <td style="width: 76px">代金券抵扣</td>
                            <td style="width: 120px;text-align: right" c-bind="discount"></td>
                        </tr>
                    </table>
                    <div class="ui divider"></div>
                    <table>
                        <tr>
                            <td style="width: 76px">还需支付</td>
                            <td style="width: 120px;text-align: right;color:#ff9812; font-size: 1.1em" c-bind="actualPay"></td>
                        </tr>
                    </table>
                </div>

            </div>
            <div class="field">
                <label>发票申请</label>
                <p>请在“企业账户中心”相关处申请发票</p>
            </div>
            <div class="field">
                <label>选择支付方式</label>
                <div c-widget="button;class:green basic;caption:支付宝(建议);width:150px;click:pay"></div>
                <div c-widget="button;class:green basic;caption:微信;width:150px;click:pay"></div>
            </div>

        </div>
    </div>
</div>


</body>
</html>