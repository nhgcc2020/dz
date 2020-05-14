<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: pxy
  Date: 2016/5/22
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>选择小行业</title>
    <!--针对移动设备,网站显示宽度等于设备屏幕显示宽度,内容缩放比例为1:1-->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!--将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面：-->
    <meta name="renderer" content="webkit">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <!-- css引入和样式定义区域 -->
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <script type="text/javascript" src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script type="text/javascript" src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script type="text/javascript" src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script type="text/javascript" src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script type="text/javascript" src="/resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>
    <script src="/resources/common/global-config.js?v=051236a6d6"></script>
    <!--加载公共js-->
    <script src="/common/growingio.js"></script>
    <!--<script type="text/javascript" src="js/public.js"></script>-->
    <style>
        li {
            text-align: left;
            margin-top: 1.5rem;
        }

        @media only screen and (min-width: 1440px) {
            .reg_logo_margin {
                margin-top: 1rem;
                margin-right: 1rem;
                margin-bottom: 8rem;
            }
            .reg_input {
                margin: 1.5rem 0;
                text-align: left;
            }
            .reg_rcon_padding {
                padding: 1rem 7rem
            }
            .reg_bnt_mt {
                text-align: center;
                margin-top: 12.8rem;
            }
            .reg_info_mt {
                margin-top: 6rem;
                text-align: left;
            }
            .reg_log_width {
                width: 180px;
            }
            .reg_bnt {
                width: 145px;
                line-height: 35px !important;
                font-size: 1.2rem;
            }
            * {
                font-size: 1.1rem;
            }
            .li_left {
                margin-top: 1.5rem;
                display: inline-block;
            }
        }
        @media only screen and (max-width: 1440px) {
            .reg_logo_margin {
                margin-top: 1rem;
                margin-right: 1rem;
                margin-bottom: 3rem;
            }
            .reg_input {
                margin: 1.5rem 0;
                text-align: left;
            }
            .reg_rcon_padding {
                padding: 1rem 5rem;
            }
            .reg_bnt_mt {
                text-align: center;
                margin-top: 2rem;
            }
            .reg_info_mt {
                margin-top: 3rem;
                text-align: left;
            }
            .reg_log_width {
                width: 180px;
            }
        }

        .dll_selected{
            text-align: center;background: #2196F3;color:white;padding: 10px;width: 100%;display: inline-block;
        }


        .dll_udselected{
            text-align: center;background: #76838F;color:white;padding: 10px;width: 100%;display: inline-block;
        }
        .check_icon{
            width: 1.7rem;vertical-align: middle;
        }
        .dl_selected{
            border-bottom: 1px solid ;padding-bottom: 1rem;margin-bottom: 0.5rem;border-color: #2E94E1;
        }
        .dl_unselected{
            border-bottom: 1px solid ;padding-bottom: 1rem;margin-bottom: 0.5rem;border-color: #76838F;
        }

        .indus_box{
            text-align: left;
            margin-top: 3rem;
        }

        .d_industry_div{
            border-bottom: 1px solid #2E94E1;text-align: left;padding-bottom: 1rem;margin-bottom: 0.5rem;
            margin-top: 2rem;
        }
        .tranform2{
            width:180px;
            height:32px;
            overflow: hidden;
            position: relative;
            cursor: pointer;
            float: right;
        }
        .tranform2>div img{
            width:180px;
            height:32px;
        }
        .tranform2>div{
            height:32px;
            width:370px;
            top:0px;
            left:0px;
            position: absolute;
            transition:all 0.2s linear;
        }
        .tranform2>div:hover{
            left:-180px;
        }
    </style>
</head>

