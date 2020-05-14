<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>事项提醒</title>
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <style>


        .panel-body{
            padding: 15px;
            max-height: 550px;
            overflow: hidden;
            overflow-y: auto;
        }
        .header {
            padding: 2px 10px;
            /*border: 1px solid #e4e4e4;*/
            font-size: 18px;
            margin:20px;
            margin-bottom: 60px;
            color: #333333;
        }

        .panel-default>.panel-heading{
            background: transparent;
            color:#bcbcbc;
        }
        .panel-default{
            vertical-align: top;
            width:550px;
            margin-left:80px;
            display: inline-block;
        }
        .panel_inner_d{
            margin-right:10px;
        }
        .panel_t{
            width: 360px;
            overflow: hidden;
            height: 30px;
            text-overflow: ellipsis;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
        .panel_t a{
            color:#4e8ae6;
            cursor: default;
        }
        .panel_con li{
            line-height: 30px;
            height:30px;
        }
        .panel_d{
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            width: 140px;
        }
        #msgwindow {
            border: none;
            z-index: 9999;
            width: 84%;
            height: 100%;
            top:0;
            left: 100%;
            box-shadow: 0px 0px 7px #999;
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: fixed;
        }
    </style>
</head>

<body class="easyui-layout" style="border:none !important;">
<%--遮罩--%>
<div id="msgwindow" style="border:none;"></div>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:10;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.6;font-size: 1px;overflow: hidden;"></div>
<div class="header">事项提醒</div>

<div class=" panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">投放开始提醒</h3>
    </div>
    <div class="panel-body">
        <ul class="panel_con ulLeft">
            <li>
                <div class="panel_t pull-left"><a href="##">此点位暂无排期</a></div>
            </li>
        </ul>
    </div>
</div>

<div class=" panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">投放结束提醒</h3>
    </div>
    <div class="panel-body">
        <ul class="panel_con ulRight">
            <li>
                <div class="panel_t pull-left"><a href="##">此点位暂无排期</a></div>
            </li>
        </ul>
    </div>
</div>
<%----%>
<script>

    function getT2T(t1)
    {
        var time1 = Date.parse(t1)/1000;
        var  time2 = new Date().getTime()/1000;
        var time_ = Math.abs(time1 - time2);
        return parseInt(time_/(3600*24));
    }
    //    getT2T("2017-09-11");
    var funUl=function (oj,type) {
        var html="";
        for(var i=0;i<oj.length;i++){
            var tm="";
            if(type=="1"){
                tm=oj[i].startDate;
            }else{
                tm=oj[i].endDate;
            }
            var absTime=getT2T(tm)+"天后";
            html +=' <li>'+
                '<div class="panel_t pull-left"><a style="cursor: pointer;" onclick="openDt(\''+oj[i].planNo+'\')" href="##">'+oj[i].adName+'</a></div>'+
                '<div class="panel_d pull-right"><span class="panel_inner_d">'+tm+'</span><span>('+absTime+')</span></div>'+
                '</li>';
        }
        return html;
    }
    $.ajax({
        url: "/ydz/mediaresource/getMediaRunPlansTodo",
        dataType: "json",
        success: function (callback) {
            if (callback.code == "1") {

                var oj=callback.start;
                var oj1=callback.end;
                if(oj.length>0){
                    $(".ulLeft").html( funUl(oj,1));
                }
                if(oj1.length>0){

                    $(".ulRight").html( funUl(oj1,2));
                }

            } else {
            }
        },
        error: function () {
        }
    })
    window.modifyPlan = function (p) {
        var turl = "/ydz/mediaresource/forward-mediarunplan-add-update?planNo=" + p;
        window.location.href = turl;
    }
    window.openDt = function (p) {
        var url = "/ydz/mediaresource/forward-media-run-plan-detail?planNo="+p  ;
        showMessageDialog(url, "", "84%", "100%", true);
    }
    function msg(content) {
        $("#msgwindow").html(content).addClass("activ");
    }

    window.hideMsg = function () {
        $(".window-mask").hide();
        $("#msgwindow").css({left: "100%"}).removeClass("activ");
    }
    function showMessageDialog(url, title, width, height, shadow) {
        var content = '<iframe id="msgF" src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="yes"></iframe>';
        $("#msgwindow").empty();
        $("#msgwindow").css({left: "16%", width: "84%"});
        $(".window-mask").hide();
        var last = Date.now();
        setTimeout(function () {
            // 监听动画完成时间
            if ($("#msgwindow").hasClass("activ")) {
                msg(content);
            } else {
                $("#msgwindow")[0].addEventListener('webkitTransitionEnd', function () {
                    if (Date.now() - last < 3000) {
                        msg(content);
                    }
                }, false);
            }

        }, 0);
    }
</script>
</body>

</html>