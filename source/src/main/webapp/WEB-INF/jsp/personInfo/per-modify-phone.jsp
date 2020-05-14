<%--
  Created by IntelliJ IDEA.
  User: pxy
  Date: 2016/6/2
  Time: 20:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <!--网页页面字符集-->
    <meta charset="UTF-8">
    <!--针对移动设备,网站显示宽度等于设备屏幕显示宽度,内容缩放比例为1:1-->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!--将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面：-->
    <meta name="renderer" content="webkit">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>11注册个人账号</title>
    <!-- css引入和样式定义区域 -->
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <script type="text/javascript" src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script type="text/javascript" src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script type="text/javascript" src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script type="text/javascript" src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script type="text/javascript" src="/resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">         <%--//全局图标样式--%>
    <!-- document 内部样式定义区域-->
</head>

<body>
<div class="transfer_admin">手机号码</div>
<div style="padding:0px 10px 0px 80px;">
        <div>
            <div class="ui form" style="color: #A3A3A3;">
                <div class="fields">
                    <div style="width: 90px;">
                        <span style="line-height: 2.5rem;">原手机号</span>
                    </div>
                    <div class="field six wide" style="width: 300px !important;">
                        <div class="fields">
                            <%--<div class="field ten wide">--%>
                                <input class="dis_input" name="userId" value="${sessionScope.sessionUser.userId}" disabled/>
                            <%--</div>--%>
                            <%--<div id="but" c-widget="button;class:basic;color:blue;" class="field six wide">获取验证码</div>--%>
                        </div>
                    </div>
                </div>
                <div class="fields">
                    <div style="width: 90px;">
                        <span style="line-height: 2.5rem;">短信验证</span>
                    </div>
                    <div class="field six wide" style="width: 300px !important;">
                        <div class="fields">
                            <div class="field ten wide">
                                <div c-widget="Input;placeholder:请填写您收到的短信验证码;name:oldCode"></div>
                            </div>
                            <div id="oldBut" c-widget="button;class:basic;color:blue;" class="field six wide">获取验证码</div>
                        </div>
                    </div>
                </div>

                <div class="fields">
                    <div style="width: 90px;">
                        <span style="line-height: 2.5rem;">新手机号:</span>
                    </div>
                    <div class="field six wide" style="width: 300px !important;">
                        <input type="text" name="newPhone"/>
                    </div>
                </div>
                <div class="fields">
                    <div style="width: 90px;">
                        <span style="line-height: 2.5rem;">短信验证</span>
                    </div>
                    <div class="field six wide" style="width: 300px !important;">
                        <div class="fields">
                            <div class="field ten wide">
                                <div c-widget="Input;placeholder:请填写您收到的短信验证码;name:newCode"></div>
                            </div>
                            <div id="newBut" c-widget="button;class:basic;color:blue;" class="field six wide">获取验证码</div>
                        </div>
                    </div>
                </div>
                <a c-widget="button;click:updatePhone;class:blue" style="width: 292px !important;" class="sure_button">保存</a>
            </div>
        </div>

    <%--</div>--%>
</div>

<%--<div class="transfer_admin">修改手机号码</div>--%>
<%--<div class="Allform">--%>
    <%--<p>--%>
        <%--<span>原手机号</span>--%>
        <%--<input class="dis_input" name="userId" value="${sessionScope.sessionUser.userId}" disabled/>--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span>短信验证</span>--%>
        <%--<i>--%>
            <%--<input name="oldCode" placeholder="请填写验证码" class="dis_input"/>--%>
            <%--<button  id="oldBut">获取验证码</button>--%>
        <%--</i>--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span>新手机号</span>--%>
        <%--<input type="text" name="newPhone"/>--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span>短信验证</span>--%>
        <%--<i>--%>
            <%--<input name="newCode" placeholder="请填写验证码" class="dis_input"/>--%>
            <%--<button  id="newBut">获取验证码</button>--%>
        <%--</i>--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span> &nbsp; &nbsp; &nbsp;  </span>--%>
        <%--<button>保存</button>--%>
    <%--</p>--%>
<%--</div>--%>

<script type="text/javascript">
    cola(function(model) {
        model.action({
            updatePhone:function (btn) {
                btn.set("disabled",true);
                btn.set("state","loading");
                var code = $("input[name='oldCode']").val();
                var newCode = $("input[name='newCode']").val();

                var newPhone = $("input[name='newPhone']").val();
                $.post("<c:url value="/ydz/user/updatePhone"/>",{code:code,newPhone:newPhone,newCode:newCode},function (data) {
                    if(data == "1"){
                        $("<div class='tips_contants'>").fadeIn(250).html("修改成功").delay(500).fadeOut(250).appendTo('body');
                        setTimeout(function(){
                            window.location.href="<c:url value="/login.jsp"/>";
                        },1000);
                    }else{
                        $("<div class='tips_contants'>").fadeIn(250).html("修改失败").delay(500).fadeOut(250).appendTo('body');
                    }
                })
            }

        })
    });

    $("#oldBut").click(function(){
        var second=120;
        $.get("<c:url value="/ydz/user/sendVerCode-info"/>",{phone:$("input[name='userId']").val()},function (data) {});
        var changeN=setInterval(function(){
            second--;
            $("#oldBut").text(second+"秒后重新获取").css({
                background:'#2e8ae6',
                color:'#fff'
            });
            if(second<=0){
                clearInterval(changeN);
                $("#oldBut").text("点击重获验证码").css({
                    background:'#fff',
                    color:'#2e8ae6'
                });
                $("#oldBut").css({"pointer-events":"auto"});
            };
            if(second>0&&second<120){//在倒计时内禁用
                $("#oldBut").css({"pointer-events":"none"});
            }
        },1000)
    });
    $("#newBut").click(function(){
        var second=120;
        $.get("<c:url value="/tool/sendNewCode"/>",{phone:$("input[name='newPhone']").val()},function (data) {});
        var changeN=setInterval(function(){
            second--;
            $("#newBut").text(second+"秒后重新获取").css({
                background:'#2e8ae6',
                color:'#fff'
            });
            if(second<=0){
                clearInterval(changeN);
                $("#newBut").text("点击重获验证码").css({
                    background:'#fff',
                    color:'#2e8ae6'
                });
                $("#newBut").css({"pointer-events":"auto"});
            };
            if(second>0&&second<120){//在倒计时内禁用
                $("#newBut").css({"pointer-events":"none"});
            }
        },1000)
    });
</script>
</body>

</html>
