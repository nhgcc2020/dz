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
            overflow: hidden;
            position: relative;
            height: 100%;
        }

        .copyright_text {
            text-align: center;
            color: #fff;
            margin-top: 35px;
            width: 100%;
            font-size: 12px;
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
    </style>
</head>
<body>
<div class="shark_contant">
    <div class="shark_heard"><img src="/wechat/image/heard_img.png" alt=""></div>
    <%--<div class="shark_code" id="wechat_code"></div>--%>
    <%--<p class="shark_Scanning">分享二维码或分享此页面邀请注册</p>--%>
    <%--<button class="shark_btn" onclick="window.location.href='/invite/normal/signIn/${key}'">注册</button>--%>

    <div class="active_resoult">
        <h4>活动规则：</h4>
        <p><span>1</span>被邀请人自注册起30天成为付费会员；</p>
        <p><span>2</span>即可获得<i>100</i>元现金奖励；</p>
        <p><span>3</span>邀请人数和奖金上不封顶。</p>
    </div>


    <div class="mui-button-row related_form_sub" style="margin: 30px 15px 0;">
        <button type="button" class="mui-btn mui-btn-primary" id="next_tap"
                style="background: #ffb900; border: 1px solid #ffb900; box-shadow: 4px 8px 2px #b23945; font-size: 18px">
            分享给好友
        </button>
    </div>
    <p class="copyright_text">Copyright@2016 上海仁石科技版权所有 <br> 沪ICP备16005067</p>
    <%--<a href="http://www.yiduizhang.com" class="shark_jump">跳过此步</a>--%>


    <%--<div class="copyright_logo">--%>
    <%--<img src="/wechat/image/logo.jpg" alt="">--%>
    <%--</div>--%>
</div>

<div class="share_tips">
    点击分享给好友吧
</div>

<script>
    function IsPC() {
        var userAgentInfo = navigator.userAgent;
        var Agents = ["Android", "iPhone",
            "SymbianOS", "Windows Phone",
            "iPad", "iPod"];
        var flag = true;
        for (var v = 0; v < Agents.length; v++) {
            if (userAgentInfo.indexOf(Agents[v]) > 0) {
                flag = false;
                break;
            }
        }
        return flag;
    }
    if(IsPC()){
        setTime(function(){
           window.location.href="/login.jsp";
        },3000);
    }

    //    $(".mui-content").height($(window).height());
    <%--var width = $(".shark_contant").width() * 0.6;--%>
    <%--$('#wechat_code').qrcode({width: width, height: width, text: "${url}"});--%>

    $("#next_tap").click(function () {
        $(".share_tips").fadeIn();
    })
    $(".share_tips").click(function () {
        $(this).fadeOut();
    })
</script>
</body>
</html>
