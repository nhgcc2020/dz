<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script src="/resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>
    <script src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/business/order-table.css?v=7367cb39d5">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
</head>
<body>

<div style="margin: 3rem auto;width: 1000px;" class="show-on-ready">
        <div style="text-align: center;margin-bottom: 3rem;font-size: 2rem;width: 920px;">非好友修改</div>
        <div c-widget="form">
            <div class="ui form">
                <div class="inline field">
                    <label style="width: 80px"><span style="color: red">*</span>企业全称</label>
                    <div c-widget="input;width:370px;bind:partner.partnerName;tag:disInput"></div>

                    <label style="width: 80px;margin-left:40px"><span style="color: red"></span>公司电话</label>
                    <div c-widget="input;width:370px;bind:partner.partnerTel"></div>
                </div>

                <div class="inline field">
                    <label style="width: 80px"><span style="color: red">*</span>企业简称</label>
                    <div c-widget="input;width:370px;bind:partner.partnerShortname;tag:disInput;change:getZJM"></div>

                    <label style="width: 80px;margin-left:40px"><span style="color: red"></span>公司QQ</label>
                    <div c-widget="input;width:370px;bind:partner.partnerQQ"></div>
                </div>

                <div class="inline field">
                    <label style="width: 80px;"><span style="color: red">*</span>助记代码</label>
                    <div c-widget="input;width:370px;bind:partner.mnemonicCode;"></div>

                    <label style="width: 80px;margin-left:40px">公司区域</label>
                    <div style="display: inline-block;width: 373px">
                        <div id="comProvince" style="width: 33%" c-widget="icon:dropdown iconfont"></div><div id="comCity" style="width: 33%" c-widget="icon:dropdown iconfont"></div><div id="comCountry" style="width: 33%" c-widget="icon:dropdown iconfont"></div>
                    </div>
                </div>

                <div class="inline field">
                    <label style="width: 80px;"><span style="color: red">*</span>联系姓名</label>
                    <div c-widget="input;width:370px;bind:partner.contacterName;tag:disInput"></div>

                    <label style="width: 80px;margin-left:40px">公司地址</label>
                    <div c-widget="input;width:370px;bind:partner.partnerAddress"></div>
                </div>

                <div class="inline field">
                    <label style="width: 80px"><span style="color: red">*</span>联系手机</label>
                    <div c-widget="input;width:370px;bind:partner.tel1;tag:disInput;change:addQuery2"></div>


                    <label style="width: 80px;margin-left:40px"><span style="color: red"></span>备用手机</label>
                    <div c-widget="input;width:370px;tag:disInput;bind:partner.tel2"></div>
                </div>


                <div class="inline field">
                    <label style="width: 80px;"><span style="color: red">*</span>伙伴分类</label>
                    <div id="radioGroup3" c-widget="RadioGroup;name:brand3;bind:partner.partnerType" style="display: inline-block"></div>

                </div>
                <div class="inline field">
                    <label style="width: 80px;"><span style="color: red">*</span>价格级别</label>
                    <div id="radioGroup4" c-widget="RadioGroup;name:brand4;bind:partner.partnerLevel"
                         style="display: inline-block"></div>
                </div>
            </div>
        </div>
        <div class="actions" style="margin-top: 1rem">
            <div c-widget="button;caption:取消;click:closeDiv" style="float:left"></div>
            <div c-widget="button;class:primary;caption:保存;click:savePartnerCom"></div>
        </div>
