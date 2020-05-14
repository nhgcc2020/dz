<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <title>邀请注册</title>
    <link href="/wechat/css/mui.min.css?v=57ec55e59d" rel="stylesheet"/>
    <link href="/wechat/css/main.css?v=9e61f29840" rel="stylesheet"/>
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/util/jquery.qrcode.min.js?v=05f0b1d7d4"></script>
    <style>
        html, body {
            height: 100%;
        }

        body {
            background: #fff;
            height: 100%;
        }

        .mui-content {
            max-width: 640px;
            margin: 0px auto;
            min-height: 100%;
        }

        .shark_contant {
            max-width: 640px;
            margin: 0px auto;
            background: #dc3d42;
            padding-bottom: 0px;
            position: relative;
            height: auto;
        }

        .copyright_text {
            text-align: center;
            color: #fff;
            margin-top: 35px;
            width: 100%;
            font-size: 12px;
            padding:0px;
            margin-bottom: 0px;
            line-height:15px;
            font-family: '微软雅黑',arial,'宋体' ;
        }

        .active_resoult {
            font-size: 16px;
            color: #fff;
            height: auto;
            overflow: hidden;
        }

        .active_resoult h4 {
            padding-left: 5px;
            height: 36px;
            line-height: 36px;
            margin-bottom: 20px;
            background: url("../../../../images/huodongguize.png") no-repeat;
            background-size: 96px 36px;
            font-size: 16px;
        }

        .active_resoult p {
            color: #fff;
            margin-left: 20px;
            font-size: 14px;
        }

        .active_resoult p span {
            display: inline-block;
            height: 20px;
            width: 20px;
            border-radius: 20px;
            background: #c9282e;
            text-align: center;
            margin-right: 10px;
        }

        .active_resoult i {
            font-size: 22px;
            color: #ffd600;
            font-style: normal;
        }

        .share_tips {
            max-width:640px;
            position: absolute;
            z-index: 333;
            height: 100%;
            width: 100%;
            background: rgba(0, 0, 0, 0.5);
            left: 0px;
            top: 0px;
            color: #fff;
            display: none;
        }
        .share_tips img{
            position: absolute;
            width:50%;
            height: auto;
            right: 10%;
            top: 5%;
        }
        .invite_link{
            height:72px;
            line-height:26px;
            width:92%;
            margin:20px 4% 20px;
            background: #ac0c0e;
            border-radius: 5px;
            padding:10px;
        }
        .invite_link a{
            display: block;
            height:52px;
            line-height:26px;
            width:100%;
            font-size: 14px;
            height:auto;
            word-wrap:break-word;
            color: #fff;
            -webkit-user-select: text;
            user-select: text;
        }
    </style>
</head>
<body>
<div class="shark_contant">
    <div class="shark_heard"><img src="/wechat/image/heard_img.png" alt=""></div>
    <div class="active_resoult">
        <h4>活动规则：</h4>
        <p><span>1</span>被邀请人自注册起30天成为付费会员；</p>
        <p><span>2</span>即可获得<i>100</i>元现金奖励；</p>
        <p><span>3</span>邀请人数和奖金上不封顶。</p>
        <p><span>4</span>长按复制下方链接分享给好友邀请注册。</p>
    </div>

    <div class="invite_link">
        <a id="kwd" href="${url}">${url}</a>
    </div>

    <p class="copyright_text">Copyright@2016 上海仁石科技版权所有 <br> 沪ICP备16005067</p>
</div>

<script>
    //    $(".mui-content").height($(window).height());
    <%--var width = $(".shark_contant").width() * 0.6;--%>
    <%--$('#wechat_code').qrcode({width: width, height: width, text: "${url}"});--%>
</script>
</body>
</html>
