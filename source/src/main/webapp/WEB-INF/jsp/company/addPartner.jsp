<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.min.css?v=c509be79d3">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.min.css?v=294128f84a">
    <link rel="stylesheet" type="text/css" href="/resources/common/common.css?v=076f5c8c95">
    <link rel="stylesheet" type="text/css" href="/resources/common/main.css?v=9e61f29840">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
    <style>.box2 {
        display: none;
    }</style>
</head>
<body>
<%--加对方为好友--%>
<div class="searchSupplierContainer friend_box1 box1">
    <div class="yaoqingjiaweihaoyou">
        <span style="font-size:14px;color:#8c8c8c">切换至 </span><span
            style="font-size:14px;color:#4284D9">创建生意伙伴></span></span>
    </div>
    <p class="searchSupplierContainertitle">对方也在使用易对账，加好友，记/对账互相同步</p>
    <p class="searchSupplierContainerinput">
        <input type="text" placeholder="请输入手机号码和企业名称"
               id="searchSupplierContainerinput">
        <button id="searchSupplierContainerbutton" disabled>搜索</button>
    </p>
    <div id="imgInit" style="    margin: 40px auto;
    width: 386px;
    height: 279px;background: url('/resources/images/addPartner.png')"></div>
    <p class="searchSupplierContainernone searchSuppliererror—hide"
       style="display: none;">很抱歉，没有搜索到您想要结果</p>
    <div class="searchSupplierContainerList">
        <div class="searchSupplierContainerListNum">
            <a class="searchPrve"><</a> <a class="searchnext">></a>
            <div id="searchSupplierContainerListNum">
                <ul id="searchSupplierContainerListNumUl">

                </ul>
            </div>
            <div class="searchSupplierContainerListicon"
                 id="searchSupplierContainerListicon"></div>
        </div>
        <div class="searchSupplierContainerListCheck">
            <p class="searchSupplierCheckradio1">
                <span style="    display: inline-block;
    width: 100px;
    position: relative;">价格级别：<i class="iconfont partner_tips_2"></i></span> <input type="radio" name="partnerLevel"
                                                                                    id="searchSupplierradio3" value="1"><label
                    for="searchSupplierradio3">优惠价</label> <input type="radio"
                                                                  name="partnerLevel" id="searchSupplierradio4"
                                                                  value="2"><label
                    for="searchSupplierradio4">标准价</label> <input type="radio"
                                                                  name="partnerLevel" id="searchSupplierradio5"
                                                                  value="3"><label
                    for="searchSupplierradio5">零散价</label>
            </p>
        </div>
        <button class="searchSupplierContainerListbtn" disabled>申请加为好友</button>
        <div style="text-align:center;margin-top:10px;color:#ee8e52;">成为好友后，你创建的销售单会同步给对方，对方创建的销售单也会同步给到你</div>
    </div>
    <div class="searchSuppliererror searchSuppliererror—hide"
         style="color: #999999; line-height: 34px;">
        原因可能是：<br> 1.输入信息有误<br> 2.对方可能还没有使用易对账，您可以通过 页面右上角的<span
            style="color: #2e8ae6">邀请加为好友</span>功能 在您的供应商名单中创建企业信息，然后邀请对方注册，成为好友
    </div>