</div>
  <script>
      cola(function (model) {
          //
          var partnerKey = "${partnerKey}";
          var contacterId = "${contacterId}";

          $.ajax({
              type: "POST",
              url: "<c:url value='/system/partner/partnerInfo'/>",
              data: {partnerKey:partnerKey,contacterId:contacterId},
              async:false,
              dataType: "json",
              success:function(callback){
                  model.set("partner",callback);
              }
          });
          var comProvince = model.get("partner.partnerProvince");
          var cityArray = [];
          for(var j=0;j<CityJson.length;j++){
              if(CityJson[j].provinceId == comProvince){
                  cityArray.push(CityJson[j])
              }
          }
          model.set("provinceList",ProvinceJson);
          model.set("cityList",cityArray);

          var comCity = model.get("partner.partnerCity");
          var countryArray = [];
          for(var k=0;k<CountryJson.length;k++){
              if(CountryJson[k].cityId == comCity){
                  countryArray.push(CountryJson[k])
              }
          }
          model.set("countryList",countryArray);

          model.action({
              savePartnerCom:function(btn){
                  $.post(
                    "<c:url value="/system/partner/modNonFriend"/>",
                    model.get("partner"),
                    function(data){
                        $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(2000).fadeOut(250).appendTo('body');
                        if(data.state){
                                window.parent.partnerModel.flush("items");
                            setTimeout(function(){

                                window.parent.partnerModel.action("closeModPartner")();
                            },2000);
                        }

                    }
                  )
              },
              closeDiv:function(){
                  window.parent.partnerModel.action("closeModPartner")();
              }
          })

          model.widgetConfig({
              //按钮组
              operations: {
                  $type: "button",
                  click: function (self, arg) {
                      var ops = cola.tag("op");
                      //初始化按钮组颜色
                      var userData;
                      for (var i = 0; i < ops.length; i++) {
                          var op = ops[i];
                          userData = op.get("userData");
                          if (self.get("userData") != userData) {
                              op.get$Dom().removeClass("active blue");
                              op.get$Dom().addClass("basic grey");
                              cola.widget(userData).hide({
                                  animation: "horizontal flip"
                              });
                          }
                      }
                      //初始化表格格式
                      self.get$Dom().removeClass("basic grey");
                      self.get$Dom().addClass("active blue");
                      //self.set("class","active blue");
                      userData = self.get("userData");
                      cola.widget(userData).show({
                          animation: "horizontal flip"
                      });
                  }
              },
              //所在省
              comProvince: {
                  $type: "dropdown",
                  items: "{{provinceList}}",
                  openMode: "drop",
                  valueProperty: "provinceId",
                  textProperty: "provinceName",
                  value: "{{partner.partnerProvince}}",
                  change: function (self, arg) {
                      var nowCityArray = [];
                      for (var i = 0; i < CityJson.length; i++) {
                          if (CityJson[i].provinceId == self.get("value")) {
                              nowCityArray.push(CityJson[i])
                          }
                      }
                      model.set("cityList", nowCityArray);
                      cola.widget("comCity").set("value", "");
                      cola.widget("comCountry").set("value", "");
                      //更新当前选中的省
                      model.set("partner.partnerProvince",arg.value);

                  }
              },
              //所在市
              comCity: {
                  $type: "dropdown",
                  items: "{{cityList}}",
                  openMode: "drop",
                  valueProperty: "cityId",
                  textProperty: "cityName",
                  value: "{{partner.partnerCity}}",//
                  change: function (self, arg) {
                      var countryArray = new Array();
                      for (var i = 0; i < CountryJson.length; i++) {
                          if (CountryJson[i].cityId == self.get("value")) {
                              countryArray.push(CountryJson[i])
                          }
                      }
                      model.set("countryList", countryArray);
                      cola.widget("comCountry").set("value", "");
                      //更新当前选中的市
                      model.set("partner.partnerCity",arg.value);
                  }
              },
              //所在县
              comCountry: {
                  $type: "dropdown",
                  items: "{{countryList}}",
                  openMode: "drop",
                  valueProperty: "countryId",
                  textProperty: "countryName",
                  value: "{{partner.partnerCountry}}",
                  change:function(self,arg){
                      model.set("partner.partnerCountry",arg.value);
                  }
              },
              radioGroup3: {
                  items: [{
                      label: "既是客户又是供应商",
                      value: "A"
                  }, {
                      label: "我的客户",
                      value: "1"
                  }, {
                      label: "我的供应商",
                      value: "2"
                  }]
              },
              radioGroup4: {
                  items: [{
                      label: "优惠价",
                      value: "1"
                  }, {
                      label: "标准价",
                      value: "2"
                  }, {
                      label: "零散价",
                      value: "3"
                  }]

              },
              radioGroupSend: {
                  items: [{
                      label: "免费发送",
                      value: true
                  }, {
                      label: "不发送",
                      value: false
                  }]

              }
          });
      })
  </script>
</body>
</html>
