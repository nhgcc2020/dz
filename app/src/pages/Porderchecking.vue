<template>
  <div>
    <div class="x-header">
      <back-header>
        <p class="title">采购对账单详情</p>
        <i class="iconfont sare" @click="ation">&#xe6e9;</i>
      </back-header>
    </div>
    <div class="big_first" style="overflow: hidden;">
      <ul class="ul_one">
        <li class="li_one">
          <span style="flex:1;" v-cloak>{{news.partnerShortname}}</span>
          <span>{{news.orderCycle}}</span>
        </li>
        <li class="li_two">
           <span style="color:#999;font-size:12px;flex:1;" v-cloak><i style="font-size:22px;border:1px solid #f2f3f5;border-radius:50%;position:relative;top:3px;" class="iconfont">&#xe6f4;</i>&nbsp;&nbsp; 订单&nbsp; <span style="font-family: 'arial';font-size:18px;color:#01a09a;position:relative;top:2px;">{{dataNo.length}}</span>&nbsp;&nbsp; 明细&nbsp; <span style="font-family: 'arial';font-size:18px;color:#01a09a;position:relative;top:2px;">{{datalist.length}}</span></span>
          <span style="color:#999;font-size:12px;" v-cloak><i style="font-size:22px;border:1px solid #f2f3f5;border-radius:50%;position:relative;top:3px;" class="iconfont">&#xe6f4;</i>&nbsp;&nbsp; 应付&nbsp; <span style="font-family: 'arial';font-size:18px;color:#ff6600;position:relative;top:2px;">{{news.receivablesMoney | money}}</span></span>
        </li>
        <li v-if="news.remarks" class="li_three">备注 : {{news.remarks}}</li>
      </ul>
      <div id="dingdan" v-for="(d,index) in datasumber" key="index">
        <div class="time">
          <span>
            <i class="iconfont">&#xe67b;</i>&nbsp;
            <span>{{d[0].purchaseNo}}</span>&nbsp;<span v-if="d[0].isReceived==1" style="color:#01a09a;font-size:14px;">已收货</span>
          </span>
          <span>
            <i class="iconfont">&#xe6f3;</i>&nbsp;
            <span>{{d[0].purchaseOrderDate}}</span>
          </span>
        </div>
        <ul class="ul_two" v-for="(l,index) in datasumber[index]" key="index">
          <li v-if="!l.businessDesc" style="color:#adadad;">无业务内容</li>
          <li v-if="l.businessDesc" v-cloak>{{l.businessDesc}}</li>
          <li v-if="!l.requirements"style="color:#ccc;padding:0.4rem 0;font-size:12px;color:#999;">无物料说明</li>
          <li v-if="l.requirements" v-cloak style="padding:0.4rem 0;font-size:12px;color:#999;">{{l.requirements}}</li>
          <li style="color: #999;padding-bottom: 0.5rem;border-bottom:1px solid #f9f9f9;font-size:12px;display:flex;" v-cloak>
            <span style="flex:1;">{{l.length}}m * {{l.width}}m</span>
            <span style="flex:0.5;">{{l.unitPrice | money}} x&nbsp;{{l.quantity}}</span>
            <span style="float:right;color:#eb6877;margin-right:1.1rem;">{{l.totalPrice | money}}</span>
          </li>
        </ul>
      </div>
      <ul class="ul_three">
        <li v-if="datalist.length>2" class="li_show" @click="montent">查看全部明细&nbsp;&nbsp; <i style="font-size:0.8rem;font-weight: 700;" class="iconfont">&#xe68a;</i></li>
        <li class="li_right"  style="color:#000;font-size:14px;padding:0;line-height:44px;">合计
          <span style="color:#eb6877;" v-cloak>{{news.price | money}}</span>
        </li>
        <li v-if="news.discount !== 0" class="li_right" style="color:#adadad;">&nbsp;&nbsp;&nbsp;&nbsp;折扣
          <span v-cloak>- {{news.discount | money}}</span>
        </li>
        <li v-if="news.preferential !==0" class="li_right" style="color:#adadad;">&nbsp;&nbsp;&nbsp;&nbsp;减免
          <span v-cloak>- {{news.preferential | money}}</span>
        </li>
        <li class="li_right" style="color:#adadad;">&nbsp;&nbsp;&nbsp;&nbsp;税款
          <span v-cloak>+ {{news.taxPrice | money}}</span>
        </li>
        <li style="border-top:1px solid #F6F6F6;line-height:44px;display:flex;font-size:14px;">
          <span v-cloak style="color:#000;flex:1;">账单金额</span>
          <p>
            <span style="color:#eb6877;margin-right:1.15rem;">{{news.totalPrice | money}}</span>
          </p>
        </li>
        <li class="li_right" style="color:#adadad;">&nbsp;&nbsp;&nbsp;&nbsp;预付
          <span v-cloak>- {{news.depositRequested | money}}</span>
        </li>
        <li style="border-top:1px solid #F6F6F6;line-height:44px;display:flex;font-size:14px;">
          <span style="color:#000;flex:1;" v-cloak>应付金额</span>
          <span style="margin-right:1.15rem;font-size:18px;color:#ff6600;font-family: 'arial';">{{news.receivablesMoney | money}}</span>
        </li>
      </ul>
      <ul class="ul_fore">
        <li>散单概要 : &nbsp;&nbsp;{{news.caseDesc}}</li>
        <li>对账单号 : &nbsp;&nbsp;{{news.purchasecheckingNo}}</li>
        <li>制单时间 : &nbsp;&nbsp;{{news.createTime}}</li>
        <li v-if="news.salescheckingNo" style="color:#adadad;">好友销售对账单号 : {{news.salescheckingNo}}</li>
      </ul>
      <div style="text-align: center;padding:1rem 0;color:#ccc;font-size:0.8rem;">——我是有底线的——</div>
      <div style="margin-left:1000px;" id="id_text">{{news.shareUrl}}</div>
      <div class="alt">
        <p>系统版本过低请手动复制</p>
        <p>{{news.shareUrl}}</p>
        <p @click="know">关闭</p>
      </div>
      <div class="cover"></div>
      <actionsheet v-model="show" :menus="menus1" :closeOnClickingMenu="false"></actionsheet>
    </div>
  </div>
