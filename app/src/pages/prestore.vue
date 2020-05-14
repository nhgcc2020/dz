<template>
  <div style="overflow: hidden;">
    <div class="x-header">
      <back-header>
        <p class="title">{{$route.params.partnerShortname}}</p>
      </back-header>
    </div>
    <div class="quit_time">
      <span style="color:#ff6600;" @click="client" :class="{ anchor_col: !show3 }">{{clientele}}
        <i v-if="show3" class="iconfont" style="font-size:12px;margin-left:4px;color: #999;">&#xe68d;</i>
        <i v-if="!show3" class="iconfont" style="font-size:12px;margin-left:4px;color:#4284d9;">&#xe68e;</i>
      </span>
      <span @click="select" :class="{ anchor_col: !show2 }">
        <span>{{value1}}</span> -
        <span>{{value2}}</span>
        <i v-if="show2" class="iconfont" style="font-size:12px;margin-left:4px;color: #999;">&#xe68d;</i>
        <i v-if="!show2" class="iconfont" style="font-size:12px;margin-left:4px;color:#4284d9;">&#xe68e;</i>
      </span>
    </div>
    <div class="anchor">
      <p @click="record(0)" class="default">充值记录</p>
      <p @click="record(1)">消费记录</p>
    </div>
    <div class="side">
      <ul>
        <li @click="chose(0)">全部时间段</li>
        <li @click="chose(1)">上月</li>
        <li @click="chose(2)" class="default">本月</li>
        <li @click="chose(3)">第一季度</li>
        <li @click="chose(4)">第二季度</li>
        <li @click="chose(5)">第三季度</li>
        <li @click="chose(6)">第四季度</li>
        <li @click="chose(7)">上半年</li>
        <li @click="chose(8)">下半年</li>
        <li @click="chose(9)">今年</li>
        <li @click="chose(10)">去年</li>
      </ul>
      <div @click="custom()" style="height:50px;line-height:50px;text-align:center;border-top:1px solid #e9e9e9;">自定义时间</div>
    </div>
    <div v-if="index==0">
      <div class="totalMoney">
        <p>充值总金额</p>
        <p>&yen;
          <span style="font-family:'arial';font-size:22px;">{{totalMoney | filmoney}}</span>
        </p>
      </div>
      <div class="recharge_title">
          <span>收</span>&nbsp;&nbsp;充值明细
      </div>
      <v-scroll :on-refresh="onRefresh" :on-infinite="onInfinite" :dataList="scrollData">
        <ul class="recharge_ul">
          <li v-for="(n,i) in news" key="i">
            <div style="width:22px;font-size:14px;color:#ccc;text-align:center;">{{i+1}}</div>
            <div style="flex:1;border-bottom:1px solid #f9f9f9;margin-left:10px;">
              <p style="margin-top:10px;font-size:16px;">{{n.rechargeDate}}</p>
              <p v-if="n.rechargeType" style="font-size:14px;color:#999;margin-top:7px;">{{n.rechargeType}}</p>
              <p v-if="!n.rechargeType" style="font-size:14px;color:#ccc;margin-top:7px;">无充值方式</p>
            </div>
            <div v-if="n.presentMoney" style="border-bottom:1px solid #f9f9f9;padding-right:25px;font-family:'arial';font-size:18px;">
              <p style="margin-top:5px;color:#ff6600;"><span style="display:inline-block;width:20px;height:20px;margin-right:2px;"></span><i class="iconfont">&#xe6a1;</i> {{n.rechargeMoney | filmoney}}</p>
              <p style="color:#999;margin-top:3px;text-align:right;"><span style="font-size:12px;color:#999;display:inline-block;height:20px;width:20px;line-height:20px;border-radius:50%;background:#f2f2f2;text-align:center;margin-right:2px;position:relative;top:-2px;">赠</span><i class="iconfont">&#xe6a1;</i> {{n.presentMoney | filmoney}}</p>
            </div>
            <div v-if="!n.presentMoney" style="border-bottom:1px solid #f9f9f9;padding-right:25px;font-family:'arial';font-size:18px;color:#ff6600;">
              <i class="iconfont">&#xe6a1;</i> {{n.rechargeMoney | filmoney}}
            </div>
          </li>
        </ul>
      </v-scroll>
    </div>
    <div v-if="index==1">
      <div class="totalMoney">
        <p>消费总金额</p>
        <p style="color:#37affd;">&yen;
          <span style="font-family:'arial';font-size:22px;">{{totalMoney | filmoney}}</span>
        </p>
      </div>
      <div class="recharge_title">
          <span style="background:#37affd;">出</span>&nbsp;&nbsp;消费明细
      </div>
      <v-scroll :on-refresh="onRefresh" :on-infinite="onInfinite" :dataList="scrollData">
      <ul class="recharge_ul">
        <li v-for="(n,i) in news" key="i">
          <div style="width:22px;font-size:14px;color:#ccc;text-align:center;">{{i+1}}</div>
          <div style="flex:1;border-bottom:1px solid #f9f9f9;margin-left:10px;">
            <p style="margin-top:10px;font-size:16px;">{{n.consumeDate}}</p>
            <p style="font-size:14px;color:#999;margin-top:7px;" v-cloak>账单：{{n.checkingNo}}</p>
          </div>
          <div style="border-bottom:1px solid #f9f9f9;padding-right:25px;font-family:'arial';font-size:18px;color:#37affd;" v-cloak>
            <i class="iconfont">&#xe6f2;</i> {{n.consumeMoney | filmoney}}
          </div>
        </li>
      </ul>
      </v-scroll>
    </div>
    <div class="foot">
      <ul style="width:100%;position:absolute;top:10px;z-index:1000;background:#fff;">
        <li @click.stop="quit()" :class="{ line: isShow }">
          <div>开始时间</div>
          <div>{{value3}}</div>
        </li>
        <li @click="quit()" :class="{ line: !isShow }">
          <div>结束时间</div>
          <div>{{value4}}</div>
        </li>
      </ul>
      <div v-if="show4">
        <datetime-view v-if="isShow" v-model="value3"></datetime-view>
        <datetime-view v-if="!isShow" :start-date="value3" end-date="2030-01-01" v-model="value4"></datetime-view>
      </div>
      <div class="last">
        <span @click="cancel()" style="color:#999999;">取消</span>
        <span @click="confirm()">确定</span>
      </div>
    </div>
    <div v-if="showding" class="la-timer" style="position: absolute;top:45%;left:45%;z-index:999;">
      <div></div>
    </div>
    <div class="error_tips">没有数据...</div>
    <div v-show="show1" class="cover" @click="conceal"></div>
    <div v-show="!show3" class="covs" @click="conceal"></div>
  </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import address from '../url.js';
