<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title></title>
    <script src="/wechat/js/mui.min.js?v=eda48251a7"></script>
    <link href="/wechat/css/mui.min.css?v=57ec55e59d" rel="stylesheet"/>
    <link href="/wechat/css/main.css?v=9e61f29840" rel="stylesheet"/>
    <script type="text/javascript" src="/wechat/js/jquery-1.8.3.min.js?v=3576a6e73c"></script>
    <style>
        .related_form_prov_undline input{
            top:3px !important;
        }
        .mui-input-group .mui-input-row{
            height:auto;
            overflow: hidden;
            margin:10px 0px;
        }
    </style>
</head>
<body>

<header class="mui-bar mui-bar-nav heard_nav">
    <h1 class="mui-title">选择小行业</h1>
</header>

<div class="mui-content">
    <div class="mui-content-padded related_form_content">
        <form class="mui-input-group related_form">

            <div class="mui-input-row mui-radio mui-left related_form_prov_undline">
                <label>普通型广告设计制作公司</label>
                <input name="radio1" value="1A" type="radio" checked>
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

<div class="button-copyright" style="margin-top: 145px;">上海仁石科技有限公司欢迎您注册使用易对账!</br>Copyright@2016 沪 ICP备16005067</div>

<script>
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
            window.location.href="<c:url value="/invite/com/createComPage?mId="/>"+mId;
        }
    })
</script>

</body>
</html>