</template>
<script>
import { Actionsheet, TransferDom } from 'vux';
import BackHeader from '../common/BackHeader';
import address from '../url.js';
import Clipboard from 'clipboard';
import $ from 'jquery';
export default {
  directives: {
    TransferDom
  },
  components: {
    BackHeader,
    Actionsheet
  },
  data() {
    return {
      show: false,
      showContent004: false,
      news: "",
      datalist: "",
      datasumber: [],
      dataNo: [],
      sumber: "",
      menus1: [{
        label: '<span style="color:#000;font-size:14px;">转发对账单详情</span><p style="color:#999999;font-size:12px;padding:8px 0;">通过QQ、微信将订单发送给对方<br/>随时沟通，随时确认</p><span class="alart" style="color:#fff;font-size:14px;background:#000; position: absolute;left:31%;top:5px;width:120px;padding:10px;border-radius:5px;opacity:0.8;display:none;">复制成功</span>',
        type: 'info'
      }, {
        label: '<div style="display: flex;justify-content: center;width:80%;margin:0 auto;"><div style="width:33%;display: inline-block;"><p id="id_copy" data-clipboard-target="#id_text" data-clipboard-action="copy" style="background:#cdcdcd;width:50px; border:none; height:50px;border-radius:50%;line-height:50px;margin:5px auto;"><i class="iconfont" style="color:#fff;font-size:40px;">&#xe6ba;</i></p><p style="color:#999999;font-size:12px;">复制订单链接</p></div><div style="width:33%;display: inline-block;"><p id="weixin" style="background:#03cb0b;width:50px; border:none; height:50px;border-radius:50%;line-height:50px; margin:5px auto;"><i class="iconfont" style="color:#fff;font-size:50px;">&#xe6ce;</i></p><p style="color:#999999;font-size:12px;">微信</p></div><div style="width:33%;display: inline-block;"><p id="QQ" style="background:#02abec;width:50px; border:none; height:50px;border-radius:50%;line-height:50px; margin:5px auto;"><i class="iconfont" style="color:#fff;font-size:40px;">&#xe6d9;</i></p><p style="color:#999999;font-size:12px;">QQ</p></div></div></div>',
        type: 'info'
      }, {
        label: '<p style="font-size:14px;border:1px solid #ccc;width:90%;height:38px;line-height:38px;margin:0 auto;border-radius:5px;">取消</p>'
      }]
    }
  },
  created() {
    this.getInfo();
  },
  methods: {
    getInfo() {
      var _this = this;
      var params = "purchasecheckingNo=" + this.$route.params.salesNo;
      // params.append('salesNo',this.$route.params.salesNo);
      this.axios.post(address.porderchecking + localStorage.getItem('token'), params)
        .then(function (data) {
          //  debugger;
          _this.news = data.data;
          _this.datalist = data.data.details;
          _this.sumber = _this.datalist[0].purchaseNo;
          var arr = [];
          for (var j = 0; j < _this.datalist.length; j++) {
            if (_this.datalist[j].purchaseNo == _this.sumber) {
              arr.push(_this.datalist[j]);
            } else {
              _this.dataNo.push(arr);
              arr = [];
              _this.sumber = _this.datalist[j].purchaseNo;
              arr.push(_this.datalist[j]);
            }
          }
          _this.dataNo.push(arr);
          if (_this.datalist.length > 1) {
            var arrone = [];
            if (_this.dataNo[0].length > 2) {
              for (var i = 0; i < 2; i++) {
                arrone.push(_this.dataNo[0][i]);
              }
              _this.datasumber.push(arrone)
            } else {
              arrone = []
              arrone.push(_this.dataNo[1][0]);
              _this.datasumber.push(_this.dataNo[0]);
              _this.datasumber.push(arrone);
            }
          } else {
            _this.datasumber = _this.dataNo;
          }
        })
        .catch(function (err) {
        })
    },
    montent() {
      this.datasumber = this.dataNo;
      $(".li_show").hide();
    },
    ation() {
      var _this = this;
      this.show = true;
      $("#weixin").click(function () {
        Wechat.share({
          message: {
            title: "您有一张对账单",
            description: "【订单周期" + _this.news.orderCycle + "】对账单金额" + parseFloat(_this.news.totalPrice).toFixed(2) + "，请点击查看详情",
            thumb: "https://www.yiduizhang.com/images/login/xhdpi.png",
            media: {
              type: Wechat.Type.LINK,
              webpageUrl: _this.news.shareUrl
            }
          },
          scene: Wechat.Scene.SESSION   // share to Timeline
        }, function () {
          // alert("Success");
        }, function (reason) {
          // alert("Failed: " + reason);
        });
      })
      $("#QQ").click(function () {
        var args = {};
        args.client = QQSDK.ClientType.QQ;//QQSDK.ClientType.QQ,QQSDK.ClientType.TIM; 
        args.scene = QQSDK.Scene.QQ;//QQSDK.Scene.QQZone,QQSDK.Scene.Favorite 
        args.url = _this.news.shareUrl;
        args.title = "您有一张对账单";
        args.description = "【订单周期" + _this.news.orderCycle + "】对账单金额" + parseFloat(_this.news.totalPrice).toFixed(2) + "，请点击查看详情";
        args.image = 'https://www.yiduizhang.com/images/login/xhdpi.png';
        QQSDK.shareNews(function () {
          // alert('shareNews success');
        }, function (failReason) {
          // alert(failReason);
        }, args);
      })
    },
    know() {
      $(".alt").hide();
      $(".cover").hide();
    }
  }
}
$(function () {
  var clipboard = new Clipboard("#id_copy");
  clipboard.on("success", function (element) {
    $(".alart").fadeIn(250).delay(500).fadeOut(250);
  });
  clipboard.on("error", function (element) {
    $(".alart").text("复制失败").fadeIn(250).delay(500).fadeOut(250);
    setTimeout(function () {
      $(".alt").fadeIn(250);
      $(".cover").fadeIn(250);
    }, 1000);
  })
})
</script>
<style scoped>
#dingdan{
  padding-left:1.2rem;
  background:#fff;
  font-size: 0.9rem;
  border-top:1px solid #ccc;
}
#dingdan:nth-child(2){
  border-top:none;
}
.ul_one {
  position: relative;
  margin-bottom: 0.7rem;
  background: #fff;
  font-size: 0.8rem;
  color: #4f4f4f;
  padding: 0 1.1rem;
  overflow: hidden;
}
.li_two{
  display: flex;
  padding-bottom: 1rem;
}
.li_two span:nth-child(1) {
  color: #adadad;
  font-size: .9rem;
}
.li_two p {
  position: relative;
  float: right;
}
.li_one{
  margin-top: 10px;
  display: flex;
}
.li_one>span {
    font-size: 0.9rem;
    color:#666;
  }
