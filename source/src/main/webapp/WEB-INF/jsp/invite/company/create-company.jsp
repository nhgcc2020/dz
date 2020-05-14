<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>注册账号</title>
    <script src="/wechat/js/mui.min.js?v=eda48251a7"></script>
    <link href="/wechat/css/mui.min.css?v=57ec55e59d" rel="stylesheet"/>
    <link href="/wechat/css/main.css?v=9e61f29840" rel="stylesheet"/>
    <script type="text/javascript" src="/wechat/js/jquery-1.8.3.min.js?v=3576a6e73c"></script>
    <script type="text/javascript" src="/wechat/js/main.js?v=7a85ec546f"></script>
    <script type="text/javascript" src="/wechat/js/form.js?v=595e2db8af"></script>
    <script type="text/javascript" src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
    <style>
        .shark_contant,html,body{
            height:100%;
        }
        .shark_contant{
            background: #fff;
            max-width: 640px;
            margin:0px auto;
            padding:0px 20px;
            overflow: scroll;
            padding-bottom: 40px;
        }
        .related_form_prov_undline input{
            border-radius: 3px;
        }
        .mui-input-group .mui-input-row{
            border-radius: 3px;
            overflow: hidden;
        }
        .related_form_sub button{
            border-radius: 0px;
        }
        .related_form_content p{
            color: #666 !important;
            height:40px;
            line-height: 40px;
            font-size: 14px;
        }
        .related_form_codes div a{
            background: #fff;
            color: #2e8ae6;
            border-radius: 3px;
        }
        .related_form_check a{
            color: #2e8ae6;
        }
        .related_form_sub button{
            background: #2e8ae6;
            border-radius: 3px;
            border: 1px solid #2e8ae6;
        }
        input[type="checkbox"]{
            display: none;
        }
        input[type="checkbox"]+label {
            display: inline-block;
            width: 100%;
            margin-top: 10px;
            margin-left: 5px;
            text-align: left;
            -webkit-box-sizing: border-box;
            color: #666;
        }
        label::before {
            content: "";
            display: inline-block;
            width: 15px;
            height: 15px;
            background: #EEE;
            vertical-align: middle;
            -webkit-border-radius: 50%;
            margin-right: 5px;
            -webkit-box-sizing:border-box;
            background: #fff;
            border: 1px solid #e4e4e4;
        }
        input[type="checkbox"]:checked+label::before{
            background-color: #2e8ae6;
            border:3px #EEEEEE solid;
        }
        .mui-input-row select{
            border: 1px solid #ccc !important;
            width:30%;
            box-sizing: border-box;
            font-size: 12px;
            height: 40px;
            float: left;
            margin:0px !important;
            box-sizing: border-box;
            text-indent:0.5rem;
            color: #999;
        }
        .mui-input-row select:nth-child(2){
            margin:0px 5% !important;
        }
        .creatyiduizhang p{
            font-size: 12px;
            padding:0px !important;
            margin:30px 0px 10px !important;
            color: #666;
            overflow: hidden;
        }
        #myyiduizhangname,.creatyiduizhang input{
            height:30px;
            line-height:30px;
            font-size: 12px;
            color: #999;
            padding:0px !important;
            margin:0px !important;
            text-indent: 0.5rem;
        }
        .creatyiduizhang input{
            border: 1px solid #ccc;
        }

        .creatyiduizhang p select{
            width:100%;
            float: left;
            border:1px solid #ccc !important;
            height:30px;
            line-height:30px;
            padding:0px !important;
            margin:0px;
            text-indent: 0.5rem;
            color: #999;
            font-size: 12px;
        }
        .creatyiduizhang p select{
            width:30%;
            float: left;
            border:1px solid #ccc !important;
            height:30px;
            line-height:30px;
            padding:0px !important;
            margin:0px !important;
            text-indent: 0.5rem;
            color: #999;
            font-size: 12px;
        }
        .creatyiduizhang p select:nth-child(2){
            margin:0px 5% !important;
        }
        .createyiduizhangtitle{
            margin:15px 0px 0px !important;
            text-align: left;
            font-size: 16px;
        }
        #next_tap{
            height:34px;
            line-height:34px;
            border:none;
            background: #2e8ae6;
            display: block;
            margin-top: 30px;
            text-align: center;
            color: #fff;
            outline: none;
            border-radius: 3px;
            font-size: 14px;
        }
    </style>
</head>
<body>

