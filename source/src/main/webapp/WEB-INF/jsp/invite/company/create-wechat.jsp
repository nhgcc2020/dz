<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title></title>

    <script src="/wechat/js/mui.min.js?v=eda48251a7"></script>
    <link href="/wechat/css/mui.min.css?v=57ec55e59d" rel="stylesheet"/>
    <link href="/wechat/css/main.css?v=9e61f29840" rel="stylesheet"/>
    <script type="text/javascript" src="/wechat/js/jquery-1.8.3.min.js?v=3576a6e73c"></script>
    <style>
        ul{
            list-style:none;
            padding:0px;
            margin:0px;
            text-align: center;
            margin-top: 50px;
        }
        ul li{
            margin-top: 20px;
            font-size:14px;
            margin-top: 15px;
            color: #666;
            letter-spacing: 3px;

        }
    </style>
</head>
<body>

<header class="mui-bar mui-bar-nav heard_nav">
    <h1 class="mui-title">注册成功</h1>
</header>

<div class="mui-content">
    <div class="mui-content-padded">
        <p style="text-align: center; font-size: 14px;margin-top: 20px; color: #333;">您可以通过电脑登录使用易对账</p>
        <p style="text-align: center; font-size: 14px;margin-top: 20px; color: #333;">http://www.yiduizhang.com/</p>
        <p style="text-align: center; font-size: 14px;margin-top: 30px; color: #333;">移动版我们正在紧锣密鼓的开发中...</p>
        <p style="text-align: center; font-size: 14px;margin-top: 20px; color: #333;">敬请等待</p>
        <p style="text-align: center; font-size: 14px;margin-top: 30px; color: #333;">还有优惠券等您领取哦！</p>
    </div>
</div>
<div class="button-copyright" style="position: absolute; bottom: 50px;">上海仁石科技有限公司欢迎您注册使用易对账!</br>Copyright@2016 沪 ICP备16005067</div>
<script>
    setInterval(function(){
       window.location = dz_url+"/member/shark.html";
    },10000);
</script>
</body>
</html>
