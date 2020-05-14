<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <link href="/resources/jquery-upload/bootstrap/css/bootstrap.min.css?v=4121062a56" rel="stylesheet">
    <link href="/resources/jquery-upload/cropper/cropper.min.css?v=d5f9bed1d1" rel="stylesheet">
    <link href="/resources/jquery-upload/sitelogo/sitelogo.css?v=1951e9ce3d" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">

    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script src="/resources/cola-ui/clipboard.min.js?v=bd70fd596a"></script>
    <script src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
    <script src="/resources/jquery-upload/cropper/cropper.min.js?v=08143dfcfe"></script>
    <script src="/resources/jquery-upload/sitelogo/sitelogo.js?v=a0320384a7"></script>
    <script src="/resources/jquery-upload/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
    <style>
    .cover {
            display: none;
            position: fixed;
            top: 0;
            width: 100%;
            height: 100%;
            background: #000;
            opacity: 0.7;
            z-index: 1000;
        }
     .alart_one {
            display: none;
            position: fixed;
            top: 50%;
            z-index: 2000;
            width: 1100px;
            margin-top: -270px;
            left: 50%;
            margin-left: -550px;
        }
    .callback {
            font-size: 45px;
            right: -40px;
            top: -20px;
            position: absolute;
            color: #fff;
            cursor: pointer;
        }
    </style>
    <script type="text/javascript">
        cola(function (model) {
            model.action({

                modify:function(btn){
                    if(model.get("company.comName")==""){
                        $("<div class='tips_contants'>").fadeIn(250).html("请填写企业全称").delay(500).fadeOut(250).appendTo('body');
                        return;
                    }
                    btn.set("disabled",true);
                    btn.set("state","loading");
                    cola.widget("comProvince").get("value") != undefined ? model.set("company.comProvince",cola.widget("comProvince").get("value")) : "";
                    cola.widget("comCity").get("value") != undefined ? model.set("company.comCity",cola.widget("comCity").get("value")) : "";
                    cola.widget("comCountry").get("value") != undefined ? model.set("company.comCountry",cola.widget("comCountry").get("value")) : "";
                    $.post("/company/modCompany",model.get("company"),
                            function(data){
                                if(data=='1'){
                                    $("<div class='tips_contants'>").fadeIn(250).html("修改成功").delay(500).fadeOut(250).appendTo('body');
                                    setTimeout(function(){
                                        window.location.reload(true);
                                    },1000);
                                }
                            })
                }
            });

            model.describe("company",{
                provider:{
                    url:"/company/single-info"
                }
            });
            var company = model.get("company","sync");
            var comProvince = company.get("comProvince");

            var cityArray = new Array();
            for(var i=0;i<CityJson.length;i++){
                if(CityJson[i].provinceId == comProvince){
                    cityArray.push(CityJson[i])
                }
            }
            model.set("provinceList",ProvinceJson);
            model.set("cityList",cityArray);

            var comCity = company.get("comCity");
            var countryArray = new Array();
            for(var i=0;i<CountryJson.length;i++){
                if(CountryJson[i].cityId == comCity){
                    countryArray.push(CountryJson[i])
                }
            }
            model.set("countryList",countryArray);


            model.widgetConfig({
                //所在省
                comProvince:{
                    $type: "dropdown",
                    items: "{{provinceList}}",
                    openMode: "drop",
                    valueProperty:"provinceId",
                    textProperty:"provinceName",
                    value:"{{company.comProvince}}",
                    dropdownHeight:"350px",
                    change:function (self,arg) {
                        var cityArray = new Array();
                        for(var i=0;i<CityJson.length;i++){
                            if(CityJson[i].provinceId == self.get("value")){
                                cityArray.push(CityJson[i])
                            }
                        }
                        model.set("cityList",cityArray);
                        cola.widget("comCity").set("value","");
                        cola.widget("comCountry").set("value","");

                    }
                },
                //所在市
                comCity:{
                    $type: "dropdown",
                    items: "{{cityList}}",
                    openMode: "drop",
                    valueProperty:"cityId",
                    textProperty:"cityName",
                    value:"{{company.comCity}}",//
                    change:function (self,arg) {
                        var comCity = self.get("value");
                        var countryArray = new Array();
                        for(var i=0;i<CountryJson.length;i++){
                            if(CountryJson[i].cityId == comCity){
                                countryArray.push(CountryJson[i])
                            }
                        }
                        model.set("countryList",countryArray);
                        cola.widget("comCountry").set("value","");
                    }
                },
                //所在县
                comCountry:{
                    $type: "dropdown",
                    items: "{{countryList}}",
                    openMode: "drop",
                    valueProperty:"countryId",
                    textProperty:"countryName",
                    value:"{{company.comCountry}}"
                },
                comTypeRg: {
                    items: [{
                        value: "1",
                        label:"有限公司"
                    },{
                        value: "2",
                        label:"个体工商户"
                    } ]
                }
            })
        });
        $(function(){
            $(".alrt").click(function(){
                $(".cover").show();
                $(".alart_one").show();
            });
            $(".callback").click(function(){
                 $(".cover").hide();
                $(".alart_one").hide();
            })
        })
    </script>
