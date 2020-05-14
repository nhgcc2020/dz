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
    <style>
        .dis_input > input{
            background-color: #f2f5f7 !important;
        }
        .ui.segment{
            padding:0px;
        }
    </style>
</head>
<body>

<div style="margin:0px auto; padding: 3rem 0px; width: 830px; " class="show-on-ready">
    <div style="text-align: center;margin-bottom: 3rem;font-size: 2rem;width:830px;">好友修改</div>
        <div c-widget="form">
            <div class="ui form">
                <div class="inline field">
                    <label style="width: 80px"><span style="color: red">*</span>企业全称</label>
                    <div c-widget="input;width:300px;bind:partner.partnerName;tag:disInput;readOnly:true;class:dis_input"></div>

                    <label style="width: 80px;margin-left:40px"><span style="color: red"></span>公司电话</label>
                    <div c-widget="input;width:300px;bind:partner.partnerTel;readOnly:true;class:dis_input"></div>
                </div>

                <div class="inline field">
                    <label style="width: 80px"><span style="color: red">*</span>企业简称</label>
                    <div c-widget="input;width:300px;bind:partner.partnerShortname;tag:disInput;readOnly:true;class:dis_input"></div>

                    <label style="width: 80px;margin-left:40px"><span style="color: red"></span>公司QQ</label>
                    <div c-widget="input;width:300px;bind:partner.partnerQQ;readOnly:true;class:dis_input"></div>
                </div>

                <div class="inline field">
                    <label style="width: 80px;"><span style="color: red">*</span>助记代码</label>
                    <div c-widget="input;width:300px;bind:partner.mnemonicCode;"></div>

                    <label style="width: 80px;margin-left:40px">公司区域</label>
                    <div style="display: inline-block;width: 300px">
                        <div c-widget="input;width:90;bind:partner.partnerProvince;readOnly:true;class:dis_input"></div><div c-widget="input;width:90px;bind:partner.partnerCity;readOnly:true;class:dis_input" style="margin: 0px 15px;"></div><div c-widget="input;width:90px;bind:partner.partnerCountry;readOnly:true;class:dis_input"></div>
                        <%--<div id="comProvince" style="width: 33%" c-widget="icon:dropdown iconfont"></div>
                        <div id="comCity" style="width: 33%" c-widget="icon:dropdown iconfont"></div>
                        <div id="comCountry" style="width: 33%" c-widget="icon:dropdown iconfont"></div>--%>
                    </div>
                </div>

                <div class="inline field">
                    <label style="width: 80px;"><span style="color: red">*</span>联系姓名</label>
                    <div c-widget="input;width:300px;bind:partner.contacterName;tag:disInput;readOnly:true;class:dis_input"></div>

                    <label style="width: 80px;margin-left:40px">公司地址</label>
                    <div c-widget="input;width:300px;bind:partner.partnerAddress;readOnly:true;class:dis_input"></div>
                </div>

                <div class="inline field">
                    <label style="width: 80px"><span style="color: red">*</span>联系手机</label>
                    <div c-widget="input;width:300px;bind:partner.tel1;tag:disInput;readOnly:true;class:dis_input"></div>


                    <label style="width: 80px;margin-left:40px"><span style="color: red"></span>备用手机</label>
                    <div c-widget="input;width:300px;tag:disInput;bind:partner.tel2;"></div>
                </div>

                <div class="inline field" style="margin-top: 2rem;">
                    <label style="width: 80px;"><span style="color: red">*</span>伙伴分类</label>
                    <div id="radioGroup" c-widget="RadioGroup;name:brand3;bind:partner.partnerType" style="display: inline-block"></div>

                </div>
                <div class="inline field" style="margin-top: 2rem;">
                    <label style="width: 80px;"><span style="color: red">*</span>价格级别</label>
                    <div id="radioGroup2" c-widget="RadioGroup;name:brand4;bind:partner.partnerLevel"
                         style="display: inline-block"></div>
                </div>
            </div>
        </div>
        <hr  style="margin-top: 2rem">
        <div class="actions" style="margin-top: 2rem; text-align: right;">
            <div c-widget="button;caption:取消;click:closeDiv"></div>
            <div c-widget="button;class:primary;caption:保存;click:savePartnerCom"></div>
        </div>
</div>

  <script>
      cola(function (model) {
          //
          var partnerKey = "${partnerKey}";
          var contacterId = "${contacterId}";
          $.post("<c:url value="/system/partner/partnerInfo"/>",
                  {partnerKey:partnerKey,contacterId:contacterId},function (data) {
                      model.set("partner",data);
                  });

          /*model.set("partner", {
              partnerShortname: "",
              partnerName: "",
              partnerTel: "",
              partnerAddress: "",
              partnerAttr: "",
              partnerQQ: "",
              partnerType: "",
              partnerLevel: "",
              tel11: "",
              contacterName11: "",
              tel112: "",
              mnemonicCode: "",
              sendMsg: ""
          });*/

          model.widgetConfig({
              radioGroup: {
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
              radioGroup2: {
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

              }
          });
          model.action({
              savePartnerCom:function(btn){
                  $.post("/system/partner/modFriend", model.get("partner"), function(data){
                      $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(3000).fadeOut(250).appendTo('body');
                      if(data.state){
                          setTimeout(function(){
                              window.parent.partnerModel.action("closeModPartner")()
                          },3000);
                      }
                  })
              },
              closeDiv:function(){
                  window.parent.partnerModel.action("closeModPartner")();
              }
          })
      })
  </script>
</body>
</html>