</div>
<%--企业客户/个人客户操作div--%>
<div class="searchSupplierContainer friend_box2">
    <div class="yaoqingjiawei_back"><span style="font-size:14px;color:#8c8c8c;">切换至 </span><span
            style="font-size:14px;color:#4284D9;">加对方为好友></span>
    </div>
    <p class="searchSupplierContainertitle">创建伙伴信息，之后就可以给他开单/记账啦</p>
    <div>
        <%--<ul class="friend_invent">--%>
        <%--<li class="active" data-value="1">企业客户</li>--%>
        <%--<li data-value="2">个人客户</li>--%>
        <%--</ul>--%>
        <div class="friend_invent_company_list">
            <%--企业客户--%>
            <div class="friend_invent_company active">
                <ul class="friend_invent_company_form">
                    <li><span><i>*</i>企业全称</span> <input type="text"
                                                         c-bind="partner.partnerName" c-onchange="copyPartnerName()"
                                                         placeholder="请输入企业全称"></li>
                    <li><span>联系人</span> <input type="text"
                                                c-bind="partner.contacterName11" placeholder="请输入真实姓名"></li>
                    <li><span><i>*</i>企业简称</span> <input type="text"
                                                         c-bind="partner.partnerShortname" c-onchange="getZJM()"
                                                         placeholder="请输入企业简称"></li>
                    <li><span>手机号码</span> <input type="text" maxlength="11"
                                                 c-bind="partner.tel11" c-onchange="addQuery()"
                                                 placeholder="请输入手机号码">
                        <%--c-onchange="addQuery()"--%></li>
                    <li><span>助记代码<i class="iconfont not_tips"
                                     data-html="<div>把客户信息简化成字母缩写，便于记忆;这样通过
        <span style='color:orange'>“助记代码”</span>，
        就可以在销售订单列表快速查找客户有关的所有
        <span style='color:orange'>订单</span></div>"></i>
						</span> <input c-bind="partner.mnemonicCode" placeholder="默认为企业简称缩写，方便记忆"
                                       type="text"></li>
                    <li style="position:relative;width:50%;"><span>区域</span>
                        <div style="display: inline-block;width: 300px;">
                            <div id="comProvince" style="width: 22%; top:10px;position:absolute;"
                                 c-widget="icon:dropdown iconfont"></div>
                            <div id="comCity" style="width: 22%; margin:0px 5%;top:10px;position:absolute;left:185px;"
                                 c-widget="icon:dropdown iconfont"></div>
                            <div id="comCountry" style="width: 22%;top:10px;position:absolute;left:310px;"
                                 c-widget="icon:dropdown iconfont"></div>
                        </div>
                    </li>
                    <li style="position:relative;"><span><i>*</i>伙伴属性</span>
                        <div id="partnerAttrNew" style="width:75%; top:10px;position:absolute;" c-widget=" icon:dropdown iconfont"></div>
                    </li>
                    <li><span>地址</span> <input type="text"
                                               c-bind="partner.partnerAddress" c-onchange="addQuery()"
                                               placeholder="请输入详细地址"></li>
                    <li><span>三证合一</span> <input type="text"
                                               c-bind="partner.taxNo"
                                               placeholder="统一社会信用代码"></li>
                </ul>
                <div class="friend_invent_company_form_check">
                    <p>
                        <span>价格级别：<i class="iconfont partner_tips_2"></i></span> <input
                            type="radio" name="radio2" value="1"
                            id="friend_invent_company_form3"> <label
                            for="friend_invent_company_form3">优惠价</label> <input
                            type="radio" name="radio2" value="2"
                            id="friend_invent_company_form4"> <label
                            for="friend_invent_company_form4">标准价</label> <input
                            type="radio" name="radio2" value="3"
                            id="friend_invent_company_form5"> <label
                            for="friend_invent_company_form5">零散价</label>
                    </p>
                </div>

                <div class="friend_invent_btn">
                    <button c-onclick="closeWin()">以后再说
                    </button>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <div
                            c-widget="button; class:primary; caption:创建伙伴;click:savePartnerCom;userData:false"></div>
                </div>
            </div>

        </div>
    </div>
</div>
<div class="searchSupplierContainer box2">
    <h1 class="success_search_tip" c-bind="tips.title"></h1>
    <p class="success_search_view">
        好友申请状态可以通过 <span>客户/供应商列表</span> 列表去查看
    </p>
    <div class="success_search_btn">
        <button class="success_search_goon" c-onclick="closeWin()">以后再说</button>
        <button class="success_search_list" c-onclick="success_search_goon()"
                c-bind="tips.operation"></button>
    </div>
</div>

<div class="ui cspartner custom  popup"
     style="border-radius: 0; color: #666; background-color: #ffffcc; max-width: 342px; width: 342px; width: 345px; border-color: #ffcc00">
    针对不同关系的<em style='color: #ff9900; font-style: normal'>生意伙伴</em>，划分价格级别，有助于在茫茫客群中快速找到他，重点服务，拉近双方业务距离。
</div>
<div class="ui cspartner  popup" id="personalPartner"
     style="border-radius: 0; color: #666; background-color: #ffffcc; max-width: 342px; width: 342px; width: 345px; border-color: #ffcc00">
    <em style='color: #ff9900; font-style: normal'>价格级别和服务定价有关，请谨慎选择，以免给错价！</em>价格级别能够针对不同伙伴采取差异化报价
</div>
<span style="  position: absolute; top:10px;right:0;display: block;height:30px;width: 30px; cursor: pointer;"
      c-onclick="closeWin()"><img src="../../images/close_user.png" alt="点击关闭"></span>

