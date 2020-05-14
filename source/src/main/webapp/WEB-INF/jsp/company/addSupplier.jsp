<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <!--将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面：-->
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta charset="UTF-8">
    <title>易对账</title>
    <link rel="stylesheet" type="text/css" href="/resources/nprogress/nprogress.css?v=b7ac70ebbe">
    <link rel="icon" href="favicon.ico" type="image/x-icon"/>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
    <script src="/resources/nprogress/nprogress.js?v=234c9db3ed"></script>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <link rel="stylesheet" type="text/css" href="/resources/common/common.css?v=076f5c8c95">
    <link rel="stylesheet" type="text/css" href="/resources/common/main.css?v=9e61f29840">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
    <%--//全局图标样式--%>
</head>
<body>
<script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
<script src="/resources/jquery/jquery.cookie.js?v=1bf09dac64"></script>
<script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
<script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
<script src="/resources/cola-ui/cola.js?v=bd5fd42985" charset="UTF-8"></script>
<style>
    .box2{
        display: none;
    }
</style>

<%--搜索供应商--%>
<div  class="searchSupplierContainer box1">
    <p class="searchSupplierContainertitle">看看对方是否在使用易对账，搜索并添加</p>
    <p class="searchSupplierContainerinput"><input type="text" placeholder="请输入手机号码和企业名称"
                                                   id="searchSupplierContainerinput">
        <button id="searchSupplierContainerbutton" disabled>搜索</button>
    </p>
    <p class="searchSupplierContainernone searchSuppliererror—hide">很抱歉，没有搜索到您想要结果</p>
    <div class="searchSupplierContainerList">
        <div class="searchSupplierContainerListNum">
            <a class="searchPrve"><</a>
            <a class="searchnext">></a>
            <div id="searchSupplierContainerListNum">
                <ul id="searchSupplierContainerListNumUl">
                    <li class="active">
                        <h4>上海仁石科技有限公司</h4>
                        <p>易对账</p>
                        <p><span>金金金</span><span>18621619311</span></p>
                        <div class="searchSupplierHide">
                            <h1>个人版用户</h1>
                            <h3>无法成为您的供应商</h3>
                        </div>
                    </li>
                    <li class="active">
                        <h4>上海仁石科技有限公司</h4>
                        <p>易对账</p>
                        <p><span>金金金</span><span>18621619311</span></p>
                        <div class="searchSupplierHide">
                            <h1>企业版用户</h1>
                            <h3>无法成为您的供应商</h3>
                        </div>
                    </li>
                    <li class="action">
                        <h4>上海仁石科技有限公司</h4>
                        <p>易对账</p>
                        <p><span>金金金</span><span>18621619311</span></p>
                    </li>
                </ul>
            </div>
            <div class="searchSupplierContainerListicon" id="searchSupplierContainerListicon"></div>
        </div>
        <div class="searchSupplierContainerListCheck">
            <p class="searchSupplierCheckradio1">价格级别：
                <input type="radio" name="partnerLevel" id="searchSupplierradio3" value="1"><label
                        for="searchSupplierradio3">优惠价</label>
                <input type="radio" name="partnerLevel" id="searchSupplierradio4" value="2"><label
                        for="searchSupplierradio4">标准价</label>
                <input type="radio" name="partnerLevel" id="searchSupplierradio5" value="3"><label
                        for="searchSupplierradio5">零散价</label>
            </p>
        </div>
        <button class="searchSupplierContainerListbtn" disabled>申请加为好友</button>
    </div>
    <div class="searchSuppliererror searchSuppliererror—hide">原因可能是：输入信息有误</div>
</div>

<div class="searchSupplierContainer box2">
     <h1 class="success_search_tip">申请成功</h1>
     <p class="success_search_view">好友申请状态可以通过 <span>供应商列表</span> 列表去查看</p>
     <div class="success_search_btn">
        <button class="success_search_goon">继续申请</button>
        <button class="success_search_list" c-onclick ="openSupplier()" >供应商列表</button>
     </div>
</div>

