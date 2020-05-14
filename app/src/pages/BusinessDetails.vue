<template>
  <div>
    <div class="x-header">
      <back-header>
        <p class="title">详情</p>
        <p class="saretxt" @click="ation">转发报价清单</p>
      </back-header>
    </div>
    <div class="big_first">
      <div class="progress">
        <x-progress :percent="percent1" :show-cancel="false" style="flex:1;"></x-progress>
        <p style="font-size:12px;color:#4284d9;margin-left:47px;" @click="adjust">调整阶段</p>
      </div>
      <div class="businessName">
        <p style="display:flex;margin-top:3px;">
          <i style="font-size:30px;color:#999;" class="iconfont">&#xe687;</i>&nbsp;
          <span style="font-size:14px;color:#333;display:inline-flex;align-items:center;">{{news.oppoDesc | incision}}</span>
        </p>
        <p style="display:flex;padding-right:22px;margin-top:-15px;">
          <i style="font-size:30px;color:#999;" class="iconfont">&#xe70c;</i>&nbsp;
          <span style="font-size:14px;color:#999;flex:1;display:inline-flex;align-items:center;">{{news.partnerShortname}}</span>
          <i v-if="(/^1[34578]\d{9}$/.test(news.contactTel))" style="font-size:30px;color:#4284d9;" class="iconfont" @click="callphone(news.contactTel)">&#xe683;</i>
        </p>
        <p class="item_p">
          <div v-if="!news.startDate" style="font-size:12px;color:#ccc;margin-top:9px;">项目时间： 无</div>
          <div v-if="news.startDate" style="font-size:12px;color:#999;margin-top:9px;">项目时间：{{news.startDate}}&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;{{news.endDate}}</div>
          <div style="font-size:12px;color:#999;margin-bottom:9px;margin-top:5px;">销售： {{news.salesName}}</div>
        </p>
      </div>
      <div v-if="chitchat.length==0" class="record">
        <router-link tag="p" :to="'/record/'+$route.params.oppoNo">
          <i class="iconfont" style="font-size:30px;color:#999;position:absolute;top:0px;">&#xe6ee;</i>
          <span style="margin-left:35px;">跟进记录</span>
          <i class="iconfont" style="float:right;font-size:14px;color:#ccc;">&#xe68b;</i>
        </router-link>
        <p>可让销售或跟进人发布商机最新进展情况，方便参与者了解</p>
      </div>
      <div v-if="chitchat.length!=0" class="record">
        <router-link tag="p" :to="'/record/'+$route.params.oppoNo">
          <i class="iconfont" style="font-size:30px;color:#4284d9;position:absolute;top:0px;">&#xe6ee;</i>
          <span style="margin-left:35px;">跟进记录</span>
          <i class="iconfont" style="float:right;font-size:14px;color:#ccc;">&#xe68b;</i>
        </router-link>
        <ul>
          <li v-for="(c,index) in chitchat">
            <span style="color:#4284d9;">{{c.chatEmployeeName | spenderName}}：</span>{{c.chatContent | chitcount}}</li>
        </ul>
      </div>
      <div v-if="!binding" class="record">
        <p>
          <i class="iconfont" style="font-size:30px;color:#999;position:absolute;top:1px;">&#xe71f;</i>
          <span style="margin-left:35px;">报价</span>
        </p>
        <p style="display:flex;color:#999;">
          <span style="flex:1;">报价次数 &nbsp;&nbsp;
            <span style="font-family: 'arial';font-size:18px;">0</span>
          </span>
          <span>报价金额 &nbsp;&nbsp;
            <span style="font-family: 'arial';font-size:18px;">0.00</span>
          </span>
        </p>
      </div>
      <div v-if="binding" class="quote">
        <p style="margin: 14px 0 10px;">
          <span style="flex:1;">
            <i class="iconfont" style="font-size:30px;color:#f26628;position:absolute;top:1px;">&#xe71f;</i>
            <span style="margin-left:35px;color:#333;">{{details.versionName}}</span>
          </span>
          <span style="font-size:12px;color:#4284d9;" @click="rests">查看其它报价</span>
        </p>
        <p style="margin-bottom: 17px;font-size:12px;">
          <span style="flex:1;">报价次数 &nbsp;&nbsp;
            <span style="font-family:'arial';font-size:18px;color:#01a09a;">{{Vlist.length}}</span>
          </span>
          <span>报价金额 &nbsp;&nbsp;
            <span style="font-family: 'arial';font-size:18px;color:#ff6600;">{{details.totalPrice | filmoney}}</span>
          </span>
        </p>
      </div>
      <div>
        <ul class="ul_two" v-for="(l,index) in datasumber" key="index">
          <li v-if="!l.businessDesc" style="color:#ccc;">无业务内容</li>
          <li v-if="l.businessDesc">{{l.businessDesc}}</li>
          <li v-if="!l.specification" style="color:#ccc;padding:0.4rem 0;font-size:12px;color:#999;">无相关描述</li>
          <li v-if="l.specification" style="padding:0.4rem 0;font-size:12px;color:#999;">{{l.specification}}</li>
          <li style="color: #999;padding-bottom: 0.5rem;border-bottom:1px solid #f9f9f9;font-size:12px;display:flex;" v-cloak>
            <span style="flex:0.3;">{{l.unitPrice | money}}</span>
            <span style="flex:0.3;">x{{l.quantity}}</span>
            <span style="flex:0.4;padding-right:22px;text-align:right;color:#ed7784;">{{l.totalPrice | filmoney}}</span>
          </li>
        </ul>
      </div>
      <ul v-if="binding" class="ul_three">
        <li v-if="datalist.length>2" class="li_show" @click="montent">查看全部明细&nbsp;&nbsp;
          <i style="font-size:0.8rem;font-weight: 700;" class="iconfont">&#xe68a;</i>
        </li>
        <li class="li_right" style="color:#000;font-size:14px;border-top: 1px solid #F6F6F6;padding-top:0.3rem;">合计
          <span style="color:#eb6877;" v-cloak>{{details.price | money}}</span>
        </li>
        <li v-if="details.discount" class="li_right" style="color:#adadad;">&nbsp;&nbsp;&nbsp;&nbsp;折扣
          <span v-cloak>- {{details.discount | money}}</span>
        </li>
        <li v-if="details.taxPrice" class="li_right" style="color:#adadad;">&nbsp;&nbsp;&nbsp;&nbsp;税款
          <span v-cloak>+ {{details.taxPrice | money}}</span>
        </li>
        <li v-if="details.preferential" class="li_right" style="color:#adadad;">&nbsp;&nbsp;&nbsp;&nbsp;减免
          <span v-cloak>- {{details.preferential | money}}</span>
        </li>
        <li style="border-top:1px solid #F6F6F6;line-height:44px;display:flex;font-size:14px;">
          <span style="color:#000;flex:1;">报价金额</span>
          <span style="margin-right:1.15rem;font-size:18px;color:#ff6600;">{{details.totalPrice | money}}</span>
        </li>
        <li style="font-size:14px;color:#999;text-align:right;margin:-5px 1.15rem 13px 0;">{{details.totalPrice | capital}}</li>
      </ul>
      <ul class="ul_fore">
        <li>报价备注 :&nbsp;&nbsp; {{details.remarks}}</li>
        <li>项目类型 :&nbsp;&nbsp; {{news.oppoTypeDesc}}</li>
        <li style="line-height:21px;">项目地址 :&nbsp;&nbsp; {{news.address}}</li>
        <li>制单时间 :&nbsp;&nbsp; {{news.createTime}}</li>
        <li>报价单号 :&nbsp;&nbsp; {{news.oppoNo}}</li>
      </ul>
      <div style="text-align: center;padding:1rem 0;color:#ccc;font-size:.8rem;">——我是有底线的——</div>
      <div class="release">
        <i class="iconfont">&#xe6ee;</i>
        <input type="text" placeholder="填写最新的进展情况" v-model="chatcount">
        <span @click="announce">发布</span>
      </div>
      <div style="opacity:0;" id="id_text">{{url}}</div>
      <div class="alt">
        <p>系统版本过低请手动复制</p>
        <p>{{url}}</p>
        <p @click="know">关闭</p>
      </div>
      <ul class="foot_quit">
        <li @click="stage(0)" class="pitch">商机</li>
        <li @click="stage(1)">需求报价</li>
        <li @click="stage(2)">谈判</li>
        <li @click="stage(3)">赢单</li>
        <li @click="stage(4)">输单</li>
        <li style="color:#ccc;border-top:1px solid #f2f2f2;" @click="conceal">取消</li>
      </ul>
      <div class="edition">
        <ul style="height:200px;overflow:auto;background:#fff;">
          <li v-for="(v,index) in Vlist" @click="Version(index,v.quotationNo)" :class="{pitch:v.isDefault==1}" style="position:relative;">{{v.versionName}}
            <span v-if="v.isDefault==1" style="font-size:12px;color:#999;position:absolute;right:27%;top:10px;">默认报价</span>
          </li>
        </ul>
        <p style="color:#ccc;border-top:1px solid #f2f2f2;line-height:40px;text-align:center;background:#fff;" @click="conceal">取消</p>
      </div>
      <div class="cover" @click="conceal"></div>
      <actionsheet v-model="show" :menus="menus1" :closeOnClickingMenu="false"></actionsheet>
    </div>
    <div v-show="show1" class="art">
      <p>确定要打电话吗？</p>
      <p>
        <span class="none" @click="none">取消</span>
        <span class="know" @click="confirm">确定</span>
      </p>
    </div>
    <div class="error_tips">没有数据...</div>
    <div v-if="showding" class="la-timer" style="position: absolute;top:45%;left:45%;">
            <div></div>
        </div>
  </div>
