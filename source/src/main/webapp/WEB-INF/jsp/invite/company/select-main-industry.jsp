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
    <script type="text/javascript" src="/wechat/js/main.js?v=7a85ec546f"></script>
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
    <h1 class="mui-title">选择大行业</h1>
</header>

<div class="mui-content">
    <div class="mui-content-padded related_form_content">
        <form class="mui-input-group related_form">

            <div class="mui-input-row mui-radio mui-left related_form_prov_undline">
                <label>泛广告印刷包装行业上下游企业</label>
                <input name="radio1" type="radio" checked="checked">
            </div>
            <div class="industry">
                广告设计/媒体代理/喷绘写真/字牌雕刻/条幅制作/婚庆公司/印
                刷厂/包装厂/CTP输出/后道加工/器材租赁/会展公司/广告耗材
                经销/印刷耗材经销/广印设备经销
            </div>

            <div class="mui-input-row mui-radio mui-left related_form_prov_undline">
                <label>现代服务业 (暂未开通)</label>
                <input name="radio1" type="radio" disabled="disabled">
            </div>
            <div class="industry">
                财务代账/公司孵化器/众创空间/互联网软件行业/培训教育行业
            </div>

            <div class="mui-input-row mui-radio mui-left related_form_prov_undline">
                <label>其他行业 (暂未开通)</label>
                <input name="radio1" type="radio" disabled="disabled">
            </div>
            <div class="industry">
                数码3C类/家用电器/五金建材/文体用品/家居装饰/电子电气/汽修汽配/母婴用品
            </div>

            <div class="mui-button-row related_form_sub">
                <button type="button" class="mui-btn mui-btn-primary" id="next_tap">下一步</button>
            </div>
        </form>
    </div>
</div>

<div class="button-copyright" style="margin-top: 180px;">上海仁石科技有限公司欢迎您注册使用易对账!</br>Copyright@2016 沪 ICP备16005067</div>
<script>
    $("#next_tap").click(function(){
        $(this).html("").addClass("lodingBtn").attr("disabled","true");
        window.location="<c:url value="/invite/com/detail"/>";
    })
</script>
</body>
</html>