<script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
<script src="/resources/cola-ui/3rd.min.js?v=59f8ac5b1a"></script>
<script src="/resources/cola-ui/semantic.min.js?v=ce263d5009"></script>
<script src="/resources/cola-ui/cola.min.js?v=96274d219a" charset="UTF-8"></script>
<script src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
<script type="text/javascript">
    var partnerAttrNew=[{"id":1,"name":"客户"},{"id":2,"name":"供应商"},{"id":"A","name":"既是客户又是供应商"}];
    var comFalg = false;
    var comFalgCom = true;
    //搜索供应商
    var slider_count = "";
    function SearchSupplier() {
        $(".secrchSupplierin").click(function () {
            $(".searchSupplierBox1").fadeIn()
        })
        $("#searchSupplierContainerinput").keydown(
            function () {
                if ($(this).val.length != 0) {
                    $("#searchSupplierContainerbutton").css(
                        "background", "#2e8ae6").css("color",
                        "#fff").removeAttr("disabled");
                }
            });

        //立即申请
        $(".searchSupplierContainerListbtn").click(
            function () {
                $(this).css("background", "").attr("disabled",
                    "disabled");
                var partnerLevel = cola.model().get("partnerLevel");
                var checkComKey = cola.model().get("checkComKey");
                //不再需要设置伙伴分类
                //var partnerType = "1";
                $.ajax({
                    url: "/system/partner/saveSltPartner",
                    type: "POST",
                    data: {
                        partnerLevel: partnerLevel,
                        partnerComKey: checkComKey
                        /*,
                         partnerType:partnerType*/
                    },
                    async: false,
                    success: function (callback) {
                        var data = eval("(" + callback + ")");
                        if (data.status == "1") {
                            $(this).css("background", "#999");
                            $(".box1").fadeOut();
                            $(".box2").fadeIn();
                        } else {
                            $(".searchSuppliererror—hide").css(
                                "display", "block").html(data.msg);
                        }
                        $("input[name='partnerLevel']").attr("checked", false);
                    }
                });
            });

        //继续添加
        /*$(".success_search_goon").click(function () {
         $(".box1").fadeIn();
         $(".box2").fadeOut();
         $("#searchSupplierContainerinput").val("");
         $("#searchSupplierContainerbutton").css("background", "#999").attr("disabled", "disabled");
         $(".searchSupplierContainerList").css("display", "none");
         $(".searchSupplierContainerListbtn").css("background", "#999").attr("disabled", "disabled");
         });*/

        //关闭
        $(".searchSupplierClose").click(
            function () {
                $(".searchSupplierBox1").fadeOut();
                $(".searchSupplierBox2").fadeOut();
                $("#searchSupplierContainerinput").val("");
                $("#searchSupplierContainerbutton").css("background",
                    "#999").attr("disabled", "disabled");
                $(".searchSupplierContainerList")
                    .css("display", "none");
                $(".searchSupplierContainerListbtn").css("background",
                    "#999").attr("disabled", "disabled");
            })

        //点击搜索
        $("#searchSupplierContainerbutton")
            .click(
                function () {
                    var addQueryKey = $("#searchSupplierContainerinput").val();
                    $.ajax({
                        type: 'POST',
                        url: '/system/partner/getPartnerByKey',
                        data: {addQueryKey: addQueryKey},
                        async: true,
                        dataType: "json",
                        success: function (data) {
                            $(".searchSuppliererror—hide").css("display", "none");
                            document.getElementById("searchSupplierContainerListNumUl").innerHTML = "";
                            document.getElementById("searchSupplierContainerListicon").innerHTML = "";
                            if (data.length == 0) {
                                $(".searchSupplierContainerList").css("display", "none");
                                $(".searchSupplierContainernone").css("display", "block");
                                $(".searchSuppliererror").css("display", "block");
                                return false;
                            } else {
                                $(
                                    ".searchSupplierContainerList")
                                    .css("display",
                                        "block");
                                $(
                                    "#searchSupplierContainerbutton")
                                    .css("background",
                                        "#999")
                                    .attr("disabled",
                                        "disabled");
                                $.each(
                                    data,
                                    function (key,
                                              val) {

                                        if (data[key].partnerStatus == "1") {
                                            document
                                                .getElementById("searchSupplierContainerListNumUl").innerHTML += "<li class='active'>"
                                                + "<h4>"
                                                + val.comName
                                                + "</h4>"
                                                + "<p>"
                                                + val.comShortname
                                                + "</p>"
                                                + "<p><span>"
                                                + val.adminName
                                                + "</span><span>"
                                                + val.adminPhone
                                                + "</span></p>"
                                                + "<div class='searchSupplierHide'>"
                                                + "<h1>已经是您的好友</h1>"
                                                + "</div></li>"
                                        } else if (data[key].partnerStatus == "2") {
                                            document
                                                .getElementById("searchSupplierContainerListNumUl").innerHTML += "<li class='active'>"
                                                + "<h4>"
                                                + val.comName
                                                + "</h4>"
                                                + "<p>"
                                                + val.comShortname
                                                + "</p>"
                                                + "<p><span>"
                                                + val.adminName
                                                + "</span><span>"
                                                + val.adminPhone
                                                + "</span></p>"
                                                + "<div class='searchSupplierHide'>"
                                                + "<h1>已经提交申请</h1>"
                                                + "<h3>待对方确认</h3>"
                                                + "</div></li>"
                                        } else if (data[key].comType == "1") {
                                            document
                                                .getElementById("searchSupplierContainerListNumUl").innerHTML += "<li class='searchSupplierContainerListNumUl_action action' data-value='" + val.comKey + "'>"
                                                + "<h4>"
                                                + val.comName
                                                + "</h4>"
                                                + "<p>"
                                                + val.comShortname
                                                + "</p>"
                                                + "<p><span>"
                                                + val.adminName
                                                + "</span><span>"
                                                + val.adminPhone
                                                + "</span></p>"
                                                + "</li>"
                                        } else if (data[key].comType == "2") {
                                            document
                                                .getElementById("searchSupplierContainerListNumUl").innerHTML += "<li class='searchSupplierContainerListNumUl_action action' data-value='" + val.comKey + "'>"
                                                + "<h4>个人用户</h4>"
                                                + "<p>"
                                                + val.comShortname
                                                + "</p>"
                                                + "<p><span>"
                                                + val.adminName
                                                + "</span><span>"
                                                + val.adminPhone
                                                + "</span></p>"
                                                + "</li>"
                                        }
                                    });
                                var page = data.length;
                                activeClick(); //绑定点击事件
                                SearchSupplierslider(page);
                            }
                        },
                        error: function () {
                            document
                                .getElementById("searchSupplierContainerListNumUl").innerHTML = "";
                            document
                                .getElementById("searchSupplierContainerListicon").innerHTML = "";
                            $(".searchSuppliererror—hide")
                                .css("display", "block");
                        }
                    });
                    $("#imgInit").hide();
                });

    }
    function SearchSupplierslider(page) {
        slider_count = 0; //赋值
        //获取ul的宽度
        var pageMatc = Math.ceil(page / 3);
        $("#searchSupplierContainerListNumUl").width(w);
        if (page <= 3) {
            $('.searchPrve,.searchnext,.searchSupplierContainerListicon')
                .css("display", "none");
        }
        var w = pageMatc * 700;
        for (var i = 0; i < pageMatc; i++) {
            document.getElementById("searchSupplierContainerListicon").innerHTML += "<span></span>";
        }

        //点击小图标
        $("#searchSupplierContainerListicon span").eq(0).css("background",
            "#2e8ae6").siblings().css("background", "#fff");
        $("#searchSupplierContainerListicon span").click(
            function () {
                $(this).css("background", "#2e8ae6").siblings().css(
                    "background", "#fff");
                var _this = $(this).index();
                $("#searchSupplierContainerListNumUl").animate({
                    left: -(_this * 700) + 'px'
                }, 'slow');
                slider_count = _this * 3;
            });

        //上一页
        $('.searchPrve').bind(
            "click",
            (function () {
                if (slider_count <= 0) {
//                    alert("这是第一页");
                    return false;
                }
                ;
                slider_count -= 3;
                $("#searchSupplierContainerListicon span").eq(
                    slider_count / 3).css("background", "#2e8ae6")
                    .siblings().css("background", "#fff");
                $("#searchSupplierContainerListNumUl").animate({
                    left: '+=' + 700 + 'px'
                }, 'slow');
            }));
        //下一页
        $('.searchnext').bind(
            "click",
            (function () {
                if (slider_count >= (page - 3)) {
//                    alert("这是最后一页");
                    return false;
                }
                ;
                slider_count += 3;
                $("#searchSupplierContainerListicon span").eq(
                    slider_count / 3).css("background", "#2e8ae6")
                    .siblings().css("background", "#fff");
                $("#searchSupplierContainerListNumUl").animate({
                    left: '-=' + 700 + 'px'
                }, 'slow');
            }));
    }
    function activeClick() {
        $(".searchSupplierContainerListNumUl_action").on(
            'click',
            function () {
                $(this).addClass("actionclick").siblings().removeClass(
                    "actionclick");

                var checkComKey = $(this).data("value");
                cola.model().set("checkComKey", checkComKey);
                var partnerLevel = cola.model().get("partnerLevel");
                if (partnerLevel != undefined && partnerLevel != ""
                    && checkComKey != undefined
                    && checkComKey != "") {
                    $(".searchSupplierContainerListbtn").css(
                        "background", "#2e8ae6").removeAttr(
                        "disabled");
                }
            });
    }
    cola(function (model) {
        model.set("tips", {
            title: "申请成功",
            operation: "继续申请"
        });
        model.set("partner", {
            partnerName: "",
            contacterName11: "",
            partnerShortname: "",
            tel11: "",
            mnemonicCode: ""
        });
        model.set("partner2", {
            contacterName11: "",
            tel11: "",
            mnemonicCode: ""
        });
        model.set("provinceList", ProvinceJson);
        model.set("partnerAttrList", partnerAttrNew);
        model.action({
            //自动带入企业全称至简称中
            copyPartnerName: function () {
                model.set("partner.partnerShortname", model
                    .get("partner.partnerName"));
                model.action("getZJM")();
            },
            closeWin: function () {
                window.parent.hideMsg();
            },
            //继续添加
            success_search_goon: function () {
                var tips = model.get("tips")._data.operation;
                if (tips === "继续添加") {
                    window.location.reload();
                    $(".friend_box2").fadeIn();
                    $(".box2").fadeOut();
                    $("#searchSupplierContainerinput").val("");
                    $("#searchSupplierContainerbutton").css(
                        "background", "#999").attr("disabled",
                        "disabled");
                    $(".searchSupplierContainerList").css("display",
                        "none");
                    $(".searchSupplierContainerListbtn").css(
                        "background", "#999").attr("disabled",
                        "disabled");
                } else if (tips === "继续申请") {
                    $(".friend_box1").fadeIn();
                    $(".box2").fadeOut();
                    $("#searchSupplierContainerinput").val("");
                    $("#searchSupplierContainerbutton").css(
                        "background", "#999").attr("disabled",
                        "disabled");
                    $(".searchSupplierContainerList").css("display",
                        "none");
                    $(".searchSupplierContainerListbtn").css(
                        "background", "#999").attr("disabled",
                        "disabled");
                }
            },
            //
            openCust: function (btn) {
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
            //助记码2
            getZJM2: function (a, b, c) {
                //var a = a.get("value");
                $
                    .post(
                        "<c:url value="/tool/getPinYinHeadChar"/>",
                        {
                            str: model
                                .get("partner2.contacterName11")
                        },
                        function (data) {
                            model
                                .set(
                                    "partner2.mnemonicCode",
                                    data);
                        })
            },
            //新建合作伙伴时查询校验2
            addQuery2: function (ipt) {
                var keyword = model.get("partner2.tel11");
                //var phone = partner.get("phone");
                // if (!(/^1[34578]\d{9}$/.test(keyword))) {
                //     $("<div class='tips_contants'>").fadeIn(250)
                //         .html("手机号码有误，请重填").delay(2000)
                //         .fadeOut(250).appendTo('body');
                //     comFalg = false;
                //     return false;
                // }
                $
                    .post(
                        "<c:url value="/system/partner/isRegistered"/>",
                        {
                            phone: keyword
                        },
                        function (data) {
                            if (data) {
                                $(
                                    "<div class='tips_contants'>")
                                    .fadeIn(250)
                                    .html(
                                        "该手机用户已在伙伴名单中，无法重复创建")
                                    .delay(2000)
                                    .fadeOut(250)
                                    .appendTo('body');
                                //model.set("partner.tel11","");
                                comFalg = false;
                            } else {
                                comFalg = true;
                            }
                        })
            },
            //添加取消
            cancel: function () {
                $(".friend_box2").slideUp();
                $(".friend_box1").slideDown();
            },
            //助记码
            getZJM: function (a, b, c) {
                //var a = a.get("value");
                $
                    .post(
                        "<c:url value="/tool/getPinYinHeadChar"/>",
                        {
                            str: model
                                .get("partner.partnerShortname")
                        }, function (data) {
                            model.set(
                                "partner.mnemonicCode",
                                data);
                        })
            },
            //新建合作伙伴时查询校验
            addQuery: function (ipt) {
                var keyword = model.get("partner.tel11");
                //var phone = partner.get("phone");
                if (keyword == undefined || keyword == "") {
                    comFalgCom = true;
                    return true;
                }

                // if (!(/^1[34578]\d{9}$/.test(keyword))) {
                //     $("<div class='tips_contants'>").fadeIn(250)
                //         .html("手机号码有误，请重填").delay(2000)
                //         .fadeOut(250).appendTo('body');
                //     comFalgCom = false;
                //     return false;
                // }

                $
                    .ajax({
                        type: "POST",
                        url: "<c:url value='/system/partner/isRegistered'/>",
                        data: {
                            phone: keyword
                        },
                        async: false,
                        dataType: "json",
                        success: function (data) {
                            if (data) {
                                $("<div class='tips_contants'>")
                                    .fadeIn(250)
                                    .html(
                                        "该手机用户已使用易对账，通过加对方为好友加他吧")
                                    .delay(2000).fadeOut(
                                    250).appendTo(
                                    'body');
                                //model.set("partner.tel11","");
                                comFalgCom = false;
                            } else {
                                comFalgCom = true;
                            }
                        }
                    });
                return comFalgCom;
            },
            //新建个人合作伙伴
            savePartnerUser: function (btn) {
                if (!comFalg) {
                    $("<div class='tips_contants'>").fadeIn(250)
                        .html("该手机用户已在伙伴名单中，无法重复创建").delay(2000).fadeOut(250).appendTo('body');
                    return false;
                }
                btn.set("disabled", true);
                btn.set("state", "loading");
                //个人
                model.get("partner2").set("partnerAttr", "2");
                //不再需要设置伙伴分类
                //model.get("partner2").set("partnerType","1");
                //合作级别
                var partnerLevel = $("input[name='radio4']:checked").val();
                model.get("partner2").set("partnerLevel", partnerLevel);

                //发送短信

                model.get("partner2").set("sendMsg", btn.get("userData") === "true");

                //简单校验
                //手机号是否合法
                var partner = model.get("partner2");
                var phone = partner.get("tel11");
                if (!(/^1[34578]\d{9}$/.test(phone))) {
                    $("<div class='tips_contants'>").fadeIn(250)
                        .html("手机号码有误，请重填").delay(2000)
                        .fadeOut(250).appendTo('body');
                    btn.set("disabled", false);
                    btn.set("state", "");
                    return false;
                }
                var contacterName11 = partner.get("contacterName11");

                if ($.trim(contacterName11) == "") {
                    $("<div class='tips_contants'>").fadeIn(250)
                        .html("请填写联系人").delay(2000)
                        .fadeOut(250).appendTo('body');
                    btn.set("disabled", false);
                    btn.set("state", "");
                    return false;
                }

                var partnerLevel2 = partner.get("partnerLevel");
                if ($.trim(partnerLevel2) == "") {
                    $("<div class='tips_contants' style='line-height: 40px;'>").fadeIn(250).html("请选择一个价格级别<br>价格级别和服务定价有关，请谨慎选择，以免给错价").delay(2000).fadeOut(250).appendTo('body');
                    btn.set("disabled", false);
                    btn.set("state", "");
                    return false;
                }


                var sendMsg2 = partner.get("sendMsg");
                if ($.trim(sendMsg2) == "") {
                    $("<div class='tips_contants'>").fadeIn(250)
                        .html("请选择是否发送短信").delay(2000).fadeOut(
                        250).appendTo('body');
                    btn.set("disabled", false);
                    btn.set("state", "");
                    return false;
                }

                $.ajax({
                    type: "POST",
                    url: "<c:url value="/system/partner/savePartnerWithout"/>",
                    data: partner,
                    async: "false",
                    dataType: "json",
                    success: function (callback) {
                        if (callback.status == "1") {
                            $(".box1").fadeOut();
                            $(".box2").fadeIn();
                            $(".friend_box2").fadeOut();
                            model.set("tips", {
                                title: "添加成功",
                                operation: "继续添加"
                            });
                            btn.set("disabled", false);
                            btn.set("state", "");
                            model.set("partner2", {
                                contacterName11: "",
                                tel11: "",
                                mnemonicCode: ""
                            });

                        } else {
                            $("<div class='tips_contants'>")
                                .fadeIn(250)
                                .html(
                                    "添加失败:"
                                    + callback.msg)
                                .delay(2000).fadeOut(
                                250).appendTo(
                                'body');
                            btn.set("disabled", false);
                            btn.set("state", "");
                        }

                    }
                });

            },
            //新建公司合作伙伴
            savePartnerCom: function (btn) {
                if (!comFalgCom) {
                    $("<div class='tips_contants'>").fadeIn(250)
                        .html("该手机用户已使用易对账，通过加对方为好友加他吧").delay(2000).fadeOut(250).appendTo('body');
                    return false;
                }
                btn.set("disabled", true);
                btn.set("state", "loading");
                //公司
                model.get("partner").set("partnerAttr", "1");
                //不再需要设置伙伴分类
                //model.get("partner").set("partnerType","1");
                //合作级别
                var partnerLevel = $("input[name='radio2']:checked").val();
                model.get("partner").set("partnerLevel", partnerLevel);

                //发送短信
                model.get("partner").set("sendMsg", btn.get("userData") === "true");
                //简单校验
                //手机号是否合法
                var partner = model.get("partner");
                var phone = partner.get("tel11");
                var partnerName = partner.get("partnerName");
                if ($.trim(partnerName) == "") {
                    $("<div class='tips_contants'>").fadeIn(250)
                        .html("请填写公司全称").delay(2000).fadeOut(
                        250).appendTo('body');
                    btn.set("disabled", false);
                    btn.set("state", "");
                    return false;
                }
                var partnerShortname = partner.get("partnerShortname");
                if ($.trim(partnerShortname) == "") {
                    $("<div class='tips_contants'>").fadeIn(250)
                        .html("请填写公司简称").delay(2000).fadeOut(
                        250).appendTo('body');
                    btn.set("disabled", false);
                    btn.set("state", "");
                    return false;
                }
                var partnerLevel2 = partner.get("partnerLevel");
                var partnerAttr10 = partner.get("partnerType");
                if(partnerAttr10 ==undefined){
                    $("<div class='tips_contants'>").fadeIn(250)
                        .html("请填写伙伴属性").delay(2000).fadeOut(
                        250).appendTo('body');
                    btn.set("disabled", false);
                    btn.set("state", "")
                    return false;
                }
                if(partnerAttr10!="2"){
                    if ($.trim(partnerLevel2) == "") {
                        $("<div class='tips_contants' style='line-height: 40px;'>").fadeIn(250).html("请选择一个价格级别<br>价格级别和服务定价有关，请谨慎选择，以免给错价").delay(2000).fadeOut(250).appendTo('body');
                        btn.set("disabled", false);
                        btn.set("state", "");
                        return false;
                    }
                }
                var sendMsg2 = partner.get("sendMsg");
                if ($.trim(sendMsg2) == "") {
                    $("<div class='tips_contants'>").fadeIn(250)
                        .html("请选择是否发送短信").delay(2000).fadeOut(
                        250).appendTo('body');
                    btn.set("disabled", false);
                    btn.set("state", "");
                    return false;
                }

                if (sendMsg2 && !(/^1[34578]\d{9}$/.test(phone))) {
                    $("<div class='tips_contants'>").fadeIn(250)
                        .html("发送邀请短信时手机号为必填").delay(3000)
                        .fadeOut(250).appendTo('body');
                    btn.set("disabled", false);
                    btn.set("state", "");
                    return false;
                }
                $.ajax({
                    type: "POST",
                    url: "/system/partner/savePartnerWithout",
                    data: partner,
                    async: "false",
                    dataType: "json",
                    success: function (callback) {
                        if (callback.status == "1") {
                            $(".box1").fadeOut();
                            $(".box2").fadeIn();
                            $(".friend_box2").fadeOut();
                            model.set("tips", {
                                title: "添加成功",
                                operation: "继续添加"
                            });

                            $("input[name='radio2']").attr("checked", false);
                            btn.set("disabled", false);
                            btn.set("state", "");
//                            cola.widget("partnerAttrNew").set("value", "");
                        } else {
                            $("<div class='tips_contants'>")
                                .fadeIn(250).html(
                                "该手机用户已在伙伴名单中，无法重复创建")
                                .delay(2000).fadeOut(
                                250).appendTo(
                                'body');
                            btn.set("disabled", false);
                            btn.set("state", "");

                        }

                    }
                });

            }
        });
//        var comProvince = model.get("partner.partnerProvince");
//        var cityArray = [];
//        for (var j = 0; j < CityJson.length; j++) {
//            if (CityJson[j].provinceId == comProvince) {
//                cityArray.push(CityJson[j])
//            }
//        }
//        model.set("cityList", cityArray);
        var comCity = model.get("partner.partnerCity");
        var countryArray = [];
        for (var k = 0; k < CountryJson.length; k++) {
            if (CountryJson[k].cityId == comCity) {
                countryArray.push(CountryJson[k])
            }
        }
        model.set("countryList", countryArray);
        model.widgetConfig({
            partnerAttrNew: {
                $type: "dropdown",
                items: "{{partnerAttrList}}",
                openMode: "drop",
                valueProperty: "id",
                textProperty: "name",
                value: "{{partner.partnerType}}",
                change: function (self, arg) {
                    if(self.get("value")=="2"){
                        $(".friend_invent_company_form_check").hide();
                        $("input[name='radio2']").removeAttr('checked');
                    }else{
                        $(".friend_invent_company_form_check").show();
                    }
//                    cola.widget("comCountry").set("value", "");
                    model.set("partner.partnerType", arg.value);
                }
            },
            comProvince: {
                $type: "dropdown",
                items: "{{provinceList}}",
                openMode: "drop",
                valueProperty: "provinceId",
                textProperty: "provinceName",
                value: "{{partner.partnerProvince}}",
                change: function (self, arg) {
                    var nowCityArray = [];
                    for (var i = 0; i < CityJson.length; i++) {
                        if (CityJson[i].provinceId == self.get("value")) {
                            nowCityArray.push(CityJson[i])
                        }
                    }
                    model.set("cityList", nowCityArray);
                    cola.widget("comCity").set("value", "");
                    cola.widget("comCountry").set("value", "");
                    //更新当前选中的省
                    model.set("partner.partnerProvince", arg.value);

                }
            },
            //所在市
            comCity: {
                $type: "dropdown",
                items: "{{cityList}}",
                openMode: "drop",
                valueProperty: "cityId",
                textProperty: "cityName",
                value: "{{partner.partnerCity}}",
                change: function (self, arg) {
                    var countryArray = new Array();
                    for (var i = 0; i < CountryJson.length; i++) {
                        if (CountryJson[i].cityId == self.get("value")) {
                            countryArray.push(CountryJson[i])
                        }
                    }
                    model.set("countryList", countryArray);
                    cola.widget("comCountry").set("value", "");
                    //更新当前选中的市
                    model.set("partner.partnerCity", arg.value);
                }
            },
            //所在县
            comCountry: {
                $type: "dropdown",
                items: "{{countryList}}",
                openMode: "drop",
                valueProperty: "countryId",
                textProperty: "countryName",
                value: "{{partner.partnerCountry}}",
                change: function (self, arg) {
                    model.set("partner.partnerCountry", arg.value);
                }
            }
        });

    });
    $(function () {
        SearchSupplier();
        //合作级别选中事件
        $("input[name='partnerLevel']").on(
            "change",
            function () {
                var partnerLevel = this.value;
                cola.model().set("partnerLevel", partnerLevel);
                var checkComKey = cola.model().get("checkComKey");
                if (partnerLevel != undefined && partnerLevel != ""
                    && checkComKey != undefined && checkComKey != "") {
                    $(".searchSupplierContainerListbtn").css("background",
                        "#2e8ae6").removeAttr("disabled");
                }
            });
        $('.not_tips').popup({
            hoverable: true
        });
        $('.partner_tips').popup({
            hoverable: true,
            popup: $('.custom.popup')
        });
        $('.partner_tips_2').popup({
            hoverable: true,
            popup: $('#personalPartner')
        });
        //邀请好友
        $(".yaoqingjiaweihaoyou").click(function () {
            $(".friend_box1").slideUp();
            $(".friend_box2").slideDown();
        })
        //返回
        $(".yaoqingjiawei_back").click(function () {
            $(".friend_box2").slideUp();
            $(".friend_box1").slideDown();
        })
        //切换个人搜索和企业搜索
        $(".friend_invent li").click(
            function () {
                $(this).addClass("active").siblings().removeClass(
                    "active");
                $(".friend_invent_company_list>div")
                    .eq($(this).index()).addClass("active")
                    .siblings().removeClass("active");
                cola.model().set("partner", {
                    partnerName: "",
                    contacterName11: "",
                    partnerShortname: "",
                    tel11: "",
                    mnemonicCode: ""
                });
                cola.model().set("partner2", {
                    contacterName11: "",
                    tel11: "",
                    mnemonicCode: ""
                });
            })
    })

</script>
</body>
</html>
