
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN" style="height: 100%; width: 100%;">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>企业中心</title>
    <link href="/resources/cola-ui/base.css?v=529b4c3d67" rel="stylesheet">
    <style>
        /*右侧中心*/
        .preson-container-right{
            height: 100%;
            width:calc(100%-180px);
            overflow: hidden;
            box-sizing: border-box;
            background: #f6f6f6;
            position: relative;
        }
    </style>
</head>
<body style="height: 100%; width: 100%;">
<div class="preson-menu">
    <div class="preson-menu-logo">企业中心</div>

    <div class="preson-menu-comName">${sessionScope.sessionUser.comName}</div>
    <div class="preson-menu-preson">
        <div class="preson-menu-preson-info">
            <img src="${sessionScope.sessionUser.avatarPath}" onerror="this.src = '/upload/logo/default_user.png'" alt="个人中心" />
            <span>您好，</span>
            <span class="company_Name">${sessionScope.sessionUser.realName}</span>
            <%--<i class="iconfont">&#xe68d;</i>--%>
        </div>

        <%--<ul class="preson-menu-preson-logout">--%>
            <%--<li class="iconfont" c-onclick="logout()"><span>退出</span></li>--%>
        <%--</ul>--%>


    </div>
</div>
<div class="preson-container">
    <div class="preson-container-left">
        <ul class="preson-container-left-menu">
            <li>
                <i class="iconfont icon-ydz-qiyezhongxin"></i>
                <a href="/openPage?pageName=company_company-info" target="presonContainer">企业信息</a>
            </li>
           <%-- <li>
                <i class="iconfont icon-ydz-qiyebumen"></i>
                <a href="/openPage?pageName=company_department" target="presonContainer">企业部门</a>
            </li>--%>
            <li>
                <i class="iconfont icon-ydz-qiyeyuangong"></i>
                <a href="/openPage?pageName=company_employee-all" target="presonContainer">企业员工</a>
            </li>
            <li>
                <i class="iconfont icon-ydz-quanxianzhuanyi"></i>
                <a href="/openPage?pageName=company_transfer-admin" target="presonContainer">权限转移</a>
            </li>
        </ul>
        <ul class="preson-container-left-botton">
            <li>
                <i class="iconfont xinshoubangzhu"></i>
                <a href="#" >新手帮助</a>
            </li>
            <li class="sever_hotLine">
                <i class="iconfont kefurexian"></i>
                <a>客服热线</a>
                <p>186-1690-0723</p>
            </li>
        </ul>
    </div>

    <div class="preson-container-right">
        <iframe src="" id="iframepage" width="100%" name="presonContainer" frameborder="0"></iframe>
    </div>
</div>
<script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
<script src="/resources/common/hub-main.js?v=6efb77a8a4"></script>
<script>
    //检测高度 onload="changeFrameHeight()"
    screnHeight();
//    presonClick();
    //changeFrameHeight();
    $(function () {
        var hashDefault=document.location.hash;
        if(hashDefault==""){
            $(".preson-container-left-menu li").eq(0).addClass("hover");
            $("#iframepage").attr("src","/openPage?pageName=company_company-info");

        }else if(hashDefault.indexOf("employee")>0){
            $(".preson-container-left-menu li").eq(1).addClass("hover");
            $("#iframepage").attr("src","/openPage?pageName=company_employee-all");
        }
        $(".preson-container-left-menu li").click(function(){
            $(this).addClass("hover").siblings().removeClass("hover");
        });
    })
</script>
</body>
</html>