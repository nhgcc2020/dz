<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <!--将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面：-->
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta charset="UTF-8">
    <title>易对账</title>
    <link rel="stylesheet" type="text/css" href="/resources/nprogress/nprogress.css?v=b7ac70ebbe">
    <link rel="icon" href="favicon.ico" type="image/x-icon" >
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" >
    <script src="/resources/nprogress/nprogress.js?v=234c9db3ed"></script>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <link rel="stylesheet" type="text/css" href="/resources/common/common.css?v=076f5c8c95">
    <link rel="stylesheet" type="text/css" href="/resources/common/main.css?v=9e61f29840">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
    <%--//全局图标样式--%>
</head>
<body>
<script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
<script src="/resources/jquery/jquery.cookie.js?v=1bf09dac64"></script>
<script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
<script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
<script src="/resources/cola-ui/cola.js?v=bd5fd42985" charset="UTF-8"></script>
<script src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
<style>
    .box2{
        display: none;
    }
</style>
<div class="searchSupplierContainer friend_box1 box1">
    <div class="yaoqingjiaweihaoyou">邀请加为好友 >
        <a class="iconfont not_tips" data-html="<div>如果对方
        <span style='color:orange'>没有使用易对账</span>，
        您可以通过
        <span style='color:orange'>邀请加为好友</span>
        在供应商名单中创建对方信息，然后再邀请对方注册，成为好友</div>"></a>
    </div>
    <p class="searchSupplierContainertitle">看看对方是否在使用易对账，搜索并添加</p>
    <p class="searchSupplierContainerinput">
        <input type="text" placeholder="请输入手机号码和企业名称" id="searchSupplierContainerinput">
        <button id="searchSupplierContainerbutton" disabled>搜索</button>
    </p>
    <p class="searchSupplierContainernone searchSuppliererror—hide" style="display: none;">很抱歉，没有搜索到您想要结果</p>
    <div class="searchSupplierContainerList">
        <div class="searchSupplierContainerListNum">
            <a class="searchPrve"><</a>
            <a class="searchnext">></a>
            <div id="searchSupplierContainerListNum">
                <ul id="searchSupplierContainerListNumUl">
                    <li class="active">
                        <h4>上海仁石科技有限公司</h4>
                        <p>易对账</p>
                        <p><span>金金金</span><span>18621619311</span></p>
                        <div class="searchSupplierHide">
                            <h1>个人版用户</h1>
                            <h3>无法成为您的供应商</h3>
                        </div>
                    </li>
                    <li class="active">
                        <h4>上海仁石科技有限公司</h4>
                        <p>易对账</p>
                        <p><span>金金金</span><span>18621619311</span></p>
                        <div class="searchSupplierHide">
                            <h1>企业版用户</h1>
                            <h3>无法成为您的供应商</h3>
                        </div>
                    </li>
                    <li class="action">
                        <h4>上海仁石科技有限公司</h4>
                        <p>易对账</p>
                        <p><span>金金金</span><span>18621619311</span></p>
                    </li>
                </ul>
            </div>
            <div class="searchSupplierContainerListicon" id="searchSupplierContainerListicon"></div>
        </div>
        <div class="searchSupplierContainerListCheck">
            <p class="searchSupplierCheckradio1">合作级别：
                <input type="radio" name="partnerLevel" id="searchSupplierradio3" value="1"><label
                        for="searchSupplierradio3">重点客户</label>
                <input type="radio" name="partnerLevel" id="searchSupplierradio4" value="2"><label
                        for="searchSupplierradio4">普通客户</label>
                <input type="radio" name="partnerLevel" id="searchSupplierradio5" value="3"><label
                        for="searchSupplierradio5">零散合作</label>
            </p>
        </div>
        <button class="searchSupplierContainerListbtn" disabled>申请加为好友</button>
    </div>
    <div class="searchSuppliererror searchSuppliererror—hide" style="color: #999999;line-height: 34px;">
        原因可能是：<br>
        1.输入信息有误<br>
        2.对方可能还没有使用易对账，您可以通过 页面右上角的<span style="color: #2e8ae6">邀请加为好友</span>功能 在您的供应商名单中创建企业信息，然后邀请对方注册，成为好友
    </div>