import $ from 'jquery';
import VScroll from '../common/VScroll';
import { DatetimeView, TransferDom } from 'vux';
export default {
  components: {
    BackHeader, VScroll, DatetimeView
  },
  directives: {
    TransferDom
  },
  data() {
    return {
      news: [],
      showding: true,
      totalPage:"",
      totalMoney:0,
      pageSize: 20,
      pageNo: 1,
      value1: "",
      value2: "",
      value3: "",
      value4: "",
      isShow: true,
      show1: false,
      show2: true,
      show3: true,
      show4: false,
      year: "",
      month: "",
      month1: "",
      day: "",
      days1: "",
      days2: "",
      clientele: "充值记录",
      index:0,
      scrollData: {
        noFlag: false //暂无更多数据显示
      }
    }
  },
  created() {
    this.getTime();
    this.getInfo(this.pageNo,this.pageSize,this.value1,this.value2);
  },
  methods: {
    getTime() {
      var _this = this;
      this.time = new Date();
      this.year = this.time.getFullYear();
      if (this.time.getMonth() > 9) {
        this.month = this.time.getMonth();
      } else {
        this.month = "0" + this.time.getMonth();
      }
      if (this.time.getMonth() >= 9) {
        this.month1 = this.time.getMonth() + 1;
      } else {
        this.month1 = "0" + (this.time.getMonth() + 1);
      }
      this.day = this.time.getDate();
      this.days1 = new Date(this.year, this.month, 0);
      this.days2 = new Date(this.year, this.month + 1, 0);
      if (this.day > 9) {
        this.value4 = this.year + "-" + this.month1 + "-" + this.day;
      } else {
        this.value4 = this.year + "-" + this.month1 + "-0" + this.day;
      }
      this.value1 = this.year + "-" + this.month1 + "-01";
      this.value2 = this.year + "-" + this.month1 + "-" + this.days2.getDate();
    },
    getInfo(pageNo,pageSize,value1,value2) {
        if(this.index == 0){
          this.axios.get(address.recharge+ localStorage.getItem('token') + "&page="+pageNo+"&rows="+pageSize+"&startTime="+value1+"&endTime="+value2+"&partnerKey="+this.$route.params.partnerKey)
                .then((data) => {
                  this.showding = false;
                    if (data.data.rows.length == 0) {
                        this.news = [];
                        this.totalMoney = 0;
                        $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
                    } else {
                        this.totalPage = data.data.totalPage;
                        this.news = this.news.concat(data.data.rows);
                        this.totalMoney = data.data.bottomInfo.sumRechargeMoney;
                    }
                })
                .catch(err => {

                })
        }else{
          this.axios.get(address.consume+ localStorage.getItem('token') + "&page="+pageNo+"&rows="+pageSize+"&startTime="+value1+"&endTime="+value2+value2+"&partnerKey="+this.$route.params.partnerKey)
                .then((data) => {
                  this.showding = false;
                    if (data.data.rows.length == 0) {
                        this.news = [];
                        this.totalMoney = 0;
                        $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
                    } else {
                        this.totalPage = data.data.totalPage;
                        this.news = this.news.concat(data.data.rows);
                        this.totalMoney = data.data.bottomInfo.sumConsumeMoney;
                    }
                })
                .catch(err => {

                })
        }
    },
    onRefresh(done) {
      this.showding = true;
      this.news = [];
      this.pageSize = 20;
      this.pageNo = 1;
      this.getInfo(this.pageNo,this.pageSize,this.value1,this.value2);
      done(); //call do
    },
    onInfinite(done) {
      this.pageNo++;
      this.pageSize = 10;
      let more = this.$el.querySelector('.load-more')
        if (this.totalPage<this.pageNo) {
          more.style.display = 'none'; //隐藏加载条
          //走完数据调用方法
          this.scrollData.noFlag = true;
          setTimeout(function() {
          this.scrollData.noFlag = false;
          }.bind(this), 1000);
        } else {
        this.showding = true;
        this.getInfo(this.pageNo,this.pageSize,this.value1,this.value2);
          more.style.display = 'none'; 
        }
      done();
    },
    chose(index) {
      var _this = this;
      $("div.side").slideUp("fast");
      this.show1 = false;
      this.show2 = !this.show2;
      $(".side li").eq(index).addClass("default").siblings().removeClass("default");
      $(".side div").removeClass("default");
      switch (index) {
        case 0:
          _this.value1 = "2017-01-01";
          _this.value2 = _this.year + "-" + "12-31";
          break;
        case 1:
          if(_this.month==0){
            _this.value1 = _this.year-1 + "-12-01";
            _this.value2 = _this.year-1 + "-12-31";
          }else{
            _this.value1 = _this.year + "-" +_this.month + "-01";
            _this.value2 = _this.year + "-" +_this.month + "-" + _this.days1.getDate();
          }
          break;
        case 2:
          _this.value1 = _this.year + "-" + _this.month1 + "-01";
          _this.value2 = _this.year + "-" + _this.month1 + "-" + _this.days2.getDate();
          break;
        case 3:
          _this.value1 = _this.year + "-01-01";
          _this.value2 = _this.year + "-03-31";
          break;
        case 4:
          _this.value1 = _this.year + "-04-01";
          _this.value2 = _this.year + "-06-30";
          break;
        case 5:
          _this.value1 = _this.year + "-07-01";
          _this.value2 = _this.year + "-09-30";
          break;
        case 6:
          _this.value1 = _this.year + "-10-01";
          _this.value2 = _this.year + "-12-31";
          break;
        case 7:
          _this.value1 = _this.year + "-01-01";
          _this.value2 = _this.year + "-06-30";
          break;
        case 8:
          _this.value1 = _this.year + "-07-01";
          _this.value2 = _this.year + "-12-31";
          break;
        case 9:
          _this.value1 = _this.year + "-01-01";
          _this.value2 = _this.year + "-12-31";
          break;
        case 10:
          _this.value1 = _this.year - 1 + "-01-01";
          _this.value2 = _this.year - 1 + "-12-31";
          break;
      }
      this.showding = true;
      this.news = [];
      this.pageNo = 1;
      this.getInfo(this.pageNo,this.pageSize,this.value1,this.value2);
    },
    select() {
      this.show1 = !this.show1;
      this.show2 = !this.show2;
      this.show3 = true;
      $("div.side").slideToggle("fast");
      $(".anchor").slideUp("fast");
    },
    custom() {
      this.value3 = this.value1;
      this.show4 = true;
      this.show2 = !this.show2;
      $(".foot").slideDown("fast");
      $("div.side").slideUp("fast");
      $(".side div").addClass("default");
      $(".side li").removeClass("default");
    },
    quit() {
      this.isShow = !this.isShow;
    },
    cancel() {
      $(".foot").slideUp("fast");
      $("div.side").slideDown("fast");
      this.show1 = true;
      this.show4 = false;
      this.show2 = !this.show2;
    },
    confirm() {
      this.pageNo = 1;
      $(".foot").slideUp("fast");
      this.news = [];
      this.show4 = false;
      this.show1 = false;
      this.value1 = this.value3;
      this.value2 = this.value4;
      this.showding = true;
      this.getInfo(this.pageNo,this.pageSize,this.value1,this.value2);
    },
    client() {
      $("div.side").slideUp("fast");
      $(".anchor").slideToggle("fast");
      this.show3 = !this.show3;
      this.show1 = false;
      this.show2 = true;
    },
    record(i) {
      this.showding = true;
      this.news = [];
      this.index = i;
      this.show3 = !this.show3;
      this.pageNo = 1;
      $(".anchor").slideUp("fast");
      this.clientele = $(".anchor p").eq(i).text();
      $(".anchor p").eq(i).addClass("default").siblings().removeClass("default");
      if (i == 0) {
        $(".quit_time span").eq(0).css("color", "#ff6600");
      } else {
        $(".quit_time span").eq(0).css("color", "#37affd");
      }
      this.getInfo(this.pageNo,this.pageSize,this.value1,this.value2);
    },
    conceal(){
            this.show1 = false;
            this.show3 = true;
            this.show2 = true;
            $("div.side").slideUp("fast");
            $(".foot").slideUp("fast");
            $(".anchor").slideUp("fast");
    }
  }
}
</script>
<style scoped>
.quit_time {
  margin-top: 45px;
  height: 3rem;
  background: #fff;
  border-bottom: 1px solid #f2f2f2;
}
header {
    background: #f26628!important;
}

