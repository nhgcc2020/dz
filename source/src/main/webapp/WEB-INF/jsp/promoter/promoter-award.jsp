<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>对账大使推广</title>
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <script src="/resources/common/vue.min.js?v=32e8fb7bee"></script>
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <script src="/resources/cola-ui/clipboard.min.js?v=bd70fd596a"></script>
</head>
<style>
    .person{    height: 500px;
        margin: 0 auto;
        margin-top: 10px;
        width: 1000px;}
    .image{text-align: center;}
    .btnEnter{
        width: 100px;
        height: 30px;
        background: #2e8ae6;
        color: #fff;
        border: none;
        line-height: 25px;
        text-align: center;
        margin: 15px 0px 0px;
        outline: none;
        font-size: 14px;
        border-radius: 3px;
    }
    .tips_contants {
        position: fixed;
        top: 50%;
        left: 50%;
        z-index: 99999;
        display: none;
        font-size:12px;
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
    #msgwindow {
        border: none;
        width: 100%;
        left: 0;
        height: 100%;
        top: 0;
z-index: 9;
        margin-top: 0;
        background: #e4e4e0;
        transition: all 0.2s 0s linear;
        -webkit-transition: all 0.2s 0s linear;
        position: fixed;
    }
    .listAc li{
        width:119px;
        height:30px;
        line-height:30px;
        text-align: center;
        cursor: pointer;
        font-size: 14px;
        color:#999;
        float:left;
        box-shadow: rgb(226, 224, 224) 0px 0px 7px;
        background: #fff;

    }
    .listAc .active{
        background: #4284d9;
        color:#fff;
    }
    .tdData th{
        background: #eff1f3;
        height:42px;
        font-size:12px;
        line-height: 42px;
        color:#333;
        font-weight:normal;
    }
    .tdData td{
color:#666;
        font-size:12px;
        height:50px;
        line-height: 50px;
        text-align: center;
        border-bottom: 1px solid #e4e4e4;
    }
