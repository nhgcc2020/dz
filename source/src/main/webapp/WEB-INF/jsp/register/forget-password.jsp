
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="renderer" content="webkit">
    <title>重置密码</title>
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <!--加载公共js-->
    <script type="text/javascript" src="/resources/business/util.js?v=cee3a7629a"></script>
    <script src="/common/growingio.js"></script>
    <style>
        *, *:before, *:after {
            box-sizing: inherit;
        }
        ::-webkit-input-placeholder{
                 font-size: 14px;
             }
        html, body {
            height: 100%;
        }
        .field {
            text-align: center;
            margin-bottom: 20px !important;
        }
        .ui.form .field .ui.input, .ui.form .fields .field .ui.input, .ui.form .wide.field .ui.input {
            width: 100%;
        }
        .ui.input {
            font-size: 1em;
        }
        .ui.input {
            position: relative;
            font-weight: normal;
            font-style: normal;
            display: -webkit-inline-flex;
            display: -ms-inline-flexbox;
            display: inline-flex;
            color: rgba(0, 0, 0, 0.87);
        }
        input[type="text"], input[type="email"], input[type="search"], input[type="password"] {
            -webkit-appearance: none;
            -moz-appearance: none;
        }
        .ui.form {
            position: relative;
            max-width: 100%;
        }
        .ui.form .fields .field .ui.input input, .ui.form .field .ui.input input {
            width: auto;
        }
        .ui.form input:not([type]), .ui.form input[type="date"], .ui.form input[type="datetime-local"], .ui.form input[type="email"], .ui.form input[type="number"], .ui.form input[type="password"], .ui.form input[type="search"], .ui.form input[type="tel"], .ui.form input[type="time"], .ui.form input[type="text"], .ui.form input[type="url"] {
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
        .ui.form textarea, .ui.form input:not([type]), .ui.form input[type="date"], .ui.form input[type="datetime-local"], .ui.form input[type="email"], .ui.form input[type="number"], .ui.form input[type="password"], .ui.form input[type="search"], .ui.form input[type="tel"], .ui.form input[type="time"], .ui.form input[type="text"], .ui.form input[type="url"] {
            width: 100%;
            vertical-align: top;
        }
        .ui.input input {
            margin: 0em;
            max-width: 100%;
            -webkit-box-flex: 1;
            -webkit-flex: 1 0 auto;
            -ms-flex: 1 0 auto;
            flex: 1 0 auto;
            outline: none;
            -webkit-tap-highlight-color: rgba(255, 255, 255, 0);
            text-align: left;
            padding: 0px 30px 0px 10px;
            height: 30px;
            line-height: 30px;
            background: #FFFFFF;
            border: 1px solid #adadad;
            color: #999;
            border-radius: 3px;
            -webkit-transition: box-shadow 0.1s ease, border-color 0.1s ease;
            transition: box-shadow 0.1s ease, border-color 0.1s ease;
            box-shadow: none;
        }
        @media only screen and (min-width: 1440px) {
            .w {
                margin: 0 auto;
                width: 1100px;
            }
            .login_form {
              /*  margin-right: 3rem*/
            }
        }

        @media only screen and (max-width: 1440px) {
            .w {
                margin: 0 auto;
                width: 1100px;
            }
        }

        @media only screen and (min-width: 1900px) {
            .login_form {
               /* margin-right: 3rem;*/
            }
        }

        .field {
            margin-bottom: 20px !important;
        }

        a:hover {
            text-decoration: underline;
            cursor: pointer;
            color: #4183c4 !important;
        }
        .foot_separate{
            display: inline-block;
            margin: auto 5px;
        }
        .company_list{
            margin-bottom: 1rem;
            padding: 0.3rem;
            cursor: pointer;
            padding-left: 1.8rem;
        }

        .comli_checked{
            padding: 0.3rem;
            background: #337AB7;color: white;

        }

        .tips_contants{
            height: 80px;
            line-height: 80px;
            width:300px;
            text-align: center;
            background: rgba(0,0,0,0.8);
            color: #fff;
            position: absolute;
            top:50%;
            margin-top:-150px;
            left:50%;
            margin-left: -150px;
            border-radius: 5px;
            display: none;
        }
    .input>input{
    height:40px !important;
    marign-bottom:20px !important;
    border-radius: 0 !important;
    }
    .focused>input{
    border:1px solid red !important;
    }
    .ui.basic.blue.button{
    box-shadow:none !important;
    height:40px;
    line-height:40px !important;
        cursor: pointer;
    background:#4284D9 !important;
    color:#fff !important;
    width:100px !important;
    float:right;
    border-radius:0;
    }
    .first{
    position:absolute;
    right:1px;
    top:1px;
    }
    .ui.form .eight.wide.field.second {
    width:360px !important;
    padding:0;
    }
    .bl .blue>span{
    font-size:18px;
    line-height:40px;
    color:#fff;
    font-weight: normal;
    }
    .prome{
    height:40px;
    line-height:26px;
    color:#da4654;
    }
    .prome>div{
    display:none;
    }
    .prome .iconfont_new{
    position:relative;
    font-size:26px;
    top:5px;
    }
    .ui.basic.blue.button.pig{
    background:#999999 !important;
    color:#ffffff !important;
    }
    .ui.basic.blue.button:hover{
    background:#4284D9 !important;
    color:#fff !important;
    }

    .ui.button{
    	border-radius: 0;
    }
    .ui.blue.button{
    	background: #4284d9;
    }
        .login_form  input:focus{
            border:1px solid red !important;
        }
        .back_ground::before{
            content: "";
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            opacity: .6;
            background-color: rgba(0,0,0,.3);
            -webkit-transition: all 3s;
            transition: all 3s;
        }
        .sectionbg{
            background: transparent;
            height: 100%;
            left: 0;
            overflow: hidden;
            position: absolute;
            top: 0;
            text-align: center;
            width: 100%;
            -webkit-transform: translateY(0);
            -ms-transform: translateY(0);
            transform: translateY(0);
            -webkit-transition: -webkit-transform .7s cubic-bezier(.825,0,.5,1);
            transition: -webkit-transform .7s cubic-bezier(.825,0,.5,1);
            transition: transform .7s cubic-bezier(.825,0,.5,1);
            transition: transform .7s cubic-bezier(.825,0,.5,1),-webkit-transform .7s cubic-bezier(.825,0,.5,1);
        }
        .logoNew{
            height: 45px;
            /* margin: 20px 0px 0px 20px; */
            position: absolute;
            cursor: pointer;
            left: 20px;
            top: 20px;
        }
        .logoNew img {
            height: 45px;
            width: auto;
        }
        .lodingBtn{
            background: #2e8ae6 !important;
            position:relative;
        }
        .lodingBtn:after{
            content: "";
            height:20px;
            width:20px;
            position: absolute;
            left:50%;
            margin-left:-12px;
            top:50%;
            margin-top:-12px;
            border-radius:20px;
            border:2px solid #DEDEDE;
            border-right:2px solid #808000;
            z-index:2;
            animation: lodingB 1s linear infinite;
        }
        @keyframes lodingB{
            0%{
                transform: rotate(0deg);
            }
            100%{
                transform: rotate(360deg);
            }
        }
    </style>
    <script src="/resources/common/change_bg.js?v=c5c2beed41d"></script>
</head>

<body>
<div class="sectionbg">
    <div class="back_ground" style="display: none;"></div>
    <div class="logoNew" style="cursor: default; margin:0;">
        <a href="http://www.yiduizhang.com"><img src="/images/login/logo_ad.png" /></a>
    </div>
<!--头部 s-->
<%--<header>--%>
    <%--<div class="menu_body common_width" style="height: 6rem;padding: 1rem;">--%>
    <%--<div><a href="http://www.yiduizhang.com"><img src="/images/login/logo_ad.png" style="width:256px; height:45px;margin:6px;"/></a></div>--%>
        <%--<!--<div class="menu_phone">服务热线@186-2161-9311</div>--%>
    <%--<div class="menu_login">登录</div>-->--%>
    <%--</div>--%>
<%--</header>--%>
<!--头部 end-->
<div class="hope_word"></div>
<div class="home-container" style="background-color:#00A9A6;margin-top: 5%">
    <div class="w" style="height:0;">
        <!--登录 end-->
        <div class='ui form login_form' style="opacity:.9;background-color: white; position:absolute; top:150px!important;right:15%; padding: 0 30px;float: right;top: 2.5rem; height:480px;font-size:12px">
            <div class="field" style="margin: 30px 0 !important; text-align: center;">
                <span style="font-size: 24px;color:#666666;font-family: '微软雅黑';">重置密码</span>
            </div>


            <div class="field">
                <%--<div c-widget="Input;bind:user.userId; placeholder:请输入手机号码; iconPosition:left"></div>--%>
                <div  class="ui input"><input type="text" id="userId" placeholder="请输入手机号码"></div>
            </div>
            <div class="field">
                <%--<div c-widget="Input;bind:user.password1;inputType:password;placeholder:输入新密码; iconPosition:left"></div>--%>
                <div  class="ui input"><input type="password" id="password1" placeholder="输入新密码"></div>
            </div>

            <div class="field">
                <%--<div c-widget="Input;bind:user.password2;inputType:password;placeholder:确认新密码; iconPosition:left"></div>--%>
                <div  class="ui input"><input type="password" id="password2" placeholder="确认新密码"></div>
            </div>
            <div class="ui form">
                <div class="fields">
                    <div class="field eight wide second" style="margin: 0 !important;">
                        <%--<div c-widget="Input;placeholder:输入短信验证码;name:code;bind:user.code"></div>--%>
                            <div  class="ui input"><input type="text" name="code" id="code" placeholder="输入短信验证码"></div>
                    </div>
                <div class="field eight wide first" style="margin: 0;">
            <!--<div c-widget="button; class:basic; color:blue; caption:blue;"></div>-->
                    <%--<div id="but" c-widget="button; click:sendCode;class:basic;color:blue;width:100%"style="font-weight: 500;min-width: 115px;padding: 0px;">获取验证码</div>--%>
                    <div id="but" onclick="forgetFun.sendCode(this)" style="font-weight: 500; min-width: 115px; padding: 0px; width: 100%;"  class="ui button basic blue"><span>获取验证码</span></div>
                    </div>
                </div>
            </div>
            <div class="prome"><div><i class="iconfont_new" >&#xe6cc;</i><span class="promt"></span></div></div>
            <div class="field bl" style="margin-top:0;">
                <%--<div c-widget="button;click:reset;color:blue; caption:立即重置密码;width:360px;height:40px;"></div>--%>
                <div onclick="forgetFun.reset(this)" class="ui button blue" style="cursor:pointer;height: 40px; width: 360px;"><span>立即重置密码</span></div>
            </div>

            <div style="margin-top: 1.5rem">
                <div style="font-size: 14px;float: right;">
                    已有账号 <a style="margin-left: 5px;color:#4284D9;" href="/login.jsp">立即登录</a>
                </div>
            </div>
        </div>
        <!--登录 end-->
    </div>
</div>

<footer style="position:absolute;bottom:0px;left:30%;right: 30%;">

    <div style="text-align: center; color:#fff;font-size: 0.9rem">@2016 上海仁石科技有限公司 / All Rights Reserved 沪 ICP备16005067</div>
</footer>
</div>

<script type="text/javascript">
    /**/


    function jump() {
        window.location.href = "index.html";
    }
    var forgetFun= {
        sendCode: function (bt) {
            var btn=$(bt);
            btn.attr("disabled", true);
            var phone = $("#userId").val();
            if (!util.checkPhone(phone)) {
                $(".prome div").show();
                $(".promt").text("请输入正确的手机号码!");
                btn.attr("disabled", false);
                return false;
            }
            var second = 120;
            $.get("/tool/sendRetrieveCode", {phone: phone}, function (data) {
            $(".prome div").hide();
            });
            var changeN = setInterval(function () {
                second--;
                $("#but").text(second + "秒后重新获取");
                if (second <= 0) {
                    clearInterval(changeN);
                    btn.attr("disabled", false);
                    $("#but").text("点击重获验证码");
                    $("#but").css({"pointer-events": "auto"});
                }
                ;
                if (second > 0 && second < 120) {//在倒计时内禁用
                    $("#but").css({"pointer-events": "none"});
                    $("#but").addClass('pig')
                } else {
                    $("#but").removeClass('pig')
                }
            }, 1000)
        },
        reset: function (bt) {
            var btn=$(bt);
            var userId = $("#userId").val();
            var password1 = $("#password1").val();
            var password2 = $("#password2").val();
            var code = $("#code").val();
            if (userId == undefined || $.trim(userId) == "") {
                $(".prome div").show()
                $(".promt").text("请输入手机号码!");
                return false;
            }
            if (password1 == undefined || $.trim(password1) == "") {
                $(".prome div").show()
                $(".promt").text("请输入密码!");
                return false;
            }
            if (password2 == undefined || $.trim(password2) == "") {
                $(".prome div").show()
                $(".promt").text("请再次输入密码!");
                return false;

            }
            if (password1 != password2) {
                $(".prome div").show()
                $(".promt").text("两次输入密码不一致!");
                return false;

            }
            if (code == undefined || $.trim(code) == "") {
                $(".prome div").show()
                $(".promt").text("请输入验证码!");
                return false;
            }

            $.post(
                "/reg/reset-password",
                {
                    userId: userId,
                    password1: password1,
                    password2: password2,
                    code: code
                },
                function (data) {
                    if (data == "1") {
                        $(".prome div").show()
                        $(".promt").text("操作成功!");
                        setTimeout(function () {
                            window.location.href = "/login.jsp";
                        }, 1000);

                    } else {
                        $(".prome div").show()
                        $(".promt").text("操作失败!");
                    }
                }
            )
        }
    }
</script>
</body>

</html>
