<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <html>

        <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
            <title>注册账号</title>
            <script src="/wechat/js/mui.min.js?v=eda48251a7"></script>
            <link href="/wechat/css/mui.min.css?v=57ec55e59d" rel="stylesheet" />
            <link href="/wechat/css/main.css?v=9e61f29840" rel="stylesheet" />
            <script type="text/javascript" src="/wechat/js/jquery-1.8.3.min.js?v=3576a6e73c"></script>
            <script type="text/javascript" src="/wechat/js/main.js?v=7a85ec546f"></script>
            <script type="text/javascript" src="/wechat/js/form.js?v=595e2db8af"></script>
            <script type="text/javascript" src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
            <style>
                #industry>.establish_one {
                    width: 80%;
                    margin: 0 auto;
                }

                .establish_one>ul {
                    display: flex;
                    justify-content: center;
                    margin-top: 10px;
                }

                .establish_one>ul>li {
                    display: inline-block;
                    width: 25%;
                    font-size: 12px;
                }

                .picture li {
                    margin: 9px 11px;
                    height: 106px;
                    border-radius: 5px;
                    box-shadow: 3px 3px 2px #ccc;
                    overflow: hidden;
                }

                .picture li p {
                    position: relative;
                    top: 17px;
                    color: #fff;
                    display: inline-block;
                }

                .picture li p>span {
                    display: block;
                    font-size: 16px;
                    margin-bottom: 12px;
                }

                .cover {
                    position: fixed;
                    top: 0;
                    background: #000;
                    opacity: 0.7;
                    width: 100%;
                    max-width: 640px;
                    height: 100%;
                    z-index: 999;
                    display: none;
                }

                .alart {
                    position: fixed;
                    display: none;
                    top: 10%;
                    left: 5%;
                    right: 5%;
                    background: #fff;
                    width: 90%;
                    margin: 0 auto;
                    max-width: 600px;
                    height: 448px;
                    z-index: 9999;
                    border-radius: 5px;
                }

                .alart>p {
                    display: none;
                    text-align: center;
                    margin-top: 60px;
                    font-size: 18px;
                    color: #333;
                }

                .alart .show {
                    display: block;
                }

                .alart .showone {
                    display: block;
                }

                .icon_font {
                    display: none;
                }

                .icon {
                    display: flex;
                    justify-content: center;
                    margin-bottom: 19px;
                }

                .icon li {
                    display: inline-block;
                    width: 25%;
                    text-align: center;
                }

                .icon li i {
                    font-size: 36px;
                }

                .icon li span {
                    display: block;
                    font-size: 12px;
                    color: #666;
                }

                .button_foot {
                    position: absolute;
                    bottom: 0;
                    height: 55px;
                    border-top: 1px solid #e4e4e4;
                    width: 100%;
                    display: flex;
                    justify-content: center;
                }

                .button_foot>span {
                    display: inline-block;
                    width: 49%;
                    text-align: center;
                    line-height: 55px;
                    font-size: 16px;
                    color: #999;
                }

                .button_foot .onlycolor {
                    color: #4285d9;
                }
            </style>
        </head>

        <body>
            <div id="industry">
                <div class="establish_one">
                    <img style="display:block;width:95%;margin:43px 0 0 5%;" src="../images/title2.png" alt="">
                    <ul>
                        <li>&nbsp;注册账号</li>
                        <li>&nbsp;&nbsp;&nbsp; 创建企业</li>
                        <li style="width:30%;color:#4285d9;">&#x3000;&#x3000; 选择行业</li>
                        <li style="width:20%;"></li>
                    </ul>
                </div>
                <div style="font-size:18px;color:#333;text-align:center;margin-top:20px;margin-bottom:17px;">选择行业类型<span style="color:#eb6877;font-size:12px;">（4选1）</span></div>
                <ol class="picture">
                    <li style="background:#3a9fef;">
                        <img src="../images/style01.png" alt="">
                        <p>
                            <span>小型广告设计工作室</span>
                            <span style="font-size:12px;">主营名片平面设计、写真喷绘、门头灯箱</span>
                        </p>
                    </li>
                    <li style="background:#437ca9;">
                        <img src="../images/style02.png" alt="">
                        <p>
                            <span>综合型广告传媒公司</span>
                            <span style="font-size:12px;">主营平面设计、活动策划、商机CRM</span>
                        </p>
                    </li>
                    <li style="background:#e95e75;">
                        <img src="../images/style03.png" alt="">
                        <p>
                            <span>广告加工制作企业</span>
                            <span style="font-size:12px;">主营写真喷绘、UV打印、标识标牌等加工</span>
                        </p>
                    </li>
                    <li style="background:#ef8201;">
                        <img src="../images/style04.png" alt="">
                        <p>
                            <span>数码图文快印</span>
                            <span style="font-size:12px;">主营企业画册、彩页印刷、CAD出图</span>
                        </p>
                    </li>
                </ol>
            </div>
            <div class="cover"></div>
            <div class="alart">
                <i style="position:absolute;top:0;right:0;font-size:30px;" class="iconfont_new close">&#xe6a0;</i>
                <p dataStyle="1A"><img style="height:30px;width:30px;border-radius:50%;border:2px solid #3a9fef;margin-right:12px;" src="../images/style01.png"
                        alt=""><span style="position:relative;top:2px;">小型广告设计工作室</span></p>
                <p dataStyle="1B"><img style="height:30px;width:30px;border-radius:50%;border:2px solid #437ca9;margin-right:12px;" src="../images/style02.png"
                        alt=""><span style="position:relative;top:2px;">综合型广告传媒公司</span></p>
                <p dataStyle="1C"><img style="height:30px;width:30px;border-radius:50%;border:2px solid #e95e75;margin-right:12px;" src="../images/style03.png"
                        alt=""><span style="position:relative;top:2px;">广告加工制作企业</span></p>
                <p dataStyle="1D"><img style="height:30px;width:30px;border-radius:50%;border:2px solid #ef8201;margin-right:12px;" src="../images/style04.png"
                        alt=""><span style="position:relative;top:2px;">数码图文快印</span></p>
                <div style="text-align:center;color:#333;font-size:12px;"><span class="money" style="color:#f0865e;font-size:26px">888</span>元/年</div>
                <div style="color:#f0865e;font-size:12px;text-align:center;margin-top:4px;">所有功能免费使用，只有当销售开单达到50笔时需付费</div>
                <div class="hite" style="width:150px;line-height:28px;margin:20px auto;border-radius:3px;background:#999;color:#fff;font-size:14px;text-align:center;">该行业拥有以下功能</div>
                <div class="icon_font">
                    <ul class="icon">
                        <li>
                            <i class="iconfont_new" style="color:#EB6877;">&#xe670;</i>
                            <span>服务目录</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#EB6877;">&#xe699;</i>
                            <span>销售开单</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#EFA219;">&#xe6f9;</i>
                            <span>设计派工</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#4284D9;">&#xe698;</i>
                            <span>采购记账</span>
                        </li>
                    </ul>
                    <ul class="icon">
                        <li>
                            <i class="iconfont_new" style="color:#49d079;">&#xe708;</i>
                            <span>费用工资</span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                    </ul>
                </div>
                <div class="icon_font">
                    <ul class="icon">
                        <li>
                            <i class="iconfont_new" style="color:#EB6877;">&#xe670;</i>
                            <span>服务目录</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#EB6877;">&#xe699;</i>
                            <span>销售开单</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#EFA219;">&#xe6f9;</i>
                            <span>设计派工</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#4284D9;">&#xe698;</i>
                            <span>采购记账</span>
                        </li>
                    </ul>
                    <ul class="icon">
                        <li>
                            <i class="iconfont_new" style="color:#49d079;">&#xe708;</i>
                            <span>费用工资</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#EB6877;">&#xe6b1;</i>
                            <span>商机RCM</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#EB6877;">&#xe6e4;</i>
                            <span>合同收款</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#EB6877;">&#xe6b3;</i>
                            <span>媒体资源</span>
                        </li>
                    </ul>
                </div>
                <div class="icon_font">
                    <ul class="icon">
                        <li>
                            <i class="iconfont_new" style="color:#EB6877;">&#xe670;</i>
                            <span>服务目录</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#EB6877;">&#xe699;</i>
                            <span>销售开单</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#EFA219;">&#xe6f9;</i>
                            <span>设计派工</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#EFA219;">&#xe715;</i>
                            <span>制作</span>
                        </li>
                    </ul>
                    <ul class="icon">
                        <li>
                            <i class="iconfont_new" style="color:#EFA219;">&#xe713;</i>
                            <span>安装</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#EFA219;">&#xe711;</i>
                            <span>配送</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#4284D9;">&#xe698;</i>
                            <span>采购记账</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#49d079;">&#xe708;</i>
                            <span>费用工资</span>
                        </li>
                    </ul>
                </div>
                <div class=" icon_font">
                    <ul class="icon">
                        <li>
                            <i class="iconfont_new" style="color:#EB6877;">&#xe670;</i>
                            <span>服务目录</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#EB6877;">&#xe699;</i>
                            <span>销售开单</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#EFA219;">&#xe6f9;</i>
                            <span>设计派工</span>
                        </li>
                        <li>
                            <i class="iconfont_new" style="color:#4284D9;">&#xe698;</i>
                            <span>采购记账</span>
                        </li>
                    </ul>
                    <ul class="icon">
                        <li>
                            <i class="iconfont_new" style="color:#49d079;">&#xe708;</i>
                            <span>费用工资</span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                    </ul>
                </div>
                <div class="warning" style="margin:30px auto;height:150px;width:250px;background:#eb6877;border-radius:5px;text-align:center;font-size:14px;color:#fff;display:none;">
                    <i class="iconfont_new" style="font-size:64px;">&#xe6bc;</i>
                    <p style="margin:10px 0;">行业类型关系到系统功能和收费模式</p>
                    <p>确定后将无法在更改</p>
                </div>
                <div class="button_foot">
                    <span class="close">选错了，重选</span><span class="confirm onlycolor" style="border-left:1px solid #e4e4e4;">确定</span>
                </div>
            </div>
            <script>
                var number = 0;
                $(".confirm").click(function () {
                    if (number == 0) {
                        $(".hite").hide();
                        $(".icon_font").removeClass("showone");
                        $(".warning").show();
                        $(this).text("确定，立即开通");
                        number = 1;
                    } else if (number == 1) {
                        $(".confirm").removeClass("onlycolor")
                        number = 2;
                        $.ajax({
                            url: '/payment/upgradeTrialVersion?industryId=' + $(".show").attr("dataStyle"),
                            type: 'GET',
                            dataType: "json",
                            success: function (data) {
                                if (data.state) {
                                    $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(2000).fadeOut(250).appendTo('body');
                                    setTimeout(function () {
                                         window.location.href="<c:url value="/invite/com/success"/>"
                                        number = 0;
                                    }, 1000);

                                }
                            },
                            error: function (data) {
                                $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(2000).fadeOut(250).appendTo('body');
                            }
                        })

                    } else if (number == 2) {
                        $("<div class='tips_contants'>").fadeIn(250).html("提交中，请耐心等待").delay(2000).fadeOut(250).appendTo('body');
                    }
                })
            </script>
        </body>

        </html>