</style>
<body>
<div id="app" style="width:1000px;margin:0 auto;" class="hide">
    <div  v-if="comBox2Flag"  id="msgwindow" style="border:none;"></div>
    <div class="person" style="position: relative">
        <div style="       position: absolute;
    background: rgb(248, 248, 248);
    left: -170px;
    font-size: 12px;
    color: rgb(102, 102, 102);
    border: 1px solid rgb(242, 242, 242);
    top: 0px;
    height: 110px;
    padding: 14px;
    width: 130px;
    line-height: 18px;">如果需要 <span style="font-weight:700;color:#ff6600">销售开单、采购记账、派工、APP查账</span>。请点击左上方下拉按钮，去创建一家企业，只有创建企业账号才能实现记账对账！
        </div>
        <input type="text" style="opacity: 0" value="https://www.yiduizhang.com/promoter/${sessionScope.sessionUser.userKey}" id="inventMsg">
        <div class="image" style="position: relative;margin-bottom: 10px;"><img src="/images/page/inviteFr.png"  alt="">
            <span style="background: url('/images/page/cashPrize.png');    position: absolute;
    left: 440px;
    bottom: 35px;
    width: 120px;
    height: 111px;"></span>
            <a v-on:click="show" style="    position: absolute;
    bottom: 5px;cursor: pointer;
    left: 450px;
    width: 100px;
    height: 30px;"></a></div>
        <%--<div class="image"><img src="/images/page/personalTx.png" style="width:120px;height: 120px;border-radius: 60px;" alt=""></div>--%>

        <div style="width: 495px;
    height: 220px;
    display: inline-block;
    float: left;
    box-shadow: rgb(248, 244, 244) 0px 0px 7px">
            <h1 style="    font-size: 20px;
    margin: 20px 0 20px 14px;color:#666;
    font-weight: normal;">方法一</h1>
            <p style="    font-size: 14px;color:#666; height:26px;margin: 40px 0 0 20px;">点击右侧复制链接</p>
            <p style="    font-size: 14px;color:#666;height:26px; margin: 0px 0 0 20px;">通过电脑端QQ/微信粘贴给好友注册</p>
                　<a id="inventMsgBtn" style="     color: rgb(66, 132, 217);
    cursor: pointer;
    text-decoration: underline;
    float: right;
    font-size: 14px;
    margin-right: 90px;
    margin-top: -40px;">复制链接</a>
        </div>
        <div style="width: 495px;
    height: 220px;
    display: inline-block;
    float: right;position:relative;
    box-shadow: rgb(248, 244, 244) 0px 0px 7px">
            <h1 style="   font-size: 20px;
    margin: 20px 0 20px 14px;color:#666;
    font-weight: normal;">方法二</h1>
            <p style=" font-size: 14px;color:#666;height: 26px; margin: 40px 0 0 20px;">扫描下载手机APP</p>
            <p style=" font-size: 14px;color:#666;height: 26px; margin: 0px 0 0 20px;">登录APP切换至个人版</p>
            <p style=" font-size: 14px;color:#666;height: 26px; margin: 0px 0 0 20px;">随时转发给好友</p>

            <div style="    position: absolute;
    right: 118px;
    top: 34px;
    overflow: hidden;
    text-align: center;"><img src="/images/page/Android_app.png" style="width: 111px;"> <br> <span style="font-size: 12px; margin-top: 5px; height: 10px; display: inline-block; text-align: center;">安卓APP下载</span> <br> <span style="font-size: 10px;color: rgb(160, 160, 160);display: inline-block;transform: scale(0.8);">适用于Android 5.0以上平台</span></div>
            <div style="position: absolute;right: 8px;top: 34px;text-align: center;"><img src="/images/page/ios_app.png" style="width: 111px; text-align: center;"> <br><span style="font-size: 12px;margin-top: 5px;display: inline-block;text-align: center;">苹果APP下载</span> <br><span style="font-size: 10px;color: rgb(160, 160, 160);transform: scale(0.8);display: inline-block;">适用于IOS 9.3以上平台</span></div>
        </div>
        <div style="height: 20px;clear: both;"></div>
       <ul  class="listAc" style="float: left;">
           <li class="active" v-on:click="enterLi($event)" >未付费</li>
           <li v-on:click="enterLi($event)" >已付费</li>
       </ul>
        <div style="height: 7px;clear: both;"></div>
        <table style="width:1000px;" class="tdData tdData0 ">
            <thead>
            <th>姓名</th>
            <th>手机号</th>
            <th>公司</th>
            <th>创建日期</th>
            </thead>
            <tbody>
            <%--<tr>--%>
                <%--<td>1</td>--%>
                <%--<td>1</td>--%>
                <%--<td>1</td>--%>
                <%--<td>1</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td>1</td>--%>
                <%--<td>1</td>--%>
                <%--<td>1</td>--%>
                <%--<td>1</td>--%>
            <%--</tr>--%>
            </tbody>
        </table>
        <table style="width:1000px;" class="tdData tdData1 hide">
            <thead>
            <th>姓名</th>
            <th>手机号</th>
            <th>公司</th>
            <th>创建日期</th>
            </thead>
            <tbody>
            <%--<tr>--%>
                <%--<td>2</td>--%>
                <%--<td>2</td>--%>
                <%--<td>2</td>--%>
                <%--<td>2</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td>2</td>--%>
                <%--<td>2</td>--%>
                <%--<td>2</td>--%>
                <%--<td>2</td>--%>
            <%--</tr>--%>
            </tbody>
        </table>
    </div>
    <div  v-if="comBoxFlag"  style="       height: 250px;
    width: 520px;
    margin-left: -230px;
    padding-top: 5px;
    z-index: 333;
    padding: 20px;
    left: 50%;
    top: 50%;
   box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
    margin-top: -125px;
    position: absolute;
    background: rgb(255, 255, 255);"  >
        <%--<p style="position:relative; text-align: center; font-size: 22px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;">--%>
            <%--个人版介绍</p>--%>
        <%--<span class="closetranform" style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" v-on:click="close"><img src="/images/close_user.png" alt="点击关闭"></span>--%>
        <span v-on:click="close" class="iconfont_new tranform" style="    font-size: 58px;
    color: rgb(255, 255, 255);
    position: absolute;
    right: -100px;
    top: -12px;
    ">&#xe6a0;</span>
       <p style="    height: 70px;
    line-height: 70px;
    text-align: center;">- 对账大使推广返现奖励规则 -</p>
        每邀请一个朋友注册易对账的企业账号并成为付费用户，邀请人即可获得100元现金奖励；超过5个（从第6个开始），每邀请成功一位可获得200元奖励。
            <br>
            <br>
        <p>多邀多得不设上限，邀请后不设时间限制，长期有效。</p>
    </div>
    <div  v-if="comBox3Flag"  style="      height: 480px;
    width: 520px;
    margin-left: -260px;
    padding-top: 5px;
    z-index: 333;
    left: 50%;
    top: 50%;
    border: 1px solid rgb(204, 204, 204);
    margin-top: -240px;
    position: absolute;
    background: rgb(255, 255, 255);"  class="personalInfo  " >
    <p style="position:relative; text-align: center; font-size: 22px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;">
    个人版介绍</p>
    <%--<span class="closetranform" style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" v-on:click="close"><img src="/images/close_user.png" alt="点击关闭"></span>--%>
    <span v-on:click="close" class="iconfont_new tranform" style="    font-size: 58px;
    color: rgb(255, 255, 255);
    position: absolute;
    right: -100px;
    top: -12px;
    ">&#xe6a0;</span>
    <div style="text-align: center;margin: 0 auto;">
    <img class="comImgTran" style="margin:44px auto 26px;width:120px;height: 120px;border-radius: 60px;"  src="/images/page/personalTx.png"/>
    <p style="font-size: 20px;color:#333;">成为易对账推广大使</p>
    <p style="font-size: 14px;color:#666;margin:16px auto 24px;">邀请好友来使用，奖励拿不停</p>
    <div>
    <button type="button" v-on:click="close" class="btnEnter" style="margin-bottom:22px;cursor:pointer;width:280px;height:38px;font-size:14px;" >我知道了，去看看活动规则</button>
    </div>
    <a style="font-size: 14px;margin:22px auto;color:#4284d9;cursor:pointer;" v-on:click="regOpen">如需销售开单、采购记账，需开通企业版 > </a>

    </div>
    </div>
