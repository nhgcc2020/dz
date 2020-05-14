<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  User: ljp
页面要求：
I :页面的url地址、提示语。请提取出来放在script脚本前面(2017-09-20 start)  js/css文件请用带min的文件(公共库)

2017年后主要方向：
II 2017年前用iframe嵌套了页面  准备用jquery.load方法去掉iframe 稍微修改了 mainConfigUrl 貌似很多样式冲突
   并且iframe有些跳转是用href方式直接会刷新页面(以后尽量用mainConfigUrl方法控制，以后后统一翻新)
    以后所有页面配置的pageUrl前面必须加上斜杠、以WEBINFO为相对路径

    尽可能用vue加element组件结合
    每个页面的头部样式和js 整合到外面公共页面里。用requirejs方式按需加载(js写法尽量不污染全局变量)
    目前页面没有做按需加载  （用textarea实现方式-未做） 可以参考jsp/advert/saleschecking-order-detail.jsp
//        $("#mainFrmCon").load(url,function () {}); 此方法需要在每个加载进来的文档里回调方法显示页面
III 2017.9.23 在主页稍微做了小屏幕适配
IIII 配置文件 实现国际化配置
IIIII 公共库引用(未修改) 引用官方的cdn
http://apps.bdimg.com/libs/jquery/2.1.3/jquery.min.js
**********************华丽分割线****************************************
页面技术设计：
  a.font 字体路径 resources/font/iconfont.*
  wechat 微信font 字体路径 wechat/fonts/iconfont.*
  b.字体升级更新请在相应css文件里加上 版本号防止缓存 修改图片也请加上图片版本号
  c.js方法最好动态绑定在dom上
  d.**** html代码 必须加上防止缓存代码

  0.pc端使用和wechat使用字体是同一套 只是在两个路径下放了两份  以后有用到字体 请修改此文件夹下两套字体(记得版本号修改，修改图片文件也要加)
 1. /resources/font/iconfont-back.ttf 主要于2016年大部分引用做的页面 未改 未确认是否能删除
2.src/main/webapp/resources/pageConfig.js?v=c1c50d6d4f  此文件 全局配置每个页面配置数据 可在其他页面共享
3.tips_contants 此样式名是系统提示框 目前在globel.css base.css 微信里 main.css里都有定义 还有各页面定义. 需要统一
4.防止系统主界面出现元素错乱 已限制页面至少1200px(显示器分辨率1280*720)上。
说好的分辨率在1366上 还是有大部分屏幕需要兼容
高度最好限制在580(720-导航高度-浏览自身url标签栏高度)以下不出现滚动条，以下已不支持
5.js css缓存 用gulp打包解决
6.系统 引用easyui/jquery/bootstrap  三套库js和css文件不动 需要修改(尽量不动) 最好写在自己的单独页面覆盖base样式
7.请勿新建文件引用 易于管理
如果需要引入其他库文件 也请相应追加到 base_new.css和base_new.js文件里 不建议单独引用

