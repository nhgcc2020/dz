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
    <link rel="stylesheet" type="text/css" href="</resources/cola-ui/cola.css?v=347492ea8b">
    <script type="text/javascript" src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script type="text/javascript" src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script type="text/javascript" src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script type="text/javascript" src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script type="text/javascript" src="/resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>
    <!-- document 内部样式定义区域-->
    <style>
        .alipay_off{
            background-image: url("img/alipay_off.png");
        }
        .alipay_on{
            background-image: url("img/alipay_on.png");
        }
        .qq_off{
            background-image: url("img/qq_off.png");
        }
        .qq_on{
            background-image: url("img/qq_on.png");
        }
        .wechat_off{
            background-image: url("./img/wechat_off.png");
        }
        .wechat_on{
            background-image: url("./img/wechat_on.png");
        }
        .binding_icon{
            width: 40px;
            height: 40px;
            margin-left: 2rem;
            background-repeat:round;
            vertical-align: middle;
            display: inline-block;
        }
    </style>
</head>

<body>
<div style="padding: 1rem">
    <%--<div style="border: 1px black solid;height: 100px;margin:2px ">我是banner</div>
    <div style="width: 15%;border: 1px black solid;height: 750px;display: inline-block">
        <div>我是菜单</div>
        <div><a href="41_person_data.html">个人资料</a></div>
        <div><a href="41_modify_pwd.html">修改密码</a></div>
        <div><a href="41_modify_phone.html">修改手机号</a></div>
        <div><a href="41_binding.html">帐号绑定</a></div>
    </div>
    <div style="width: 84%;border: 1px black solid;height: 750px;display: inline-block;float: right;padding: 1rem">--%>
        <div style="padding:1rem;border-bottom:2px #53A1FC solid;margin-bottom: 1em;font-size: 1.15rem;font-weight: bold">帐号绑定</div>
        <!--绑定框 start-->
        <div style="margin-top: 1rem;">
            <div style="width:100%;height: 4rem;line-height: 4rem;border: 1px solid #DFDFDF;background-color: #F6F6F6">
                <i class="binding_icon wechat_on"></i>
                <div style="display: inline-block;vertical-align: middle;font-weight: bold;margin-left: 1rem">绑定微信号</div>
                <div style="display: inline-block;vertical-align: middle;color: #999999;margin-left: 8rem">jinsheqiwu</div>
                <div style="display: inline-block;vertical-align: middle;color: #418ADF;float: right;margin-right: 2rem;cursor: pointer">解除绑定</div>
            </div>
        </div>
        <!--绑定框 end-->

        <!--绑定框 start-->
        <div style="margin-top: 1rem;">
            <div style="width:100%;height: 4rem;line-height: 4rem;border: 1px solid #DFDFDF;background-color: #F6F6F6">
                <i class="binding_icon qq_on"></i><div style="display: inline-block;vertical-align: middle;font-weight: bold;margin-left: 1rem">绑定QQ号</div>
                <div style="display: inline-block;vertical-align: middle;color: #999999;margin-left: 8.2rem">531133874</div><div style="display: inline-block;vertical-align: middle;color: #418ADF;float: right;margin-right: 2rem;cursor: pointer">解除绑定</div>
            </div>
        </div>
        <!--绑定框 end-->
        <!--绑定框 start-->
        <div style="margin-top: 1rem;">
            <div style="width:100%;height: 4rem;line-height: 4rem;border: 1px solid #DFDFDF;background-color: #F6F6F6">
                <i class="binding_icon alipay_on"></i><div style="display: inline-block;vertical-align: middle;font-weight: bold;margin-left: 1rem">绑定支付宝帐号</div>
                <div style="display: inline-block;vertical-align: middle;color: #999999;margin-left: 6rem">hahahaha@zfb.com</div><div style="display: inline-block;vertical-align: middle;color: #418ADF;float: right;margin-right: 2rem;cursor: pointer">解除绑定</div>
            </div>
        </div>
        <!--绑定框 end-->


        <!--未绑定-->
        <div style="padding:1rem;border-bottom:2px #53A1FC solid;margin-bottom: 1em;font-size: 1.15rem;font-weight: bold">帐号绑定</div>
        <!--绑定框 start-->
        <div style="margin-top: 1rem;">
            <div style="width:100%;height: 4rem;line-height: 4rem;border: 1px solid #DFDFDF;background-color: #F6F6F6">
                <i class="binding_icon wechat_off"></i><div style="display: inline-block;vertical-align: middle;font-weight: bold;margin-left: 1rem">绑定微信号</div>
                <div style="display: inline-block;vertical-align: middle;color: #999999;margin-left: 8rem">未绑定</div><div style="display: inline-block;vertical-align: middle;color: #418ADF;float: right;margin-right: 2rem;cursor: pointer">绑定</div>
            </div>
        </div>
        <!--绑定框 end-->

        <!--绑定框 start-->
        <div style="margin-top: 1rem;">
            <div style="width:100%;height: 4rem;line-height: 4rem;border: 1px solid #DFDFDF;background-color: #F6F6F6">
                <i class="binding_icon qq_off"></i><div style="display: inline-block;vertical-align: middle;font-weight: bold;margin-left: 1rem">绑定QQ号</div>
                <div style="display: inline-block;vertical-align: middle;color: #999999;margin-left: 8.2rem">未绑定</div><div style="display: inline-block;vertical-align: middle;color: #418ADF;float: right;margin-right: 2rem;cursor: pointer">绑定</div>
            </div>
        </div>
        <!--绑定框 end-->
        <!--绑定框 start-->
        <div style="margin-top: 1rem;">
            <div style="width:100%;height: 4rem;line-height: 4rem;border: 1px solid #DFDFDF;background-color: #F6F6F6">
                <i class="binding_icon alipay_off"></i><div style="display: inline-block;vertical-align: middle;font-weight: bold;margin-left: 1rem">绑定支付宝帐号</div>
                <div style="display: inline-block;vertical-align: middle;color: #999999;margin-left: 6rem">未绑定</div><div style="display: inline-block;vertical-align: middle;color: #418ADF;float: right;margin-right: 2rem;cursor: pointer">绑定</div>
            </div>
        </div>
        <!--绑定框 end-->
    <%--</div>--%>
</div>
<script type="text/javascript">
    cola(function(model) {

    });
</script>
</body>

</html>
