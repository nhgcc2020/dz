<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: pengxuyang
  Date: 16/10/31
  Time: 下午5:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>员工邀请</title>
    <style>

        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
            -webkit-appearance: none;
        }
        .page {
            width: 100%;
            height: 100%;
            background: #dfe3e8;
            padding: 8px;
        }
        .main{
            position: relative;
            width: 100%;
            height: 95%;
            background: #fff;
            border-radius: 5px;
            box-shadow: 3px 4px 4px rgba(0,0,0,0.1);
        }
        article{
            width: 100%;
            height: 100%;
            position: relative;
            border-radius: 3px;
            background: #fff;
        }
        header {
            width: 100%;
            text-align: center;
            position: relative;
            border: none;
            border-radius: 3px;
            border-bottom: 1px dashed #ccc;
            margin-bottom: 2rem;
        }
        .topdiv{
            background: url("/images/invite-logo.png") 13px center no-repeat #008cee;
            height: 40px;
            background-size: 20%;
        }

        #avatar{
            width: 86px;
            height: 86px;
            line-height: 80px;
            color: #fff;
            border: 6px solid #f3f5f5;
            border-radius: 50%;
            margin: 12px auto;
            overflow: hidden;
            background-color: #ccc;
        }

        header #avatar img {
            width: 100%;
            height: 100%;
        }

        p {
            display: block;
            -webkit-margin-before: 1em;
            -webkit-margin-after: 1em;
            -webkit-margin-start: 0px;
            -webkit-margin-end: 0px;
        }

        header p {
            text-align: center;
            font-size: 14px;
            color: #222222;
            margin-bottom: 12px;
        }

        header p > span {
            font-weight: bolder;
        }

        header p.company {
            color: #008cee;
            font-size: 16px;
            padding-top: 1px;
            margin-right: 2px;
            width: 80%;
            margin: 0 auto;
            position: relative;
            text-align: center;
            text-overflow: ellipsis;
            overflow: hidden;
            margin-bottom: 25px;
            /*-webkit-transform: translateX(-27px);
             -ms-transform: translateX(-27px);
             -o-transform: translateX(-27px);
             transform: translateX(-27px);*/
        }
        section.input, section.alread-submit {
            position: relative;
            top: 0;
            margin-top: 0;
            -webkit-transform: translateY(0);
            -ms-transform: translateY(0);
            -o-transform: translateY(0);
            transform: translateY(0);
        }
        section input {
            width: 240px;
            height: 45px;
            border-radius: 23px;
            margin: 0 auto;
            margin-bottom: 8px;
            box-shadow: none;
            padding-left: 16px;
            outline: none;
            font-size: 14px;
            background: #f8f8f8;
            text-align: left;
            border: 1px solid #ccc;
        }
        section .input-code {
            width: 240px;
            height: 45px;
            margin: 0 auto;
            text-align: left;
        }

        img#code {
            width: 45%;
            height: 45px;
            float: right;
            border-radius: 23px;
        }



        @media ( min-width: 640px){
            .page{
                position: relative;
                width: 400px;
                height: auto;
                padding: 0;
                background: #6290c6;
                margin: 0 auto;
                border-radius: 5px;
                overflow: hidden;
                -webkit-transform: translateY(100px);
                -ms-transform: translateY(100px);
                -o-transform: translateY(100px);
                transform: translateY(100px);
            }

            section input, section .input-code, p.small-text {
                width: 80%;
                min-width: 100px;
                color: #c8c7cc;
            }
            section input {
                color: #333;
            }
            section input#captcha {
                width: 40%;
                float: left;
            }
            img#code {
                width: 25%;
                float: left;
            }

            button#submit {
                width: 200px;
            }
            #submit {
                margin: 16px auto 14px;
            }
            section.input .official-web {
                display: block;
                margin-bottom: 16px;
                font-size: 12px;
            }

            a {
                text-decoration: none;
                color: #008cee;
            }
        }




        button {
            width: 120px;
            height: 45px;
            border-radius: 23px;
            background: #008cee;
            color: #fff;
            font-size: 17px;
            border: none;
            display: block;
            margin: 27px auto;
        }

        input {
            -webkit-appearance: textfield;
            background-color: white;
            border-image-source: initial;
            border-image-slice: initial;
            border-image-width: initial;
            border-image-outset: initial;
            border-image-repeat: initial;
            -webkit-rtl-ordering: logical;
            -webkit-user-select: text;
            cursor: auto;
            padding: 1px;
            border-width: 2px;
            border-style: inset;
            border-color: initial;
        }
        section {
            text-align: center;
            background: #fff;
        }
        .error_tips {
            display: none;
            position: absolute;
            bottom: 80px;
            left: 0px;
            width: 80%;
            left: 10%;
            height: 36px;
            line-height: 36px;
            background: rgba(0, 0, 0, 0.7);
            color: #fff;
            z-index: 999;
            font-size: 12px;
            border-radius: 5px;
            text-align: center;
        }
    </style>
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/common/growingio.js"></script>
</head>
<body style="min-height: 100%;background: #6290c6;">
<div class="page">
    <section class="main">
        <article>
            <header>
                <div class="topdiv"></div>
                <div  class="avatar" id="avatar">
                    <img src="/ydz/user/other-com-avatar?comKey=${sessionScope.sessionInvite.comKey}" onerror="this.src='/images/default_company.png'"  alt="">
                </div>
                <p><span>${sessionScope.sessionInvite.inviterName}</span>邀请你加入</p>
                <p class="company">${sessionScope.sessionInvite.comName}</p>
            </header>

            <section class="input">
                <!-- <p class="small-text">国际手机号请在号码前加上“+[国家码]-”</p>-->
                <input id="phone" type="tel" name="userId" require="" value="${sessionScope.sessionInvite.invitee}" disabled>
                <input id="pwd"   type="password" name="password" placeholder="请设定密码" maxlength="20">
                <input id="realName"   type="text" name="realName" value="${sessionScope.sessionInvite.name}" maxlength="20">

                <input type="hidden" name="roleKey" value="${sessionScope.sessionInvite.roleKey}">
                <input type="hidden" name="comKey" value="${sessionScope.sessionInvite.comKey}">

            <%--<div class="input-code">
                    <input type="text" id="captcha" placeholder="验证码" require="">
                    <img src="//pin.aliyun.com/get_img?identity=dingtalk.com&amp;sessionid=C6FA836B13C90B25D4580BA770907D3C&amp;kjtype=number" alt="checkcode" id="code">
                </div>--%>
                <button id="submit" style="cursor: pointer" onclick="sure(this)">确认加入</button>
                <p class="official-web"><a href="http://www.yiduizhang.com" target="_blank">登录易对账官网了解更多</a></p>
            </section>
        </article>
    </section>
