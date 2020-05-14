<%--
  Created by IntelliJ IDEA.
  User: pxy
  Date: 2016/6/2
  Time: 20:35
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
<div class="transfer_admin">修改密码</div>
<div style="padding:0px 10px 0px 80px;">
        <div>
            <div class="ui form" style="color: #A3A3A3;">

                <div class="fields">
                    <div style="width: 90px;">
                        <span class="fontSize14A">原始密码:</span>
                    </div>
                    <div class="field six wide" style="width: 300px !important;">
                        <input type="password" name="oldPwd"/>
                        <!--<div c-widget="Input;type:password"></div>type="password"-->
                    </div>
                </div>
                <div class="fields">
                    <div style="width: 90px;">
                        <span class="fontSize14A">新设密码:</span>
                    </div>

                    <div class="field six wide" style="width: 300px !important;">
                        <input type="password" name="newPwd"/>
                    </div>

                </div>
                <div class="fields">
                    <div style="width: 90px;">
                        <span class="fontSize14A">确认密码:</span>
                    </div>
                    <div class="field six wide" style="width: 300px !important;">
                        <input type="password" name="newPwd2"/>
                    </div>
                </div>
                <div class="fields">
                    <div style="width: 90px;">
                        <span class="fontSize14A">我的手机</span>
                    </div>
                    <div class="field six wide" style="width: 300px !important;">
                        <div class="fields">
                            <div class="field ten wide">
                                <input value="${sessionScope.sessionUser.userId}"  name="userId" class="dis_input" disabled/>
                            </div>
                            <div id="but" c-widget="button; class:basic;color:blue;"  class="field six wide">获取验证码</div>
                        </div>
                    </div>
                </div>
                <div class="fields">
                    <div style="width: 90px;">
                        <span class="fontSize14A">短信验证</span>
                    </div>
                    <div class="field six wide" style="width: 300px !important;">
                        <div c-widget="Input;placeholder:请填写您收到的短信验证码;name:code"></div>
                    </div>
                </div>
                <a c-widget="button; class:blue" class="sure_button" onclick="save()" style="width: 292px !important;">保存</a>
            </div>
        </div>

    </div>
</div>
<%--<div class="transfer_admin">修改密码</div>--%>
<%--<div class="Allform">--%>

    <%--<p>--%>
        <%--<span>原始密码</span>--%>
        <%--<input type="password" name="oldPwd" >--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span>新密码</span>--%>
        <%--<input type="password" name="newPwd" >--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span>确认密码</span>--%>
        <%--<input type="password" name="newPwd2">--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span>手机号码</span>--%>
        <%--<input value="${sessionScope.sessionUser.userId}" type="text" name="userId">--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span>验证手机</span>--%>
        <%--<i>--%>
            <%--<input name="code" placeholder="短信验证码" class="dis_input"/>--%>
            <%--<button  id="but">获取验证码</button>--%>
        <%--</i>--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span> &nbsp; &nbsp; &nbsp;  </span>--%>
        <%--<button>保存</button>--%>
    <%--</p>--%>
<%--</div>--%>
<script type="text/javascript">

    $("#but").click(function(){
        var second=120;
        $.get("<c:url value="ydz/user/sendVerCode-info-modPwd"/>",{phone:$("input[name='userId']").val()},function (data) {});
        var changeN=setInterval(function(){
            second--;
            $("#but").text(second+"秒后重新获取").css({
                background:'#2e8ae6',
                color:'#fff'
            });
            if(second<=0){
                clearInterval(changeN);
                $("#but").text("点击重获验证码").css({
                    background:'#fff',
                    color:'#2e8ae6'
                });
                $("#but").css({"pointer-events":"auto"});
            };
            if(second>0&&second<120){//在倒计时内禁用
                $("#but").css({"pointer-events":"none"});
            }
        },1000)
    });

    function save(){
     var newPwd =  $("input[name='newPwd']").val();
     var oldPwd =   $("input[name='oldPwd']").val();
     var newPwd2 =   $("input[name='newPwd2']").val();
     var code =    $("input[name='code']").val();
     if($.trim(newPwd) != "" && newPwd == newPwd2 ){
         $.post("<c:url value="/ydz/user/modPwd"/>",
                 {
                     newPwd:newPwd,
                     oldPwd:oldPwd,
                     code:code
                 },
                 function(callback){
                     var data = eval("("+callback+")");
                     if(data.state == '1'){
                         $("<div class='tips_contants'>").fadeIn(250).html("修改成功").delay(500).fadeOut(250).appendTo('body');
                         setTimeout(function(){
                             window.parent.location.reload(true);
                         },1000);
                     }else{
                         $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(500).fadeOut(250).appendTo('body');
                    }



                 })
     }else{
         ("<div class='tips_contants'>").fadeIn(250).html("校验未通过，请核对您填写的信息").delay(500).fadeOut(250).appendTo('body');
     }
    }


    cola(function(model) {

    });

    window.onload = function(){
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
    }
</script>
</body>

</html>