<body>
<div id="content" style="height: 100%;">

    <div id="leftcon" style='display: inline-block;background-color: #ed683f ;width:64.5%;height: 100%'>
        <div style="text-align: center;">
            <div style="margin-top: 14rem">
                <img src="<c:url value="/images/welcome/4_title.png"/>" style="width: 51%;">
            </div>
            <img src="<c:url value="/images/welcome/4_image.png"/>" style="margin-top: 10rem;width: 35%">
        </div>
    </div>

    <div style="width: 35%;display: inline-block;background-color: white;float: right;height: 100%;text-align: center;" >
        <div class="reg_logo_margin tranform2" id="main_logo" >
            <div>
                <img class="reg_log_width" src="<c:url value="/images/u0.jpg"/>"/>
                <img class="reg_log_width" src="<c:url value="/images/transforn2.png"/>"/>
            </div>
        </div>
        <div class="clearboth"></div>

        <div class="reg_rcon_padding">
            <div>
                <div class="reg_input" style="text-align: left;padding-bottom: 2rem;">
                    请选择一个小行业，我们会提供符合行业特点的功能与服务！
                </div>
                <%--<input type="hidden" id="mId" />--%>
                <input type="hidden" name="industryId" value="" />
                <c:forEach items="${industrys}" var="indus" varStatus="stat">
                    <c:choose>
                        <c:when test="${stat.first}">
                            <div  class="d_industry_div">
                                <i class="iconfont font_checked checkereding" onclick="change(this)" name="check_right" data-value="${indus.industryId}">&#xe6a9;</i>
                                <%--<img src="<c:url value="/images/u2.png"/>" onclick="change(this)" name="check_right" data-value="${indus.industryId}" style="width: 1.7rem;height: 1.7rem;" />--%>
                                <label style="margin-left:15px;vertical-align: super;">
                                        ${indus.industryName}
                                </label >
                            </div>
                            <c:set var="industryId" value="${indus.industryId}"/>
                        </c:when>
                        <c:otherwise>
                            <div  class="d_industry_div" style="margin-top: 3.41rem">
                                <i class="iconfont font_checked checkereding" onclick="change(this)" name="check_right" data-value="${indus.industryId}">&#xe684;</i>
                                <%--<img src="<c:url value="/images/u48.png"/>" onclick="change(this)" name="check_right" data-value="${indus.industryId}" style="width: 1.7rem;height: 1.7rem;" />--%>
                                <label style="margin-left: 15px;vertical-align: super;">
                                        ${indus.industryName}
                                </label >
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <ul style="padding-left: 3.41rem;text-align: left;">${indus.industryDesc}</ul>
                </c:forEach>
                <div class="reg_bnt_mt">
                    <!--Next需要加icon-->
                    <div c-widget="button; color:teal;click:save" class="reg_bnt">下一步</div>
                </div>
            </div>
        </div>
    </div>
    <!--右边 s-->
   <%-- <div style="width: 35%;display: inline-block;background-color: white;float: right;height: 100%;text-align: center;" >
        <div style="text-align: right;" class="reg_logo_margin">
            <img class="reg_log_width" src="<c:url value="/images/u0.jpg"/>" />
        </div>
        <div class="reg_rcon_padding">
            <input type="hidden" name="industryId" value="" />
            <div class="reg_input" style="text-align: left;">
                请选择一个小行业，我们会提供符合行业特点的功能与服务！
            </div>
            <c:forEach items="${industrys}" var="indus" varStatus="stat">
                <!---->
                <div class="indus_box">
                    <!--左边部分 start-->
                    <div style="display: inline-block;line-height: 35px;vertical-align: top;cursor: pointer" onclick="change_industry(this)" data-value="${indus.industryId}">
                        <img
                                <c:choose>
                                    <c:when test="${stat.first}">
                                        src="<c:url value="/images/u2.png"/>"
                                        <c:set var="industryId" value="${indus.industryId}"/>
                                    </c:when>
                                    <c:otherwise>
                                        src="<c:url value="/images/u48.png"/>"
                                    </c:otherwise>
                                </c:choose>
                                class="check_icon"
                        />
                    </div>
                    <!--左边部分 end-->
                    <!--右边部分 start-->
                    <div style="display: inline-block;margin-left: 1.5rem;width: 75%">
                        <div
                         <c:choose>
                            <c:when test="${stat.first}">
                                class="dl_selected"
                            </c:when>
                            <c:otherwise>
                                class="dl_unselected"
                            </c:otherwise>
                         </c:choose>
                               >
                            <label
                                    <c:choose>
                                        <c:when test="${stat.first}">
                                            class="dll_selected"
                                        </c:when>
                                        <c:otherwise>
                                            class="dll_udselected"
                                        </c:otherwise>
                                    </c:choose>
                                   >
                                ${indus.industryName}
                            </label >
                        </div>
                        <ul>
                            ${indus.industryDesc}
                        </ul>
                    </div>
                    <!--右边部分 end-->
                </div>
                <!---->
            </c:forEach>

            <div class="reg_bnt_mt">
                <!--Next需要加icon-->
                <div c-widget="button; color:teal; caption:下一步 &nbsp;&nbsp;&nbsp; >;" class="reg_bnt" onclick="save()"></div>
            </div>
        </div>
    </div>--%>
    <!--右边 end-->

</div>
</body>
<script type="text/javascript">

    function change(img){
        var mId	= $(img).data("value");
        $("input[name='industryId']").val(mId);
        console.info(mId);

        $("i[name='check_right']").html("&#xe684;");
        $(img).html("&#xe6a9;");
    }

    function change_industry(chk){
        $(".indus_box").each(function (index) {
            //清除所有选中效果
            $(this).find("img").attr("src","/images/u48.png");
            $(this).find(".dl_selected").attr("class","dl_unselected");
            $(this).find(".dll_selected").attr("class","dll_udselected");
        })

        $(chk).find("img").attr("src","/images/u2.png");
        var dll_div = $(chk).next("div");
        dll_div.find(".dl_unselected").attr("class","dl_selected");
        dll_div.find(".dll_udselected").attr("class","dll_selected");
        $("input[name='industryId']").val($(chk).data("value"));
    }



    function save() {

    };



    cola(function(model) {
        model.action({
            save:function(btn){
                btn.set("disabled",true);
                btn.set("state","loading");
                var ids = $("input[name='industryId']").val();
                /*console.info(ids);*/
                if(ids==null || ids == ""){
                    ids="${industryId}";
                }
                window.location.href="<c:url value="/reg/company?ids="/>"+ids;
                /*$.post("<c:url value="/reg/saveSIndus"/>",{ids:ids},function (data) {
                 if(data=="1"){
                 /!*alert("成功");*!/
                 window.location.href="<c:url value="/reg/company"/>";
                 }else{
                 alert("失败");
                 }
                 })*/
            }
        })
    });
    cola.on("ready", function() {
        var allHeight = $("#content").height();
        var leftconHeight = $("#leftcon").height();
        $("#leftcon").css("margin-top", (allHeight - leftconHeight) / 2);
    });
    $("#main_logo").click(function(){
        window.open(dz_url+"index.html");
    })
</script>

</html>