</div>
<script>
    function sure(btn){
        var btnAjax = btn;
        $(btn).attr("disabled",true);
        var phone = $("input[name='userId']").val();
        var pwd = $('input[name="password"]').val();
        var realName = $("#realName").val();
        var comKey = $("input[name='comKey']").val();
        var roleKey = $("input[name='roleKey']").val();
        if(pwd == undefined || pwd == ""){
            $("<div class='error_tips'>").fadeIn(250).html("请填写密码").delay(5000).fadeOut(250).appendTo("body");
            $(btn).removeAttr("disabled");
            return false;
        }
        if(realName == undefined || realName == ""){
            $("<div class='error_tips'>").fadeIn(250).html("请填写真实姓名").delay(5000).fadeOut(250).appendTo("body");
            $(btn).removeAttr("disabled");
           return false;
        }
        $.post(
             "/invite/emp/completeRegist",
             {
                userId:phone,
                password:pwd,
                realName:realName,
                comKey:comKey,
                roleKey:roleKey
             },
             function(data){
                 var callback = eval("("+data+")");
                 if(callback.state == "1"){
                    $(btn).text("已完成");
                    window.location.href="/invite/emp/success";
                    $("<div class='error_tips'>").fadeIn(250).html("请关注我们的公众号-易对账，或者登录官网。").delay(3500).fadeOut(250).appendTo("body");
                }else{
                     $(btn).removeAttr("disabled",false);
                    $("<div class='error_tips'>").fadeIn(250).html(callback.msg).delay(2000).fadeOut(250).appendTo("body");
                }
        })
    }
</script>
</body>
</html>