</div>

    <script>
        var app= new Vue({
            el: '#app',
            data: {
                comBoxFlag: false,
                comBox2Flag: false,
                comBox3Flag: false
            },
            mounted:function () {
            },
            created:function () {
                $("#app").removeClass("hide");
             this.mainOpen("0");
//                $.get("/invite/normal/getKey", {}, function (data) {
//                });
                var clipboard = new Clipboard('#inventMsgBtn', {
                    target: function () {
                        return document.getElementById('inventMsg');
                    }
                });
                clipboard.on('success', function (e) {
                    tipsPop("复制成功，赶快去分享给微信或QQ上的好友");
                });
                clipboard.on('error', function (e) {
                    tipsPop("您的浏览器不支持");
                });
            },

            ready: function() {

            },

            methods: {
//                getProv:function (val) {
//
//                },
//                getCountry:function (val) {
//
//                },
                enterLi:function (e) {
                    var btn=e.currentTarget;
                    $(btn).addClass("active").siblings().removeClass("active");
                    $(".tdData").addClass("hide");
                    $(".tdData"+$(btn).index()).removeClass("hide");
                    this.mainOpen($(btn).index());
                },
                regOpen: function() {
                    window.parent.location.href="/openPage?pageName=choose-scene&tp=create";
                },
                comOpen: function() {
                    this.result.comType="";
                    this.result.industryId="";
                    this.comBox4Flag=true;
                    this.comBox5Flag=false;
                },
                show: function() {
                    this.comBoxFlag=true;
//                    this.comBox2Flag=true;
//                    this.initDt();
                },
                close: function() {
                    this.comBox3Flag=false;
                    this.comBoxFlag=false;
                    this.comBox2Flag=false;
                },
                successOpen: function() {
                    var d=this.result.comType;
                    if(!d ||d==""){
                        tipsPop("请选择公司类型");
                        return;
                    }
                    this.comBox5Flag=true;
                    this.comBox4Flag=false;

//                    this.initDt();
                },
                startOpen: function(event) {
                    var that=this,btn=event.currentTarget;
//                    this.initDt(); 我已确定，立即开通
                    $(btn).attr("disabled", "disabled").html("正在开通...");
                    var industryId =  that.result.industryId;
                    $.ajax({
                        url: '/payment/upgradeTrialVersion',
                        type: 'GET',
                        async: true,
                        dataType: "json",
                        data: {industryId: industryId},
                        success: function (data) {
                            if (data.state == true) {
                                $(btn).removeAttr("disabled").html("我已确定，立即开通");
                                that.comBox7Flag=true;
                                that.comBox6Flag=false;
                            }
                        },
                        error: function () {
                            $(btn).removeAttr("disabled").html("我已确定，立即开通");
                            tipsPop("升级失败");
                        }
                    });
                },
                typeOpen: function() {
                    this.comBox4Flag=true;
                    this.comBox2Flag=false;
//                    this.initDt();
                },
                radioSel:function (event) {
                    var that=this,btn=event.currentTarget;
                    that.result.comType=$(btn).attr("did");
                    that.result.industryId=$(btn).attr("aid");
                    $(btn).find("input[type='radio']").prop('checked', true);
                },
                mainOpen: function(type) {
                    $.get("/ydz/user/my-promotion",{"paid":type},function (callback) {
                        var dt = eval("("+callback+")");
                        var baseData = dt.data;
                        var html="";
                        $.each(baseData,function(key, val){
                            html +=
                                "<tr>"
                                +"<td style='width:15%'>"+val.realName+"</td>"
                                +"<td style='width:20%'>"+val.userId+"</td>"
                                +"<td style='width:25%'>"+val.comName+"</td>"
                                +"<td style='width:25%'>"+val.createTime+"</td>"
                                +"</tr>";
                        });
                       $(".tdData"+type).find("tbody").empty().html(html);
                    })
                },
                marketOpen: function(event) {
                    var btn=event.currentTarget;
                    $(btn).attr("disabled",true);
                    $.post(
                        "/reg/toBePromoter",
                        function (data) {
                            window.location.href="/login/tomain";
                        }
                    )


                },
                save:     function (event) {
                    var that=this,btn=event.currentTarget;
                    $(btn).css({"pointer-events": "none"}).html("创建中...");
                    var bossOrAdmin = $(".chose-manger").find(".active").data("value");
                    var comName = $.trim($("#comName").val());
                    if (comName == "") {
                        $(btn).css({"pointer-events": "auto"}).html("创建企业，开始记对账");
                        tipsPop("请填写企业全称");
                        return false;
                    }
                    var comShortname = $.trim($("#comShortname").val());
                    if (comShortname == "") {
                        $(btn).css({"pointer-events": "auto"}).html("创建企业，开始记对账");
                        tipsPop("请填写企业简称");
                        return false;
                    }
                    var province = $("#province").val();
                    if (province == "" || province == null) {
                        $(btn).css({"pointer-events": "auto"}).html("创建企业，开始记对账");

                        tipsPop("请选择省");
                        return false;
                    }
                    var city = $("#city").val();
                    if (city == "" || city == null) {
                        $(btn).css({"pointer-events": "auto"}).html("创建企业，开始记对账");
                        tipsPop("请选择市");
                        return false;
                    }
                    var country = $("#country").val();
                    if (country == "" || country == null) {
                        $(btn).css({"pointer-events": "auto"}).html("创建企业，开始记对账");
                        tipsPop("请选择区/县");
                        return false;
                    }
                    $.post(
                        "/reg/saveCom",
                        {
                            bossOrAdmin: bossOrAdmin,
                            comName: comName,
                            comShortname: comShortname,
                            comProvince: province,
                            comCity: city,
                            comCountry: country
                        },
                        function (data) {

                            if (data.state) {
//                            $.get("/company/openPerson", {userKey_person: data.userKey_person, comType: "1"}, function (data) {
//                            });
                                <%--cola.model().set("create_company", {--%>
                                <%--comName: comName,--%>
                                <%--adminName: '${sessionScope.sessionUser.realName}',--%>
                                <%--adminPhone: '${sessionScope.sessionUser.userId}',--%>
                                <%--comId: data.comId--%>
                                <%--});--%>
//                            $(".createComCon").fadeOut();
                                <%--that.result.comName=comName;--%>
                                <%--that.result.adminName='${sessionScope.sessionUser.realName}';--%>
                                <%--that.result.adminPhone='${sessionScope.sessionUser.userId}';--%>
                                <%--that.result.comId=data.comId;--%>

                                setTimeout(function () {
//                                    that.comBoxFlag = false;
//                                that.comBox2Flag = true;
//                                    that.comBox4Flag=true;
                                    window.location.href="/login/tomain";
                                },2000);

//                                this.comBox2Flag=false;
                            } else {

                                tipsPop(data.msg);
                                $(btn).css({"pointer-events": "auto"}).html("创建企业，开始记对账");

                            }
                        }
                    )
                },
                create:  function (val) {
                    switch (val) {
                        case "1":
//                        $(".createComCon").fadeIn();
                            this.comBoxFlag = false;
                            //默认省市



                            break;
                        case "2":
//                        $.post("/company/openPerson", {}, function (data) {
//                        });
//                        $(".createComCon").fadeOut();
//                        $("#comApp").removeClass("hide");

//                            $("#registerApp").removeClass("hide");
                            if(iscreate){
                                window.location.href="/login/tomain";
                            }else{
                                this.comBoxFlag=false;
                                this.showFlag=true;
                            }

                            break;
                        //点击创建个人
                        case "3":
                            $.post(
                                "/company/openPerson", {}, function (data) {
                                    if (data == "1") {
                                        window.location.reload();
//                            $(".chose-style").fadeOut();
                                    } else {
                                        alert("请重新登录");
                                    }
                                });
                            break;
                    }
                }
            }
        });

        //   app.comBox2Flag=true;
        //   app.comBoxFlag=true;
        //创建企业

        //    createCompanyModel("1");
        //创建公司


        function tipsPop(h) {
            $(".tips_contants").empty();
            $("<div class='tips_contants'>").fadeIn(250).html(h).delay(1000).fadeOut(250).appendTo('body');
        }

    </script>
</body>
</html>