.quit_time>span:nth-child(1) {
  font-size: 0.9rem;
  line-height: 3rem;
  margin-left: 22px;
}

.quit_time>span:nth-child(2) {
  float: right;
  font-size: 0.9rem;
  color: #333;
  line-height: 46px;
  margin-right: 22px;
}

.side {
  width: 100%;
  position: absolute;
  display: none;
  top: 95px;
  background: #fff;
  z-index: 200;
  height: 300px;
  color: #666;
}

.side ul {
  height: 250px;
  overflow: scroll;
}

.side ul li {
  height: 50px;
  line-height: 50px;
  text-align: center;
}

.totalMoney {
  width: 100%;
  height: 99px;
  text-align: center;
  background: #fff;
  overflow: hidden;
  border-bottom: 1px solid #f2f2f2;
}

.totalMoney p:nth-child(1) {
  font-size: 14px;
  color: #666;
  margin-top: 19px;
}

.totalMoney p:nth-child(2) {
  margin-top: 3px;
  font-size: 20px;
  color: #ff6600;
}
.recharge_title{
  box-sizing: border-box;
  padding-left: 22px;
  background: #fff;
  font-size: 14px;
  color: #666;
  line-height: 52px;
}
.recharge_title span{
  font-size: 12px;
  color: #fff;
  display: inline-block;
  width: 22px;
  height: 22px;
  line-height: 22px;
  border-radius: 50%;
  background: #ff6600;
  text-align: center;
}
.recharge_ul{
  background: #fff;
  box-sizing: border-box;
  padding-left: 22px;
}
.recharge_ul li{
  display: flex;
  line-height: 62px;
}
.recharge_ul li p{
  line-height: normal;
}
.foot {
  height: 300px;
  display: none;
  width: 100%;
  position: fixed;
  bottom: 0;
  background: #fff;
  z-index: 1100;
}