<div class="shark_contant">
    <p class="createyiduizhangtitle">创建企业</p>
    <form id="signForm">
    <div class="creatyiduizhang">
        <p>真实姓名</p>
        <input type="text" id="realName" name="realName" value="${company.contacterName}" placeholder="真实姓名">
        <p>企业全称</p>
        <input type="text" id="comName" name="comName" value="${company.partnerName}" placeholder="企业全称">
        <p>简称或品牌</p>
        <input type="text" id="comShortname" name="comShortname" value="${company.partnerShortname}" placeholder="企业简称">
        <p>我的角色</p>
        <p style="margin: 0px !important;">
            <select  name ="bossOrAdmin"  style="width: 100%;">
                <option value="boss">法人兼管理员</option>
                <option value="admin">管理员</option>
            </select>
        </p>
        <p>所在区域</p>
        <p style="margin: 0px !important;">
            <select name="comProvince" onchange="changeProvince(this)"></select>
            <select name="comCity" onchange="changeCity(this)"></select>
            <select name="comCountry"></select>
        </p>
        <buttom id="next_tap">注册</buttom>
    </div>
    </form>
</div>
<script>
    $("select[name='comProvince']").html("");
    $(ProvinceJson).each(function (index,element) {
        var option = "<option value='"+element.provinceId+"'>"+element.provinceName+"</option>"
        $("select[name='comProvince']").append(option);
    });
    var provinceId = $("select[name='comProvince']").val();
    $(CityJson).each(function(index,element){
        if(element.provinceId == provinceId){
            var option = "<option value='"+element.cityId+"'>"+element.cityName+"</option>"
            $("select[name='comCity']").append(option);
        }
    });
    var cityId = $("select[name='comCity']").val();
    $(CountryJson).each(function(index,element){
        if(element.cityId == cityId){
            var option = "<option value='"+element.countryId+"'>"+element.countryName+"</option>"
            $("select[name='comCountry']").append(option);
        }
    });

    $("#next_tap").click(function(self){
        $(this).html("").addClass("lodingBtn").attr("disabled","true");
        var userId = $("#userId").val();
        var realName = $("#realName").val();
        var comName = $("#comName").val();
        var comShortname = $("#comShortname").val();

        //
        if(realName == undefined || realName == ""){
            $("<div class='tips_contants'>").fadeIn(250).html("请填写真实姓名").delay(3000).fadeOut(250).appendTo('body');
            $(this).html("注册").removeClass("lodingBtn").removeAttr("disabled");
            return false;
        };
        //
        if(comName == undefined || comName == ""){
            $("<div class='tips_contants'>").fadeIn(250).html("请填写公司名称").delay(3000).fadeOut(250).appendTo('body');
            $(this).html("注册").removeClass("lodingBtn").removeAttr("disabled");
            return false;
        };
        //
        if(comShortname == undefined || comShortname == ""){
            $("<div class='tips_contants'>").fadeIn(250).html("请填写公司简称").delay(3000).fadeOut(250).appendTo('body');
            $(this).html("注册").removeClass("lodingBtn").removeAttr("disabled");
            return false;
        };

        $.post("<c:url value="/invite/com/signUpCompany"/>",$("#signForm").serialize(),function(callback){
            //var callback = eval("("+data+")");
            if(callback.state=="1"){
                $("#next_tap").text("注册成功");
                setTimeout(function(){
                    window.location.href="<c:url value="/invite/com/success"/>"
                },1000);
            }else{
                $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(3000).fadeOut(250).appendTo('body');
                $(this).html("注册").removeClass("lodingBtn").attr("disabled","false");
            }
        })

    });

    //修改省时触发
    function changeProvince(slt){
        $("select[name='comCity']").html("");
        $("select[name='comCountry']").html("");

        var provinceId = slt.value;
        $(CityJson).each(function(index,element){
            if(element.provinceId == provinceId){
                var option = "<option value='"+element.cityId+"'>"+element.cityName+"</option>"
                $("select[name='comCity']").append(option);
            }
        });
        var cityId = $("select[name='comCity']").val();
        $(CountryJson).each(function(index,element){
            if(element.cityId == cityId){
                var option = "<option value='"+element.countryId+"'>"+element.countryName+"</option>"
                $("select[name='comCountry']").append(option);
            }
        });
    }
    //修改市触发
    function changeCity(slt){
        $("select[name='comCountry']").html("");
        var cityId = slt.value;
        $(CountryJson).each(function(index,element){
            if(element.cityId == cityId){
                var option = "<option value='"+element.countryId+"'>"+element.countryName+"</option>"
                $("select[name='comCountry']").append(option);
            }
        });
    }
</script>
</body>
</html>
