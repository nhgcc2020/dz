<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: pengxuyang
  Date: 16/11/2
  Time: 下午5:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>选择小行业</title>
    <link href="/wechat/css/mui.min.css?v=57ec55e59d" rel="stylesheet"/>
    <link href="/wechat/css/main.css?v=9e61f29840" rel="stylesheet"/>
    <style>
        .related_form_prov_undline input{
            top:12px !important;
        }
        body{
            background: rgba(0,0,0,0.8);
        }
        .mui-content{
            max-width: 640px;
            margin: 0px auto;
            min-height:100%;
        }
        .shark_contant{
            height:auto;
            max-width:640px;
            margin: 0px auto;
            background: linear-gradient(#66b3ff,#2e8ae6);
            padding-bottom: 30px;
            overflow: hidden;
        }
    </style>
</head>
<body>


<div class="mui-content">
    <div class="mui-content-padded related_form_content">
        <form id="iForm" action="/invite/normal/toCreateCompay" class="mui-input-group related_form">
            <input type="hidden" name="mId" >
            <div class="mui-input-row mui-radio mui-left related_form_prov_undline">
                <label>普通型广告设计制作公司</label>
                <input name="radio1" value="1A" type="radio" checked="checked">
            </div>
            <div class="industry">
                适用于较小规模的广告设计制作公司
            </div>

            <div class="mui-input-row mui-radio mui-left related_form_prov_undline">
                <label>综合型广告及媒体发布公司</label>
                <input name="radio1" value="1B" type="radio">
            </div>
            <div class="industry">
                适用于综合型的广告设计制作、活动策划执行及广告媒体代理发布业务的公司
            </div>

            <div class="mui-input-row mui-radio mui-left related_form_prov_undline">
                <label>广告加工制作公司</label>
                <input name="radio1" value="1C" type="radio">
            </div>
            <div class="industry">
                适合于主要做广告加工的行业用户，例如写真 / 喷绘 / 字牌 /
                雕刻 / 条幅 等加工，也包含有活动策划执行及管理广告媒体资
                源及广告合同的功能
            </div>
            <div class="mui-input-row mui-radio mui-left related_form_prov_undline">
                <label>数码图文快印</label>
                <input name="radio1" value="1D" type="radio">
            </div>
            <div class="industry">
                适合图文快印业务为主、其他业务为辅的行业用户。
            </div>

            <div class="mui-input-row mui-checkbox mui-left related_form_prov_undline" style="margin-top: 25px;">
                <label style="color: #ff0000;">我已确认选择。<span style="color: #999;">(该选择在提交之后不可更改)</span></label>
                <input name="checkbox1" value="Item1" id="check_checked" type="checkbox">
            </div>

            <div class="mui-button-row related_form_sub">
                <button type="button" class="mui-btn mui-btn-primary" id="next_tap" disabled>下一步</button>
            </div>
        </form>
    </div>
</div>

<script src="/wechat/js/jquery-1.8.3.min.js?v=3576a6e73c"></script>
<script>
    $(".mui-content").height($(window).height());

    $("#check_checked").click(function(){
        if($(this).is(":checked")){
            $("#next_tap").removeAttr("disabled");
        }else{
            $("#next_tap").attr("disabled","true");
        }
    });


    $("#next_tap").click(function(){
        $(this).html("").addClass("lodingBtn").attr("disabled","true");
        var $mIds = $("input[name='radio1']");
        var mId;
        $mIds.each(function(){
            if($(this).prop("checked")){
                mId = $(this).val();
            }
        });

        if(mId != undefined && mId != ""){
            $("input[name='mId']").val(mId);
            $("#iForm").submit();
        }
    })
</script>

</body>
</html>
