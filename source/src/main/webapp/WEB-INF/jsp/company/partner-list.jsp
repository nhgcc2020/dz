<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script src="/../resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/business/order-table.css?v=7367cb39d5">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">         <%--//全局图标样式--%>
    <style type="text/css">
        .disabled_block > input{
            background-color: gainsboro
        }

        .disabled_block > input {
            background-color: gainsboro!important;
        }
        thead tr th{
            background-color: #F4F4F4 !important;
        }

        .ui.widget-table table tbody td > div {
            padding: 0.6em 0.4em !important;
        }
        .hide-cust{
            display: none !important;
        }
    </style>
    <script type="text/javascript">

        cola(function(model) {

            function GetQueryString(name){
                var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if(r!=null)return  unescape(r[2]); return null;
            }

            var type = GetQueryString("type");
            var para = {};
            if(type == "2"){
                $("#friendOptions").remove();
                para.partnerStatus  = "1";
            }
            if(type == "3"){
                $("#friendOptions").remove();
                para.partnerStatus  = "0";
            }

            $("#addCustomer").find(".dropdown").dropdown({transition: 'drop'});
            $(".ui.teal.buttons.dropdown").dropdown({transition: 'drop'});

            model.describe("items", {
                provider: {
                    url: "<c:url value='/system/partner/partnerList'/>",
                    parameter:para,
                    complete:function(){
                        $(".loading_box").removeClass("loadingssss");
                    }
                }
            });
            var items = model.get("items","sync");
            model.set("totalParten",model.get("items").totalEntityCount);
            model.set("friendOptions",[
                {"text":"全部","value":"ALL"},
                {"text":"好友","value":"1"},
                {"text":"非好友","value":"0"}
            ]);
            model.set("partnerOptions",[
                {"text":"全部","value":"ALL"},
                {"text":"重点客户","value":"1"},
                {"text":"普通客户","value":"2"},
                {"text":"零散客户","value":"3"}
            ]);
            model.widgetConfig({
                friendOptions: {
                    $type: "dropdown",
                    items: "{{item in friendOptions}}",
                    openMode: "drop",
                    valueProperty: "value",
                    textProperty: "text",
                    tag:"friendOptions",
                    icon:"dropdown icon iconfont",
                    value:"ALL"
                },
                partnerDp: {
                    $type: "dropdown",
                    items: "{{item in partnerOptions}}",
                    openMode: "drop",
                    valueProperty: "value",
                    textProperty: "text",
                    tag:"partnerDp",
                    icon:"dropdown icon iconfont",
                    value:"ALL"
                },

                templateList: {
                    $type: "listView",
                    bind: "company in companies"
                },
                customerTable: {
                    $type: "Table",
                    bind: "item in items",
                    "class": "celled compact",
                    showHeader: true,
                    columns: [
                        {
                            $type: "select"
                        },
                        {
                            caption: "简称/品牌",
                            bind: ".partnerShortname",
                            align: "center",
                            template: "oddNumbersTemplate"

                        },
                        {
                            caption: "客户分类",
                            bind: ".partnerLevelValue",
                            align: "center"
                        },
                        {
                            caption: "好友关系",
                            bind: ".statusValue",
                            align: "center"
                        }, {
                            caption: "企业属性",
                            bind: ".partnerAttrValue",
                            align: "center"
                        }, {
                            caption: "助记码",
                            bind: ".mnemonicCode",
                            align: "center"
                        },
                        {
                            caption: "企业对账号",
                            bind: ".comId",
                            align: "center"

                        },
                        {
                            caption: "联系人",
                            bind: ".contacterName",
                            align: "center"
                        },
                        {
                            caption: "联系电话1",
                            bind: ".tel1",
                            align: "center"
                        },
                        {
                            caption: "公司电话",
                            bind: ".partnerTel",
                            align: "center"
                        },
                        {
                            caption: "公司QQ",
                            bind: ".partnerQQ",
                            align: "center"

                        },
                        {
                            caption: "创建日期",
                            bind: ".createTime",
                            align: "center",
                            width:"160px"
                        }/*,
                        {
                            bind: ".partnerStatus",
                            width: "120px",
                            align: "center",
                            caption: "操作",
                            template: "operations"
                        }*/
                    ]
                }
            });
            model.action({
                query:function (data) {
                    var searchTag = cola.tag("searchTag");
                    var paras = model.get("items")._providerInvoker.invokerOptions.data;
                    var searchKey = searchTag[0].get("value");

                    var partnerDp = cola.tag("partnerDp");
                    if(partnerDp.length > 0 && partnerDp[0].get("value") != "ALL"){
                        paras.partnerLevel = partnerDp[0].get("value");
                    }else {
                        paras.partnerLevel = undefined;
                    }
                    var friendOptions = cola.tag("friendOptions");
                    if(friendOptions.length > 0 && friendOptions[0].get("value") != "ALL"){
                        paras.partnerStatus = friendOptions[0].get("value");
                    }else{
                        paras.partnerStatus = undefined;

                    }
                    if(type == "2"){
                        paras.partnerStatus  = "1";
                    }
                    if(type == "3"){
                        paras.partnerStatus  = "0";
                    }
                    paras.searchKey = searchKey;
                    $(".loading_box").addClass("loadingssss");
                    model.describe("items",{
                        provider: {
                            url: "<c:url value='/system/partner/partnerList'/>",
                            method: 'post',
                            parameter: paras,
                            complete:function(){
                                $(".loading_box").removeClass("loadingssss");
                            }
                        }
                    });
                    model.flush("items");
                },

                //修改弹出框
                showModPartner:function(){

                    var sltArray = [];
                    var items = model.get("items");
                    items.each(function (element,index) {
                        if(element.get("selected")){
                            sltArray.push(element);
                        }
                    });
                    if(sltArray.length > 1){
                        $("<div class='tips_contants'>").fadeIn(250).html("每次只可修改单个合作伙伴").delay(3000).fadeOut(250).appendTo('body');
                        /*btn.set("disabled",false);
                        btn.set("state","");*/
                        return false;
                    }
                    if(sltArray == 0){
                        $("<div class='tips_contants'>").fadeIn(250).html("请勾选你需要修改的合作伙伴").delay(3000).fadeOut(250).appendTo('body');
                        /*btn.set("disabled",false);
                        btn.set("state","");*/
                        return false;
                    }
                    var partnerMod = sltArray[0];
                    if(partnerMod.get("partnerKey") == "temp-customer"){
                        $("<div class='tips_contants'>").fadeIn(250).html("过路客不可修改").delay(3000).fadeOut(250).appendTo('body');
                        return false;
                    }
                    var url;
                    if(partnerMod.get("partnerStatus") == "0"){
                        url = "/system/partner/modPage?partnerKey="+partnerMod.get("partnerKey");
                    }else{
                        url = "/system/partner/modPageFriend?partnerKey="+partnerMod.get("partnerKey");
                    }
                    $("#rightWinMod").find("iframe").attr("src",url);
                    var width =  $(window).width() -290;
                    cola.widget("rightWinMod").set("size",width);
                    cola.widget("rightWinMod").show();
                    /*btn.set("disabled",false);
                    btn.set("state","");*/
                },
                closeModPartner:function(){
                    $("#rightWinMod").find("iframe").attr("src","");
                    cola.widget("rightWinMod").hide();
                }



            });
            window.partnerModel = model;
        });

    </script>