</head>
<body>
<div class="cover"></div>
<div class="alart_one">
    <div class="callback iconfont">&#xe6a0;</div>
    <img src="/images/sale.png" alt="">
</div>
<div class="transfer_admin">企业基本信息</div>
<div style="padding:0px 10px 0px 80px;">
    <div class="ui form">
        <div class="fields">
            <div style="width: 90px;">
                <span class="fontSize14A fontSize14_header">企业Logo<span style="color: red;font-size: 18px;vertical-align: top;"></span></span>
            </div>

            <div class="field six wide">
                <!---------------------------------------------------------->
                <div class="ibox-content">
                    <div class="row">
                        <div id="crop-avatar" class="col-md-6">
                            <div class="avatar-view" title="点击修改企业LOGO">
                                <img id="avatar_show" width="100px" onerror="this.src='/images/default_company.png'" src="${sessionScope.sessionUser.comLogoPath}" alt="企业logo">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <form class="avatar-form" action="/file/upload-com" enctype="multipart/form-data" method="post">
                                <div class="modal-header">
                                    <button class="close" data-dismiss="modal" type="button">&times;</button>
                                    <h4 class="modal-title" id="avatar-modal-label">上传企业Logo</h4>
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

        <div class="fields">
            <div style="width: 90px;">
                <span class="fontSize14A">企业全称</span>
            </div>
            <div class="field six wide" style="width: 300px !important;">
                <div c-widget="input; bind:company.comName;"></div>
            </div>
        </div>

        <div class="fields">
            <div style="width: 90px;">
                <span class="fontSize14A">企业简称</span>
            </div>
            <div class="field six wide" style="width: 300px !important;">
                <div c-widget="input; bind:company.comShortname;"></div>
            </div>
        </div>

        <div class="fields">
            <div style="width: 90px;">
                <span class="fontSize14A">企业对账号</span>
            </div>
            <div class="field six wide" style="width: 300px !important;">
                <div c-widget="input; bind:company.comId;readOnly:true" class="copy_left" id="copy_comId"></div>
                <div class="copy_right" id="copy_right2">复制</div>
            </div>
        </div>

        <div class="fields">
            <div style="width: 90px;">
                <span class="fontSize14A">内部邀请码</span>
            </div>
            <div class="field six wide" style="width: 300px !important;">
                <div c-widget="input; bind:company.withinComId;readOnly:true" class="copy_left" id="copy_withinComId"></div>
                <div class="copy_right" id="copy_right3">复制</div>
            </div>
        </div>

        <div class="fields">
            <div style="width: 90px;">
                <span class="fontSize14A">所属行业</span>
            </div>
            <div class="field six wide" style="width: 300px !important;">
                <div c-widget="input; bind:company.industryValue;readOnly:true"></div>
            </div>
        </div>

        <div class="fields">
            <div style="width: 90px;">
                <span class="fontSize14A">企业类型</span>
            </div>

            <div class="field six wide" style="width: 300px !important;">
                <div id="comTypeRg" c-widget="RadioGroup;name:comAttr;bind:company.comAttr"></div>
            </div>
        </div>
        <div class="fields">
            <div style="width: 90px;">
                <span class="fontSize14A">企业QQ</span>
            </div>

            <div class="field six wide" style="width: 300px !important;">
                <div c-widget="input; bind:company.comQQ"></div>
            </div>
        </div>

        <div class="fields">
            <div style="width: 90px;">
                <span class="fontSize14A">联系电话</span>
            </div>
            <div class="field six wide" style="width: 300px !important;">
                <input c-bind="company.areaCode" type="text" placeholder="区号" style="width:28%; float: left;">
                <input c-bind="company.comTel" type="text" placeholder="号码" style="width:70%; float: right;">
            </div>
        </div>

        <div class="fields">
            <div style="width: 90px;">
                <span class="fontSize14A">通讯地址</span>
            </div>
            <div class="field six wide" style="width: 300px !important;">
                <div id="comProvince" class="field five wide" c-widget="icon:dropdown iconfont;dropdownHeight:200px;"></div><div id="comCity" class="field five wide" c-widget="icon:dropdown iconfont;dropdownHeight:200px;"></div><div id="comCountry"  class="field six wide" c-widget="icon:dropdown iconfont;dropdownHeight:200px;"></div>
            </div>

        </div>

        <div class="fields fix-fields">
            <div style="width: 90px;">
                <span class="fontSize14A"></span>
            </div>
            <div class="field six wide" style="width: 300px !important;">
                <div c-widget="input; bind:company.comAddress; placeholder:详细地址"></div>
            </div>
        </div>
        <div class="fields">
            <div style="width: 90px;">
                <span class="fontSize14A">开户行</span>
            </div>

            <div class="field six wide" style="width: 300px !important;">
                <div c-widget="input; bind:company.comBank"></div>
            </div>
        </div>
        <div class="fields">
            <div style="width: 90px;">
                <span class="fontSize14A">开户账号</span>
            </div>

            <div class="field six wide" style="width: 305px !important;">
                <div c-widget="input; bind:company.comAccount"></div>
            </div>
            <div class="alrt" style=" cursor: pointer;position: relative;left:10px;color:#999;top:0px;">显示在销售对账单打印页最下方，方便客户打款 <span style="color:#4284d9;margin-left:10px;"><i class="iconfont" style="font-size:19px;position:relative;top:2px;">&#xe6df;</i> 预览打印样式</span></div>
        </div>
        <div class="fields">
            <a c-widget="button;click:modify;caption:保存; class:primary fluid;" style="width: 292px !important;" class="sure_button"></a>
        </div>
    </div>
</div>

<div class="model_box1"></div>

<script>
    var clipboard = new Clipboard('#copy_right3', {
        target: function(){
            //document.getElementById('copy_withinComId')
            return  $("#copy_withinComId input")[0];
        }
    });
    clipboard.on('success', function(e) {
        $("<div class='tips_contants'>").fadeIn(250).html("复制成功").delay(500).fadeOut(250).appendTo('body');
    });
    clipboard.on('error', function(e) {
        $("<div class='tips_contants'>").fadeIn(250).html("您的浏览器不支持").delay(500).fadeOut(250).appendTo('body');
    });

    var clipboard1 = new Clipboard('#copy_right2', {
        target: function(){
            return $("#copy_comId input")[0];
            //document.getElementById('copy_comId');
        }
    });
    clipboard1.on('success', function(e) {
        $("<div class='tips_contants'>").fadeIn(250).html("复制成功").delay(500).fadeOut(250).appendTo('body');
    });
    clipboard1.on('error', function(e) {
        $("<div class='tips_contants'>").fadeIn(250).html("您的浏览器不支持").delay(500).fadeOut(250).appendTo('body');
    });

    //禁止返回上一页
    window.onload = function(){
        window.history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
    }
</script>
</body>
</html>