</template>
<script>
import { Actionsheet, XProgress, TransferDom } from 'vux';
import BackHeader from '../common/BackHeader';
import Clipboard from 'clipboard';
import $ from 'jquery';
import address from '../url.js';
export default {
  directives: {
    TransferDom
  },
  components: {
    BackHeader,
    Actionsheet,
    XProgress
  },
  data() {
    return {
      percent1: 11,
      show: false,
      show1: false,
      showContent004: false,
      reminder:false,
      Vlist: "",
      news: "",
      showding:true,
      chitchat: "",
      chatcount: "",
      details: "",
      quotationNo: "",
      url: "",
      binding: "",
      phone: "",
      datalist: [],
      datasumber: [],
      menus1: [{
        label: '<span style="color:#000;font-size:14px;">转发订单详情</span><p style="color:#999999;font-size:12px;padding:8px 0;">通过QQ、微信将订单发送给对方<br/>随时沟通，随时确认</p><span class="alart" style="color:#fff;font-size:14px;background:#000; position: absolute;left:31%;top:5px;width:120px;padding:10px;border-radius:5px;opacity:0.8;display:none;">复制成功</span>',
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
    this.getChat();
  },
  mounted() {
    $(".weui-progress__inner-bar").html("<span class='circle'>商机</span>");
  },
  methods: {
    getInfo() {
      var params = "&oppoNo=" + this.$route.params.oppoNo;
      this.axios.get(address.businessdetails + localStorage.getItem('token') + params)
        .then(data => {
          this.news = data.data.data;
          switch (this.news.orderSection) {
            case "01":
              this.percent1 = 11
              $(".weui-progress__inner-bar").html("<span class='circle'>商机</span>");
              $(".weui-progress__inner-bar").removeClass("color_two color_one");
              $(".foot_quit li").eq(0).addClass("pitch").siblings().removeClass("pitch");
              break;
            case "02":
              this.percent1 = 33
              $(".weui-progress__inner-bar").html("<span class='circle'>报价</span>");
              $(".weui-progress__inner-bar").removeClass("color_two color_one");
              $(".foot_quit li").eq(1).addClass("pitch").siblings().removeClass("pitch");
              break;
            case "03":
              this.percent1 = 66
              $(".weui-progress__inner-bar").html("<span class='circle'>谈判</span>");
              $(".weui-progress__inner-bar").removeClass("color_two color_one");
              $(".foot_quit li").eq(2).addClass("pitch").siblings().removeClass("pitch");
              break;
            case "04":
              this.percent1 = 100
              $(".weui-progress__inner-bar").html("<span class='circle' style='background:#01a09a;'>赢单</span>");
              $(".weui-progress__inner-bar").removeClass("color_two");
              $(".weui-progress__inner-bar").addClass("color_one");
              $(".foot_quit li").eq(3).addClass("pitch").siblings().removeClass("pitch");
              break;
            case "05":
              this.percent1 = 100
              $(".weui-progress__inner-bar").html("<span class='circle' style='background:#ff9900;'>输单</span>");
              $(".weui-progress__inner-bar").removeClass("color_one");
              $(".weui-progress__inner-bar").addClass("color_two");
              $(".foot_quit li").eq(4).addClass("pitch").siblings().removeClass("pitch");
              break;
          }
        })
        .catch(err => {

        });
      var params = "&oppoNo=" + this.$route.params.oppoNo;
      this.axios.get(address.versionslist + localStorage.getItem('token') + params)
        .then(data => {
          this.Vlist = data.data.data;
          this.showding = false;
          for (var i = 0; i < data.data.data.length; i++) {
            if (data.data.data[i].isDefault == 1) {
              this.quotationNo = data.data.data[i].quotationNo;
              this.getVersion(this.quotationNo);
            }
          }
        })
        .catch(err => {

        });
      this.axios.get(address.querone + localStorage.getItem('token') + "&orderNo=" + this.$route.params.oppoNo)
        .then(data => {
          this.url = data.data.shareUrl;
        })
        .catch(err => {

        })
    },
    getChat() {
      this.axios.get(address.chatlist + localStorage.getItem('token') + "&oppoNo=" + this.$route.params.oppoNo + "&page=1&rows=2")
        .then(data => {
          this.chitchat = data.data.rows;
        })
        .catch(err => {

        });
    },
    getVersion(quotationNo) {
      var params = "&quotationNo=" + quotationNo;
      this.axios.get(address.versiondetails + localStorage.getItem('token') + params)
        .then(data => {
          if (data.data.code==1){
            this.details = data.data.data;
            this.datalist = data.data.data.details;
            this.datasumber = [];
            if(this.reminder){
              $(".error_tips").html("报价版本切换成功").fadeIn(250).delay(800).fadeOut(250);
            }
            if (data.data.data.details.length > 2) {
              for (var i = 0; i < 2; i++) {
                this.datasumber.push(data.data.data.details[i]);
              }
            } else {
              this.datasumber = this.datalist;
            }
            this.binding = "1";
            $(".li_show").show();
          }
        })
        .catch(err => {

        });
    },
    adjust() {
      $(".cover").show();
      $(".foot_quit").slideDown("fast");
    },
    stage(i) {
      switch (i) {
        case 0:
          this.percent1 = 11
          $(".weui-progress__inner-bar").html("<span class='circle'>商机</span>");
          $(".weui-progress__inner-bar").removeClass("color_two color_one");
          break;
        case 1:
          this.percent1 = 33
          $(".weui-progress__inner-bar").html("<span class='circle'>报价</span>");
          $(".weui-progress__inner-bar").removeClass("color_two color_one");
          break;
        case 2:
          this.percent1 = 66
          $(".weui-progress__inner-bar").html("<span class='circle'>谈判</span>");
          $(".weui-progress__inner-bar").removeClass("color_two color_one");
          break;
        case 3:
          this.percent1 = 100
          $(".weui-progress__inner-bar").html("<span class='circle' style='background:#01a09a;'>赢单</span>");
          $(".weui-progress__inner-bar").removeClass("color_two");
          $(".weui-progress__inner-bar").addClass("color_one");
          break;
        case 4:
          this.percent1 = 100
          $(".weui-progress__inner-bar").html("<span class='circle' style='background:#ff9900;'>输单</span>");
          $(".weui-progress__inner-bar").removeClass("color_one");
          $(".weui-progress__inner-bar").addClass("color_two");
          break;
      }
      $(".cover").hide();
      $(".foot_quit").slideUp("fast");
      $(".foot_quit li").eq(i).addClass("pitch").siblings().removeClass("pitch");
      this.axios.get(address.businessmoment + localStorage.getItem('token') + "&oppoNo=" + this.$route.params.oppoNo + "&orderSection=0" + (i + 1))
        .then(data => {
          if (data.data.code == 1) {
            $(".error_tips").html("调整成功").fadeIn(250).delay(800).fadeOut(250);
          }
        })
        .catch(err => {

        });
    },
    Version(i, ve) {
      $(".cover").hide();
      $(".edition").slideUp("fast");
      $(".edition li").eq(i).addClass("pitch").siblings().removeClass("pitch");
      this.quotationNo = ve;
      this.reminder = true;
      this.getVersion(this.quotationNo);
    },
    rests() {
      $(".cover").show();
      $(".edition").slideDown("fast");
    },
    conceal() {
      $(".cover").hide();
      $(".foot_quit").slideUp("fast");
      $(".edition").slideUp("fast");
    },
    callphone(tel) {
      this.show1 = true;
      this.phone = tel;
      $(".cover").show();
    },
    none() {
      this.show1 = false;
      $(".cover").hide();
    },
    confirm() {
      window.location.href = 'tel:' + this.phone;
      this.show1 = false;
      $(".cover").hide();
    },
    montent() {
      this.datasumber = this.datalist;
      $(".li_show").hide();
    },
    announce() {
      if (this.chatcount) {
        this.axios.post(address.chatsave + localStorage.getItem('token'), { "oppoNo": this.$route.params.oppoNo, "chatContent": this.chatcount }, { headers: { 'Content-Type': 'application/json' } })
          .then(data => {
            if (data.data.code == 1) {
              $(".error_tips").html("发布成功").fadeIn(250).delay(800).fadeOut(250);
              this.chatcount = "";
              this.getChat();
            }
          })
          .catch(err => {

          })
      } else {
        $(".error_tips").html("内容不能为空").fadeIn(250).delay(800).fadeOut(250);
      }
    },
    ation() {
      var _this = this
      this.show = true;
      $("#weixin").click(function () {
        Wechat.share({
          message: {
            title: "您有一张订单",
            description: "【业务时间" + _this.news.orderDate + "】订单金额" + parseFloat(_this.news.totalPrice).toFixed(2) + "，请点击查看详情",
            thumb: "https://www.yiduizhang.com/images/login/xhdpi.png",
            media: {
              type: Wechat.Type.LINK,
              webpageUrl: _this.url
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
        args.url = _this.url;
        args.title = "您有一张订单";
        args.description = "【业务时间" + _this.news.orderDate + "】订单金额" + parseFloat(_this.news.totalPrice).toFixed(2) + "，请点击查看详情";
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
  clipboard.on("success", function (e) {
    $(".alart").fadeIn(250).delay(500).fadeOut(250);
    e.clearSelection();
  });
  clipboard.on("error", function (e) {
    $(".alart").text("复制失败").fadeIn(250).delay(500).fadeOut(250);
    setTimeout(function () {
      $(".alt").fadeIn(250);
      $(".cover").fadeIn(250);
    }, 1000);
  })
})
</script>
<style scoped>
.big_first {
  overflow: hidden;
}

.progress {
  display: flex;
  box-sizing: border-box;
  padding: 0 22px;
  line-height: 46px;
  background: #fff;
  border-bottom: 1px solid #f2f2f2;
}

.strip {
  height: 10px;
  background: #ccc;
}

.weui-progress__inner-bar {
  position: relative;
  background-color: #f26628!important;
}

.li_two p span:nth-child(2) {
  font-size: 1.1rem;
  color: #d80404;
}

.dingdan {
  position: absolute;
  top: 0.7rem;
  font-size: 1rem;
  left: 2rem;
}

.li_two {
  display: flex;
  padding-bottom: 1rem;
}

.li_two span:nth-child(1) {
  color: #adadad;
  font-size: 0.9rem;
}

.li_two p {
  position: relative;
  line-height: 18px;
}

.li_three {
  border-top: 1px solid #F6F6F6;
  padding: 0.5rem 0;
  color: #adadad;
}

.ul_two {
  font-size: 14px;
  padding-left: 1.2rem;
  padding-top: 0.6rem;
  background: #fff;
}

.ul_two li:nth-child(1) {
  width: 95%;
}

.big_first .ul_two:first-child>li {
  border: none;
}

.ul_three {
  background: #fff;
  font-size: 0.9rem;
  padding-left: 1.2rem;
  overflow: hidden;
}

.li_show {
  text-align: center;
  color: #2e8ae6;
  padding: 0.3rem 0 0.6rem 0;
  font-size: .8rem;
}

.li_right {
  padding-bottom: 0.3rem;
  font-size: 12px;
  color: #999;
}

.li_right span {
  float: right;
  margin-right: 1.15rem;
}

.ul_fore {
  margin-top: 0.7rem;
  background: #fff;
  padding:0 1.2rem 0.5rem 1.2rem;
}

.ul_fore li i {
  font-size: 1.5rem;
}

.ul_fore li {
  font-size: 12px;
  padding-top: 10px;
  color: #999;
}

.big_first>div>.ul_two:last-child>li:nth-child(3) {
  border: 0 !important;
}

.alt {
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

.alt p:nth-child(1) {
  text-align: center;
  padding-top: 1rem;
}

.alt p:nth-child(2) {
  font-size: 0.9rem;
  padding: 1rem;
  word-wrap: break-word;
}

.alt p:nth-child(3) {
  padding: 0.5rem 0;
  text-align: center;
  color: #4284d9;
  border-top: 1px solid #ccc;
}

.pitch {
  color: #4284d9!important;
}

.record,
.quote {
  box-sizing: border-box;
  padding: 0 22px;
  background: #fff;
  margin-bottom: 10px;
  position: relative;
  overflow: hidden;
}

.record p:nth-child(1) {
  font-size: 14px;
  color: #333;
  margin: 14px 0 10px;
}

.record p:nth-child(2) {
  font-size: 12px;
  color: #ccc;
  margin-bottom: 17px;
}

.record ul {
  margin-bottom: 17px;
}

.record li {
  font-size: 12px;
  color: #999;
}

.quote {
  margin-bottom: 0px;
  border-bottom: 1px solid #f2f2f2;
}

.quote p {
  display: flex;
  font-size: 14px;
  color: #999;
}

.release {
  position: fixed;
  width: 100%;
  height: 50px;
  background: #fff;
  bottom: 0;
  border-top: 1px solid #f2f2f2;
}

.release i {
  position: relative;
  top: 2px;
  font-size: 30px;
  color: #999;
  margin: 0 10px 0 15px;
}

.release input {
  height: 30px;
  width: 68%;
  border: 1px solid #f2f2f2;
  border-radius: 3px;
  position: relative;
  top: -5px;
  box-sizing: border-box;
  padding-left: 10px;
  font-size: 14px;
}

.release span {
  position: relative;
  top: -5px;
  font-size: 14px;
  color: #4284d9;
  margin-left: 15px;
}

.cover {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0.2;
  z-index: 500;
  background: #000;
  display: none;
}

.saretxt {
  position: absolute;
  font-size: 14px;
  color: #fff;
  top: 0px;
  right: 15px;
}

.foot_quit,
.edition {
  position: fixed;
  bottom: 0;
  width: 100%;
  display: none;
  z-index: 999;
}

.foot_quit li,
.edition li {
  display: flex;
  height: 40px;
  background: #fff;
  align-items: center;
  justify-content: center;
}

.businessName {
  overflow: hidden;
  box-sizing: border-box;
  padding: 0 22px;
  background: #fff;
  margin-bottom: 10px;
}

.item_p {
  padding-right: 22px;
  border-top: 1px solid #f2f2f2;
}

.art {
  position: fixed;
  top: 33%;
  width: 83%;
  margin: 0 auto;
  left: 9%;
  right: 9%;
  background: #fff;
  border-radius: 0.5rem;
  z-index: 1100;
  font-size: 1.2rem;
}

.know {
  padding: .8rem 0;
  display: inline-block;
  width: 48%;
  text-align: center;
}

.none {
  padding: .8rem 0;
  display: inline-block;
  width: 48%;
  text-align: center;
  border-right: 1px solid #F6F6F6;
}

.art p:nth-child(1) {
  text-align: center;
  padding: 2rem 0;
}

.art p:nth-child(2) {
  text-align: center;
  color: #4284d9;
  border-top: 1px solid #F6F6F6;
}

.error_tips {
  position: fixed;
  height: 4rem;
  line-height: 4rem;
  top: 50%;
  width: 70%;
  margin: 0 auto;
  left: 15%;
  right: 15%;
  background: #000;
  border-radius: 0.5rem;
  z-index: 1100;
  opacity: 0.7;
  display: none;
  color: #fff;
  text-align: center;
}
</style>