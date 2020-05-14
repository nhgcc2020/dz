
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="renderer" content="webkit">
    <title>欢迎注册</title>
    <%--<link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">--%>
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">

    <!--[if lt IE 10]>
    <script src="/wechat/js/jquery-1.8.3.min.js?v=3576a6e73c"></script>
    <![endif]-->
    <script>
        if(!window.jQuery) {
            document.write('<script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"><\/script>');
        }
    </script>

    <script type="text/javascript" src="/resources/business/util.js?v=cee3a7629a"></script>
    <!--加载公共js-->
    <script src="/common/growingio.js"></script>
    <!-- document 内部样式定义区域-->
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
                text-align: center;
                margin-bottom: 20px !important;
        }

        a:hover {
            text-decoration: underline;
            cursor: pointer;
            color: #4183c4 !important;
        }

        .foot_separate {
            display: inline-block;
            margin: auto 5px;
        }

        .company_list {
            margin-bottom: 1rem;
            padding: 0.3rem;
            cursor: pointer;
            padding-left: 1.8rem;
        }

        .comli_checked {
            padding: 0.3rem;
            background: #337AB7;
            color: white;

        }

        .tips_contants {
            height: 80px;
            line-height: 80px;
            width: 300px;
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
        }
        .ui.form textarea, .ui.form input[type="checkbox"]{
            vertical-align: baseline;
        }
    .input>input{
    height:40px !important;
    marign-bottom:20px;
    border-radius: 0 !important;
    }
  .login_form  input:focus{
    border:1px solid red !important;
    }
    .first{
    position:absolute;
    right:1px;
    top:1px;
    }
    .ui.form .eight.wide.field.second {
    width:360px !important;
    margin:0 !important;
    }
    .ui.form .fields .wide.field:first-child{
    padding:0;
    }
    .ui.basic.blue.button:hover{
    background:#4284D9 !important;
    color:#fff !important;
    }
    .ui.basic.blue.button{
    box-shadow:none !important;
    height:38px;
    line-height:38px !important;
    background:#4284D9 !important;
    color:#fff !important;
    width:100px !important;
    float:right;
    border-radius:0 ;
    }
    .field.bl{
    margin:0 !important;
    }
    .bl .blue>span{
    font-size:18px;
    line-height:40px;
    font-family: "微软雅黑";
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
    .regist_a{
    margin-top:5px;
    }
    .regist_a a{
    color:#000;
    }
    .ui.basic.blue.button.pig{
    background:#999999 !important;
    color:#ffffff !important;
    }
    .home-container{
    <%--background-image: url(images/regest_ad.jpg);--%>
    <%--height:500px;--%>
    }

    .ui.button{
    	border-radius: 0;
    }
    .ui.blue.button{
    	background: #4284d9;
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
        .codeCss{
            font-weight: 500;
            min-width: 115px;
            padding: 0px;
            width: 100%;
            box-shadow: none !important;
            height: 40px;
            line-height: 38px !important;
            background: #4284D9 !important;
            color: #fff !important;
            cursor: pointer;
            width: 100px !important;
            -webkit-user-select: none;
            float: right;
            border-radius: 0;
        }
        .registerBtnShow{
            height: 40px;   font-size: 18px;
            line-height: 40px;
            font-weight: normal;
            width: 360px;            -webkit-user-select: none;
            cursor: pointer;
            background-color: #1678c2;
            color: #FFFFFF;
            text-shadow: none;
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
<%--<header>--%>
    <%--<div class="menu_body common_width" style="height: 6rem;padding: 1rem;">--%>
        <%--<div><a href="http://www.yiduizhang.com"><img src="/images/login/logo_ad.png" style="width:256px; height:45px;margin:6px;"/></a></div>--%>
        <%--<!--<div class="menu_phone">服务热线@186-2161-9311</div>--%>
    <%--<div class="menu_login">登录</div>-->--%>
    <%--</div>--%>
<%--</header>--%>
<!--头部 end-->
<div class="hope_word"></div>
<div class="home-container" style="background-color:#00A9A6;margin-top: 5%">
    <div class="w">
        <!--登录 end-->
        <div class="ui form login_form"style="opacity: .9;background-color: white;padding: 0 30px;position:absolute;right:15% !important;top:150px;height:480px;font-size:12px;right:200px;">
            <div class="field" style="margin:30px 0;">
                <span style="font-size:24px;color:#666666;">账户注册</span>
            </div>
            <div class="field">
                <%--<div class="ab" c-widget="Input;bind:user.realName;placeholder:请输入真实姓名;iconPosition:left"></div>--%>
                <div class="ab ui input" ><input id="realName" type="text" placeholder="请输入真实姓名"></div>
            </div>
            <div class="field">
                <%--<div style="width:360px;height:40px;" c-widget="Input;bind:user.userId; maxlength:11; iconPosition:left"></div>--%>
                <div style="width:360px;height:40px;"  class="ui input"><input id="userId" type="text" placeholder="请输入手机号码" maxlength="11"></div>
            </div>
            <div class="field">
                <%--<div c-widget="Input;bind:user.password;inputType:password;placeholder:请设置密码;iconPosition:left"></div>--%>
                <div  class="ui input"><input type="password" id="password" placeholder="请设置密码"></div>
            </div>


            <div class="ui form">
                <div class="fields">
                    <div class="field eight wide second" style="margin: 0;">
                        <%--<div c-widget="Input;placeholder:输入验证码;name:code;bind:user.code"></div>--%>
                        <div  class="ui input"><input type="text" name="code" id="code" placeholder="输入验证码"></div>
                    </div>
                    <div class="field eight wide first" style="margin: 0;">
                        <div id="but" class="codeCss" onclick="registerFun.sendCode(this)" >获取验证码
                        </div>
                    </div>
                </div>
            </div>
            <div class="prome"><div><i class="iconfont_new" >&#xe6cc;</i><span class="promt"></span></div></div>
            <div class="field bl" style="margin-top: 1.5rem">
                <div class="registerBtnShow" onclick="registerFun.signUp(this)" >立即注册</div>
            </div>

            <div>
                <div class="regist_a" style="float: left;">
                    注册即同意
                    <a href="https://www.yiduizhang.com/privacy.html" target="_blank">用户隐私</a>与
                    <a href="https://www.yiduizhang.com/service.html" target="_blank">服务条款</a>
                </div>
                <div style="float: right; margin-top:45px;font-size:13px;">
                    已有账户？<a href="/login.jsp" style="color:#4284d9;">立即登录</a>
                </div>
                <div style="clear:both;"></div>
            </div>
            <div style="float:left;margin-top:-17px;font-size:14px;"><a style="color:#4284D9!important;" href="https://www.yiduizhang.com">返回首页</a></div>
        </div>
        <!--登录 end-->
    </div>
    </div>
<footer style="position:absolute;bottom:0px;left:30%;right: 30%;">
    <div style="text-align: center;color:#fff;font-size: 0.9rem">@2016 上海仁石科技有限公司 / All Rights Reserved 沪 ICP备16005067</div>
</footer>
</div>
<script type="text/javascript">
    function jump() {
        window.location.href = "index.html";
    }
//        model.set("user", {
//            userId: "",
//            realName: "",
//            password: "",
//            code: ""
//        });

       var registerFun={
            //发送验证码
            sendCode: function (bt) {
                var btn=$(bt);
                btn.attr("disabled",true);
                var phone = $("#userId").val();
                if(!util.checkPhone(phone)){
                    $(".prome div").show();
                $(".promt").text("请输入手机号码!");
                    btn.attr("disabled",false);
//                    btn.set("state","");
                    return false;
                }
                var second=120;
                $.get("/tool/sendVerCode",{phone:phone},function (data) {    $(".prome div").hide();});
                var changeN=setInterval(function(){
                    second--;
//                    $("#but").html(second+"秒后重新获取");
                    btn.text(second+"秒后重新获取");
                    if(second<=0){
                        $("#but").empty();
                        clearInterval(changeN);
                        btn.attr("disabled",false);
                        btn.text("点击重获验证码");
//                        $("#but").empty().html("点击重获验证码");
                        $("#but").css({"pointer-events":"auto"});
                    };
                    if(second>0&&second<120){//在倒计时内禁用
                        $("#but").css({"pointer-events":"none"});
                        $("#but").addClass('pig')
                    }else{
                        $("#but").removeClass('pig')
                    }
                },1000);
            },
            //注册
            signUp: function (bt) {
                var btn=$(bt);
                btn.text("");
                btn.attr("disabled",true);
                btn.addClass("lodingBtn");
                //真实姓名
                var realName =$("#realName").val();
                //$.trim($("#realName4Reg").val());
                if (realName == null || "" == realName) {
                $(".prome div").show();
                $(".promt").text("请输入真实姓名!");
                btn.attr("disabled",false);
                    btn.text("立即注册");
                    btn.removeClass("lodingBtn");
                return false;
                }
                //密码
                var pwd = $("#password").val();
                //$.trim($("#pwd4Reg").val());
                if (!util.checkPwd(pwd)) {
                $(".prome div").show()
                $(".promt").text("请设置6-18位密码!");
                btn.attr("disabled",false);
                    btn.text("立即注册");
                    btn.removeClass("lodingBtn");
                return false;
                }
                //手机号
                var userId = $("#userId").val();
                        //$.trim($("#userId4Reg").val());
                if (!util.checkPhone(userId)) {
                $(".prome div").show()
                $(".promt").text("请输入正确的手机号码!");
                    btn.attr("disabled",false);

                    btn.text("立即注册");
                    btn.removeClass("lodingBtn");
                    return false;
                }
                //验证码
                var code = $("#code").val();
                        //$.trim($("#code4Reg").val());
                if (code == null || "" == code) {
                $(".prome div").show()
                $(".promt").text("请输入验证码!");
                    btn.attr("disabled",false);
                    btn.text("立即注册");
                    btn.removeClass("lodingBtn");
                    return false;
                }
                //提交
                $.post(
                        "/reg/signUp",
                        {
                            userId: userId,
                            password: pwd,
                            realName: realName,
                            code: code
                        },
                        function (data) {
                            //$(".tips_contants").fadeIn(250).html(data.msg).delay(2000).fadeOut(250).appendTo("#reg_tips");
                            if (data.state) {
                                setTimeout(function () {
                                    window.location.href = "/login/tomain";
                                }, 1000);
                            } else {
                                $(".prome div").show();
                                $(".promt").text(data.msg);
                                btn.attr("disabled",false);
                                btn.text("立即注册");
                                btn.removeClass("lodingBtn");
                            }

                        }
                )
            }
        }
</script>
</body>

</html>
