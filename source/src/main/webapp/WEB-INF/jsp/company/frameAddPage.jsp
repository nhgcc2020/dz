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
    <link rel="icon" href="favicon.ico" type="image/x-icon"/>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
    <script src="/resources/nprogress/nprogress.js?v=234c9db3ed"></script>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <link rel="stylesheet" type="text/css" href="/resources/common/common.css?v=076f5c8c95">
    <link rel="stylesheet" type="text/css" href="/resources/common/main.css?v=9e61f29840">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
    <%--//全局图标样式--%>
</head>
<body>
<script src="/resources/jquery/jquery-2.1.3.js?v=b11891de95"></script>
<script src="/resources/jquery/jquery.cookie.js?v=1bf09dac64"></script>
<script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
<script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
<script src="/resources/cola-ui/cola.js?v=bd5fd42985" charset="UTF-8"></script>
<script src="/resources/cola-ui/china_city.js?v=bef170068c"></script>

<div style="width: 1000px;margin: 3rem auto">
    <div>
        <div c-widget="ButtonGroup">
            <div c-widget="#operations;tag:op; caption:搜索客户;class:active blue;userData:flipLayer"></div>
            <div c-widget="#operations;tag:op; caption:企业客户;class:basic grey; userData:flipLayer2"></div>
            <div c-widget="#operations;tag:op; caption:个人客户;class:basic grey; userData:flipLayer3"></div>
        </div>
        <div style="display: inline-block;vertical-align: bottom;">
            <span style="color: red">&nbsp;&nbsp;强烈建议</span>
            <label>:添加前请先搜索，如果对方也是系统用户，即可直接添加。</label>
        </div>
    </div>
</div>

<!--搜索 start-->
<div id="flipLayer" class="show-on-ready" c-widget="Layer;" style="display: block;visibility: visible;top: 45px">
    <div style="width: 1000px;margin: 1rem auto">
        <div style="line-height: 30px">
            <div style="margin-bottom: 1rem;">默认仅搜索本地区范围内（地级市/区）的企业名称和负责人</div>
            <div id="searchIpt" c-widget="Input; placeholder:  企业名称、企业负责人、手机号、企业对账号; bind:keyword;class:fluid" style="width: 500px;">
                <div id="searchBtn" c-widget="Button; caption:搜索;click:search"></div>
            </div>
        </div>

        <!---已搜到 start-->
        <div id="found_box" style="display: none">
            <div style="text-align: right;margin:30px 0 -10px 0;">
                <label>记录数:<span c-bind="entityCount"></span></label>;
                <label>当前页数:<span c-bind="currentPage"></span></label>
                <button c-onclick="previousPage()"><</button>
                <button c-onclick="nextPage()">></button>
            </div>
            <div c-widget="divider"></div>
            <!--公司信息列表 start-->
            <div id="com_list"></div>
            <!--公司信息列表 end-->
            <div c-widget="divider"></div>

            <div class="ui form">
                <div class="inline field">
                    <label style="width: 80px;margin-left:8px"><span style="color: red"></span>伙伴分类</label>
                    <div id="radioGroup" c-widget="RadioGroup; name:brand;bind:slt_partnerType"
                         style="display: inline-block"></div>
                </div>
                <div class="inline field">
                    <label style="width: 80px;margin-left:8px"><span style="color: red"></span>合作级别</label>
                    <div id="radioGroup2" c-widget="RadioGroup;name:brand2;bind:slt_partnerLevel"
                         style="display: inline-block"></div>
                </div>
                <c:if test="${sessionScope.sessionUser.detailIndustryId eq '1C'}">
                    <div class="inline field">
                        <label style="color: red;margin-left: 8px">注意：如果您启用了“基础数据”功能里的“服务定价”模块，这里的合作分级决定了客户可享受的价格。请注意！</label>
                    </div>
                </c:if>


                <div class="inline field">
                    <div c-widget="Button;caption:添加;class:primary;click:save_slt"></div>
                </div>
            </div>
        </div>
        <!---已搜到 end-->

        <!--未搜到 start-->
        <div id="not_found_box" style="margin-top: 2rem;display: none">很抱歉，没有搜索到您需要的结果。您可以尝试其他更加精准的搜索条件，如手机号或企业对账号。
        </div>
        <!--未搜到 start-->
    </div>