.foot ul {
  display: flex;
  justify-content: center;
}

.foot li {
  display: inline-block;
  width: 50%;
  text-align: center;
  box-sizing: border-box;
  padding: 0px 40px 5px;
}

.foot li div:nth-child(1) {
  font-size: 12px;
  color: #ccc;
}

.foot li div:nth-child(2) {
  color: #999;
}

.cover,
.covs {
  position: fixed;
  top: 94px;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0.2;
  z-index: 100;
  background: #000;
}

.default {
  color: #509ce8;
}
.yo-scroll {
  top: 246px !important;
  background: #fff;
}
.last {
  position: absolute;
  bottom: 0;
  width: 100%;
  display: flex;
  height: 50px;
  line-height: 50px;
  justify-content: center;
  border-top: 1px solid #e9e9e9;
  background: #fff;
}

.last span {
  display: inline-block;
  width: 50%;
  text-align: center;
}

.line div:nth-child(1) {
  color: #a8a8a8 !important;
}

.line div:nth-child(2) {
  border-bottom: 2px solid #2e8ae6;
  box-sizing: border-box;
  padding-bottom: 10px;
  color: #000 !important;
}

.anchor {
  background: #fff;
  width: 100%;
  position: absolute;
  top: 95px;
  z-index: 200;
  display: none;
}

.anchor p {
  text-align: center;
  line-height: 50px;
}

.anchor_color,
.anchor_col {
  color: #0296fa!important;
}
.error_tips {
  position: absolute;
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

