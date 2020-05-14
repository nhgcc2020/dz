<%--
  Created by IntelliJ IDEA.
  User: pxy
  Date: 2016/6/2
  Time: 20:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <!--网页页面字符集-->
    <meta charset="UTF-8">
    <!--针对移动设备,网站显示宽度等于设备屏幕显示宽度,内容缩放比例为1:1-->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!--将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面：-->
    <meta name="renderer" content="webkit">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>11注册个人账号</title>
    <!-- css引入和样式定义区域 -->
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <script type="text/javascript" src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script type="text/javascript" src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script type="text/javascript" src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script type="text/javascript" src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script type="text/javascript" src="/resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>
    <script src="/resources/cola-ui/china_city.js?v=bef170068c"></script>


    <!------>
    <link href="/resources/jquery-upload/bootstrap/css/bootstrap.min.css?v=4121062a56" rel="stylesheet">
    <link href="/resources/jquery-upload/cropper/cropper.min.css?v=d5f9bed1d1" rel="stylesheet">
    <link href="/resources/jquery-upload/sitelogo/sitelogo.css?v=1951e9ce3d" rel="stylesheet">
    <script src="/resources/jquery-upload/cropper/cropper.min.js?v=08143dfcfe"></script>
    <script src="/resources/jquery-upload/sitelogo/sitelogo.js?v=a0320384a7"></script>
    <script src="/resources/jquery-upload/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">         <%--//全局图标样式--%>
    <!------>
    <!-- document 内部样式定义区域-->
</head>

<body>
<div>
    <div class="transfer_admin">基本信息</div>
        <!--用户信息-->
        <div style="padding:0px 10px 0px 80px;">
            <div class="ui form" style="color: #A3A3A3;" >
                <div class="fields">
                    <div style="width: 90px;">
                        <span class="fontSize14A fontSize14_header">个人头像<span style="color: red;font-size: 18px;vertical-align: top;"></span></span>
                    </div>
                    <div class="field six wide"><!--class="field eight wide"-->
                        <!---------------------------------------------------------->
                        <div class="ibox-content">
                            <div class="row">
                                <div id="crop-avatar" class="col-md-6">
                                    <div class="avatar-view" title="点击修改个人头像">
                                        <img id="avatar_show" width="100px" onerror="this.src='/images/default_user.png'" src="${sessionScope.sessionUser.avatarPath}" alt="个人头像">
                                        <%--<img src="logo.jpg" alt="Logo">--%>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <form class="avatar-form" action="<c:url value="/file/upload"/>" enctype="multipart/form-data" method="post">
                                        <div class="modal-header">
                                            <button class="close" data-dismiss="modal" type="button">&times;</button>
                                            <h4 class="modal-title" id="avatar-modal-label">上传头像</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="avatar-body">
                                                <div class="avatar-upload">
                                                    <input class="avatar-src" name="avatar_src" type="hidden">
                                                    <input class="avatar-data" name="avatar_data" type="hidden">
                                                    <label for="avatarInput">图片上传</label>
                                                    <input class="avatar-input" id="avatarInput" name="avatar_file" type="file"></div>
                                                <div class="row">
                                                    <div class="col-md-9">
                                                        <div class="avatar-wrapper"></div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="avatar-preview preview-lg"></div>
                                                        <div class="avatar-preview preview-md"></div>
                                                        <div class="avatar-preview preview-sm"></div>
                                                    </div>
                                                </div>
                                                <div class="row avatar-btns">
                                                    <div class="col-md-9">
                                                        <div class="btn-group">
                                                            <button class="btn" data-method="rotate" data-option="-90" type="button" title="Rotate -90 degrees"><i class="fa fa-undo"></i> 向左旋转</button>
                                                        </div>
                                                        <div class="btn-group">
                                                            <button class="btn" data-method="rotate" data-option="90" type="button" title="Rotate 90 degrees"><i class="fa fa-repeat"></i> 向右旋转</button>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <button class="btn btn-success btn-block avatar-save" type="submit"><i class="fa fa-save"></i> 保存修改</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>
                        <!----------------------------------------------------------------->

                    </div>

                </div>

                <form>
                <div class="fields">
                    <div style="width: 90px;">
                        <span class="fontSize14A">用户昵称</span>
                    </div>
                    <div class="field six wide" style="width: 300px !important;">
                        <div c-widget="Input;bind:user.nickName;name:nickName"></div>
                    </div>
                </div>
                <div class="fields">
                    <div style="width: 90px;">
                        <span class="fontSize14A">真实姓名</span>
                    </div>
                    <div class="field six wide" style="width: 300px !important;">
                        <div c-widget="Input;bind:user.realName;name:realName"></div>
                    </div>
                </div>
                <div class="fields">
                    <div style="width: 90px;">
                        <span class="fontSize14A">手机号码</span>
                    </div>
                    <div class="field six wide" style="width: 300px !important;">
                        <div class="fields">
                            <div class="field ten wide ">
                                <input class="dis_input" c-bind="user.userId" name="userId" disabled/>
                            </div>
                            <div c-widget="button;class:basic;color:blue" class="field six wide"  onclick="window.location.href='openPage?pageName=personInfo_per-modify-phone'">修改手机号</div>
                        </div>
                    </div>
                </div>
                <div class="fields">
                    <div style="width: 90px;">
                        <span class="fontSize14A">备用手机</span>
                    </div>
                    <div class="field six wide" style="width: 300px !important;">
                        <div c-widget="Input;placeholder:如您是管理员，建议填写;name:telBak;bind:user.telBak;"></div>
                    </div>
                </div>
                <div class="fields">
                    <div style="width: 90px;">
                        <span class="fontSize14A">联系QQ</span>
                    </div>
                    <div class="field six wide" style="width: 300px !important;">
                        <div c-widget="Input;bind:user.qq;name:qq"></div>
                    </div>
                </div>
                <div class="fields">
                    <div style="width: 90px;">
                        <span class="fontSize14A">电子邮件</span>
                    </div>
                    <div class="field six wide" style="width: 300px !important;">
                        <div c-widget="Input;bind:user.email;name:email"></div>
                    </div>
                </div>

                <div class="fields">
                    <div style="width: 90px;">
                        <span class="fontSize14A">所在城市</span>
                    </div>
                    <div class="field six wide" style="margin-bottom: 0rem !important;width: 300px !important;">
                        <div id="nowProvince" class="field five wide" c-widget="icon:dropdown iconfont;dropdownHeight:200px;"></div><div id="nowCity" class="field five wide" c-widget="icon:dropdown iconfont;dropdownHeight:200px;"></div><div id="nowCountry" class="field six wide" c-widget="icon:dropdown iconfont;dropdownHeight:200px;"></div>
                    </div>
                </div>
                <div class="fields">
                    <div style="width: 90px;">
                        <span class="fontSize14A">我的故乡</span>
                    </div>
                    <div class="field six wide" style="margin-bottom: 0rem !important; width: 300px !important;">
                        <div id="localProvince" class="field five wide" c-widget="icon:dropdown iconfont;dropdownHeight:200px;"></div><div id="localCity" class="field five wide" c-widget="icon:dropdown iconfont;dropdownHeight:200px;"></div><div id="localCountry" class="field six wide" c-widget="icon:dropdown iconfont;dropdownHeight:200px;"></div>
                    </div>
                </div>

                <a c-widget="button;color:blue;click:save" class="sure_button" style="width: 292px !important;">保存</a>
        </form>