</div>
<!--添加企业 start-->

<div id="flipLayer2" class="show-on-ready" c-widget="Layer;" style="top: 45px;">
    <div style="width: 1000px;margin: 1rem auto 2rem">
        <div c-widget="form">
            <div class="ui form">
                <div class="inline field">
                    <label style="width: 80px"><span style="color: red">*</span>企业全称</label>
                    <div c-widget="input;placeholder:如：不能超过20个汉字 如：上海仁石科技有限公司;width:370px;bind:partner.partnerName;tag:disInput"></div>

                    <label style="width: 80px;margin-left:40px"><span style="color: red"></span>公司电话</label>
                    <div c-widget="input;width:370px;bind:partner.partnerTel"></div>
                </div>

                <div class="inline field">
                    <label style="width: 80px"><span style="color: red">*</span>企业简称</label>
                    <div c-widget="input;placeholder:外界通称 如：仁石科技或易对账（小于8汉字）;width:370px;bind:partner.partnerShortname;tag:disInput;change:getZJM"></div>

                    <label style="width: 80px;margin-left:40px"><span style="color: red"></span>公司QQ</label>
                    <div c-widget="input;width:370px;bind:partner.partnerQQ"></div>
                </div>

                <div class="inline field">
                    <label style="width: 80px;"><span style="color: red">*</span>助记代码</label>
                    <div c-widget="input;placeholder:RSKJ;width:370px;bind:partner.mnemonicCode;"></div>

                    <label style="width: 80px;margin-left:40px">公司区域</label>
                    <div style="display: inline-block;width: 373px">
                        <div id="comProvince" style="width: 33%" c-widget="icon:dropdown iconfont"></div><div id="comCity" style="width: 33%" c-widget="icon:dropdown iconfont"></div><div id="comCountry" style="width: 33%" c-widget="icon:dropdown iconfont"></div>
                    </div>
                </div>

                <div class="inline field">
                    <label style="width: 80px;"><span style="color: red">*</span>联系姓名</label>
                    <div c-widget="input;placeholder:请输入姓名;width:370px;bind:partner.contacterName11;tag:disInput"></div>

                    <label style="width: 80px;margin-left:40px">公司地址</label>
                    <div c-widget="input;width:370px;bind:partner.partnerAddress"></div>
                </div>

                <div class="inline field">
                    <label style="width: 80px"><span style="color: red">*</span>联系手机</label>
                    <div c-widget="input;placeholder:负责人的手机号;width:370px;bind:partner.tel11;tag:disInput;change:addQuery2"></div>


                    <label style="width: 80px;margin-left:40px"><span style="color: red"></span>备用手机</label>
                    <div c-widget="input;placeholder:负责人手机号;width:370px;tag:disInput;bind:partner.tel112"></div>
                </div>


                <div class="inline field">
                    <label style="width: 80px;"><span style="color: red">*</span>伙伴分类</label>
                    <div id="radioGroup3" c-widget="RadioGroup;name:brand3;width:370px;bind:partner.partnerType"
                         style="display: inline-block"></div>

                </div>
                <div class="inline field">
                    <label style="width: 80px;"><span style="color: red">*</span>合作级别</label>
                    <div id="radioGroup4" c-widget="RadioGroup;name:brand4;bind:partner.partnerLevel"
                         style="display: inline-block"></div>
                </div>
                <div class="inline field">
                    <label style="width: 80px;"><span style="color: red">*</span>邀请短信</label>
                    <div id="radioGroupSend" c-widget="RadioGroup;name:brandSend;bind:partner.sendMsg"
                         style="display: inline-block"></div>
                </div>
                <c:if test="${sessionScope.sessionUser.detailIndustryId eq '1C'}">
                    <div class="inline field">
                        <label style="color: red;">注意：如果您启用了“基础数据”功能里的“服务定价”模块，这里的合作分级决定了客户可享受的价格。请注意！</label>
                    </div>
                </c:if>
                <!--<div c-widget="divider"></div>-->

                <div class="field">
                    <div style="margin-left: 100px;">免费发送邀请短信（每邀请成功1位，即可获得100元现金奖励） 短信内容如下:</div>
                    <p style="margin:15px 15px 15px 100px">
                        亲爱的合作伙伴：邀请您也来使用专业服务于广告印刷行业的记账/对账软件--易对账，当您注册后我们就可以轻松开展往来业务的协同处理了，还支持在线结算哦。
                    </p>
                </div>
            </div>
        </div>
        <div class="actions">
            <div c-widget="button;caption:取消;click:closeDiv" style="float:left"></div>
            <div c-widget="button;class:primary;caption:保存;click:savePartnerCom"></div>
        </div>
    </div>