2017.09.08 note
8.没有表格的页面请使用vue框架基础上写页面逻辑 参照页面模板最新(/WEB-INF/jsp/choose-scene.jsp)
9.有表格的页面布局大部分类似 上:搜索 中:表格 下:分页 参照页面模板最新(WEB-INF/jsp/assignment/install-standing-by.jsp)
10.详情页面 参照页面(/jsp/advert/salesorder-with-purchaseorder-detail.jsp) 组装代码
11  创建工单、销售单、采购单 页面请参考（/WEB-INF/jsp/assignment/installation-add.jsp）
12  colaui写的采购单(优化) 做参考 (不做修改(变easyui) 做保留) WEB-INF/jsp/advert/purchase-order-add.jsp
13   colaui 写的table表格  做参考 (不做修改(变easyui) 做保留) WEB-INF/jsp/company/employee-all.jsp
14   业务功能准备用 easyui 新框架实现   各业务功能详情页面 、企业管理功能、个人管理功能 还是用colaui实现(不做改变 先colaui优化过渡 以后用vue来翻 不做太复杂交互)
15  打印页面和分享页面 参照 webapp/print/sales-order-detail-print.html
--%>
<!--
user:ljp
系统存在以下几个下拉框
1.select2
2.jquery autocomplete
3.自己写的ydz_select_menu 扩展性不强
4. 在ydz_select_menu 基础上 修改满足 一个页面公用同一个div层 数据共享 增加了自定义修改增加删除功能
5.bootstrap自带的dropdown-menu 在每一个选项绑定事件回写值到文本框
-->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>欢迎使用易对账</title>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" type="text/css" href="/resources/common/common.css?v=3e10f9c6f9">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=ca049c7ec2">
    <link rel="stylesheet" type="text/css" href="/resources/new/main.css?v=4c8fd16a29">
    <style>

        .menuList li {
            overflow: hidden;
        }

        .expandBtn {
            border-top: 1px solid #ccc;
            margin-top: 30px;
            padding-left: 20px;
            /*text-align: center;*/
            font-size: 14px;
            color: #4284d9;
            height: 30px;
            line-height: 40px;
            cursor: pointer;
            overflow: hidden;
        }

        .expandCtrl {
            font-size: 26px;
            color: #4284d9;
            vertical-align: bottom;
        }

        /*适应小屏幕的样式，未上线*/
        /*收菜单栏目*/

        /*控制小屏幕显示菜单方式开始 2017 0925*/

        .collapse_icon {
            display: none;
        }

        /*@media only screen and (max-width:900px){*/
        /*.menuList li a{*/
        /*text-indent: -999px;*/
        /*display: block;*/
        /*}*/
        /*.header-wrap  ul[type=left]{*/
        /*float: none;*/
        /*}*/
        /*.header-wrap  ul[type=left] > li{*/
        /*float: none;*/
        /*}*/
        /*.header-wrap  ul[type=left] > li{*/
        /*float: none;color:#000;*/
        /*border-bottom:1px solid #f2f2f2;*/
        /*}*/
        /*.header-wrap  ul[type=left] > li:hover, .header-wrap  ul[type=left] > li.active{*/
        /*color:#000;*/
        /*}*/
        /*.header-wrap  ul[type=left]:hover .active{*/
        /*background-color:transparent !important ;color:#000;*/
        /*}*/
        /*.navbar_collapse{*/
        /*position: fixed;*/
        /*width: 100%;*/
        /*text-align: center;*/
        /*z-index: 99999;*/
        /*top:60px;*/
        /*background: #fff;*/
        /*}*/
        /*.collapse_icon{*/
        /*display: block;*/
        /*}*/
        /*.h-box .max-hidden{*/
        /*width:60px;*/
        /*}  }*/
        /*@media only screen and (min-width:900px){*/
        /*.navbar_collapse{display: block !important;}*/
        /*}*/

        /*控制小屏幕显示菜单方式结束 2017 0925*/

        /*把导航自动隐藏或者缩小一定范围或者0.1的透明处理鼠标放上去才完全显示 不占高度 浮在整个页面上*/
        /*.top-menu {*/
        /*height: 60px;*/
        /*width: 100%;*/
        /*position: fixed;*/
        /*!* opacity: 0; *!*/
        /*top: 0;*/
        /*left: 0;*/
        /*z-index: 9999;*/
        /*}*/

        #create_company::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }

        body, html {
            min-width: 1280px;
        }

        /*max-width 请根据页面一级导航实时调整*/
        @media only screen and (max-width: 1360px) {
            .header-wrap ul[type=left] > li {
                padding: 0 10px;
            }
        }

        .ui.tree .child-nodes {
            margin-left: 1.25em !important
        }

        .ui.tree .tree.node > .expand-button {
            width: 1.8em
        }

        html body > .h-box > .flex-box > .v-box > .flex-box #viewTabTools > div {
            margin-top: 0
        }

        .ui.toggle.checkbox input:checked ~ .box, .ui.toggle.checkbox input:checked ~ label {
            color: #fff !important
        }

        .ui.toggle.checkbox input:focus:checked ~ .box, .ui.toggle.checkbox input:focus:checked ~ label {
            color: #fff !important
        }

        .ui.toggle.checkbox .box:before, .ui.toggle.checkbox label:before {
            background: #666 !important
        }

        .ui.toggle.checkbox input:checked ~ .box:before, .ui.toggle.checkbox input:checked ~ label:before {
            background: #2e8ae6 !important
        }

        .ui.toggle.checkbox input:checked ~ .box:before, .ui.toggle.checkbox input:checked ~ label:before {
            background: #2e8ae6 !important
        }

        #viewTab > .tab-bar > .tabs > .tab-button.active:before {
            background: 0 0
        }

        .preson-container-left-botton li:hover {
            background: #2e8ae6
        }

        .preson-container-left-botton li:hover a, .preson-container-left-botton li:hover i {
            color: #fff
        }

        #comType {
            opacity: 0
        }

        .preson-container-left-botton {
            display: none;
            background: #27283c
        }

        .preson-container-left-botton li i {
            font-size: 2.5rem !important
        }

        .dis_btn {
            border: none !important;
            background: #e4e4e4 !important
        }

        .tips_contants {
            position: fixed;
            top: 50%;
            left: 50%;
            z-index: 99999;
            display: none;
            margin-top: -150px;
            margin-left: -150px;
            width: 300px;
            height: 80px;
            border-radius: 5px;
            background: rgba(0, 0, 0, .8);
            color: #fff;
            text-align: center;
            line-height: 80px
        }

        .showCom:after {
            border: 6px solid transparent;
            border-top: 6px solid #fff;
            width: 0;
            height: 0;
            left: 180px;
            /*transition:all 0.5s 0s linear;*/
            top: 28px;
            position: absolute;
            content: ' ';
        }

        /*.show:hover .showCom:after{*/
        /*-webkit-transform: rotate(180deg);*/
        /*}*/
        .user-name:after {
            border: 6px solid transparent;
            border-top: 6px solid #fff;
            width: 0;
            height: 0;
            right: 0;
            top: 28px;
            position: absolute;
            content: ' ';
        }

        .pace .pace-progress {
            background: #f86;
            position: fixed;
            z-index: 2000;
            box-shadow: 0 0 10px #fff, 0 0 5px #fff;
            top: 0;
            right: 100%;
            width: 100%;
            height: 2px;
        }

        /*.showCom:hover .comImgTran{
             -webkit-transform: rotate(360deg);
             -moz-transform: rotate(360deg);
             transform: rotate(360deg);
             transition: transform 01s ease-out;
         }*/


    </style>
    <style>
        .loadingPa .item {
            float: left;
            height: 180px;
            position: relative;
            text-align: center;
            transition: all 250ms linear 0s;
            width: 25%;
        }

        .loadingPa .item .item-inner {
            -moz-box-align: center;
            -moz-box-pack: center;
            align-items: center;
            display: flex;
            height: 100%;
            justify-content: center;
            position: relative;
            width: 100%;
        }

        .loadingPa .item .item-loader-container div, .loadingPa .item .item-loader-container div::before, .loadingPa .item .item-loader-container div::after {
            animation-play-state: running;
        }

        /*.la-square-jelly-box.la-2x {*/
        /*height: 64px;*/
        /*width: 64px;*/
        /*}*/
        /*.la-square-jelly-box {*/
        /*height: 32px;*/
        /*width: 32px;*/
        /*}*/
        /*.la-square-jelly-box {*/
        /*color: #fff;*/
        /*display: block;*/
        /*font-size: 0;*/
        /*}*/
        /*.la-square-jelly-box, .la-square-jelly-box > div {*/
        /*box-sizing: border-box;*/
        /*position: relative;*/
        /*}*/
        /*.la-square-jelly-box > div:nth-child(1) {*/
        /*animation: 0.6s linear -0.1s normal none infinite running square-jelly-box-animate;*/
        /*border-radius: 10%;*/
        /*height: 100%;*/
        /*top: -25%;*/
        /*z-index: 1;*/
        /*}*/
        /*.la-square-jelly-box > div:nth-child(1), .la-square-jelly-box > div:nth-child(2) {*/
        /*left: 0;*/
        /*position: absolute;*/
        /*width: 100%;*/
        /*}*/
        /*.la-square-jelly-box > div {*/
        /*background-color: #4da9eb;*/
        /*!*background: -webkit-linear-gradient(red, #5c8f4e);*!*/
        /*!*border: 1px solid #5c8f4e;*!*/
        /*display: inline-block;*/
        /*float: none;*/
        /*}*/
        /*.la-square-jelly-box > div:nth-child(2) {*/
        /*animation: 0.6s linear -0.1s normal none infinite running square-jelly-box-shadow;*/
        /*background: #000 none repeat scroll 0 0;*/
        /*border-radius: 50%;*/
        /*bottom: -9%;*/
        /*height: 10%;*/
        /*opacity: 0.2;*/
        /*}*/
        /*.la-square-jelly-box > div:nth-child(1), .la-square-jelly-box > div:nth-child(2) {*/
        /*left: 0;*/
        /*position: absolute;*/
        /*width: 100%;*/
        /*}*/
        /*@keyframes square-jelly-box-animate {*/
        /*17% {*/
        /*border-bottom-right-radius: 10%;*/
        /*}*/
        /*25% {*/
        /*transform: translateY(25%) rotate(22.5deg);*/
        /*}*/
        /*50% {*/
        /*border-bottom-right-radius: 100%;*/
        /*transform: translateY(50%) scale(1, 0.9) rotate(45deg);*/
        /*}*/
        /*75% {*/
        /*transform: translateY(25%) rotate(67.5deg);*/
        /*}*/
        /*100% {*/
        /*transform: translateY(0px) rotate(90deg);*/
        /*}*/
        /*}*/
        /*@keyframes square-jelly-box-shadow {*/
        /*50% {*/
        /*transform: scale(1.25, 1);*/
        /*}*/
        /*}*/

        .la-ball-climbing-dot.la-2x {
            height: 64px;
            width: 84px;
        }

        .la-ball-climbing-dot {
            height: 32px;
            width: 42px;
        }

        .la-ball-climbing-dot {
            color: #fff;
            display: block;
            font-size: 0;
        }

        .la-ball-climbing-dot, .la-ball-climbing-dot > div {
            box-sizing: border-box;
            position: relative;
        }

        .la-ball-climbing-dot.la-2x > div:nth-child(1) {
            height: 28px;
            width: 28px;
        }

        .la-ball-climbing-dot > div:nth-child(1) {
            animation: 0.6s ease-in-out 0s normal none infinite running ball-climbing-dot-jump;
            border-radius: 100%;
            bottom: 32%;
            height: 14px;
            left: 18%;
            position: absolute;
            transform-origin: center bottom 0;
        }

        .la-ball-climbing-dot.la-2x > div:not(:nth-child(1)) {
            height: 4px;
            width: 28px;
        }

        .la-ball-climbing-dot > div:nth-child(2):not(:nth-child(1)) {
            animation-delay: 0ms;
        }

        .la-ball-climbing-dot > div:not(:nth-child(1)) {
            animation: 1.8s linear 0s normal none infinite running ball-climbing-dot-steps;
            border-radius: 0;
            height: 2px;
            position: absolute;
            right: 0;
            top: 0;
            transform: translate(60%, 0px);
            width: 14px;
        }

        .la-ball-climbing-dot > div {
            webkit-transform: translate3d(0, 0, 0);
            -moz-transform: translate3d(0, 0, 0);
            -ms-transform: translate3d(0, 0, 0);
            -o-transform: translate3d(0, 0, 0);
            transform: translate3d(0, 0, 0);
            background-color: #4284d9;
            /*e7c295*/
            border: 0 solid currentcolor;
            display: inline-block;
            float: none;
        }

        .la-ball-climbing-dot > div:not(:nth-child(1)) {
            background-color: #4284d9;
            border: 0 solid currentcolor;
            display: inline-block;
            float: none;
        }

        .la-ball-climbing-dot > div:nth-child(3):not(:nth-child(1)) {
            animation-delay: -600ms;
        }

        .la-ball-climbing-dot > div:not(:nth-child(1)) {
            animation: 1.8s linear 0s normal none infinite running ball-climbing-dot-steps;
            border-radius: 0;
            height: 2px;
            position: absolute;
            right: 0;
            top: 0;
            transform: translate(60%, 0px);
            width: 14px;
        }

        .la-ball-climbing-dot > div:nth-child(4):not(:nth-child(1)) {
            animation-delay: -1200ms;
        }

        @keyframes ball-climbing-dot-steps {
            0% {
                opacity: 0;
                right: 0;
                top: 0;
            }
            50% {
                opacity: 1;
            }
            100% {
                opacity: 0;
                right: 100%;
                top: 100%;
            }
        }

        @keyframes ball-climbing-dot-jump {
            0% {
                transform: scale(1, 0.7);
            }
            20% {
                transform: scale(0.7, 1.2);
            }
            40% {
                transform: scale(1, 1);
            }
            50% {
                bottom: 125%;
            }
            46% {
                transform: scale(1, 1);
            }
            80% {
                transform: scale(0.7, 1.2);
            }
            90% {
                transform: scale(0.7, 1.2);
            }
            100% {
                transform: scale(1, 0.7);
            }
        }

        /*主页面删除colaui一些样式做的补充*/
        .h-box {
            display: -webkit-box;
            display: -ms-flexbox;
            display: -webkit-flex;
            display: flex;
        }

        .h-box {
            width: 100%;
            -webkit-flex-direction: row;
            -ms-flex-direction: row;
            flex-direction: row;
            -webkit-box-orient: horizontal;
            -moz-box-orient: horizontal;
        }

        .v-box, .h-box {
            position: relative;
            -webkit-flex-wrap: nowrap;
            -ms-flex-wrap: nowrap;
            flex-wrap: nowrap;
            -webkit-justify-content: flex-start;
            -ms-flex-pack: start;
            justify-content: flex-start;
            -webkit-align-content: stretch;
            -ms-flex-line-pack: stretch;
            align-content: stretch;
            -webkit-align-items: flex-start;
            -ms-flex-align: start;
            align-items: flex-start;
        }

        .v-box .flex-box, .h-box .flex-box {
            -webkit-box-flex: 1;
            -moz-box-flex: 1;
            -webkit-flex: 1 1 auto;
            -ms-flex: 1 1 auto;
            flex: 1 1 auto;
            -webkit-align-self: auto;
            -ms-flex-item-align: auto;
            align-self: auto;
        }

        .h-box > * {
            position: relative;
            height: 100%;
        }

        *, *:before, *:after {
            box-sizing: inherit;
        }

        article, aside, details, figcaption, figure, footer, header, hgroup, main, nav, section, summary {
            display: block;
        }

        html, body {
            height: 100%;
        }

        html {
            font-family: sans-serif;
            -ms-text-size-adjust: 100%;
            -webkit-text-size-adjust: 100%;
        }

        html {
            box-sizing: border-box;
        }

        button {
            cursor: pointer;
        }

        .cover {
            display: none;
            position: fixed;
            top: 0;
            width: 100%;
            height: 100%;
            background: #000;
            opacity: 0.7;
            z-index: 1000;
        }

        .alart_one {
            display: none;
            position: fixed;
            top: 50%;
            z-index: 2000;
            width: 930px;
            margin-top: -270px;
            left: 55%;
            margin-left: -550px;
            background: #fff;
        }

        .alart_img {
            width: 300px;
            height: 201px;
            position: absolute;
            top: 0;
            left: -80px;
        }

        .official {
            width: 73%;
            margin: 40px 0px 40px 150px;
            font-size: 15px;
        }

        .official li {
            margin: 35px 0;
        }

        .alart_last {
            width: 310px;
            height: 45px;
            margin: 150px auto 0 !important;
            line-height: 45px;
            text-align: center;
            background: #ff3300;
            border-radius: 5px;
            color: #fff;
            cursor: pointer;
        }

        .callback {
            font-size: 45px;
            right: 0px;
            top: 2px;
            position: absolute;
            color: #a5a5a5;
            cursor: pointer;
        }
    </style>
    <style>
        #msgwindow {
            border: none;
            height: 650px;
            /*height: 100%;*/
            box-shadow: 0px 0px 7px #999;
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
        }

        .ui.top.visible.sidebar, .ui.bottom.visible.sidebar {
            box-shadow: 0px 0px 20px rgba(34, 36, 38, 0.15);
        }

        .ui.top.sidebar {
            top: 0px !important;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            bottom: auto !important;
            -webkit-transform: translate3d(0, -100%, 0);
            transform: translate3d(0, -100%, 0);
        }

        .ui.top.sidebar, .ui.bottom.sidebar {
            width: 100% !important;
            /*height: auto !important;*/
        }

        @-webkit-keyframes sidebarVs {
            0% {
                -webkit-transform: translate3d(0, -100%, 0);
                transform: translate3d(0, -100%, 0);
            }

            100% {
                -webkit-transform: translate3d(0, 0, 0);
                transform: translate3d(0, 0, 0);
            }
        }

        .ui.sidebar.visible {
            display: block !important;
            -webkit-animation-name: sidebarVs;
            -webkit-animation-duration: 0.5s;
            -webkit-animation-timing-function: ease-in-out;
        }

        .ui.visible.sidebar {
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            visibility: visible;
            -webkit-transform: translate3d(0, 0, 0);
            transform: translate3d(0, 0, 0);
        }

        .ui.sidebar {
            display: none;
        }

        .ui.dimmer {
            display: none;
            position: absolute;
            top: 0em !important;
            left: 0em !important;
            width: 100%;
            height: 100%;
            text-align: center;
            vertical-align: middle;
            background-color: rgba(0, 0, 0, 0.18);
            opacity: 0;
            line-height: 1;
            -webkit-animation-fill-mode: both;
            animation-fill-mode: both;
            -webkit-animation-duration: 0.5s;
            animation-duration: 0.5s;
            -webkit-transition: background-color 0.5s linear;
            transition: background-color 0.5s linear;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            will-change: opacity;
            z-index: 1000;
        }

        .dimmed.dimmable > .ui.animating.dimmer, .dimmed.dimmable > .ui.visible.dimmer, .ui.active.dimmer {
            display: block;
            opacity: 1;
        }

    </style>
    <script>
        //    采购单链接
        var purchaseMenuUrl = "/ydz/purchaseorder/toAdd";
        var marketType = "${type}" == "promoter" ? true : false;
    </script>
    <script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "https://hm.baidu.com/hm.js?9f66759d01bead4ba7509b00b4542912";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
