<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN" style="height: 100%;">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>易对账软件服务已过期</title>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67"> 		<!--整体修改-->
</head>
<style>
    body{overflow: hidden;}
    .frame{height: 500px;width: 440px;position: absolute;top:20%;bottom:20%;left:35%;right: 35%;}
    .frame>i{font-size: 200px;display: block;margin: 0 auto;width: 200px;color: #f8b55a;}
    .company_name{font-size: 24px;text-align: center;color:#333;margin-top:20px;}
    .order{font-size: 16px;color: #ff0000;text-align: center;margin-top:20px;}
    button{border: none;outline: none;border-radius: 40px;display: block;margin: 30px auto 116px;width: 220px;height: 44px;color: #fff;background: #eb6877;font-size: 16px;}
    .jump{font-size: 14px;color: #999;}
    .jump>i{font-size: 12px;}
</style>
<body style="background: #fff; height: 100%;">
    <div class="frame">
        <i class="iconfont">&#xe6f3;</i>
        <div class="company_name">${sessionScope.sessionUser.comName} 已到期</div>
        <div class="order">如需使用，请尽快让管理员来订购</div>
        <button id="buyEdition" style="cursor: pointer" 　 type="">立即订购 或 续费</button>
        <div class="jump" id="backHome" style="cursor: pointer">如果你开通了多家企业，先返回个人版，再切换到其他企业使用操作 <i class="iconfont">&#xe68b;</i></div>
    </div>
<script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
<script src="/resources/common/global-config.js?v=051236a6d6"></script>
<script type="text/javascript">
     $("#buyEdition").one("click",function(){
         window.location = "/openPage?pageName=c_payment/priceList";
     });
      $("#backHome").one("click",function(){
          window.location = "/login/tomain";
      });
</script>
</body>
</html>