<script type="text/javascript">
    cola(function (model) {
        model.action({
            openSupplier:function(btn){
                var config = {
                    closeable: "true",
                    icon: "icon dashboard",
                    label: "全部供应商",
                    path: "/openPage?pageName=company_supplier-list&type=1",
                    type: "subWindow"
                };
                App.open(config.path, config);
                window.parent.cola.widget("s1").hide();
            },
        })
    });
    //搜索供应商
    var slider_count = "";
    function SearchSupplier() {
        $(".secrchSupplierin").click(function () {
            $(".searchSupplierBox1").fadeIn();
        });
        $("#searchSupplierContainerinput").keydown(function () {
            if ($(this).val.length != 0) {
                $("#searchSupplierContainerbutton").css("background", "#2e8ae6").css("color", "#fff").removeAttr("disabled");
            }
        });

        //立即申请
        $(".searchSupplierContainerListbtn").click(function () {
            $(this).css("background","").attr("disabled","disabled");
            var partnerLevel =  cola.model().get("partnerLevel");
            var checkComKey =  cola.model().get("checkComKey");
            //改页面途径均为:供应商类型
            var partnerType = "2";
            $.ajax({
                url:"/system/partner/saveSltPartner",
                type:"POST",
                data:{
                    partnerLevel:partnerLevel,
                    partnerComKey:checkComKey,
                    partnerType:partnerType
                },
                async:false,
                success:function(callback){
                 var data = eval("("+callback+")")
                 if(data.status == "1"){
                     $(this).css("background", "#999");
                     $(".box1").fadeOut();
                     $(".box2").fadeIn();
                 }else{
                     //$(".searchSupplierContainernone").css("display", "block").html(data.msg);
                 }

                }
            });
            //$(this).attr("disabled","disabled");
            /**/
        });

        //继续添加
        $(".success_search_goon").click(function () {
            $(".box1").fadeIn();
            $(".box2").fadeOut();
            $("#searchSupplierContainerinput").val("");
            $("#searchSupplierContainerbutton").css("background", "#999").attr("disabled", "disabled");
            $(".searchSupplierContainerList").css("display", "none");
            $(".searchSupplierContainerListbtn").css("background", "#999").attr("disabled", "disabled");
        });

        //点击搜索
        $("#searchSupplierContainerbutton").click(function () {
            var addQueryKey = $("#searchSupplierContainerinput").val();

            $.ajax({
                url: '/system/partner/getSupplierByKey',//
                type: 'GET',
                data:{
                    addQueryKey:addQueryKey
                },
                async: true,
                dataType: "json",
                success: function (data) {
                    $(".searchSuppliererror—hide").css("display", "none");

                    document.getElementById("searchSupplierContainerListNumUl").innerHTML = "";
                    document.getElementById("searchSupplierContainerListicon").innerHTML = "";
                    if(data.length == 0){
                        $(".searchSupplierContainerList").css("display", "none");
                        $(".searchSupplierContainernone").css("display", "block");
                        $(".searchSuppliererror").css("display", "block");
                        return false;
                    }else{
                        $(".searchSupplierContainerList").css("display", "block");
                        $("#searchSupplierContainerbutton").css("background", "#999").attr("disabled", "disabled");

                        $.each(data, function (key, val) {
                            if(data[key].partnerStatus == "1"){
                                document.getElementById("searchSupplierContainerListNumUl").innerHTML +=
                                        "<li class='active'>" +
                                        "<h4>" + val.comName + "</h4>" +
                                        "<p>" + val.comShortname + "</p>" +
                                        "<p><span>" + val.adminName + "</span><span>" + val.adminPhone + "</span></p>" +
                                        "<div class='searchSupplierHide'>" +
                                        "<h1>已经是您的好友</h1>" +
                                        "</div></li>"
                            }if(data[key].partnerStatus == "2"){
                                document.getElementById("searchSupplierContainerListNumUl").innerHTML +=
                                        "<li class='active'>" +
                                        "<h4>" + val.comName + "</h4>" +
                                        "<p>" + val.comShortname + "</p>" +
                                        "<p><span>" + val.adminName + "</span><span>" + val.adminPhone + "</span></p>" +
                                        "<div class='searchSupplierHide'>" +
                                        "<h1>已经提交申请</h1>" +
                                        "<h3>待对方确认</h3>" +
                                        "</div></li>"
                            }else if(data[key].comType == "1"){
                                document.getElementById("searchSupplierContainerListNumUl").innerHTML +=
                                        "<li class='searchSupplierContainerListNumUl_action action' data-value='"+val.comKey+"'>" +
                                        "<h4>" + val.comName + "</h4>" +
                                        "<p>" + val.comShortname + "</p>" +
                                        "<p><span>" + val.adminName + "</span><span>" + val.adminPhone + "</span></p>"
                                        + "</li>"
                            }else if(data[key].comType == "2"){
                                document.getElementById("searchSupplierContainerListNumUl").innerHTML +=
                                        "<li class='searchSupplierContainerListNumUl_action action' data-value='"+val.comKey+"'>" +
                                        "<h4>个人用户</h4>" +
                                        "<p>" + val.comShortname + "</p>" +
                                        "<p><span>" + val.adminName + "</span><span>" + val.adminPhone + "</span></p>"
                                        + "</li>"
                            }

                            /*if (val.id == 2) {

                             }
                             if (val.id == 1) {
                             document.getElementById("searchSupplierContainerListNumUl").innerHTML +=
                             "<li class='active'>" +
                             "<h4>" + val.company + "</h4>" +
                             "<p>" + val.manger + "</p>" +
                             "<p><span>" + val.name + "</span><span>" + val.phone + "</span></p>" +
                             "<div class='searchSupplierHide'>" +
                             "<h1>个人版用户</h1>" +
                             "<h3>无法成为您的供应商</h3>" +
                             "</div></li>"
                             }
                             if (val.id == 3) {

                             }*/
                        });
                        var page = data.length;
                        activeClick();  //绑定点击事件
                        SearchSupplierslider(page);
                    }
                },
                error: function () {
                    document.getElementById("searchSupplierContainerListNumUl").innerHTML = "";
                    document.getElementById("searchSupplierContainerListicon").innerHTML = "";
                    $(".searchSuppliererror—hide").css("display", "block");
                }
            });
        });
    }
    SearchSupplier();
    //左右滑动
    function SearchSupplierslider(page) {
        slider_count = 0;	//赋值
        //获取ul的宽度
        var pageMatc = Math.ceil(page / 3);
        $("#searchSupplierContainerListNumUl").width(w);
        if (page <= 3) {
            $('.searchPrve,.searchnext,.searchSupplierContainerListicon').css("display", "none");
        }
        var w = pageMatc * 700;
        for (var i = 0; i < pageMatc; i++) {
            document.getElementById("searchSupplierContainerListicon").innerHTML += "<span></span>";
        }

        //点击小图标
        $("#searchSupplierContainerListicon span").eq(0).css("background", "#2e8ae6").siblings().css("background", "#fff");
        $("#searchSupplierContainerListicon span").click(function () {
            $(this).css("background", "#2e8ae6").siblings().css("background", "#fff");
            var _this = $(this).index();
            $("#searchSupplierContainerListNumUl").animate({left: -(_this * 700) + 'px'}, 'slow');
            slider_count = _this * 3;
        });

        //上一页
        $('.searchPrve').bind("click", (function () {
            if (slider_count <= 0) {
                alert("这是第一页");
                return false;
            }
            ;
            slider_count -= 3;
            $("#searchSupplierContainerListicon span").eq(slider_count / 3).css("background", "#2e8ae6").siblings().css("background", "#fff");
            $("#searchSupplierContainerListNumUl").animate({left: '+=' + 700 + 'px'}, 'slow');
        }));
        //下一页
        $('.searchnext').bind("click", (function () {
            if (slider_count >= (page - 3)) {
                alert("这是最后一页");
                return false;
            }
            ;
            slider_count += 3;
            $("#searchSupplierContainerListicon span").eq(slider_count / 3).css("background", "#2e8ae6").siblings().css("background", "#fff");
            $("#searchSupplierContainerListNumUl").animate({left: '-=' + 700 + 'px'}, 'slow');
        }));
    }
    //选中需要添加好友的公司
    function activeClick() {
        $(".searchSupplierContainerListNumUl_action").on('click',function(){
            $(this).addClass("actionclick").siblings().removeClass("actionclick");
            var checkComKey = $(this).data("value");
            cola.model().set("checkComKey",checkComKey);
            var partnerLevel =  cola.model().get("partnerLevel");
            if(partnerLevel != undefined && partnerLevel != "" && checkComKey != undefined && checkComKey != ""){
                $(".searchSupplierContainerListbtn").css("background", "#2e8ae6").removeAttr("disabled");
            }
        });
    }
    //合作级别选中事件
    $("input[name='partnerLevel']").on("change",function(){
        var partnerLevel = this.value;
        cola.model().set("partnerLevel",partnerLevel);
        var checkComKey = cola.model().get("checkComKey");
        if(partnerLevel != undefined && partnerLevel != "" && checkComKey != undefined && checkComKey != ""){
            $(".searchSupplierContainerListbtn").css("background", "#2e8ae6").removeAttr("disabled");
        }
    });
</script>
</body>
</html>
