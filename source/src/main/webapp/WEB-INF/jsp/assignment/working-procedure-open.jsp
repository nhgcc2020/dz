<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>开启复杂工序</title>
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <style>
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
        .checkbox-slider--b-flat.checkbox-slider-md input + span:before {
            content: "未启用";
            text-align: left;
            color:#fff;
            text-indent: 30px;
        }
        .checkbox-slider--b-flat.checkbox-slider-md input:checked+span:before {
            content: "已启用";
            text-align: left;
            color:#fff;
            text-indent: 13px;
        }
        .checkbox-slider-md input+span:before{
            width:75px;
        }

        .checkbox-slider-md input:checked+span:after,.checkbox-slider--b-flat input:checked + span::after{
            margin-left: 50px;
        }
        .checkbox-slider--b-flat input+span:before{
            background: #666;
        }
        .checkbox-slider--b-flat.checkbox-slider-md input+span:after, .checkbox-slider--b-flat.checkbox-slider-md input+span:before{
            border-radius: 80px;
        }
        .checkbox-slider-md input+span:after{
            width:25px;
        }
        .checkbox-slider-md input+span:after, .checkbox-slider-md input+span:before{
            height: 25px;
            line-height: 25px;
        }
    </style>
</head>
<body>
<div style="    margin: 50px auto;
    width: 450px;
    height: 300px;
    position: relative;
    padding: 20px;
    background: #f8f8f8;">
    <a  style="
        position: absolute;
    top: 285px;
    width: 130px;
    height: 40px;
    left: 50%;
    cursor: pointer;
    margin-left: -65px;" onclick="openUrl(this)">&nbsp;</a>

    <h1 style="font-size: 18px;font-weight: normal">复杂工序</h1><div style="    text-align: center;
    position: absolute;
    height: auto;
    right: 20px;
    width: 100px;
    top: 3px;" class="datagrid-cell datagrid-cell-c2-isChecked"> <div style="width: 50px;    display: inline-block;" class="checkbox checkbox-slider--b-flat checkbox-slider-md "><label><input onclick="openUrl(this)" value="1"  type="checkbox"><span></span></label></div></div>

    <p style="    line-height: 40px;
    font-size: 14px;">如果【简单加工】不能满足派工需求,可以开启制作任务拥有复杂工序的功能模块，针对不同的服务类型配置不同的制作工序，更好的管控每一道制作工序，客户也能实时查看每道工序的制作进度。</p>

</div>
<%--<div style="background: url('/images/page/job_dispatch.png') no-repeat;margin: 50px auto;width:600px;height: 600px;position: relative;">--%>
<%--<a  style="--%>
<%--position: absolute;--%>
<%--top: 285px;--%>
<%--width: 130px;--%>
<%--height: 40px;--%>
<%--left: 50%;--%>
<%--cursor: pointer;--%>
<%--margin-left: -65px;" onclick="openUrl(this)">&nbsp;</a>--%>
<%--</div>--%>
<script>

    function openUrl() {
        $.ajax({
            url:"/order/workingassigntask/openOrCloseWorkingProcedure?configValue=1",
            dataType:"json",
            success:function(dt){
                if(dt.code=="1"){
                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
                    window.location.href="openPage?pageName=assignment_workshop-setting";
                }else{
                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
                }
            },
            error:function(){
                $("<div class='tips_contants'>").fadeIn(250).html("启用失败").delay(1000).fadeOut(250).appendTo('body');
            }
        })

    }
</script>
</body>
</html>