</head>
<body style="position: relative;overflow: hidden;">
<div class="cover"></div>
<div class="alart_one">
    <div class="callback iconfont_new">&#xe6a0;</div>
    <img class="alart_img" src="../../images/serviceok.png" alt="">
    <ul class="official">
        <li>亲爱的用户朋友：</li>
        <li>&#X3000;&#X3000;&#X3000;很抱歉，您的免费体验开单额度<span style="color:#ff3300;">超过<span class="stroke">50</span>笔</span>了，需要您付费才能继续使用系统！
        </li>
        <li>&#X3000;&#X3000;&#X3000;我们全力以赴致力于为用户提供更好的产品功能和用户体验！</li>
        <li>&#X3000;&#X3000;&#X3000;欢迎您不断地将需求告知我们，有不足的地方，我们一起改进优化，携手创造一个伟大的产品！</li>
        <li>&#X3000;&#X3000;&#X3000;如有疑问，请咨询 <span style="color:#ff3300;">186-2158-0723</span></li>
        <li class="alart_last">立即去付费支持我们！</li>
    </ul>
</div>
<div class="loadingPa"
     style="    position: absolute;
    left: 50%;
    top: 50%;
    margin-top: -100px;
    width: 100px;
    z-index: 88;
    height: 100px;
    margin-left: -100px;">
    <div class="item-inner">
        <div class="item-loader-container">
            <div class="la-ball-climbing-dot la-2x">
                <div></div>
                <div></div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>

