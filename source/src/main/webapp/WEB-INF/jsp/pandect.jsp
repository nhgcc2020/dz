<%--
  Created by IntelliJ IDEA.
  User: pengxuyang
  Date: 16/12/12
  Time: 下午5:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="网站关键词" />
    <meta name="description" content="网站简介" />
    <title>个人中心</title>
    <link href="/resources/cola-ui/base.css?v=529b4c3d67" rel="stylesheet">
</head>
<body>
<div id="pandect-list" class="lazy-loding">
    <ul class="pandect-list" id="CompanyList"></ul>
</div>

<ul class="pandect-list-creat">
    <li><p onclick="createCompanyModel('1')">创建企业</p></li>
    <li><p class="JionCompanyWin">加入企业</p></li>
</ul>
<script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
<script src="/resources/common/hub-main.js?v=6efb77a8a4"></script>
<script>
    screnHeight();		//自动获取高度
    JionCompany();      //加入企业
    companyList();      //总揽公司列表
</script>
</body>
</html>