.li_two p span:nth-child(1) {
    position: absolute;
    right: 0rem;
    top: -3px;
    font-size: 1.1rem;
    color: #d80404;
  }
.dingdan{
    position: absolute;
    top:0.7rem;
    font-size: 1rem;
    left: 2rem;
  }
.time>span:nth-child(1){
    display: inline-block;
  }
.time>span:nth-child(2){
  float: right;
  margin-right: 1rem;
}
.time>span>span{
  position: relative;
  top: -0.2rem;
  font-size: 12px;
}
.li_three{
  border-top: 1px solid #F6F6F6;
  padding: 1rem 0;
  color: #adadad;
}
.ul_two{
  font-size: 14px;
  /*padding-left: 1.2rem;*/
  padding-top: 0.6rem;
  background: #fff;
}
.ul_two li:nth-child(1){
  width: 95%;
}
.ul_two li:nth-child(3){
  color: #adadad;
  border-bottom: 1px solid #F6F6F6;
  padding-bottom: 0.5rem;
}
.big_first>div>.ul_two:last-child>li:nth-child(3) {
  border:0 !important;
}
.ul_three{
  border-top: 1px solid #F6F6F6;
  background: #fff;
  font-size: 0.9rem;
  padding-left: 1.2rem;
}
.li_show{
  text-align: center;
  color: #2e8ae6;
  padding: 0.3rem 0 0.6rem 0;
  font-size: 0.8rem;
}
.li_right{
  padding-bottom: 0.3rem;
  font-size: 12px;
  color:#999;
}
.li_right span{
  float: right;
  margin-right: 1.15rem;
}
.ul_fore{
  margin-top:0.7rem;
  background: #fff;
  padding-left:1.2rem;
  padding-bottom:0.5rem;
}
.ul_fore li i{
  font-size: 1.5rem;
}
.ul_fore li{
  font-size: 12px;
  padding-top: 10px;
}
.time{
  background: #fff;
  border-bottom: 1px solid #F6F6F6;
  color:#01a09a;
}
.time i{
  font-size: 1.5rem;
}
.alt{
    display: none;
    position: absolute;
    top: 20%;
    width: 70%;
    margin: 0 auto;
    left: 15%;
    right: 15%;
    background: #fff;
    border-radius: 0.5rem;
    z-index: 1100;
}
.alt p:nth-child(1){
    text-align: center;
    padding-top: 1rem;
}
.alt p:nth-child(2){
    font-size: 0.9rem;
    padding: 1rem;
    word-wrap:break-word;
}
.alt p:nth-child(3){
    padding:0.5rem 0;
    text-align: center;
    color: #4284d9;
    border-top: 1px solid #ccc;
}
.cover {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 110%;
    opacity: 0.2;
    z-index: 500;
    background: #000;
    display: none;
}
.vux-header {
  background: #4284d9;
}
</style>