</div>
<script src="/resources/jquery/jquery-2.1.3.min.js?v=ea11ea1d51"></script>
<script src="/resources/nprogress/pace.min.js?v=49b254ce06"></script>
<%--注册成功--%>
<c:if test="${sessionScope.sessionUser.comIsvalid ne '1'}">
    <%--<div class="chose-style" style="display: block">--%>
    <%--<p class="chose-style-text"><span>注册成功！</span>我们免费帮您开通了"易对账个人版"</p>--%>
    <%--<h4>您还可以选择创建或者加入企业</h4>--%>
    <%--<ul class="chose-style-list">--%>
    <%--<li onclick="createCompanyModel('1')">--%>
    <%--<a href="#">--%>
    <%--<p>作为企业管理者</p>--%>
    <%--<img src="../../images/chose-style1.jpg" alt="作为企业管理者">--%>
    <%--<h1>创建 企业/团队</h1>--%>
    <%--<h2>为我所在的公司或团队，开通并使用</h2>--%>
    <%--</a>--%>
    <%--</li>--%>
    <%--<li class="JionCompanyWin">--%>
    <%--<a href="#">--%>
    <%--<p>作为企业员工</p>--%>
    <%--<img src="../../images/chose-style2.jpg" alt="作为企业管理者">--%>
    <%--<h1>加入 企业/团队</h1>--%>
    <%--<h2>加入我所在的企业，为企业出力</h2>--%>
    <%--</a>--%>
    <%--</li>--%>
    <%--<li onclick="createCompanyModel('3')">--%>
    <%--<a href="#">--%>
    <%--<p>作为个人</p>--%>
    <%--<img src="../../images/562620019.jpg" alt="作为企业管理者">--%>
    <%--<h1>我想立即开始使用</h1>--%>
    <%--</a>--%>
    <%--</li>--%>
    <%--</ul>--%>
    <%--</div>--%>
</c:if>
<%--加入企业--%>
<div class="joinCompany joinCompany1">
    <div class="creatr-company-from">
        <div class="creatr-company-hrear">
            <img src="../../images/chose-style2.jpg" alt="">
            <p>加入企业</p>
        </div>

        <div class="joinCompanyContainer">
            <div class="joinCompanyperson">申请人：<span class="realNameCls"></span></div>
            <div class="joinCompanyinventCode">员工邀请码</div>
            <p class="joinCompanyinventInp"><input type="text" placeholder="需向企业获取，邀请码为10位数字与字母组合"
                                                   id="joinCompanyinventInp">
                <button id="joinCompanyinventBtn" onclick="mainPageFun.search_company(this)">搜索企业</button>
            </p>
            <div class="joinCompanyDetail">
                <p class="comNameCls2"></p>
                <p class="adminNameCls2"></p>
                <p class="adminPhoneCls2"></p>
            </div>
            <div class="joinCompanyinventNone">通过邀请码搜索到企业，才能申请加入</div>
            <div class="joinCompanyinventPass">已加入该企业</div>
        </div>

        <div class="joinCompanyBtn">
            <button class="yihouzaishuo">以后再说</button>
            <button class="shenqingjiaru dis_btn" disabled>申请加入</button>
        </div>

    </div>
</div>
<div class="joinCompany joinCompany2">
    <div class="creatr-company-from">
        <div class="creatr-company-hrear">
            <img src="../../images/chose-style2.jpg" alt="">
            <p>加入企业</p>
        </div>

        <div class="joinCompanyContainer">
            <div class="joinCompanyDetail1">
                <p class="comNameCls2"></p>
                <p class="adminNameCls2"></p>
                <p class="adminPhoneCls2"></p>
            </div>
            <div class="joinCompanySceccess">
                <p>申请成功</p>
                <p>企业管理员会尽快审核，审核结果会以短信形式通知您。<br>
                    请注意查收！</p>
            </div>
        </div>

        <div class="joinCompanyBtn">
            <button class="lijishiyonggerenban">知道了，先去使用个人版</button>
        </div>

    </div>
</div>
<%--顶部导航--%>
<div class="top-menu  blur_box">

    <nav class="header-wrap">
        <div class="show" style="width: 206px;">
            <div class="showCom" style="margin-left:14px;width:210px;">
                <img class="comImgTran" style="border:none;outline:none;width:40px;height: 40px;border-radius: 20px;"
                     src="${sessionScope.sessionUser.comLogoPath}" onerror="this.src='/images/default_company.png'"/>
                <span style=" width:114px; display: inline-block;color:#fff;text-indent: 5px;
    height: 60px;line-height:60px;vertical-align:middle;font-size: 14px;white-space: nowrap;text-overflow: ellipsis;
    overflow: hidden;" class="helloCom comShortnameCls">...</span>
                <ul class="setting">

                    <div class="main_box">
                        <div class="main_botton" id="main_botton">
                            <img class="comImgTran" src="${sessionScope.sessionUser.comLogoPath}"
                                 onerror="this.src='/images/default_company.png'"/>
                            <span class="main_botton_span comNameCls"></span>
                            <span class="main_botton_span_sec personalHide comIdCls"></span>
                            <%--<span class="main_point iconfont_new">&#xe68d;</span>--%>

                        </div>
                        <div class="main_hide_new">
                            <ul class="create_company scroller" id="create_company"></ul>
                            <p class="main_hide_text" style="display: none">您当前还没有创建或加入任何企业赶紧拉上您的企业，一同并肩作战</p>
                            <ul class="main_hide_sec">
                                <li onclick="mainPageFun.createCompanyModel()">
                                    <a>创建新企业</a>
                                </li>
                                <li class="JionCompanyWin">
                                    <a>加入新企业</a>
                                </li>
                            </ul>
                        </div>
                    </div>

                </ul>
            </div>
        </div>
        <div class="collapse_icon iconfont_new" style="    font-size: 30px;
    color: #fff;
    position: absolute;
    left: 220px;
    top: 18px;">&#xe66d;</div>


        <div class="navbar_collapse">
            <ul type="left" id="headerLeftMenu">
                <%--<li class="">工作台</li>--%>
            </ul>
        </div>


        <div class="freeUse" style="      z-index: 99;
    transform: translate(-10px,15px);
    /*display: inline-block;*/
    background: #f15822;
        display: none;
    padding: 0 10px;
    color: #fff;
    border-radius: 10px;">7天内订购立享优惠
        </div>

        <ul>
            <li>
                <div class="header-message user-name">
                    <%--<img onerror="this.src='/images/default_user.png'" src="${sessionScope.sessionUser.avatarPath}">--%>
                    <span class="hellouser">您好，
                    <span class="username realNameCls"></span></span>
                </div>
                <ul class="service">
                    <li><a href="javascript:window.open('/openPage?pageName=person-main');"><span
                            class="iconfont_new serviceicon"></span><span>个人中心</span></a></li>
                    <li onclick="logout()"><a href="#"><span
                            class="iconfont_new logouticon"></span><span>退出登录</span></a></li>
                </ul>
            </li>


            <%--<div class="menudivide"></div>--%>
            <li class="messageControl hide" style="padding-left:11px;line-height:63px;">
                <span id="message-num-circle" style="       display: none;
    line-height: 18px;
    text-align: center;
    height: 20px;
    width: 20px;
    background: #da4654;
    color: #fff;
    border-radius: 20px;
    position: absolute;
    right: 5px;
    top: 5px;
    font-size: 12px;">0</span>
                <div class="header-message"><span class="iconfont_new messageicon"></span><span class="newsIcon"
                                                                                                style="position:relative;top:-2px;font-size:14px;">消息</span>
                </div>
                <ul class="account">
                    <li onclick="xiaoxiliebiao()"><a href="##" style="letter-spacing: 2px;"><span>消息提醒</span><span
                            class="rightNum"><strong id="message-num">0</strong></span></a></li>
                    <%--<li><a href="#/setting/account"><span>好友申请</span><span class="rightNum">+3</span></a></li>--%>
                </ul>
            </li>

            <li class="messageControl hide" style="padding-right:11px;">
                <div class="header-message" title="创建/邀请">
                    <i class=" iconfont_new createSC ">&#xe6a5;</i><span class="addone"
                                                                         style="position:relative;top:-5px;font-size:14px;">开单</span>
                </div>
                <ul class="account" id="invent_add_list_first">
                </ul>
            </li>
        </ul>

    </nav>