</div>
<!---添加个人 start-->
<div id="flipLayer3" class="show-on-ready" c-widget="Layer;" style="top: 45px;">
    <div style="width: 1000px;margin: 1rem auto 2rem">
        <div>
            <div class="ui form">
                <div class="inline field">
                    <label style="width: 80px;"><span style="color: red">*</span>客户姓名</label>
                    <div c-widget="input;placeholder:请输入姓名;bind:partner2.contacterName11;tag:disInput;change:getZJM2"></div>

                </div>
                <div class="inline field">
                    <label style="width: 80px"><span style="color: red">*</span>负责人手机</label>
                    <div c-widget="input;placeholder:负责人的手机号;bind:partner2.tel11;tag:disInput;"></div>
                </div>
                <div class="inline field">
                    <label style="width: 80px;"><span style="color: red">*</span>助记代码</label>
                    <div c-widget="input;placeholder:RSKJ;bind:partner2.mnemonicCode;"></div>
                </div>

                <div class="inline field">
                    <label style="width: 80px;"><span style="color: red">*</span>伙伴分类</label>
                    <div id="radioGroup5" c-widget="RadioGroup; name:brand5;bind:partner2.partnerType"
                         style="display: inline-block"></div>
                </div>
                <div class="inline field">
                    <label style="width: 80px;"><span style="color: red">*</span>合作级别</label>
                    <div id="radioGroup6" c-widget="RadioGroup;name:brand6;bind:partner2.partnerLevel"
                         style="display: inline-block"></div>
                </div>
                <c:if test="${sessionScope.sessionUser.detailIndustryId eq '1C'}">
                    <div class="inline field">
                        <label style="color: red;">注意：如果您启用了“基础数据”功能里的“服务定价”模块，这里的合作分级决定了客户可享受的价格。请注意！</label>
                    </div>
                </c:if>
                <div c-widget="divider"></div>

                <%--<div class="field">
                    <div c-widget="checkbox;label:免费发送邀请短信：（内容如下）"></div>
                    <p style="margin:15px 15px 15px 15px">
                        “本公司“的“管理员姓名”邀请你使用专业服务于广告印刷行业的管理软件“易对账”来帮助我们进行往来业务的订单记录、收货确认及对账结算。点击链接“带有邀请人userkey”注册即可使用。电脑上搜索“易对账”使用更方便！
                    </p>
                </div>--%>

            </div>
        </div>
        <div class="actions">
            <div c-widget="button;caption:取消" style="float:left"></div>
            <div c-widget="button;class:primary;caption:保存;click:savePartnerPer"></div>
        </div>
    </div>
</div>


