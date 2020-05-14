<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>开启设计派工</title>
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
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
    </style>
</head>
<body>
<div style="background: url('/images/page/job_design.png') no-repeat;margin: 50px auto;width:600px;height: 600px;position: relative;">
    <a  style="    position: absolute;
    top: 285px;
    width: 130px;
    height: 40px;
    left: 50%;
    cursor: pointer;
    margin-left: -65px;" onclick="openUrl(this)">&nbsp;</a>
</div>
<script>
    function openUrl() {
//
        $.ajax({
            url:"/order/assignment/openAssignDesign",
            type:'post',
            contentType:'application/x-www-form-urlencoded; charset=UTF-8',
            dataType:"json",
            success:function(dt){
                if(dt.code=="1"){
                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
                    window.location.href="openPage?pageName=assignment_design-assign-task";
                }else{
                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
                }
//
            },
            error:function(){
                $("<div class='tips_contants'>").fadeIn(250).html("启用失败").delay(1000).fadeOut(250).appendTo('body');
            }
        })

    }
</script>
</body>
</html>