</div>
<%--底部窗口--%>
<div class="h-box blur_box workbench_box" style="">
    <aside class=" max-hidden marginlr30" style="">
    </aside>
    <div class="flex-box" type="content">
        <iframe name="mainFrmCon" id="mainFrmCon" frameborder="0" width="100%" height="100%" src=""></iframe>
    </div>
</div>

<div id="msgwindow" class="segment ui sidebar top "
     style="right: 0px; padding-left: 22px; margin: 0px auto !important; z-index: 1112;"></div>
<div class="ui dimmer " style="position: fixed; opacity: 0.6; z-index: 1111;"></div>
<script src="/resources/common/global-config.js?v=b6d799628b"></script>
<script src="/resources/common/common_new.js?v=827294e84d"></script>
<script src="/resources/common/main.js?v=29a874f647"></script>
<script src="/resources/jquery/jquery.cookie.js?v=1bf09dac64"></script>
<script>
    //打开合作伙伴搜索添加页面
    function openPartner() {
        var url = "/system/partner/frameAddPartner";
        showMessageDialog(url, "", "84%", "100%", true);
    }
    function msg(content) {
        $("#msgwindow").html(content).addClass(" activ ");
    }
    function hideMsg() {
        $("#msgwindow").empty();
//        $(".window-mask").hide();
        $("#msgwindow").removeClass("activ visible");
        $(".dimmer").removeClass("active");
    }
    function showMessageDialog(url, title, width, height, shadow) {
        var content = '<iframe id="msgF" src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="yes"></iframe>';
        $("#msgwindow").empty();
        $("#msgwindow").addClass("visible");
        $(".dimmer").addClass("active");
        var last = Date.now();
        setTimeout(function () {
            // 监听动画完成时间
//            if ($("#msgwindow").hasClass("activ")) {
//                msg(content);
//            } else {
            $("#msgwindow")[0].addEventListener('webkitAnimationEnd', function () {
                msg(content);
            }, false);
//            }
        }, 0);
    }
    //menu全部初始化
    function MenuQuery() {
        $.ajax({
            url: '/menus',
            type: 'GET',
//            async: false,
            dataType: "json",
            cache: false,
            success: function (data) {
                $("#MenuSetting").css("opacity", "1");
                $(".switch-btn").css("opacity", "1");
                $(".preson-container-left-botton").css("display", "block");

//                data.menus
//                data.config.roleMenuVOs  menuName
                //菜单 工作台
                try {
                    var funTree = function (o) {
                        var str = "";
                        var changeItem;
                        if (o.length == undefined) {
                            changeItem = JSON.stringify(o.roleMenuVOs);
//                        var itm='<span style="position:absolute;top:-10px;right:0;background: #f15822">7天内订购立享优惠</span>';
                            if (o["menuName"] != "") {
                                str = "<li style='position:relative' data-url='" + o["menuId"] + "' data-icon='" + o["menuIcon"] + "' data-json='" + changeItem + "'>" + o["menuName"] + "</li>";
                            }
                        } else {
                            for (var i = 0; i < o.length; i++) {
                                var urlstr = "";
                                try {
//                                        if (o[i]["menuUrl"] == "") {
                                    changeItem = JSON.stringify(o[i].roleMenuVOs);
                                    urlstr = "<li data-url='" + o[i]["menuId"] + "' data-icon='" + o[i]["menuIcon"] + "' data-json='" + changeItem + "'>" + o[i]["menuName"] + "</li>";
//                                        }
                                    str += urlstr;
                                } catch (e) {
                                }
                            }
                        }
                        return str;
                    };
                    $("#headerLeftMenu").empty().html(funTree(data.menus)).append(funTree(data.config));

                } catch (e) {
                }
                topMenuChange();

//                $(function () {
//                    document.getElementById("menuList").innerHTML = forTree(data.menus);
//                }());
                //设置
//                        document.getElementById("MenuSetting").innerHTML += "<li><i class='iconfont " + data.config.menuIcon + "'></i><a>" + data.config.menuName + "</a><ul id='setting_sec'></ul></li>";

//                        document.getElementById("setting_sec").innerHTML = forTree(data.config.roleMenuVOs);
            },
            error: function () {
                tipsPop("菜单请求失败");
            }
        });
    }
    function expandBtnFun() {
        var $t = $(".max-hidden");
        if ($t.hasClass("collapseMenuBtn")) {
            $(".max-hidden").css({"width": "180px"}).addClass("expandMenuBtn").removeClass("collapseMenuBtn");
        } else {
            $(".max-hidden").css({"width": "60px"}).addClass("collapseMenuBtn").removeClass("expandMenuBtn");
        }
    }
    var _str_globe = "";
    var _str_globe_three = "";
    var forTreeTwo = function (o, icon) {
        var isTwoTree = false;
        var urlstr = "";
        for (var i = 0; i < o.length; i++) {
            var threeStr = "";
            try {
                if (o[i]["menuUrl"] == "") {
                    //升级菜单特殊处理
                    if (o[i]["menuIcon"] === "upgrade-ydz") {
                        var changeItem = JSON.stringify(o[i]);
                        urlstr += "<h1 data-url='" + o[i]["menuUrl"] + "' class=' hfont14 iconfont_new " + icon + " " + o[i]["menuIcon"] + "  urlClick'  onclick='change(" + changeItem + ")'>" + o[i]["menuName"] + "</h1>";
                    } else {
                        urlstr += "<h1 > " + o[i]["menuName"] + "</h1>";
                    }
                } else {
                    isTwoTree = true;
                    // 目前系统里由于菜单结构未定 暂定一种方案解决 以后需要修改三层结构展示 修改此代码
                    // 注释的代码请勿删除 2017-04-12
                    var changeItem = JSON.stringify(o[i]);
                    urlstr += "<li data-url='" + o[i]["menuUrl"] + "'  class='urlClick " + o[i]["menuType"] + "' onclick='change(" + changeItem + ")'><span class='bgColorspan'></span><i class='iconfont_new " + o[i]["menuIcon"] + "'></i><a href='javascript:void(0);'>" + o[i]["menuName"] + "</a></li>";
                }
                if (o[i].roleMenuVOs.length > 0) {
                    threeStr = forTreeThree(o[i].roleMenuVOs, icon);
                }
                urlstr += threeStr;
                if (isTwoTree) {
                    urlstr = '<ul  class="menuList">' + urlstr + '</ul>';
                }
            } catch (e) {
            }
        }
        return urlstr;
    };
    var forTreeThree = function (o, menuIcon) {
        var urlstr = '<ul  class="menuList">';
        for (var i = 0; i < o.length; i++) {
            if (o[i]["menuUrl"] == "") {
                urlstr += "<li class='" + o[i]["menuType"] + "'><span class='bgColorspan'></span><i class='iconfont_new " + o[i]["menuIcon"] + "'></i><a href='javascript:void(0);'>" + o[i]["menuName"] + "</a></li>";

            } else {
                var changeItem = JSON.stringify(o[i]);
                urlstr += "<li data-url='" + o[i]["menuUrl"] + "'  class='urlClick " + o[i]["menuType"] + "' onclick='change(" + changeItem + ")'><span class='bgColorspan'></span><i class='iconfont_new " + o[i]["menuIcon"] + "'></i><a href='javascript:void(0);'>" + o[i]["menuName"] + "</a></li>";

            }
        }
        return urlstr + "</ul>";
    };
    //一级菜单点击事件
    function topMenuChange() {

        $(".collapse_icon").click(function () {
            if ($(".navbar_collapse").is(":hidden")) {
                $(".navbar_collapse").show();
            } else {
                $(".navbar_collapse").hide();
            }
        })
        // 一级菜单切换
        $("#headerLeftMenu").on("click", "li", function () {
            $("#mainFrmCon").attr("src", "");
//            $(".navbar_collapse").hide();
            var menuUrl = "";
            var $this = $(this);
            $this.addClass("active").siblings().removeClass("active");
            if ($this.index() == 0) {
                $('.h-box').addClass('workbench_box');
                menuUrl = "/frame/workbench-simple.html";

            } else {
//                $(".max-hidden").empty().html(forTreeTwo($this.data("json"),$this.data("icon"))).append("<div onclick='expandBtnFun()' class='expandBtn'><span class='iconfont_new
//     expandCtrl'>&#xe66d;</span><span style='letter-spacing: 1px;padding-left: 15px;'>展开/收起</span></div>");
                $(".max-hidden").empty().html(forTreeTwo($this.data("json"), $this.data("icon")))
                menuUrl = $(".max-hidden").find(".urlClick:first").addClass("active").data("url");
                $('.h-box').removeClass('workbench_box');
            }
//            $("#mainFrmCon").attr("src",menuUrl);
            sessionSave("ydzoneMenu", $this.data("url"));

            if ($this.index() == 0) {
                mainConfigUrl(menuUrl, 1);
            } else {
                mainConfigUrl(menuUrl);
            }
//            清空全局变量菜单数据
            _str_globe = "";
            _str_globe_three = "";
        });
        initClickMenu();
    }
    // 页面加载初始化选中menu
    function initClickMenu() {
        var url, liNum;
        try {
            $(".loadingPa").fadeOut();
            $(".item-loader-container div").css("animationPlayState", "paused");
            $(".item-loader-container div").css("WebkitAnimationPlayState", "paused");
            $(".item-loader-container div").css("MozAnimationPlayState", "paused");
            if (sessionGet("ydzoneData") != "null" && sessionGet("ydzoneData") != "") {
                url = sessionGet("ydzoneData");
            } else {
                url = "/frame/workbench-simple.html";
            }

            if (sessionGet("ydzoneMenu") != "undefined" && sessionGet("ydzoneMenu") != "null" && sessionGet("ydzoneMenu") != "") {
                liNum = sessionGet("ydzoneMenu");
            }

            if (marketType) {
                $("#mainFrmCon").attr("src", "/openPage?pageName=promoter_promoter-award");
            } else {
                if (liNum) {
                    if ($("#headerLeftMenu").children("li[data-url='" + liNum + "']").length > 0) {
                        $("#headerLeftMenu").children("li[data-url='" + liNum + "']").click();
                    } else {
                        $("#headerLeftMenu").children("li:first").click();
                    }

                } else {
                    $("#headerLeftMenu").children("li:first").click();
                }
            }
//            mainConfigUrl(url,type);
            //     window.frames['mainFrmCon'].history.pushState(null, null, $("#mainFrmCon").attr("src"));
        } catch (e) {
            $(".loadingPa").fadeOut();
            $(".item-loader-container div").css("animationPlayState", "paused");
            $(".item-loader-container div").css("WebkitAnimationPlayState", "paused");
            $(".item-loader-container div").css("MozAnimationPlayState", "paused");
        }
    }
    //二级菜单的点击事件
    function change(item) {
        var ev = arguments.callee.caller.arguments[0] || window.event;
        $("#mainFrmCon").attr("src", "");
        var tag = $(ev.target)[0].tagName;
        if (tag === "H1") {
            $(ev.target).parent(".max-hidden").find(".active").removeClass("active");
            $(ev.target).addClass("active");
            mainConfigUrl(item);
        } else {
            $(ev.target).parents(".max-hidden").find(".active").removeClass("active");
            $(ev.target).parent("li").addClass("active");
            mainConfigUrl(item);
        }
    }
    //二级菜单跳转的方法 总部调用
    function mainConfigUrl(item, type) {
        $("#mainFrmCon").attr("src", "");
        var url = "";
        try {

            if (item.hasOwnProperty("menuUrl")) {
                url = item.menuUrl;
            } else {
                url = item;
            }
        } catch (e) {

        }

        $("#mainFrmCon").attr("src", url);

        sessionSave("ydzoneData", url);

        if (type) {
            $('.h-box').addClass('workbench_box');
            $(".max-hidden").empty();
        }
        //禁用回退
        window.history.pushState(null, null, document.URL);
        try {
            window.frames['mainFrmCon'].history.pushState(null, null, url);
        } catch (e) {
        }
    }
    // 创建 采购销售订单
    function purchaseOrderAdd(url) {
        var config;
        if (url) {
            config = {
                menuUrl: url
            };
        } else {
            config = {
                menuUrl: purchaseMenuUrl
            };
        }


        // icon 必须固定 否则触发不了点击事件
        $("#headerLeftMenu li[data-icon='icon-ydz-menu-synchro-order']").click();
        mainConfigUrl(config);
    }
    // tips提示框
    function tipsPop(h) {
        $(".tips_contants").empty();
        $("<div class='tips_contants'>").fadeIn(250).html(h).delay(1000).fadeOut(250).appendTo('body');
    }
    var mainPageFun = {
        //请求企业名称+用户名称
        comPersonalInfo: function () {
            var dataIndustryId = "";
            $.ajax({
                url: '/ydz/mainframe/mainBanner',
                type: 'GET',
                async: false,
                dataType: "json",
                cache: false,
                success: function (data) {
                    localStorage.setItem("industryIdYdz", data.industryId);//设置行业
                    //菜单消息列表
                    if (data.msgCount > 99) {
                        $("#message-num-circle").show().html("99");
                        $('#message-num').css("opacity", "1").html("99");
                    } else if (data.msgCount <= 0) {
                        $('#message-num').css("opacity", "0");
                        $("#message-num-circle").hide();
                    } else {
                        $("#message-num-circle").show().html(data.msgCount);
                        $('#message-num').css("opacity", "1").html(data.msgCount);
                    }

                    dataIndustryId = data.industryId;

                    //进入企业中心
                    if (data.roleKey == 1) {
                        var ScriptCode = data.scriptCode;
                        eval(ScriptCode);
                        $(".personalHide").hide();
                        $(".main_botton_span_sec").on('click', function (event) {
                            window.open('/openPage?pageName=company-main');
                            event.stopPropagation();
                        });
                    }
                    // 创建生意伙伴
                    if (data.addPartner == 1) {
                        var addPartnerScriptCode = data.addPartnerScriptCode;
//                        eval(addPartnerScriptCode);
                        document.getElementById("invent_add_list_first").innerHTML += '<li onclick="openPartner()">'
                            + '<a href="javascript:void(0)" ><span>创建客户/供应商</span></a></li>';
                    }

                    //创建销售订单
                    if (data.addsoKey == 1) {

//                    var addsoScriptCode = data.addsoScriptCode;
//                    eval(addsoScriptCode);
                        document.getElementById("invent_add_list_first").innerHTML += '<li onclick="salesOrderAdd()">'
                            + '<a href="javascript:void(0)" ><span>销售开单</span></a></li>';
                    }
                    $("#invent_add_list_first").append('<li onclick="purchaseOrderAdd()"><a href="javascript:void(0)"><span>采购开单</span></a></li>');

                    var create_company = document.getElementById("create_company");
                    var defaultCom = data.defaultCom, currentCom = data.currentCom;       //判断默认
                    create_company.innerHTML = "";

                    if (data.companies.length <= 1) {
                        $(".main_hide_text").show();
                    }
                    $.each(data.companies, function (key, val) {
                        var active = val.comKey === currentCom ? "active" : "";
                        if (defaultCom == val.comKey) {
                            create_company.innerHTML +=
                                "<li>"
                                + "<i class='" + active + "'></i>"
                                + "<a onclick=mainPageFun.changeCompany('" + val.comKey + "')>" + val.comName + "</a>"
                                + "<b>默认</b>"
                                + "</li>"
                        } else {
                            create_company.innerHTML +=
                                "<li>"
                                + "<i class='" + active + "'></i>"
                                + "<a onclick=mainPageFun.changeCompany('" + val.comKey + "')>" + val.comName + "</a>"
                                + "<button id='btnSetDefaultCom' key='" + val.comKey + "' onclick=mainPageFun.setDefaultCompany('" + val.comKey + "')>设为默认</button>"
                                + "</li>"
                        }
                    })

                },
                error: function () {
                    tipsPop("请求失败");
                }
            });

        },
        search_company: function () {
            var insideCode = $("#joinCompanyinventInp").val();
            if (insideCode == "") {
                return;
            }
            $.ajax({
                url: '/company/findByCom',
                type: 'GET',
                async: true,
                dataType: "json",
                data: {
                    insideCode: insideCode
                },
                success: function (data) {
                    var empStatus = data.empStatus;

                    var $tips = $(".joinCompanyinventPass");
                    switch (empStatus) {
                        case "0" :
                            $tips.css("background", "#3dcc74").text("未加入该企业");
                            $(".shenqingjiaru").removeClass("dis_btn").removeAttr("disabled");
                            break;
                        case "1" :
                            $tips.css("background", "#ee8e52").text("该企业已邀请您");
                            $(".shenqingjiaru").addClass("dis_btn").attr("disabled", "disabled");
                            break;
                        case "2" :
                            $tips.css("background", "#ee8e52").text("正在审批中...");
                            $(".shenqingjiaru").addClass("dis_btn").attr("disabled", "disabled");
                            break;
                        case "3" :
                            $tips.css("background", "#da4654").text("已经加入该企业");
                            $(".shenqingjiaru").addClass("dis_btn").attr("disabled", "disabled");
                            break;
                            /*case "4" :
                             $tips.css("background","#3dcc74").text("离职状态");
                             break;*/
                        case "5" :
                            $tips.css("background", "#da4654").text("申请被拒绝，请联系企业");
                            $(".shenqingjiaru").addClass("dis_btn").attr("disabled", "disabled");
                            break;
                    }
                    $("#joinCompanyinventBtn").css("background", "#e4e4e4").css("color", "#666").attr("disabled", "disabled");
                    if (data == "0") {
                        $(".joinCompanyinventNone").html("邀请码错误，未搜索到该企业").css("background", "#ff0000").css("color", "#fff");
                    } else {
                        join_company = data;
                        $(".comNameCls2").text(join_company.comName);
                        $(".adminNameCls2").text(join_company.adminName);
                        $(".adminPhoneCls2").text(join_company.adminPhone);
                        $(".joinCompanyinventNone").css("display", "none");
                        $(".joinCompanyDetail").css("display", "block");
                        $(".joinCompanyinventPass").css("display", "block");
                    }
                },
                error: function () {
                    $(".joinCompanyinventNone").html("搜索失败").css("background", "#69d082").css("color", "#fff");
                }
            });
        },
        //加入企业
        JionCompany: function () {
            $(".JionCompanyWin").click(function () {
                $(".blur_box").addClass("blur");
                $("#joinCompanyinventBtn").css("background", "#2e8ae6").css("color", "#fff").removeAttr("disabled");
                $(".joinCompany1").fadeIn();
                $('.main_hide').slideUp();
                $(".main_botton").children('.main_point').removeClass('active');
            });
            //以后再说
            $(".yihouzaishuo").click(function () {
                join_company = {};
                $(".blur_box").removeClass("blur");
                $(".joinCompany1").fadeOut();
                $(".joinCompanyinventNone").css("display", "block").html("通过邀请码搜索到企业，才能申请加入").css("background", "none").css("color", "#999999");
                $(".joinCompanyDetail").css("display", "none");
                $(".joinCompanyinventPass").css("display", "none");
                $(".shenqingjiaru").addClass("dis_btn").attr("disabled", "disabled");
                $("#joinCompanyinventInp").val("");
            });

            //立即
            $(".lijishiyonggerenban").click(function () {
                $(".joinCompany2").fadeOut();
                $(".blur_box").removeClass("blur");
            });
            $("#joinCompanyinventInp").keyup(function () {
                /*var regx = /^[A-Z0-9]{10}$/;*/
                //!regx.test($(this).val())
                if ($(this).val().length == 0) {
                    $(".joinCompanyinventNone").html("通过邀请码搜索到企业，才能申请加入").css("background", "none").css("color", "#999999").show();
                    $("#joinCompanyinventBtn").css("background", "#e4e4e4").css("color", "#666").attr("disabled", "disabled");
                    $(".joinCompanyinventPass").hide();
                    $(".joinCompanyDetail").hide();
                } else if ($(this).val().length != 10) {
                    //邀请码错误，未搜索到该企业
                    $(".joinCompanyinventNone").html("格式错误，请输入10位邀请码").css("background", "#ff0000").css("color", "#fff").show();
                    $("#joinCompanyinventBtn").css("background", "#e4e4e4").css("color", "#666").attr("disabled", "disabled");
                    $(".joinCompanyinventPass").hide();
                    $(".joinCompanyDetail").hide();
                    //隐藏  joinCompanyDetail1
                } else {
                    $("#joinCompanyinventBtn").css("background", "#2e8ae6").css("color", "#fff").removeAttr("disabled");
                    $(".joinCompanyinventNone").html("点击搜索企业").css("background", "#69d082").css("color", "#fff");
                }
            });
        },
        createCompanyModel: function () {
            window.location.href = "/openPage?pageName=choose-scene&tp=create";
        },
        //切换公司
        changeCompany: function (changeComKey) {
            $.post('/ydz/mainframe/changeValidateDue',
                {comKey: changeComKey},
                function (data) {
                    if (data == "1") {
                        $ajaxFun();
                    } else {
//                	window.location.href="/jsp/company/service-maturity.jsp";
                        window.location.href = data;
                    }

                }, "text");

            var $ajaxFun = function () {
                $.ajax({
                    url: '/ydz/mainframe/changeCurrentCompany',
                    type: 'GET',
                    async: true,
                    data: {comKey: changeComKey},
                    dataType: "json",
                    success: function (data) {
                        tipsPop("正在切换公司");
                        sessionRemove("ydzoneData");
                        setTimeout(function () {
                            window.location.reload();
                        }, 1500);
                    },
                    error: function () {
                        tipsPop("修改失败");
                    }
                });
            }
        },
        //设置默认
        setDefaultCompany: function (defaultComKey) {
            $.ajax({
                url: '/ydz/mainframe/setDefaultCompany',
                type: 'GET',
                async: true,
                data: {comKey: defaultComKey},
                dataType: "json",
                success: function (data) {
                    tipsPop("正在设置默认公司");
                    setTimeout(function () {
                        window.location.reload();
                    }, 1500);
                },
                error: function () {
                    tipsPop("修改失败");
                }
            });
        },
    }
    mainPageFun.comPersonalInfo();
    $(function () {
        // 关闭弹窗
        $(".callback").click(function () {
            $(".alart_one").hide();
            $(".cover").hide();
        })
//   付费跳转
        $(".alart_last").click(function () {
            window.location = "/openPage?pageName=c_payment/priceList";
        })

        $(".dimmer").click(function () {
            hideMsg();
        })
        if (!marketType) {
            $(".messageControl").removeClass("hide");
        }
        //点击body隐藏
//        var clipboard = new Clipboard('#inventMsgBtn', {
//            target: function () {
//                return document.getElementById('inventMsg');
//                return document.getElementById('inventMsg');
//            }
//        });
//        clipboard.on('success', function (e) {
//            tipsPop("复制成功，赶快去分享给微信或QQ上的好友");
//        });
//        clipboard.on('error', function (e) {
//            tipsPop("您的浏览器不支持");
//        });
        //点击加入企业
        $(".shenqingjiaru").click(function () {
            $(this).attr("disabled", "disabled");
            $.post(
                "/company/applyCom",
                {
                    comKey: join_company.comKey,
                    comName: join_company.comName
                }, function (data) {
                    $(this).removeAttr("disabled", "disabled");
                    if (data == "1") {
                        $(".joinCompany1").fadeOut();
                        $(".lijishiyonggerenban").text("我知道了");
                        $(".joinCompany2").fadeIn();
                    } else {
                        $(".joinCompanyinventNone").html("申请失败").css("background", "#69d082").css("color", "#fff");
                    }
                }
            );
        });

        //禁止返回上一页
        window.history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
        MenuQuery();
        mainPageFun.JionCompany();

    });
