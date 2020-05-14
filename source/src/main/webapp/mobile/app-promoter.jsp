<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta HTTP-EQUIV="pragma" CONTENT="no-cache">
        <meta HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate">
        <meta HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT">
        <meta HTTP-EQUIV="expires" CONTENT="0">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
        <title>移动端对账大使</title>
        <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=18ddabfb69">
        <script src="/resources/jquery/jquery-2.1.3.min.js?v=ea11ea1d51"></script>
        <style>
            * {
                margin: 0;
                padding: 0;
            }

            .count {
                overflow: hidden;
                max-width: 640px;
                margin: 0 auto;
                padding-bottom: 46px;
            }

            header {
                position: relative;
            }

            header>img {
                width: 100%;
                height: 100%;
            }

            header>div {
                position: absolute;
                width: 100%;
                top: 20%;
                text-align: center;
            }

            header>div>p:nth-child(1) {
                color: #fff;
                font-size: 36px;
                margin-bottom: 88px;
            }

            header>div>p:nth-child(2) {
                color: #fff;
                font-size: 20px;
                margin-bottom: 22px;
            }

            .explain>li {
                text-align: center;
                list-style-type: none;
            }

            .explain>li>p:nth-child(1) {
                color: #2e8ae6;
                font-size: 22px;
                margin-top: 39px;
            }

            .explain>li>p:nth-child(2) {
                color: #666;
                font-size: 16px;
                height: 120px;
                margin-top: 38px;
                line-height: 40px;
            }

            .explain>li>img {
                width: 200px;
                height: 200px;
                border-radius: 50%;
                margin-top: 26px;
            }

            .explain>li>div {
                width: 110px;
                height: 36px;
                margin: 0 auto;
                background: #2e8ae6;
                color: #fff;
                line-height: 36px;
                border-radius: 28px;
                margin-top: 36px;
            }

            .explain>li>span {
                display: block;
                width: 227px;
                margin: 0 auto;
                border-top: 1px solid #d7d7d7;
                margin-top: 30px;
            }

            .register_button {
                background: #4285d9;
                width: 100%;
                max-width: 640px;
                color: #fff;
                height: 46px;
                line-height: 46px;
                border: none;
                position: fixed;
                bottom: 0px;
                z-index: 1000;
                font-size: 1rem;
                box-shadow: 0px -.5px 10px #8e8e8e;
            }

            #sidedown {
                position: absolute;
                top: -54px;
                color: #fff;
                text-align: center;
                font-size: 12px;
                right: 20px;
                line-height: normal;
            }

            #sidedown>i {
                display: block;
                margin-top: 6px;
            }
        </style>
    </head>

    <body>
        <div class="count">
            <header>
                <img src="../images/APPbackground.png" alt="">
                <div>
                    <p class="shortname">我是易对账</p>
                    <p>推荐一款广告传媒行业管理软件</p>
                    <img style="width:168px; height:48px;" src="../images/logo.png" alt="">
                </div>
            </header>
            <ul class="explain">
                <li>
                    <p>记账软件太多，好像没有啥区别</p>
                    <p>易对账 不但可以自己记<br>还能和客户、供应商互记互对，账单共享<br>玩爆传统软件</p>
                    <img src="../images/avamix_01.png" alt="">
                    <div>了解更多</div>
                    <span></span>
                </li>
                <li>
                    <p style="color:#00c59f;">做广告的老板很忙，天天出门在外</p>
                    <p style="margin-top:55px;height:68px;line-height:34px;">易对账-APP可随时查账<br>让你不再错失任何商机</p>
                    <img src="../images/avamix_02.png" alt="">
                    <div style="background:#00c59f;">了解更多</div>
                    <span></span>
                </li>
                <li>
                    <p style="color:#ff9200;">竞争大，如何甩开对手</p>
                    <p>易对账-从细节入手，工作透明化<br>将设计、制作进度，展现给老板、客户<br>工作、服务有效提升80%</p>
                    <img src="../images/avamix_03.png" alt="">
                    <div style="background:#ff9200;">了解更多</div>
                    <span></span>
                </li>
                <li>
                    <p style="color:#eb6877;">会操作电脑，分分钟可开始使用</p>
                    <p style="margin-top:55px;height:68px;line-height:34px;">易对账-专业工程师7x24小时维护<br>你只需关注业务，其他都交给他们</p>
                    <img src="../images/avamix_04.png" alt="">
                    <div style="background:#eb6877;">了解更多</div>
                    <span></span>
                </li>
            </ul>
            <button class="register_button">
             <p id="sidedown">
               下滑查看介绍
               <br>
               <i class="iconfont_new">&#xe68a;</i>
           </p>
           <span style="display:block;width:100%;height:100%;">
            立即免费开通试用
           </span>
            </button>
        </div>
    </body>

    </html>
    <script>
        $(window).scroll(function () {
            if ($(window).scrollTop() > 200) {
                $("#sidedown").hide();
            }else{
                $("#sidedown").show();
            }
        })
        function GetRequest() {
            var url = location.search; //获取url中"?"符后的字串
            var theRequest = new Object();
            if (url.indexOf("?") != -1) {
                var str = url.substr(1);
                strs = str.split("&");
                for (var i = 0; i < strs.length; i++) {
                    theRequest[strs[i].split("=")[0]] = strs[i].split("=")[1];
                }
            }
            return theRequest;
        }
        var a = decodeURI(GetRequest().name);
        $(".shortname").text("我是" + a);
        $(".register_button>span").click(function () {
            location.href = "register_phone.html?key=" + GetRequest().key
        })
        $("li>div").click(function () {
            location.href = "register_phone.html?key=" + GetRequest().key + "&type=1"
        })

    </script>