<%--</div>--%>
        <%--</div>--%>
        <%--<!--用户信息 end-->--%>
    <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
<%--</div>--%>

<%--<div class="transfer_admin">基本信息</div>--%>
<%--<div class="Allform">--%>

    <%--<div class="fields" style="margin-bottom: 15px;">--%>
        <%--<div style="min-width: 90px;">--%>
            <%--<span style=" display: block;width: 75px; float: left; text-align:right;margin-right: 15px; font-size: 14px; color: #999;">个人头像</span>--%>
        <%--</div>--%>
        <%--<div class="field six wide"><!--class="field eight wide"-->--%>
            <%--<!---------------------------------------------------------->--%>
            <%--<div class="ibox-content">--%>
                <%--<div class="row">--%>
                    <%--<div id="crop-avatar">--%>
                        <%--<div class="avatar-view" title="点击修改个人头像">--%>
                            <%--<img id="avatar_show" width="100px" onerror="this.src='/images/default_user.png'" src="${sessionScope.sessionUser.avatarPath}" alt="个人头像">--%>
                            <%--&lt;%&ndash;<img src="logo.jpg" alt="Logo">&ndash;%&gt;--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>

            <%--<div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">--%>
                <%--<div class="modal-dialog modal-lg">--%>
                    <%--<div class="modal-content">--%>
                        <%--<form class="avatar-form" action="<c:url value="/file/upload"/>" enctype="multipart/form-data" method="post">--%>
                            <%--<div class="modal-header">--%>
                                <%--<button class="close" data-dismiss="modal" type="button">&times;</button>--%>
                                <%--<h4 class="modal-title" id="avatar-modal-label">上传头像</h4>--%>
                            <%--</div>--%>
                            <%--<div class="modal-body">--%>
                                <%--<div class="avatar-body">--%>
                                    <%--<div class="avatar-upload">--%>
                                        <%--<input class="avatar-src" name="avatar_src" type="hidden">--%>
                                        <%--<input class="avatar-data" name="avatar_data" type="hidden">--%>
                                        <%--<label for="avatarInput">图片上传</label>--%>
                                        <%--<input class="avatar-input" id="avatarInput" name="avatar_file" type="file"></div>--%>
                                    <%--<div class="row">--%>
                                        <%--<div class="col-md-9">--%>
                                            <%--<div class="avatar-wrapper"></div>--%>
                                        <%--</div>--%>
                                        <%--<div class="col-md-3">--%>
                                            <%--<div class="avatar-preview preview-lg"></div>--%>
                                            <%--<div class="avatar-preview preview-md"></div>--%>
                                            <%--<div class="avatar-preview preview-sm"></div>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                    <%--<div class="row avatar-btns">--%>
                                        <%--<div class="col-md-9">--%>
                                            <%--<div class="btn-group">--%>
                                                <%--<button class="btn" data-method="rotate" data-option="-90" type="button" title="Rotate -90 degrees"><i class="fa fa-undo"></i> 向左旋转</button>--%>
                                            <%--</div>--%>
                                            <%--<div class="btn-group">--%>
                                                <%--<button class="btn" data-method="rotate" data-option="90" type="button" title="Rotate 90 degrees"><i class="fa fa-repeat"></i> 向右旋转</button>--%>
                                            <%--</div>--%>
                                        <%--</div>--%>
                                        <%--<div class="col-md-3">--%>
                                            <%--<button class="btn btn-success btn-block avatar-save" type="submit"><i class="fa fa-save"></i> 保存修改</button>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</form>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>

            <%--<div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>--%>
            <%--<!----------------------------------------------------------------->--%>

        <%--</div>--%>

    <%--</div>--%>

    <%--<p>--%>
        <%--<span>用户昵称</span>--%>
        <%--<input type="text" c-bind="user.nickName ">--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span>真实姓名</span>--%>
        <%--<input type="text" c-bind="user.realName">--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span>手机号码</span>--%>
        <%--<input type="text" c-bind="user.userId">--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span>备用手机</span>--%>
        <%--<input type="text" c-bind="user.telBak">--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span>联系QQ</span>--%>
        <%--<input type="text" c-bind="user.qq">--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span>电子邮件</span>--%>
        <%--<input type="text" c-bind="user.email">--%>
    <%--</p>--%>

    <%--<p>--%>
        <%--<span>所在城市</span>--%>
        <%--<a>--%>
            <%--<select name="" id="comProvince"></select>--%>
            <%--<select name="" id="comCity"></select>--%>
            <%--<select name="" id="comCountry"></select>--%>
        <%--</a>--%>
    <%--</p>--%>

    <%--<p>--%>
        <%--<span>我的故乡</span>--%>
        <%--<a>--%>
            <%--<select name="" id="comProvince"></select>--%>
            <%--<select name="" id="comCity"></select>--%>
            <%--<select name="" id="comCountry"></select>--%>
        <%--</a>--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span> &nbsp; &nbsp; &nbsp;  </span>--%>
        <%--<button>保存</button>--%>
    <%--</p>--%>
