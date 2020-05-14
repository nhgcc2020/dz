<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <link rel="stylesheet" type="text/css" href="/resources/new/iconfont.css?v=07c82181ff">
    <link rel="stylesheet" type="text/css" href="/resources/business/order-table.css?v=7367cb39d5">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/animate.css?v=044dba19fd">
    <style>
        .dis_input > input {
            background-color: #f2f5f7 !important;
        }

        #partnerAttrNew input {
            width: 300px;
        }

        .ui.segment {
            padding: 0px;
        }

        .tips_contants {
            height: 80px;
            line-height: 80px;
            width: 350px;
            text-align: center;
            background: rgba(0, 0, 0, 0.8);
            color: #fff;
            position: absolute;
            top: 50%;
            margin-top: -150px;
            left: 50%;
            margin-left: -150px;
            border-radius: 5px;
            display: none;
            z-index: 10000;
        }

        body {
            height: 100%;
            width: 100%;
        }

        .friendAdd {
            color: #ccc;
            font-size: 14px;
        }

        .friendAdd:hover {
            text-decoration: underline;
            color: #558edd;
            cursor: pointer;
        }

        .blueColor {
            color: #2e8ae6;
        }
        .fixheader {
            background: #fff;
            height: 55px;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            border-bottom: 1px solid #dddddd;
            padding: 8px 20px 0 20px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 99;
            overflow: hidden;
        }
        #tableContainer{
            padding-top:80px !important;
            /*border: 1px rgb(204, 204, 204) solid;box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.3);*/
        }
        .btfontSize{
            font-size: 12px;
            vertical-align: middle;
            color:#4e8ae6;
            cursor: pointer;
        }
        .btfontSize2{
            font-size: 16px;
            vertical-align: middle;
            color:#4e8ae6;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div id="orderProcedure" class=" animated flipInY" style="box-shadow: rgba(0, 0, 0, 0.2) 1px 3px 10px 2px;
 width:680px;-webkit-animation-fill-mode:both;-webkit-animation-duration: 1s;display: none;
 background: rgb(255, 255, 255); position: absolute; z-index: 9999; top: 50%; left: 50%; margin-left: -290px; margin-top: -208px; ">
    <div style="font-size: 18px;color: #333;line-height: 50px; border-bottom: 1px solid #e4e4e4; padding-left: 15px;">
        加好友
    </div>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="closeOverFlow()"><img src="../../images/close_user.png" alt="点击关闭"></span>

    <div style="margin: 0 auto; width:600px;">
        <div style="background: url('/resources/images/addfriend.png?v=0629')  no-repeat;margin-top:10px;height: 80px;"></div>
        <div style="font-size: 12px;color:#666;background-color: #f5f5f5; text-align: center;margin: 20px auto; line-height: 30px;">
            作为好友，你给对方建的销售单，对方可以通过采购菜单查看！
        </div>
        <div style=" padding: 0 20px;">
            <div class="invite_content" style="
          margin-top:2rem;
    text-align: center;">
                <p id="inviteCom" style="font-size:16px; margin: 1rem auto 2rem;"></p>
                <p id="inviteName" style="color:#ccc; margin: 1rem auto 2rem;"></p>
                <input type="hidden" value="" id="partnerKeyPop">
                <input name="sendPhone" id="sendPhone" maxlength="11" placeholder="请填写手机号码" style="
            margin: 0em;
    -webkit-box-flex: 1;
    -webkit-flex: 1 0 auto;
    -ms-flex: 1 0 auto;
    flex: 1 0 auto;
    -webkit-tap-highlight-color: rgba(255, 255, 255, 0);
    text-align: left;
    padding: 0px 30px 0px 10px;
    height: 30px;
    line-height: 30px;
    background: #FFFFFF;
    border: 1px solid #adadad;
    color: #999;
    border-radius: 3px;
    transition: box-shadow 0.1s ease, border-color 0.1s ease;
            width:250px;" onblur="checkPhoneblur()" onkeyup="checkPhone()"><span style="    cursor: pointer;
    font-size: 12px;
    margin-left: 10px;
    color: #2e8ae6;
    font-weight: 700;" id="modifyTel" class="hide">修改手机号码</span>
                <p style="color: #ff9900;margin: 1rem auto 2rem;font-size: 12px;width: 350px;">
                    <span style="    font-size: 20px;
    vertical-align: bottom;" class="iconfont_new">&#xe6bc;</span><span id="tips">请再次确认，发送后如对方注册成功，手机号将无法修改</span></p>
            </div>
        </div>
        <div style="clear: both; padding-bottom: 20px; text-align: center">
            <button type="button" class="btn  btn-default" onclick="closeOverFlow()" style="width:100px;">取消</button>
            <button type="button" id="sendMsgBtn" disabled class="btn btn-primary"
                    style="margin-left:15px;width:100px;font-size:12px;" onclick="sendMsg(this)">发送短信
            </button>
        </div>
    </div>

</div>


<div class="fixheader">
    <div class="actions" style="margin-top: .5rem;">
        <div c-widget="button;class:primary;caption:保存;click:savePartnerCom"></div>
        <div c-widget="button;caption:取消;click:closeDiv" style="background:transparent;"></div>
    </div>
</div>
<div style="margin: 0 auto;width: 880px;" class="show-on-ready" id="tableContainer">
    <div style="position:relative;text-align: center;margin-bottom: 3rem;font-size: 2rem;width: 850px;">伙伴信息修改
        <div class=" hide friend5 "
             style=" font-size: 12px;  color: #2e8ae6;cursor: pointer;position: absolute;right: 40px;top:10px;"
             onclick="showOverFlow(this,5)"><span class="iconfont_new" style="     font-size: 30px;
    vertical-align: middle;
    top: -2px;
    position: relative;">&#xe6c8;</span>邀请加为好友，订单互相同步
        </div>
        <div class="hide friend1"
             style="  font-size: 12px;  color: #47b183;position: absolute;right: 40px;top:10px;"><span
                class="iconfont_new" style="    font-size: 30px;
    vertical-align: middle;">&#xe6c8;</span>互为好友，订单随时同步
        </div>
        <div class="hide friend2"
             style="  font-size: 12px;  color: #ababab;position: absolute;right: 40px;top:10px;"><span
                class="iconfont_new" style="    font-size: 20px;
    vertical-align: middle;">&#xe6f3;</span>申请中...(等待对方同意)
        </div>
        <div class="hide friend6" onclick="showOverFlow(this,6)"
             style="cursor: pointer;  font-size: 12px;  color: #ababab;position: absolute;right: 40px;top:10px;"><span
                class="iconfont_new" style="     font-size: 20px;
    vertical-align: middle;
    top: -2px;
    position: relative;">&#xe6f3;</span>邀请中...<span style="color:#2e8ae6">(重新发送邀请)</span></div>
        <%--<span style="color: #ababab;">(发出邀请)</span>--%>
    </div>
    <div c-widget="form" style="width: 850px">
        <div class="ui form">
            <div class="inline field">
                <label style="width: 80px"><span style="color: red">*</span>企业全称</label>
                <div c-widget="input;width:300px;bind:partner.partnerName;tag:disInput;class:{{forbiddenClass}};readOnly:{{forbiddenFlag}}"></div>

                <label style="width: 80px;margin-left:40px"><span style="color: red"></span>公司电话</label>
                <div c-widget="input;width:300px;bind:partner.partnerTel;"></div>
            </div>

            <div class="inline field">
                <label style="width: 80px"><span style="color: red">*</span>企业简称</label>
                <div c-widget="input;width:300px;bind:partner.partnerShortname;tag:disInput;change:getZJM;class:{{forbiddenClass}};readOnly:{{forbiddenFlag}}"></div>

                <label style="width: 80px;margin-left:40px"><span style="color: red"></span>公司QQ</label>
                <div c-widget="input;width:300px;bind:partner.partnerQQ;"></div>
            </div>

            <div class="inline field">
                <label style="width: 80px;">&nbsp;助记代码</label>
                <div c-widget="input;width:300px;bind:partner.mnemonicCode;"></div>

                <label style="width: 80px;margin-left:40px">公司区域</label>
                <div style="display: inline-block;width: 300px">
                    <div id="comProvince" style="width: 30%" c-widget="icon:dropdown iconfont"></div>
                    <div id="comCity" style="width: 30%; margin:0px 11px;" c-widget="icon:dropdown iconfont"></div>
                    <div id="comCountry" style="width: 30%" c-widget="icon:dropdown iconfont"></div>
                </div>
            </div>

            <div class="inline field">
                <label style="width: 80px;">&nbsp;联系姓名</label>
                <div c-widget="input;width:300px;bind:partner.contacterName;tag:disInput;class:{{forbiddenClass}};readOnly:{{forbiddenFlag}}"></div>

                <label style="width: 80px;margin-left:40px">公司地址</label>
                <div c-widget="input;width:300px;bind:partner.partnerAddress;"></div>
            </div>

            <div class="inline field">
                <label style="width: 80px">&nbsp;联系手机</label>
                <div c-widget="input;width:300px;bind:partner.tel1;tag:disInput;change:addQuery2;class:{{forbiddenClass}};readOnly:{{forbiddenFlag}}"></div>
                <label style="width: 80px;margin-left:40px">伙伴属性</label>
                <div id="partnerAttrNew" c-widget=" icon:dropdown iconfont;" style="display: inline-block"></div>
            </div>
            <div class="inline field">
                <label style="width: 80px">&nbsp;三证合一</label>
                <div c-widget="input;placeholder:统一社会信用代码;width:300px;bind:partner.taxNo;"></div>
            </div>

            <div class="inline field">
                <label style="width: 80px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注</label>
                <textarea placeholder="可将催款、催货、查账等重要事宜通过备注做记录，防止遗忘" rows="2" style="width:87.5%;height: 4rem"
                          c-bind="partner.remarks"></textarea>
            </div>

            <div class="inline field">
                <label style="width: 80px;">&nbsp;价格级别</label>
                <div id="radioGroup4" c-widget="RadioGroup;name:brand4;bind:partner.partnerLevel"
                     style="display: inline-block"></div>
            </div>
        </div>
    </div>
    <div style=" height: 1px; width: 850px; margin: 2rem 0 2rem 0; background: #e4e4e4;"></div>

    <div c-widget="form" id="contactIdSec">
        <div  class="ui form">

            <div class="inline field" c-repeat="employee in employees">
                <label style="width: 80px;">&nbsp;&#x3000;联系人</label>
                <div c-widget="input;width:300px;placeholder:其他联系人姓名;bind:employee.contacterName;tag:disInput;"></div>
                <label style="width: 80px;margin-left:40px">&nbsp;&#x3000;手机号</label>
                <div c-widget="input;width:300px;bind:employee.tel1;"></div>
                <span class="btfontSize" c-onclick="remove(employee)" title="删除">删除</span>
                <span class="btfontSize" c-onclick="saveEmployee(employee)" title="保存">保存</span>
            </div>

        </div>
        <div  class="ui form" style="margin: 25px 0 40px 0;">

        <div class="inline field" >
        <label style="width: 80px;"></label>
        <span class="glyphicon glyphicon-plus btfontSize2" c-onclick="addEmployee()" style="top:-3px;color:#4284d9"></span><label style="
        font-size: 14px;color:#4284d9;cursor: pointer;
        margin-left: 5px;" c-onclick="addEmployee()">添加其他联系人</label>
        </div>

        </div>

    </div>

</div>

<script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
<script src="/resources/cola-ui/3rd.min.js?v=59f8ac5b1a"></script>
<script src="/resources/cola-ui/semantic.min.js?v=ce263d5009"></script>
<script src="/resources/cola-ui/cola.min.js?v=96274d219a"></script>
<script src="/resources/business/util.js?v=cee3a7629a"></script>
<script src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
<script>

    function checkPhoneblur() {
        var keyword = $("#sendPhone").val();
        if (keyword.length < 11) {
            $("#sendMsgBtn").prop("disabled", true);
            $("#tips").html("手机号码格式错误");
        }

    }
    function checkPhone() {
        var keyword = $("#sendPhone").val();

        if (keyword.length < 11) {
            $("#sendMsgBtn").prop("disabled", true);
            return;
        }
        if (!(/^1[34578]\d{9}$/.test(keyword))) {
//            $("#tips").css("color", "#DA4654");
            $("#tips").html("手机号码格式错误");
            $("#sendMsgBtn").prop("disabled", true);
            comFalgCom = false;
            return comFalgCom;
        }
//       $("#sendMsgBtn").prop("disabled", false);
        $.ajax({
            type: "POST",
            url: "/system/partner/isRegistered",
            data: {phone: keyword},
            dataType: "json",
            success: function (data) {
                if (data) {
//                    $("#tips").css("color", "#DA4654");
                    $("#tips").html("该手机已注册，请通过顶部 + <span class='blueColor'>加对方为好友</span> 吧");
                    $("#sendMsgBtn").prop("disabled", true);
                    comFalgCom = false;
                } else {
//                    $("#tips").css("color", "#ee8e52");
                    $("#tips").html("请再次确认，发送后如对方注册成功，手机号将无法修改");
                    $("#sendMsgBtn").prop("disabled", false);
                    comFalgCom = true;
                }
            }
        });
        return comFalgCom;

    }
    function showOverFlow(obj, type) {
        var partner = $(obj);
        var partnerAttr = partner.data("did");
        if (type == "5") {
            $("#sendMsgBtn").text("发送短信");
        } else {
            $("#sendPhone").prop("disabled", true).css({"background-color": "#eee"});
            $("#sendMsgBtn").text("重新发送短信");
            $("#modifyTel").removeClass("hide").click(function () {
                $("#sendPhone").prop("disabled", false).css({"background-color": "#fff"});
                //$(this).remove();
            });

        }
        //1 公司
        if (partnerAttr == "1") {
            $("#inviteCom").html(partner.data("id"));
        } else {
            $("#inviteCom").html("个人伙伴");
        }
        $("#sendPhone").val(partner.data("pid"));
        if ($("#sendPhone").val() == "" || !(/^1[34578]\d{9}$/.test($("#sendPhone").val()))) {
            $("#sendMsgBtn").prop("disabled", true);
        } else {
            $("#sendMsgBtn").prop("disabled", false);
        }
        $("#inviteName").html(partner.data("cid"));
        $("#partnerKeyPop").val(partner.data("kid"));
        $("#partnerAttrPop").val(partnerAttr);
        $("#orderProcedure").css({display: 'block'});
        $(".window-mask").show();
    }
    function closeOverFlow() {
//        $("#orderProcedure").addClass(" flipOutY").removeClass("flipInY");//css({display:'none'});
        $("#orderProcedure").css({display: 'none'});//css({display:'none'});
        $("#sendPhone").val("");
        $("#partnerKeyPop").val("");
        $("#partnerAttrPop").val("");
        $("#sendMsgBtn").prop("disabled", true);
        $(".window-mask").hide()
    }
    function sendMsg(btn) {
        $("#sendMsgBtn").prop("disabled", true);
        var partnerKey = $("#partnerKeyPop").val();
        var phone = $("#sendPhone").val();
        $.post("/system/partner/sendInviteMsg",
            {
                partnerKey: partnerKey,
                partnerAttr: $("#partnerAttrPop").val(),
                phone: phone
            },
            function (data) {
                $("<div class='tips_contants'>").fadeIn(50).html("发送成功，等待对方查看").delay(2000).fadeOut(250).appendTo('body');
                if (data.state) {
                    setTimeout(function () {
                        window.location.reload();
                    }, 2000);
                }
                $("#sendMsgBtn").prop("disabled", true);
            })
    }
    cola(function (model) {
        var partnerKey = "${partnerKey}";
        var contacterId = "${contacterId}";
        var comFalg = true;
        var partnerStatus;
        $.ajax({
            type: "POST",
            url: "/system/partner/partnerInfo",
            data: {partnerKey: partnerKey,contacterId:contacterId},
            async: false,
            dataType: "json",
            success: function (callback) {
                //获取合作伙伴信息
                model.set("partner", callback);
                var partner = model.get("partner");
                // 其他联系人的方式
                model.describe("employees", {
                    provider: "/system/partner/listPartnerContacter?partnerKey="+partnerKey+"&contacterIdNo="+partner.get("contacterId")
                });
                if(partner.get("partnerType")=="2"){
                    $("#contactIdSec").hide();
                }

                partnerStatus = partner.get("partnerStatus");
                if (partnerStatus != "5") {
                    model.set("forbiddenFlag", true);
                    model.set("forbiddenClass", "dis_input");
                } else {
                    model.set("forbiddenFlag", false);
                    model.set("forbiddenClass", "");
                }
                if (partnerStatus == "1") {
                    $(".friend1").removeClass("hide");

                } else if (partnerStatus == "2") {
                    $(".friend2").removeClass("hide");
                } else if (partnerStatus == "6") {
                    $(".friend6").removeClass("hide");
                    $(".friend6").attr("data-kid", partner.get("partnerKey"));
                    $(".friend6").attr("data-pid", partner.get("tel1"));
                    $(".friend6").attr("data-cid", partner.get("contacterName"));
                    $(".friend6").attr("data-id", partner.get("partnerName"));
                    $(".friend6").attr("data-did", partner.get("partnerAttr"));
                } else if (partnerStatus == "5") {
                    $(".friend5").removeClass("hide");
                    $(".friend5").attr("data-kid", partner.get("partnerKey"));
                    $(".friend5").attr("data-pid", partner.get("tel1"));
                    $(".friend5").attr("data-cid", partner.get("contacterName"));
                    $(".friend5").attr("data-id", partner.get("partnerName"));
                    $(".friend5").attr("data-did", partner.get("partnerAttr"));
                }
            }
        });



        var comProvince = model.get("partner.partnerProvince");
        var cityArray = [];
        for (var j = 0; j < CityJson.length; j++) {
            if (CityJson[j].provinceId == comProvince) {
                cityArray.push(CityJson[j])
            }
        }
        model.set("provinceList", ProvinceJson);
        model.set("cityList", cityArray);

        var comCity = model.get("partner.partnerCity");
        var countryArray = [];
        for (var k = 0; k < CountryJson.length; k++) {
            if (CountryJson[k].cityId == comCity) {
                countryArray.push(CountryJson[k])
            }
        }
        model.set("countryList", countryArray);
        var partnerAttrNew = [{"id": 1, "name": "客户"}, {"id": 2, "name": "供应商"}, {"id": "A", "name": "既是客户又是供应商"}];
        model.set("partnerAttrList", partnerAttrNew);
        model.action({
            remove: function(employee) {

//               if( model.get("employees").entityCount<2){return};
                if(employee.get("contacterId")==undefined ||employee.get("contacterId")==null){
                    employee.remove();
                }else{
                    $.ajax({
                        type: "DELETE",
                        url: "/system/partner/deleteContacter?partnerKey="+partnerKey+"&contacterId="+employee.get("contacterId"),
                        contentType: "application/json;charset=UTF-8",
                        success: function (callback) {
                            if (callback.code == "1") {
                                $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(1000).fadeOut(250).appendTo('body');
                                model.flush("employees");
                            } else {
                                $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(2000).fadeOut(250).appendTo('body');
                            }
                        }
                    })
                }
            },
            addEmployee: function() {
                model.get("employees").insert({});
            },
            saveEmployee: function(employee) {

                if(employee.get("contacterId")==undefined ||employee.get("contacterId")==null){
                    var param= {
                        "partnerKey":partnerKey, //合作伙伴key
                        "contacterName":employee.get("contacterName"), //联系人姓名
                        "tel1":employee.get("tel1")  //联系人电话
                    };
                    $.ajax({
                        type: "POST",
                        url: "/system/partner/newContacter",
                        data:JSON.stringify(param),
                        contentType: "application/json;charset=UTF-8",
                        success: function (callback) {
                            if (callback.code == "1") {
                                $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(1000).fadeOut(250).appendTo('body');
                                model.flush("employees");
                            } else {
                                $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(2000).fadeOut(250).appendTo('body');
                            }
                        }
                    })
                }else{
                    // 更新
                    var param= {
                        "partnerKey":partnerKey, //合作伙伴key
                        "contacterId":employee.get("contacterId"), //联系人ID
                        "contacterName":employee.get("contacterName"), //联系人姓名
                        "tel1":employee.get("tel1")  //联系人电话
                    };
                    $.ajax({
                        type: "put",
                        url: "/system/partner/updateContacter",
                        data:JSON.stringify(param),
                        contentType: "application/json;charset=UTF-8",
                        success: function (callback) {
                            if (callback.code == "1") {
                                $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(1000).fadeOut(250).appendTo('body');
                                model.flush("employees");
                            } else {
                                $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(2000).fadeOut(250).appendTo('body');
                            }
                        }
                    })
                }


            },
            addQuery2: function (btn) {
                var phone = model.get("partner.tel1");
                if (phone != undefined && phone != "") {
                    $.ajax({
                        type: "POST",
                        url: "/system/partner/isRegistered",
                        data: {phone: phone},
                        async: false,
                        dataType: "json",
                        success: function (data) {
                            if (data) {
                                $("<div class='tips_contants'>").fadeIn(250).html("该手机用户已使用易对账，通过加对方为好友加他吧").delay(2000).fadeOut(250).appendTo('body');
                                //model.set("partner.tel11","");
                                comFalg = false;
                            } else {
                                comFalg = true;
                            }
                        }
                    });

                } else {
                    comFalg = true;
                }
                return comFalg;
            },
            savePartnerCom: function (btn) {

                var partner = model.get("partner");
                if (partner.get("partnerName") == undefined || partner.get("partnerName") == "") {
                    $("<div class='tips_contants'>").fadeIn(250).html("请填写企业全称").delay(2000).fadeOut(250).appendTo('body');
                    return false;
                }
                if (partner.get("partnerShortname") == undefined || partner.get("partnerShortname") == "") {
                    $("<div class='tips_contants'>").fadeIn(250).html("请填写企业简称").delay(2000).fadeOut(250).appendTo('body');
                    return false;
                }

                if (partnerStatus == "5" && !model.action("addQuery2")()) {
                    return false;
                }

                if (partner.get("partnerType") != "2") {
                    if ($.trim(partner.get("partnerLevel")) == "") {
                        $("<div class='tips_contants' style='line-height: 40px;'>").fadeIn(250).html("请选择一个价格级别<br>价格级别和服务定价有关，请谨慎选择，以免给错价").delay(2000).fadeOut(250).appendTo('body');
                        return false;
                    }
                }

                if (model.get("partner.remarks") != undefined && model.get("partner.remarks").length > 50) {
                    $("<div class='tips_contants'>").fadeIn(250).html("备注不可大于50字符").delay(2000).fadeOut(250).appendTo('body');
                    return false;
                }

                $.post(
                    "/system/partner/modPartner",
                    model.get("partner"),
                    function (data) {
                        $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(2000).fadeOut(250).appendTo('body');
                        if (data.state) {
//                                window.parent.partnerModel.flush("items");
                            setTimeout(function () {
                                parent.closeModPartner(0);
                            }, 2000);
                        }
                    }
                )
            },
            closeDiv: function () {
                parent.closeModPartner();
            }
        })
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
            },
            partnerAttrNew: {
                $type: "dropdown",
                items: "{{partnerAttrList}}",
                openMode: "drop",
                valueProperty: "id",
                textProperty: "name",
                value: "{{partner.partnerType}}",
                change: function (self, arg) {
                    model.set("partner.partnerType", arg.value);
                }
            },
//            radioGroup3: {
//                items: [{
//                    label: "既是客户又是供应商",
//                    value: "A"
//                }, {
//                    label: "我的客户",
//                    value: "1"
//                }, {
//                    label: "我的供应商",
//                    value: "2"
//                }]
//            },
            radioGroup4: {
                items: [{
                    label: "优惠价",
                    value: "1"
                }, {
                    label: "标准价",
                    value: "2"
                }, {
                    label: "零散价",
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
    })
</script>
</body>
</html>