</script>
<style>
    #upgradeWin {
        border: none;
        z-index: 9999;
        width: 700px;
        box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
        min-height: 290px;
        background: #fff;
        transition: all 0.2s 0s linear;
        -webkit-transition: all 0.2s 0s linear;
        position: fixed;
    }

    .secTitle {
        color: #4e8ae6;
        font-size: 14px;
        line-height: 30px;
    }

    .secCon {
        font-size: 14px;
        line-height: 30px;
    }

    .secDesc {
        font-size: 14px;
        line-height: 30px;
        color: #ccc;
    }

    .secOther {
        line-height: 30px;

    }

    .upgradeCon {
        margin: 65px 51px;
        overflow: auto;
        height: 400px;
    }

    .upgradeCon .section {
        margin-bottom: 30px;
    }

    #upgradeWin {
        padding-top: 5px;
        top: 50%;
        left: 50%;
        margin-left: -465px;
        margin-top: -300px;
        position: absolute;
        width: 930px;
        display: none;
        height: 600px;
    }

    .window-mask {
        position: fixed;
        left: 0;
        display: none;
        top: 0;
        background: #000;
        z-index: 999;
        width: 100%;
        height: 100%;
        filter: alpha(opacity=20);
        opacity: 0.4;
        font-size: 1px;
        overflow: hidden;
    }

    #upgradTitle {
        position: relative;
        font-weight: 100;
        text-align: left;
        font-size: 16px;
        margin: 0px auto;
        color: #01a09a;
        padding: 14px 30px;
        border-bottom: 1px solid #e8e8e8
    }