<script type="text/javascript">
    document.onkeydown=function(event){
        var e = event || window.event || arguments.callee.caller.arguments[0];
        if(e && e.keyCode==27){ // 按 Esc
            //要做的事情
        }
        if(e && e.keyCode==113){ // 按 F2
            //要做的事情
        }
        if(e && e.keyCode==13){ // enter 键
            var ops =  cola.tag("op")
            for (var i = 0; i < ops.length; i++) {
                var op = ops[i];
                var flag = op.get$Dom().hasClass("active");
                if(op.get("userData") == "flipLayer" && flag){
                    cola.widget("searchBtn").set("focusable",true);
                    $("#searchBtn").click();
                }
            }
        }
    };
    //////////////////////////////////////pxy//////////////////////////////////////////////
    var comFalg = false;
    function check_com(div){
        $(".com_list").each(function(){
            $(this).removeClass("slt_com");
        })
        $(div).addClass("slt_com");
    }
    cola(function (model) {
        model.set("provinceList", ProvinceJson);
        model.set("keyword", "");
        //合作伙伴

        model.set("partner", {
            partnerShortname: "",
            partnerName: "",
            partnerTel: "",
            partnerAddress: "",
            partnerAttr: "",
            partnerQQ: "",
            partnerType: "",
            partnerLevel: "",
            tel11: "",
            contacterName11: "",
            tel112: "",
            mnemonicCode: "",
            sendMsg: ""

        });
        model.set("partner2", {
            partnerAttr: "",
            partnerType: "",
            partnerLevel: "",
            tel11: "",
            contacterName11: "",
            mnemonicCode: ""
        });

        model.widgetConfig({
            //按钮组
            operations: {
                $type: "button",
                click: function (self, arg) {
                    var ops = cola.tag("op");
                    //初始化按钮组颜色
                    var userData;
                    for (var i = 0; i < ops.length; i++) {
                        var op = ops[i];
                        userData = op.get("userData");
                        if (self.get("userData") != userData) {
                            op.get$Dom().removeClass("active blue");
                            op.get$Dom().addClass("basic grey");
                            cola.widget(userData).hide({
                                animation: "horizontal flip"
                            });
                        }
                    }
                    //初始化表格格式
                    self.get$Dom().removeClass("basic grey");
                    self.get$Dom().addClass("active blue");
                    //self.set("class","active blue");
                    userData = self.get("userData");
                    cola.widget(userData).show({
                        animation: "horizontal flip"
                    });
                }
            },
            //所在省
            comProvince: {
                $type: "dropdown",
                items: "{{provinceList}}",
                openMode: "drop",
                valueProperty: "provinceId",
                textProperty: "provinceName",
                value: "{{company.comProvince}}",
                change: function (self, arg) {
                    var nowCityArray = new Array();
                    for (var i = 0; i < CityJson.length; i++) {
                        if (CityJson[i].provinceId == self.get("value")) {
                            nowCityArray.push(CityJson[i])
                        }
                    }
                    model.set("cityList", nowCityArray);
                    cola.widget("comCity").set("value", "");
                    cola.widget("comCountry").set("value", "");
                }
            },
            //所在市
            comCity: {
                $type: "dropdown",
                items: "{{cityList}}",
                openMode: "drop",
                valueProperty: "cityId",
                textProperty: "cityName",
                value: "{{company.comCity}}",//
                change: function (self, arg) {
                    var countryArray = new Array();
                    for (var i = 0; i < CountryJson.length; i++) {
                        if (CountryJson[i].cityId == self.get("value")) {
                            countryArray.push(CountryJson[i])
                        }
                    }
                    model.set("countryList", countryArray);
                    cola.widget("comCountry").set("value", "");
                }
            },
            //所在县
            comCountry: {
                $type: "dropdown",
                items: "{{countryList}}",
                openMode: "drop",
                valueProperty: "countryId",
                textProperty: "countryName",
                value: "{{company.comCountry}}"
            },
            radioGroup: {
                items: [{
                    label: "既是客户又是供应商",
                    value: "A"
                }, {
                    label: "我的客户",
                    value: "1"
                }, {
                    label: "我的供应商",
                    value: "2"
                }]

            },
            radioGroup2: {
                items: [{
                    label: "重点伙伴",
                    value: "1"
                }, {
                    label: "普通伙伴",
                    value: "2"
                }, {
                    label: "零散合作",
                    value: "3"
                }]

            },
            radioGroup3: {
                items: [{
                    label: "既是客户又是供应商",
                    value: "A"
                }, {
                    label: "我的客户",
                    value: "1"
                }, {
                    label: "我的供应商",
                    value: "2"
                }]

            },
            radioGroup4: {
                items: [{
                    label: "重点伙伴",
                    value: "1"
                }, {
                    label: "普通伙伴",
                    value: "2"
                }, {
                    label: "零散合作",
                    value: "3"
                }]

            },
            radioGroup5: {
                items: [{
                    label: "既是客户又是供应商",
                    value: "A"
                }, {
                    label: "我的客户",
                    value: "1"
                }, {
                    label: "我的供应商",
                    value: "2"
                }]

            },
            radioGroup6: {
                items: [{
                    label: "重点伙伴",
                    value: "1"
                }, {
                    label: "普通伙伴",
                    value: "2"
                }, {
                    label: "零散合作",
                    value: "3"
                }]

            },
            radioGroupSend: {
                items: [{
                    label: "免费发送",
                    value: true
                }, {
                    label: "不发送",
                    value: false
                }]

            }
        });
        model.action({
            closeDiv:function () {
                window.parent.cola.widget("s1").hide();
            },
            //保存 个人
            savePartnerPer: function (btn) {
                btn.set("disabled",true);
                btn.set("state","loading");
                var partner = model.get("partner2");
                var phone = partner.get("tel11");
                if(!(/^1[34578]\d{9}$/.test(phone))){
                    $("<div class='tips_contants'>").fadeIn(250).html("手机号码有误，请重填").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","")
                    return false;
                }
                var contacterName11 = partner.get("contacterName11");
                if(contacterName11.trim()==""){
                    $("<div class='tips_contants'>").fadeIn(250).html("请填写客户姓名").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","")
                    return false;
                }
                var partnerType = partner.get("partnerType");
                if(partnerType.trim()==""){
                    $("<div class='tips_contants'>").fadeIn(250).html("请选择伙伴分类").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","")
                    return false;
                }
                var partnerLevel = partner.get("partnerLevel");
                if(partnerLevel.trim()==""){
                    $("<div class='tips_contants'>").fadeIn(250).html("请选择合作级别").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","")
                    return false;
                }
                var mnemonicCode = partner.get("mnemonicCode");
                if(mnemonicCode.trim()==""){
                    $("<div class='tips_contants'>").fadeIn(250).html("请填写助记代码").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","")
                    return false;
                }

                model.get("partner2").set("partnerAttr", "2");
                $.ajax({
                    type: "POST",
                    url: "/system/partner/savePartnerWithout",
                    data: partner,
                    async:"false",
                    dataType: "json",
                    success:function(callback){
                        //var callback = eval("("+data+")");
                        if (callback.status == "1") {
                            window.parent.cola.widget("s1").hide();
                            $("<div class='tips_contants'>").fadeIn(250).html("添加成功").delay(1000).fadeOut(250).appendTo('body');
                            btn.set("disabled",false);
                            btn.set("state","")
                        }else{
                            $("<div class='tips_contants'>").fadeIn(250).html("添加失败:"+callback.msg).delay(2000).fadeOut(250).appendTo('body');
                            btn.set("disabled",false);
                            btn.set("state","")
                        }

                    }
                });

                /*$.post("/partner/savePartnerWithout",
                 model.get("partner"),
                 function (callback) {
                 if (callback == "1") {
                 //todo
                 }
                 }
                 )*/
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
                //省市县
                cola.widget("comProvince").get("value") != undefined ? model.set("partner.partnerProvince",cola.widget("comProvince").get("value")) : "";
                cola.widget("comCity").get("value") != undefined ? model.set("partner.partnerCity",cola.widget("comCity").get("value")) : "";
                cola.widget("comCountry").get("value") != undefined ? model.set("partner.partnerCountry",cola.widget("comCountry").get("value")) : "";
                //公司
                model.get("partner").set("partnerAttr", "1");
                //简单校验
                //手机号是否合法
                var partner = model.get("partner");
                var phone = partner.get("tel11");
                if(!(/^1[34578]\d{9}$/.test(phone))){
                    $("<div class='tips_contants'>").fadeIn(250).html("手机号码有误，请重填").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","")
                    return false;
                }
                var partnerName = partner.get("partnerName");
                if($.trim(partnerName)==""){
                    $("<div class='tips_contants'>").fadeIn(250).html("请填写公司全称").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","")
                    return false;
                }
                var partnerShortname = partner.get("partnerShortname");
                if($.trim(partnerShortname)==""){
                    $("<div class='tips_contants'>").fadeIn(250).html("请填写公司简称").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","")
                    return false;
                }
                var partnerType = partner.get("partnerType");
                if($.trim(partnerType)==""){
                    $("<div class='tips_contants'>").fadeIn(250).html("请选择伙伴分类").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","")
                    return false;
                }
                var partnerLevel = partner.get("partnerLevel");
                if($.trim(partnerLevel)==""){
                    $("<div class='tips_contants'>").fadeIn(250).html("请选择合作级别").delay(2000).fadeOut(250).appendTo('body');
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
                var sendMsg = partner.get("sendMsg");
                if($.trim(sendMsg) == ""){
                    $("<div class='tips_contants'>").fadeIn(250).html("请选择邀请短信").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","");
                    return false;
                }
                $.ajax({
                    type: "POST",
                    url: "/system/partner/savePartnerWithout",
                    data: partner,
                    async:"false",
                    dataType: "json",
                    success:function(callback){
                        //var callback = eval("("+data+")");
                        if (callback.status == "1") {
                            window.parent.cola.widget("s1").hide();
                            $("<div class='tips_contants'>").fadeIn(250).html("添加成功").delay(1000).fadeOut(250).appendTo('body');
                            btn.set("disabled",false);
                            btn.set("state","")
                        }else{
                            $("<div class='tips_contants'>").fadeIn(250).html("添加失败:"+callback.msg).delay(2000).fadeOut(250).appendTo('body');
                            btn.set("disabled",false);
                            btn.set("state","")
                        }

                    }
                });
            },
            //添加搜索出来的公司
            save_slt: function () {
                var comkey = $(".slt_com").data("value");
                if (comkey == undefined) {
                    var options = {
                        title: "警告",
                        level: "warning"
                    }
                    $("<div class='tips_contants'>").fadeIn(250).html("请选择需要添加的企业").delay(500).fadeOut(250).appendTo('body');
                    //cola.alert("请选择需要添加的企业", options);
                } else {
                    var slt_partnerLevel = model.get("slt_partnerLevel");
                    var slt_partnerType = model.get("slt_partnerType");
                    $.post("/system/partner/saveSltPartner",
                            {
                                "partnerComKey": comkey,
                                "partnerLevel" : slt_partnerLevel,
                                "partnerType" :  slt_partnerType
                            },
                            function (callback) {
                                var data =  eval("("+callback+")");
                                if (data.status == "0") {
                                    var options = {
                                        title: "警告",
                                        level: "warning"
                                    }
                                    $("<div class='tips_contants'>").fadeIn(250).html("添加失败").delay(500).fadeOut(250).appendTo('body');
                                    //cola.alert("添加失败:"+data.msg, options);
                                } else {
                                    var options = {
                                        title: "提示",
                                        level: "info"
                                    }
                                    $("<div class='tips_contants'>").fadeIn(250).html("添加成功").delay(500).fadeOut(250).appendTo('body');
                                    //cola.alert("添加成功", options);
                                    setTimeout('window.parent.cola.widget("s1").hide()',1000);
                                    //cola.widget("s1").hide();

                                }
                            })
                }
            },

            //分页
            previousPage: function () {
                var entityCount = model.get("entityCount");
                var currentPage = model.get("currentPage");
                var lastPage = Math.ceil(entityCount / 3);
                if (currentPage == 1) {
                    console.info("当前为第一页");
                } else {
                    var $com_list = $("#com_list");
                    $com_list.children().remove();
                    //var $callback = eval("("+callback+")");
                    var firstNun = 3 * (currentPage - 2);
                    var lastNum = 3 * (currentPage - 1);
                    model.get("entityDatas").each(function (element, index) {
                        if (firstNun <= index && index < lastNum) {
                            var com_div =
                                    "<div class='com_list' data-value='" + element._data.comKey + "' onclick='check_com(this)'> " +
                                    "<div><label style='color: #00ACED'>" + element._data.comName + "</label>(" + element._data.comShortname + ")</div> " +
                                    "<div>企业对账号:" + element._data.comId + "</div> " +
                                    "<div>法定代表人:" + element._data.bossName + " &nbsp;手机号码:" + element._data.bossPhone + "</div> " +
                                    "<div>系统管理员:" + element._data.adminName + " &nbsp;手机号码:" + element._data.adminPhone + "</div></div>";
                            $com_list.append(com_div);
                        }
                    })
                    var currentPage = model.set("currentPage", currentPage - 1);
                    //请求上一页
                }
            },
            nextPage: function () {
                var entityCount = model.get("entityCount");
                var currentPage = model.get("currentPage");
                var lastPage = Math.ceil(entityCount / 3);

                if (currentPage == lastPage) {
                    console.info("当前为第一页");
                } else {
                    var $com_list = $("#com_list");
                    $com_list.children().remove();
                    //var $callback = eval("("+callback+")");

                    var firstNun = 3 * currentPage;
                    var lastNum = 3 * (currentPage + 1);
                    model.get("entityDatas").each(function (element, index) {

                        if (firstNun <= index && index < lastNum) {
                            var com_div =
                                    "<div class='com_list' data-value='" + element._data.comKey + "' onclick='check_com(this)'> " +
                                    "<div><label style='color: #00ACED'>" + element._data.comName + "</label>(" + element._data.comShortname + ")</div> " +
                                    "<div>企业对账号:" + element._data.comId + "</div> " +
                                    "<div>法定代表人:" + element._data.bossName + " &nbsp;手机号码:" + element._data.bossPhone + "</div> " +
                                    "<div>系统管理员:" + element._data.adminName + " &nbsp;手机号码:" + element._data.adminPhone + "</div></div>";
                            $com_list.append(com_div);
                        }
                        $("#com_list>div").eq(0).addClass("slt_com");
                    })
                    var currentPage = model.set("currentPage", currentPage + 1);
                }
            },
            //新建合作伙伴时查询校验
            addQuery2: function (ipt) {
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
            search: function (btn) {
                //禁用按钮 ，loading
                btn.set("disabled",true);
                btn.set("state","loading");
                //搜索时隐藏上次的搜索结果
                var $found_box = $("#found_box");
                var $not_found_box = $("#not_found_box");
                $not_found_box.hide();
                $found_box.hide();
                var keyword = $("#searchIpt input").val();

                $.post(
                        "/system/partner/getCustByKey",
                        {addQueryKey: keyword},
                        function (data) {
                            var callback = eval("(" + data + ")");
                            if (callback != "0") {
                                model.set("entityCount", callback.length);
                                model.set("currentPage", 1);
                                model.set("entityDatas", callback);
                                var $com_list = $("#com_list");
                                $com_list.children().remove();
                                //var $callback = eval("("+callback+")");
                                $(callback).each(function (index) {
                                    if (index < 3) {
                                        var com_div =
                                                "<div class='com_list' data-value='" + this.comKey + "' onclick='check_com(this)'> " +
                                                "<div><label style='color: #00ACED'>" + this.comName + "</label>(" + this.comShortname + ")</div> " +
                                                "<div>企业对账号:" + this.comId + "</div> " +
                                                "<div>法定代表人:" + this.bossName + " &nbsp;手机号码:" + this.bossPhone + "</div> " +
                                                "<div>系统管理员:" + this.adminName + " &nbsp;手机号码:" + this.adminPhone + "</div></div>";
                                        $com_list.append(com_div);
                                    }
                                    $("#com_list>div").eq(0).addClass("slt_com");
                                })
                                $found_box.show();

                                btn.set("disabled",false);
                                btn.set("state","")
                            } else {
                                $not_found_box.show();
                                btn.set("disabled",false);
                                btn.set("state","")
                            }
                        })

            },
            getZJM:function(a,b){
                var a = a.get("value");
                $.post("/tool/getPinYinHeadChar",{str:a},function(data){
                    model.set("partner.mnemonicCode",data);

                })
            },
            getZJM2:function(a,b){
                var a = a.get("value");
                $.post("/tool/getPinYinHeadChar",{str:a},function(data){
                    model.set("partner2.mnemonicCode",data);

                })
            },
            getcity: function (slt) {

                var provinceId = $('#testslt option:selected').val();
                $.post("/place/citybyprovince", {provinceId: provinceId}, function (data) {
                    var citydata = eval(data);
                    model.set("citydata", citydata);
                });


                setTimeout(function () {
                    var cityId = $('#testslt2').val();
                    console.info(cityId);
                    console.info("$('#testslt2').val():" + $('#testslt2').val());
                    $.post("/place/countrybycity", {cityId: cityId}, function (data) {
                        var countydata = eval(data);
                        model.set("countydata", countydata);
                    });
                }, 100);

            },

            getcounty: function (slt) {
                var cityId = $('#testslt2 option:selected').val();
                $.post("/place/countrybycity", {cityId: cityId}, function (data) {
                    var countydata = eval(data);
                    model.set("countydata", countydata);
                });
            }
        });
    })
</script>
</body>
</html>
