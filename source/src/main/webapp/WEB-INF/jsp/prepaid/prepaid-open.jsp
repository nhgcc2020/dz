<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>开通预充值功能</title>
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
</head>
<body>
<div id="startInit"
     style="background: url('/images/page/paidStart.png') center center no-repeat #fff;margin: 0 auto;left: 0;top: 0;width:100%;height: 100%; z-index: 999;position: absolute;">
    <a style="     position: absolute;
    top: 50%;
    width: 130px;
    height: 40px;
    margin-top:-60px;
    left: 50%;
    cursor: pointer;
    margin-left: -65px;" onclick="openUrl(this)">&nbsp;</a>
</div>
<script>
    function  openUrl() {
//        window.location.href = "openPage?pageName=prepaid_prepaid-deposit-list";
        $.ajax({
            url: "/system/partner/recharge/openbusiness",
            type: 'post',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            dataType: "json",
            success: function (dt) {
                if (dt.code == "1") {
                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
                    window.location.href = "openPage?pageName=prepaid_prepaid-deposit-list";
                } else {
                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
                }
//
            },
            error: function () {
                $("<div class='tips_contants'>").fadeIn(250).html("启用失败").delay(1000).fadeOut(250).appendTo('body');
            }
        })
    }
</script>
</body>
</html>