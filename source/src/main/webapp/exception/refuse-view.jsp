<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>无权限访问</title>
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css"> 		<!--整体修改-->
	<style>
		html,body,.refuse-view{
			height:100%;
			width:100%;
		}
		.refuse-view{
			position: relative;
		}
		.refuse-view div{
			max-width: 765px;
			max-height:427px;
			position: absolute;
			top:50%;
			margin-top: -213px;
			left:50%;
			margin-left: -382px;
		}
		.refuse-view img{
			max-width: 100%;
			max-height:100%;
		}
	</style>
</head>
<body style="background: #fff;">
	<div class="refuse-view">
		<div><img src="/images/refuse-view.png" alt="您没有权限操作，请与管理员联系"></div>
	</div>
</body>
</html>