</style>
<script>
    //    升级内容操作区域
    $(function () {
        "use strict";
        var upgradeKey = "upgrade20117122701";// 每次升级设置的key值 请保持唯一
        var upgradePrevKey = "";     // 请置空上次设置的cookie的值 根据key清空  如果是第一次设置 勿做设置
        var upgradeTitle = "易对账（2017-12-27）升级公告"; //升级标题
        var upgradeOff = false;// 是否启用
        if (upgradeOff) {
            return false;
        }
        // 每次更新请更新key和value值
        $.cookie(upgradePrevKey, null);
        var upgradeMark = $.cookie(upgradeKey); // cookie存在 => 'value' cookie不存在 => null
        if (upgradeMark == "null" || upgradeMark == null || upgradeMark == "") {
            $("body").append($("#upgradeWinText").val());
            $("#upgradeWin,.window-mask").show();
            $("#upgradTitle").text(upgradeTitle);
            $(".upgradeClose").on("click", function () {
                $("#upgradeWin,.window-mask").hide();
                $.cookie(upgradeKey, '0', {expires: 700});
            })
        }

    })

</script>
<%-- 
<textarea id="upgradeWinText" style="display: none">
    <div class="window-mask"></div>
<div id="upgradeWin">
    <p id="upgradTitle"></p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          class="upgradeClose"><img src="../../images/close_user.png"></span>
    升级内容区域 填写
    <div class="upgradeCon">
        <section class="section">
            <p class="secTitle">
                 01. 销售单一键生成多笔外协采购
            </p>
            <p class="secCon">
				当一笔销售业务需要由多家供应商制作，可通过“生成采购单”功能一键将销售单生成多笔外协采购，节省采购记账时间
            </p>
            <p class="secDesc">功能位置：销售——销售单详情，生成采购单 按钮</p>
        </section>
        <section class="section">
            <p class="secTitle">
            02. 制作派工增加“简单加工制作”
            </p>
            <p class="secCon">
				业务描述：当你的制作业务中不存在多车间/多工序流程，即可使用，符合小微制作加工企业所需
            </p>
            <p class="secDesc">功能位置：派工——制作派工</p>
        </section>
        <section class="section">
            <p class="secTitle">
            03. 客户多联系人
            </p>
            <p class="secCon">
				业务描述：当你和某个客户的不同联系人产生不同业务时，可为客户添加多位联系人，销售开单时选用，方便和不同联系人结算
            </p>
            <p class="secDesc">生意伙伴——我的客户——客户详情页，添加其他联系人</p>
        </section>
    </div>
</div>
</textarea> 
--%>
</body>
</html>