</head>
<body style="padding: 10px;">

<div class="ui form">
    <div class="fields">
        <div id="friendOptions"></div>
        <div id="partnerDp"></div>
        <div class="field">
            <div c-widget="Input; width:20em;placeholder:输入客户名称或助记码; icon:search iconfont;iconPosition:left;tag:searchTag"></div>
        </div>
        <div class="field">
            <div id="addCustomer" >
                <div class="ui teal button" c-onclick="query()">搜索</div>
            </div>
        </div>

        <div class="field button-right">
            <div class="ui teal button" style="background: #dde1e2;color: #000;">删除</div>
            <div class="ui teal button" c-onclick="showModPartner()" >修改</div>
        </div>

    </div>
</div>

<div class="table_contant">
	<div class="box"><span></span></div>
    <table id="customerTable">

        <%--<template name="oddNumbersTemplate">--%>
            <%--<div>--%>
                <%--<a c-widget="link;bind:$default;href:###;content:{{$default}};click:{{showOrderDetail(item)}}" class="table-link-temp"></a>--%>
            <%--</div>--%>
        <%--</template>--%>

        <template name="operations">
            <div c-widget="button;class:primary;caption:添加好友;" style="padding:0 10px; height: 20px; font-size: 12px; line-height: 20px; font-weight: normal;" c-class="hide-cust:$default==1"></div>
                <%--c-style="padding: 0px 20px;display:{{item.partnerStatus}} == 0?'':'none'"--%>
                    <%--<div c-bind="item.partnerStatus" ></div>--%>
                <%--<div c-widget="menuButton;icon:configure">
                <div c-widget="Menu">
                    <a class="item">修改</a>
                    <a class="item">删除</a>
                    <a class="item">短信邀请</a>
                    <a class="item">QQ邀请</a>
                </div>
            </div>--%>
        </template>
    </table>

</div>

<div class="page_fix">

    <%--这个是加载框，切勿修改--%>
    <div class="loadingssss loading_box"><span></span></div>


    <div id="order2Pager"  class="order-Pager"></div>
    <div style="font-weight: bolder;width: 50%;line-height: 50px;">
        <span class="total_all">本页合计:</span>
        好友数(位)：
        <span style="color: red;margin-right: 15px;" c-bind="totalParten"></span>
    </div>

</div>

<div id="rightWinMod" c-widget="Sidebar;dimmerClose:false; direction:right;" class="segment">
    <iframe style="width: 100%;height: 100%" src=""></iframe>
</div>

<!--订单详情-->
<div id="rightWin" c-widget="Sidebar; direction:right;" class="segment">
    <iframe style="width: 100%;height: 100%" src=""></iframe>
</div>

<script>
    $('.table_contant, .table_contant>table').height($(document.body).height()-88);
    $('.table_contant>table').css('overflow-x','scroll');
    $(window).bind("resize", function(e){
        $('.table_contant, .table_contant>table').height($(document.body).height()-88)
    });

    $(".table_contant").on("click",".table-link-temp",function(){
        $(this).parentsUntil(".table_contant").find(".table-link-temp").removeClass("clikcBTn");
        $(this).addClass("clikcBTn");
    });
</script>

</body>
</html>