</div>

<div class="searchSupplierContainer box2">
    <h1 class="success_search_tip" c-bind="tips.title"></h1>
    <p class="success_search_view">好友申请状态可以通过 <span>客户列表</span> 列表去查看</p>
    <div class="success_search_btn">
        <button class="success_search_goon" c-bind="tips.operation">继续申请</button>
        <button class="success_search_list" c-onclick = "openCust()">客户列表</button>
    </div>
</div>

<div class="searchSupplierContainer friend_box2">
    <div class="yaoqingjiawei_back">< 申请加为好友</div>
    <p class="searchSupplierContainertitle">对方没有在使用易对账，您可以在客户名单中创建对方信息，邀请对方注册，再成为好友</p>
    <div>
        <ul class="friend_invent">
            <li class="active" data-value="1">企业</li>
            <li data-value="2">个人</li>
        </ul>
        <div class="friend_invent_company_list">
            <div class="friend_invent_company active">
                <ul class="friend_invent_company_form">
                    <li>
                        <span>企业全称</span>
                        <input type="text" c-bind="partner.partnerName" placeholder="请输入企业全称">
                    </li>
                    <li>
                        <span>联系人</span>
                        <input type="text" c-bind="partner.contacterName11" placeholder="请输入真实姓名">
                    </li>
                    <li>
                        <span>企业简称</span>
                        <input type="text" c-bind="partner.partnerShortname" c-onchange="getZJM()" placeholder="请输入企业简称">
                    </li>
                    <li>
                        <span>手机号码</span>
                        <input type="text" c-bind="partner.tel11" c-onchange="addQuery()" placeholder="请输入手机号码">
                    </li>
                    <li>
                    <span>助记代码 <i class="iconfont not_tips" data-html="<div>把客户信息简化成字母缩写，便于记忆;这样通过
        <span style='color:orange'>“助记代码”</span>，
        就可以在销售订单列表快速查找客户有关的所有
        <span style='color:orange'>订单</span></div>"></i>
                    </span>
                        <input c-bind="partner.mnemonicCode" type="text">
                    </li>
                </ul>
                <div class="friend_invent_company_form_check">
                    <p><span>合作级别<a class="iconfont not_tips" data-html="<div>如果对方<span style='color:orange'>没有使用易对账</span>，您可以通过<span style='color:orange'>邀请加为好友</span>在供应商名单中创建对方信息，然后再邀请对方注册，成为好友</div>"></a>：</span>
                        <input type="radio" name="radio2" value="1" id="friend_invent_company_form3">
                        <label for="friend_invent_company_form3">重点伙伴</label>
                        <input type="radio" name="radio2" value="2" id="friend_invent_company_form4">
                        <label for="friend_invent_company_form4">普通伙伴</label>
                        <input type="radio" name="radio2" value="3" id="friend_invent_company_form5">
                        <label for="friend_invent_company_form5">零散合作</label>
                    </p>
                    <p><span>邀请注册短信：</span>
                        <input type="radio" name="radio3" value="true" id="friend_invent_company_form6">
                        <label for="friend_invent_company_form6">发送</label>
                        <input type="radio" name="radio3" value="false" id="friend_invent_company_form7">
                        <label for="friend_invent_company_form7">暂不发送，以后再发</label>
                    </p>
                </div>
                <div class="friend_invent_btn">
                    <div c-widget="button; class:basic;click:cancel" style="width: 120px">取消</div>
                    <div c-widget="button; class:primary; caption:确认邀请;click:savePartnerCom" style="width: 120px"></div>
                </div>
            </div>
            <div class="friend_invent_company">
                <ul class="friend_invent_presonal_form">
                    <li>
                        <span>联系人</span>
                        <input type="text" c-bind="partner2.contacterName11" c-onchange="getZJM2()" placeholder="请输入真实姓名">
                    </li>
                    <li>
                        <span>手机号码</span>
                        <input type="text" c-bind="partner2.tel11" c-onchange="addQuery2()" placeholder="请输入手机号码">
                    </li>
                    <li>
                        <span>助记代码 <i class="iconfont not_tips" data-html="<div>把客户信息简化成字母缩写，便于记忆;这样通过<span style='color:orange'>“助记代码”</span>，就可以在销售订单列表快速查找客户有关的所有<span style='color:orange'>订单</span></div>"></i></span>
                        <input c-bind="partner2.mnemonicCode" type="text">
                    </li>
                </ul>
                <div class="friend_invent_company_form_check">
                    <p><span>合作级别<a class="iconfont not_tips" data-html="<div>如果对方<span style='color:orange'>没有使用易对账</span>，您可以通过<span style='color:orange'>邀请加为好友</span>在供应商名单中创建对方信息，然后再邀请对方注册，成为好友</div>"></a>：</span>
                        <input type="radio" name="radio4" value="1" id="friend_invent_preson_form3">
                        <label for="friend_invent_preson_form3">重点伙伴</label>
                        <input type="radio" name="radio4" value="2" id="friend_invent_preson_form4">
                        <label for="friend_invent_preson_form4">普通伙伴</label>
                        <input type="radio" name="radio4" value="3" id="friend_invent_preson_form5">
                        <label for="friend_invent_preson_form5">零散合作</label>
                    </p>
                    <p><span>邀请注册短信：</span>
                        <input type="radio" name="radio5" value="true" id="friend_invent_preson_form6">
                        <label for="friend_invent_preson_form6">发送</label>
                        <input type="radio" name="radio5" value="false" id="friend_invent_preson_form7">
                        <label for="friend_invent_preson_form7">暂不发送，以后再发</label>
                    </p>
                </div>
                <div class="friend_invent_btn">
                    <div c-widget="button; class:basic;click:cancel" style="width: 120px">取消</div>
                    <div c-widget="button; class:primary; caption:确认邀请;click:savePartnerUser" style="width: 120px"></div>
                    <%--<button class="yaoqingjiawei_back friend_invent_company_form_quxiao">取消</button>
                    <button>确认邀请</button>--%>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var comFalg = false;
    cola(function (model) {
        model.set("tips",{
            title:"申请成功",
            operation:"继续申请"
        });
        model.set("partner",{
            partnerName:"",
            contacterName11:"",
            partnerShortname:"",
            tel11:"",
            mnemonicCode:""
        });
        model.set("partner2",{

        });

        model.action({
            //
            openCust:function(btn){
                var config = {
                    closeable: "true",
                    icon: "icon dashboard",
                    label: "全部客户",
                    path: "/openPage?pageName=company_customer-list&type=1",
                    type: "subWindow"
                };
                App.open(config.path, config);
                window.parent.cola.widget("s1").hide();
            },
            //
            savePartnerUser:function (btn) {
                //var sendMsg = modle.get("partner.sendMsg");
                if(!comFalg){
                    $("<div class='tips_contants'>").fadeIn(250).html("校验不通过").delay(2000).fadeOut(250).appendTo('body');
                    return false;
                }
                btn.set("disabled",true);
                btn.set("state","loading");
                //个人
                model.get("partner2").set("partnerAttr", "2");
                //类型为客户
                model.get("partner2").set("partnerType","1");
                //合作级别
                var partnerLevel = $("input[name='radio4']:checked").val();
                model.get("partner2").set("partnerLevel", partnerLevel);
                //发送短信
                var sendMsg = $("input[name='radio5']:checked").val();
                model.get("partner2").set("sendMsg",sendMsg==="true");

                //简单校验
                //手机号是否合法
                var partner = model.get("partner2");
                var phone = partner.get("tel11");
                if(!(/^1[34578]\d{9}$/.test(phone))){
                    $("<div class='tips_contants'>").fadeIn(250).html("手机号码有误，请重填").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","");
                    return false;
                }

                var mnemonicCode = partner.get("mnemonicCode");
                if($.trim(mnemonicCode) == ""){
                    $("<div class='tips_contants'>").fadeIn(250).html("请填写助记代码").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","")
                    return false;
                }

                $.ajax({
                    type: "POST",
                    url: "/system/partner/savePartnerWithout",
                    data: partner,
                    async:"false",
                    dataType: "json",
                    success:function(callback){
                        if (callback.status == "1") {
                            $(".box1").fadeOut();
                            $(".box2").fadeIn();
                            $(".friend_box2").fadeOut();
                            model.set("tips",{
                                title:"添加成功",
                                operation:"继续添加"
                            });

                        }else{
                            $("<div class='tips_contants'>").fadeIn(250).html("添加失败:"+callback.msg).delay(2000).fadeOut(250).appendTo('body');

                        }

                    }
                });
            },
            //助记码2
            getZJM2:function(a,b,c){
                //var a = a.get("value");
                $.post("/tool/getPinYinHeadChar",{str:model.get("partner2.contacterName11")},function(data){
                    model.set("partner2.mnemonicCode",data);
                })
            },
            //新建合作伙伴时查询校验2
            addQuery2: function (ipt) {
                var keyword = model.get("partner2.tel11");
                //var phone = partner.get("phone");
                if(!(/^1[34578]\d{9}$/.test(keyword))){
                    $("<div class='tips_contants'>").fadeIn(250).html("手机号码有误，请重填").delay(2000).fadeOut(250).appendTo('body');
                    comFalg =false;
                    return false;
                }
                $.post(
                        "/system/partner/isRegistered",
                        {phone: keyword},
                        function (data) {

                            if (data) {
                                $("<div class='tips_contants'>").fadeIn(250).html("该公司已存在，请搜索后添加").delay(2000).fadeOut(250).appendTo('body');
                                //model.set("partner.tel11","");
                                comFalg =false;
                            }else{
                                comFalg =true;
                            }
                        })
            },
            //添加取消
            cancel:function(){
                $(".friend_box2").slideUp();
                $(".friend_box1").slideDown();
            },
            //助记码
            getZJM:function(a,b,c){
                //var a = a.get("value");
                $.post("/tool/getPinYinHeadChar",{str:model.get("partner.partnerShortname")},function(data){
                    model.set("partner.mnemonicCode",data);
                })
            },
            //新建合作伙伴时查询校验
            addQuery: function (ipt) {
                var keyword = model.get("partner.tel11");
                //var phone = partner.get("phone");
                if(!(/^1[34578]\d{9}$/.test(keyword))){
                    $("<div class='tips_contants'>").fadeIn(250).html("手机号码有误，请重填").delay(2000).fadeOut(250).appendTo('body');
                    comFalg =false;
                    return false;
                }
                $.post(
                        "/system/partner/isRegistered",
                        {phone: keyword},
                        function (data) {

                            if (data) {
                                $("<div class='tips_contants'>").fadeIn(250).html("该公司已存在，请搜索后添加").delay(2000).fadeOut(250).appendTo('body');
                                //model.set("partner.tel11","");
                                comFalg =false;
                            }else{
                                comFalg =true;
                            }
                        })
            },
            //新建公司合作伙伴
            savePartnerCom: function (btn) {
                //var sendMsg = modle.get("partner.sendMsg");
                if(!comFalg){
                    $("<div class='tips_contants'>").fadeIn(250).html("校验不通过").delay(2000).fadeOut(250).appendTo('body');
                    return false;
                }
                btn.set("disabled",true);
                btn.set("state","loading");
                //公司
                model.get("partner").set("partnerAttr", "1");
                //类型为客户
                model.get("partner").set("partnerType","1");
                //合作级别
                var partnerLevel = $("input[name='radio2']:checked").val();
                model.get("partner").set("partnerLevel", partnerLevel);
                //发送短信
                var sendMsg = $("input[name='radio3']:checked").val();
                model.get("partner").set("sendMsg",sendMsg==="true");

                //简单校验
                //手机号是否合法
                var partner = model.get("partner");
                var phone = partner.get("tel11");
                if(!(/^1[34578]\d{9}$/.test(phone))){
                    $("<div class='tips_contants'>").fadeIn(250).html("手机号码有误，请重填").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","");
                    return false;
                }
                var partnerName = partner.get("partnerName");
                if($.trim(partnerName)==""){
                    $("<div class='tips_contants'>").fadeIn(250).html("请填写公司全称").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","");
                    return false;
                }
                var partnerShortname = partner.get("partnerShortname");
                if($.trim(partnerShortname)==""){
                    $("<div class='tips_contants'>").fadeIn(250).html("请填写公司简称").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","")
                    return false;
                }

                var mnemonicCode = partner.get("mnemonicCode");
                if($.trim(mnemonicCode) == ""){
                    $("<div class='tips_contants'>").fadeIn(250).html("请填写助记代码").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","")
                    return false;
                }

                $.ajax({
                    type: "POST",
                    url: "/system/partner/savePartnerWithout",
                    data: partner,
                    async:"false",
                    dataType: "json",
                    success:function(callback){
                        if (callback.status == "1") {
                            $(".box1").fadeOut();
                            $(".box2").fadeIn();
                            $(".friend_box2").fadeOut();
                            model.set("tips",{
                                title:"添加成功",
                                operation:"继续添加"
                            });

                        }else{
                            $("<div class='tips_contants'>").fadeIn(250).html("添加失败:"+callback.msg).delay(2000).fadeOut(250).appendTo('body');

                        }

                    }
                });
            }
        })

    });
    //搜索供应商
    var slider_count = "";
    function SearchSupplier() {
        $(".secrchSupplierin").click(function () {
            $(".searchSupplierBox1").fadeIn()
        })
        $("#searchSupplierContainerinput").keydown(function () {
            if ($(this).val.length != 0) {
                $("#searchSupplierContainerbutton").css("background", "#2e8ae6").css("color", "#fff").removeAttr("disabled");
            }
        });

        //立即申请
        $(".searchSupplierContainerListbtn").click(function () {
            $(this).css("background","").attr("disabled","disabled");
            var partnerLevel =  cola.model().get("partnerLevel");
            var checkComKey =  cola.model().get("checkComKey");
            //改页面途径均为: 客户类型
            var partnerType = "1";
            $.ajax({
                url:"/system/partner/saveSltPartner",
                type:"POST",
                data:{
                    partnerLevel:partnerLevel,
                    partnerComKey:checkComKey,
                    partnerType:partnerType
                },
                async:false,
                success:function(callback){
                    var data = eval("("+callback+")");
                    if(data.status == "1"){
                        $(this).css("background", "#999");
                        $(".box1").fadeOut();
                        $(".box2").fadeIn();
                    }else{
                        $(".searchSuppliererror—hide").css("display", "block").html(data.msg);
                    }

                }
            });
        });


        //继续添加
        $(".success_search_goon").click(function () {
            $(".box1").fadeIn();
            $(".box2").fadeOut();
            $("#searchSupplierContainerinput").val("");
            $("#searchSupplierContainerbutton").css("background", "#999").attr("disabled", "disabled");
            $(".searchSupplierContainerList").css("display", "none");
            $(".searchSupplierContainerListbtn").css("background", "#999").attr("disabled", "disabled");
        });

        //关闭
        $(".searchSupplierClose").click(function () {
            $(".searchSupplierBox1").fadeOut();
            $(".searchSupplierBox2").fadeOut();
            $("#searchSupplierContainerinput").val("");
            $("#searchSupplierContainerbutton").css("background", "#999").attr("disabled", "disabled");
            $(".searchSupplierContainerList").css("display", "none");
            $(".searchSupplierContainerListbtn").css("background", "#999").attr("disabled", "disabled");
        })

        //点击搜索
        $("#searchSupplierContainerbutton").click(function () {
            var addQueryKey = $("#searchSupplierContainerinput").val();

            $.ajax({
                url: '/system/partner/getSupplierByKey',//
                type: 'GET',
                data:{
                    addQueryKey:addQueryKey
                },
                async: true,
                dataType: "json",
                success: function (data) {
                    $(".searchSuppliererror—hide").css("display", "none");

                    document.getElementById("searchSupplierContainerListNumUl").innerHTML = "";
                    document.getElementById("searchSupplierContainerListicon").innerHTML = "";
                    if(data.length == 0){
                        $(".searchSupplierContainerList").css("display", "none");
                        $(".searchSupplierContainernone").css("display", "block");
                        $(".searchSuppliererror").css("display", "block");
                        return false;
                    }else{
                        $(".searchSupplierContainerList").css("display", "block");
                        $("#searchSupplierContainerbutton").css("background", "#999").attr("disabled", "disabled");

                        $.each(data, function (key, val) {
                            if(data[key].partnerStatus == "1"){
                                document.getElementById("searchSupplierContainerListNumUl").innerHTML +=
                                        "<li class='active'>" +
                                        "<h4>" + val.comName + "</h4>" +
                                        "<p>" + val.comShortname + "</p>" +
                                        "<p><span>" + val.adminName + "</span><span>" + val.adminPhone + "</span></p>" +
                                        "<div class='searchSupplierHide'>" +
                                        "<h1>已经是您的好友</h1>" +
                                        "</div></li>"
                            }if(data[key].partnerStatus == "2"){
                                document.getElementById("searchSupplierContainerListNumUl").innerHTML +=
                                        "<li class='active'>" +
                                        "<h4>" + val.comName + "</h4>" +
                                        "<p>" + val.comShortname + "</p>" +
                                        "<p><span>" + val.adminName + "</span><span>" + val.adminPhone + "</span></p>" +
                                        "<div class='searchSupplierHide'>" +
                                        "<h1>已经提交申请</h1>" +
                                        "<h3>待对方确认</h3>" +
                                        "</div></li>"
                            }else if(data[key].comType == "1"){
                                document.getElementById("searchSupplierContainerListNumUl").innerHTML +=
                                        "<li class='searchSupplierContainerListNumUl_action action' data-value='"+val.comKey+"'>" +
                                        "<h4>" + val.comName + "</h4>" +
                                        "<p>" + val.comShortname + "</p>" +
                                        "<p><span>" + val.adminName + "</span><span>" + val.adminPhone + "</span></p>"
                                        + "</li>"
                            }else if(data[key].comType == "2"){
                                document.getElementById("searchSupplierContainerListNumUl").innerHTML +=
                                        "<li class='searchSupplierContainerListNumUl_action action' data-value='"+val.comKey+"'>" +
                                        "<h4>个人用户</h4>" +
                                        "<p>" + val.comShortname + "</p>" +
                                        "<p><span>" + val.adminName + "</span><span>" + val.adminPhone + "</span></p>"
                                        + "</li>"
                            }

                            /*if (val.id == 2) {

                             }
                             if (val.id == 1) {
                             document.getElementById("searchSupplierContainerListNumUl").innerHTML +=
                             "<li class='active'>" +
                             "<h4>" + val.company + "</h4>" +
                             "<p>" + val.manger + "</p>" +
                             "<p><span>" + val.name + "</span><span>" + val.phone + "</span></p>" +
                             "<div class='searchSupplierHide'>" +
                             "<h1>个人版用户</h1>" +
                             "<h3>无法成为您的供应商</h3>" +
                             "</div></li>"
                             }
                             if (val.id == 3) {

                             }*/
                        });
                        var page = data.length;
                        activeClick();  //绑定点击事件
                        SearchSupplierslider(page);
                    }
                },
                error: function () {
                    document.getElementById("searchSupplierContainerListNumUl").innerHTML = "";
                    document.getElementById("searchSupplierContainerListicon").innerHTML = "";
                    $(".searchSuppliererror—hide").css("display", "block");
                }
            });
        });

    }
    SearchSupplier();
    //左右滑动
    function SearchSupplierslider(page) {
        slider_count = 0;	//赋值
        //获取ul的宽度
        var pageMatc = Math.ceil(page / 3);
        $("#searchSupplierContainerListNumUl").width(w);
        if (page <= 3) {
            $('.searchPrve,.searchnext,.searchSupplierContainerListicon').css("display", "none");
        }
        var w = pageMatc * 700;
        for (var i = 0; i < pageMatc; i++) {
            document.getElementById("searchSupplierContainerListicon").innerHTML += "<span></span>";
        }

        //点击小图标
        $("#searchSupplierContainerListicon span").eq(0).css("background", "#2e8ae6").siblings().css("background", "#fff");
        $("#searchSupplierContainerListicon span").click(function () {
            $(this).css("background", "#2e8ae6").siblings().css("background", "#fff");
            var _this = $(this).index();
            $("#searchSupplierContainerListNumUl").animate({left: -(_this * 700) + 'px'}, 'slow');
            slider_count = _this * 3;
        });

        //上一页
        $('.searchPrve').bind("click", (function () {
            if (slider_count <= 0) {
                alert("这是第一页");
                return false;
            }
            ;
            slider_count -= 3;
            $("#searchSupplierContainerListicon span").eq(slider_count / 3).css("background", "#2e8ae6").siblings().css("background", "#fff");
            $("#searchSupplierContainerListNumUl").animate({left: '+=' + 700 + 'px'}, 'slow');
        }));
        //下一页
        $('.searchnext').bind("click", (function () {
            if (slider_count >= (page - 3)) {
                alert("这是最后一页");
                return false;
            }
            ;
            slider_count += 3;
            $("#searchSupplierContainerListicon span").eq(slider_count / 3).css("background", "#2e8ae6").siblings().css("background", "#fff");
            $("#searchSupplierContainerListNumUl").animate({left: '-=' + 700 + 'px'}, 'slow');
        }));
    }
    //选中需要添加好友的公司
    function activeClick() {
        $(".searchSupplierContainerListNumUl_action").on('click',function(){
            $(this).addClass("actionclick").siblings().removeClass("actionclick");

            var checkComKey = $(this).data("value");
            cola.model().set("checkComKey",checkComKey);
            var partnerLevel =  cola.model().get("partnerLevel");
            if(partnerLevel != undefined && partnerLevel != "" && checkComKey != undefined && checkComKey != ""){
                $(".searchSupplierContainerListbtn").css("background", "#2e8ae6").removeAttr("disabled");
            }
        });
    }
    //合作级别选中事件
    $("input[name='partnerLevel']").on("change",function(){
        var partnerLevel = this.value;
        cola.model().set("partnerLevel",partnerLevel);
        var checkComKey = cola.model().get("checkComKey");
        if(partnerLevel != undefined && partnerLevel != "" && checkComKey != undefined && checkComKey != ""){
            $(".searchSupplierContainerListbtn").css("background", "#2e8ae6").removeAttr("disabled");
        }
    });

    $('.not_tips').popup({
        hoverable  : true
    });
    
    function yaoQing() {
        //邀请好友
        $(".yaoqingjiaweihaoyou").click(function(){
            $(".friend_box1").slideUp();
            $(".friend_box2").slideDown();
        })

        //返回
        $(".yaoqingjiawei_back").click(function(){
            $(".friend_box2").slideUp();
            $(".friend_box1").slideDown();
        })


        //切换个人搜索和企业搜索
        $(".friend_invent li").click(function(){
            $(this).addClass("active").siblings().removeClass("active");
            $(".friend_invent_company_list>div").eq($(this).index()).addClass("active").siblings().removeClass("active");
            $(".friend_invent_company_list>div input").val("");
        })
    }
    yaoQing()
</script>
</body>
</html>
