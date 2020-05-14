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
    <script type="text/javascript" src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
</head>
<body>

<header class="mui-bar mui-bar-nav heard_nav">
    <h1 class="mui-title">创建企业</h1>
</header>

<div class="mui-content">
    <div class="mui-content-padded related_form_content">
        <form id="create_con" class="mui-input-group related_form">

            <input type="hidden" name="comAttr" value="1" />
            <input type="hidden" name="bossOrAdmin" value="boss"/>
            <input type="hidden" name="industryId" value="${mId}"/>

            <p>我的角色</p>
            <div class="mui-segmented-control">
                <a class="mui-control-item mui-active" data-value="boss" href="#item1" style="text-decoration: none;">法人代表管理员</a>
                <a class="mui-control-item" data-value="admin" href="#item2" style="text-decoration: none;">管理员</a>
            </div>

            <p>企业全称<i>（不可修改）</i></p>
            <div class="mui-input-row related_form_row">
                <input type="text" name="comName" class="mui-input-clear" placeholder="请输入营业执照上的公司全称">
            </div>
            <p>简称或品牌</p>
            <div class="mui-input-row related_form_row">
                <input type="text" name="comShortname" class="mui-input-clear" placeholder="请输入对外的公司简称或品牌（3-8字为宜）">
            </div>

            <p>企业区域</p>
            <div class="mui-input-row related_form_prov related_form_prov_undline">
                <select id="selProvince" name="comProvince">
                    <option selected value="">请选择省份</option>
                </select>
                <select id="selCity" name="comCity">
                    <option selected value="">请选择城市</option>
                </select>
                <select id="selCountry" name="comCountry">
                    <option selected value="">请选择区域</option>
                </select>
            </div>
            <div class="mui-button-row related_form_sub">
                <button type="button" class="mui-btn mui-btn-primary" id="next_tap">下一步</button>
            </div>
        </form>
    </div>
</div>
<div class="button-copyright" style="margin-top: 100px;">上海仁石科技有限公司欢迎您注册使用易对账!</br>Copyright@2016 沪 ICP备16005067</div>
<script>

    $(".mui-control-item").on("click",function (btn) {
        $(this).addClass("mui-active");
        $(this).siblings().removeClass("mui-active");
    });

    //城市三级联动
    $(function() {
        //选择省
        $.each(ProvinceJson, function(k, p) {
            var option = "<option value='" + p.provinceId + "'>" + p.provinceName + "</option>";
            $("#selProvince").append(option);
        });

        //选择市
        $("#selProvince").change(function() {
            var selValue = $(this).val();
            $("#selCity option:gt(0)").remove();
            $("#selCountry option:gt(0)").remove();
            $.each(CityJson, function(k, p) {
                if (p.provinceId == selValue) {
                    var option = "<option value='" + p.cityId + "'>" + p.cityName + "</option>";
                    $("#selCity").append(option);
                }
            });
        });

        //选择县
        $("#selCity").change(function() {
            var selValue = $(this).val();
            $("#selCountry option:gt(0)").remove();
            $.each(CountryJson, function(k, p) {
                if (p.cityId == selValue) {
                    var option = "<option value='" + p.countryId + "'>" + p.countryName + "</option>";
                    $("#selCountry").append(option);
                }
            });
        });
    });


    $("#next_tap").click(function(){
        var _this = $(this);
        var value = $(".mui-segmented-control").find(".mui-active").data("value");
        $("input[name='bossOrAdmin']").val(value);

        //非空校验
        var comName = $("input[name='comName']").val();
        var comShortname = $("input[name='comShortname']").val();
        var comProvince = document.getElementById("selProvince");
        var comCity = document.getElementById("selCity");
        var comCountry = document.getElementById("selCountry");

        if(comName != "" && comShortname != "" && comProvince.value != "" && comCity.value != "" && comCountry.value != ""){
            $(_this).html("").addClass("lodingBtn").attr("disabled","true");
            $.post(
                    "/invite/com/createCom",
                    $("#create_con").serialize(),
                    function (data) {
                        if(data=="1"){
                            window.location.href="/invite/com/create_succ";
                        }else{
                            $("<div class='tips_contants'>").fadeIn(250).html("提交失败").delay(1000).fadeOut(250).appendTo('body');
                            $(_this).html("下一步").removeClass("lodingBtn").attr("disabled","false");
                        }
                    }
            );
        }else {
            $("<div class='tips_contants'>").fadeIn(250).html("您提交的信息不完整,请确认").delay(2000).fadeOut(250).appendTo('body');
            return false;
        }
        //window.location="select-main-industry.html";
    });



</script>
</body>
</html>