<%--</div>--%>

<script type="text/javascript">
    function uploadImg() {
        $("#uploadForm").submit();
    }

    function changeImg(){
        $("#fileInput").click();
    }

    cola(function(model) {

        model.describe("user",{
            provider: {
                url: "<c:url value="/ydz/user/per-data"/>",
            }
        });
        model.get("user","sync");

        model.set("provinceList",ProvinceJson);
        var nowCityArray = new Array();
        var nowCity = model.get("user.nowProvince");
        for(var i=0;i<CityJson.length;i++){
            if(CityJson[i].provinceId == nowCity){
                nowCityArray.push(CityJson[i])
            }
        }
        model.set("nowCityList",nowCityArray);

        var nowCountryArray = new Array();
        for(var i=0;i<CountryJson.length;i++){
            if(CountryJson[i].cityId == model.get("user.nowCity")){
                nowCountryArray.push(CountryJson[i])
            }
        }
        model.set("nowCountryList",nowCountryArray);

        var localCityArray = new Array();
        for(var i=0;i<CityJson.length;i++){
            if(CityJson[i].provinceId == model.get("user.localProvince")){
                localCityArray.push(CityJson[i])
            }
        }
        model.set("localCityList",localCityArray);

        var localCountryArray = new Array();
        for(var i=0;i<CountryJson.length;i++){
            if(CountryJson[i].cityId == model.get("user.localCity")){
                localCountryArray.push(CountryJson[i])
            }
        }
        model.set("localCountryList",localCountryArray);

        model.action({
            save:function(btn){
                btn.set("disabled",true);
                btn.set("state","loading");
                cola.widget("nowProvince").get("value") != undefined ? model.set("user.nowProvince",cola.widget("nowProvince").get("value")) : "";
                cola.widget("nowCity").get("value") != undefined ? model.set("user.nowCity",cola.widget("nowCity").get("value")) : "";
                cola.widget("nowCountry").get("value") != undefined ? model.set("user.nowCountry",cola.widget("nowCountry").get("value")) : "";

                cola.widget("localProvince").get("value") != undefined ? model.set("user.localProvince",cola.widget("localProvince").get("value")) : "";
                cola.widget("localCity").get("value") != undefined ? model.set("user.localCity",cola.widget("localCity").get("value")) : "";
                cola.widget("localCountry").get("value") != undefined ? model.set("user.localCountry",cola.widget("localCountry").get("value")) : "";

               $.post("<c:url value="/ydz/user/modUser"/>",model.get("user"),function(data){
                    if(data == '1'){
                        $("<div class='tips_contants'>").fadeIn(250).html("修改成功").delay(500).fadeOut(250).appendTo('body');
                        setTimeout(function(){
                            window.location.reload(true);
                        },1000);
                    }else{
                        $("<div class='tips_contants'>").fadeIn(250).html("修改失败").delay(500).fadeOut(250).appendTo('body');
                    }
                })
            }
        })

        model.widgetConfig({
            //所在省
            nowProvince:{
                $type: "dropdown",
                items: "{{provinceList}}",
                openMode: "drop",
                valueProperty:"provinceId",
                textProperty:"provinceName",
                value:"{{user.nowProvince}}",
                change:function (self,arg) {
                    var nowCityArray = new Array();
                    for(var i=0;i<CityJson.length;i++){
                        if(CityJson[i].provinceId == self.get("value")){
                            nowCityArray.push(CityJson[i])
                        }
                    }
                    model.set("nowCityList",nowCityArray);

                    cola.widget("nowCity").set("value","");
                    cola.widget("nowCountry").set("value","");
                }
            },
            //所在市
            nowCity:{
                $type: "dropdown",
                items: "{{nowCityList}}",
                openMode: "drop",
                valueProperty:"cityId",
                textProperty:"cityName",
                value:"{{user.nowCity}}",//

                change:function (self,arg) {
                    var countryArray = new Array();
                    for(var i=0;i<CountryJson.length;i++){
                        if(CountryJson[i].cityId == self.get("value")){
                            countryArray.push(CountryJson[i])
                        }
                    }
                    model.set("nowCountryList",countryArray);
                    cola.widget("nowCountry").set("value","");

                }
            },
            //所在县
            nowCountry:{
                $type: "dropdown",
                items: "{{nowCountryList}}",
                openMode: "drop",
                valueProperty:"countryId",
                textProperty:"countryName",
                value:"{{user.nowCountry}}"

            },
            //故乡省
            localProvince:{
                $type: "dropdown",
                items: "{{provinceList}}",
                openMode: "drop",
                valueProperty:"provinceId",
                textProperty:"provinceName",
                value:"{{user.localProvince}}",
                change:function (self,arg) {
                    var cityArray = new Array();
                    for(var i=0;i<CityJson.length;i++){
                        if(CityJson[i].provinceId == self.get("value")){
                            cityArray.push(CityJson[i])
                        }
                    }
                    model.set("localCityList",cityArray);
                    cola.widget("localCity").set("value","");
                    cola.widget("localCountry").set("value","");

                }
            },
            //故乡市
            localCity:{
                $type: "dropdown",
                items: "{{localCityList}}",
                openMode: "drop",
                valueProperty:"cityId",
                textProperty:"cityName",
                value:"{{user.localCity}}",
                change:function (self,arg) {
                    var countryArray = new Array();
                    for(var i=0;i<CountryJson.length;i++){
                        if(CountryJson[i].cityId == self.get("value")){
                            countryArray.push(CountryJson[i])
                        }
                    }
                    model.set("localCountryList",countryArray);
                    cola.widget("localCountry").set("value","");
                }
            },
            //故乡县
            localCountry:{
                $type: "dropdown",
                items: "{{localCountryList}}",
                openMode: "drop",
                valueProperty:"countryId",
                textProperty:"countryName",
                value:"{{user.localCountry}}"

            }
        });
    });

    window.onload = function(){
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
    }
</script>
</body>

</html>