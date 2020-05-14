<template>
  <div style="overflow: hidden;">
    <div class="x-header">
      <back-header>
        <p class="title">销售单列表</p>
        <router-link tag="p" class="remember" to="/billing"><i class="iconfont" style="font-size:25px;float:left;">&#xe6a1;</i>&nbsp;开单</router-link>
      </back-header>
    </div>
    <ol class="ol_quit">
      <li :class="{ol_line:colorid==0}" @click="bill(0)"><span>待对账</span></li>
      <li :class="{ol_line:colorid==1}" @click="bill(1)"><span>已对账</span></li>
      <li :class="{ol_line:colorid==2}" @click="bill(2)"><span>草稿箱</span></li>
    </ol>
    <div class="quit_time">
      <span @click="client" :class="{ anchor_col: !show3 }">{{clientele | character}}<i v-if="show3" class="iconfont" style="font-size:14px;margin-left:4px;">&#xe68d;</i><i v-if="!show3" class="iconfont" style="font-size:14px;margin-left:4px;color:#4284d9;">&#xe68e;</i></span><span @click="select" :class="{ anchor_col: !show2 }"><span>{{value1}}</span> - <span>{{value2}}</span><i v-if="show2" class="iconfont" style="font-size:14px;margin-left:4px;">&#xe68d;</i><i v-if="!show2" class="iconfont" style="font-size:14px;margin-left:4px;color:#4284d9;">&#xe68e;</i></span>
    </div>
    <div class="anchor">
      <ul class="anchor_ul">
        <li patk="" class="anchor_color" @click="keydown(0)">全部客户</li>
        <li v-for="(n,index) in newsone" key="index" @click="keydown(index+1)" :patk="n.partnerKey">{{n.partnerShortname}}</li>
      </ul>
      <div class="last"><span @click="dele()" style="color:#999999;">取消</span><span @click="konw()">确定</span></div>
    </div>
    <div class="side">
        <ul>
         <li @click="chose(0)" class="default">全部时间段</li>
          <li @click="chose(1)">上月</li>
          <li @click="chose(2)">本月</li>
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
    <v-scroll :on-refresh="onRefresh" :on-infinite="onInfinite" :dataList="scrollData" v-if="colorid!=2">
      <div>
        <div class="sare_time" v-for="(n,index) in news" key="index">
        <router-link tag="div" :to="'/particulars/'+n.salesNo">
          <ul class="sare_ul">
            <li class="sare_one" v-cloak><i class="iconfont">&#xe69b;</i>&nbsp;&nbsp;<span>{{n.partnerShortname}}</span></li>
            <li class="sare_two" v-cloak><span>{{n.orderDate}}</span><span>{{(n.totalPrice).toFixed(2)}}</span></li>
            <li class="sare_three" v-cloak>{{n.caseDesc | casedesc}}</li>
          </ul>
          </router-link>
        </div>
      </div>
   </v-scroll>
   <v-scroll :on-refresh="onRefresh" :on-infinite="onInfinite" :dataList="scrollData" v-if="colorid==2">
      <div>
        <div class="sare_time" v-for="(n,index) in news" key="index">
        <router-link tag="div" :to="'/particularsDraft/'+n.salesNo">
          <ul class="sare_ul">
            <li class="sare_one" v-cloak><i class="iconfont">&#xe69b;</i>&nbsp;&nbsp;<span>{{n.partnerShortname}}</span></li>
            <li class="sare_two" v-cloak><span>{{n.orderDate}}</span><span>{{(n.totalPrice).toFixed(2)}}</span></li>
            <li class="sare_three" v-cloak>{{n.caseDesc | casedesc}}</li>
          </ul>
          </router-link>
        </div>
      </div>
   </v-scroll>
  <div class="foot">
        <ul style="width:100%;position:absolute;top:10px;z-index:1000;background:#fff;">
          <li @click.stop="quit()" :class="{ line: isShow }">
            <div >开始时间</div>
            <div>{{value3}}</div>
          </li>
          <li  @click="quit()" :class="{ line: !isShow }">
            <div>结束时间</div>
            <div>{{value4}}</div>
          </li>
        </ul>
        <div v-if="show4">
          <datetime-view v-if="isShow" v-model="value3"></datetime-view>
          <datetime-view v-if="!isShow" :start-date="value3" end-date="2030-01-01" v-model="value4"></datetime-view>
        </div>
        <div class="last"><span @click="cancel()" style="color:#999999;">取消</span><span @click="confirm()">确定</span></div>
  </div>
   <div v-if="showding" class="la-timer" style="position: absolute;top:45%;left:45%;">
                <div></div>
            </div>
    <div class="error_tips">没有数据...</div>
    <div v-show="show1" class="cover"></div>
    <div v-show="!show3" class="covs"></div>
  </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import bus from '../bus.js';
import address from '../url.js';
import $ from 'jquery';
import VScroll from '../common/VScroll';
import { DatetimeView, TransferDom } from 'vux';
export default {
  components: {
    BackHeader, VScroll,DatetimeView
  },
 directives: {
    TransferDom
  },
  data() {
    return {
      news: [],
      newsone:[],
      scrollTop: 0,
      pageSize: 20,
      pageNo: 1,
      colorid: 0,
      showding:true,
      totalPage: "",
      value1: "",
      value2: "",
      value3:"",
      value4:"",
      isShow: true,
      show1:false,
      show2:true,
      show3:true,
      show4:false,
      year:"",
      month:"",
      month1:"",
      day:"",
      days1:"",
      days2:"",
      Status:"04",
      matter:"",
      render:false,
      clientele:"全部客户",
      cal:false,
      scrollData: {
        noFlag: false //暂无更多数据显示
      }
    }
  },
  created() {
    bus.$on('save', this.saveDate);
    this.getTime();
    this.getInfo(this.pageSize, this.pageNo,this.Status,this.value1,this.value2,this.matter);
    JAnalytics.onPageStart({'pageName': '销售单'});
  },
   destroyed(){
        JAnalytics.onPageEnd({'pageName': '销售单'});
    },
  methods: {
    getTime() {
      var _this = this;
      this.time = new Date();
      this.year = this.time.getFullYear();
      if(this.time.getMonth()>9){
        this.month = this.time.getMonth();
      }else{
        this.month = "0"+this.time.getMonth();
      }
      if(this.time.getMonth()>=9){
        this.month1 = this.time.getMonth()+1;
      }else{
        this.month1 = "0"+(this.time.getMonth()+1);
      }
      this.day = this.time.getDate();
      this.days1 = new Date(this.year, this.month, 0);
      this.days2 = new Date(this.year, this.month+1, 0);
      this.value1 = "2017-01-01";
      this.value2 = this.year +"-" + "12-31";
      if(this.day>9){
        this.value4 = this.year + "-" + this.month1 + "-" + this.day;
      }else{
        this.value4 = this.year + "-" + this.month1 + "-0" + this.day;
      }
       var params = "type=1&page=1&rows=30&searchKey=";
          this.axios.post(address.addressbook + localStorage.getItem('token'),params)
                .then(function (data) {
                   if(data.data.length == 0){
                      $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
                    }
                    _this.newsone = data.data;
                })
                .catch(err => {
                  
                })
                
    },
    getInfo(pageSize, pageNo,Status,startTime,endTime,partnerKey) {
      var _this = this;
      var params = "pageSize="+pageSize+"&pageNo="+pageNo+"&orderStatus="+Status+"&isSynchro=1&startTime="+startTime+"&endTime="+endTime+"&partnerKey="+partnerKey;
      this.axios.post(address.report + localStorage.getItem('token'), params)
        .then(function (data) {
          _this.showding = false;
          if (data.data.data.length == 0) {
            $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
          }
          _this.totalPage = data.data.totalPage;
          _this.news = _this.news.concat(data.data.data);
          _this.render = true;
        })
        .catch(err => {

        })
    },
    onRefresh(done) {
      this.showding = true;
      this.news = [];
      this.pageSize = 20;
      this.pageNo = 1;
      this.getInfo(this.pageSize, this.pageNo,this.Status,this.value1,this.value2,this.matter);
      done(); // call done
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
         this.getInfo(this.pageSize, this.pageNo,this.Status,this.value1,this.value2,this.matter);
          more.style.display = 'none'; //隐藏加载条
        }
      done();
    },
    chose(index){
        var _this = this;
         $("div.side").slideUp("fast");
         _this.show1 = false;
         _this.show2 = !_this.show2;
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
            _this.value1 = _this.year-1 + "-01-01";
            _this.value2 = _this.year-1 + "-12-31";
            break;
        }
        _this.showding = true;
        _this.news = [];
        _this.getInfo(_this.pageSize, _this.pageNo,_this.Status,_this.value1,_this.value2,_this.matter);
    },
    select() {
      this.show1 = !this.show1;
      this.show2 = !this.show2;
      this.show3 = true;
      $("div.side").slideToggle("fast");
      $(".anchor").slideUp("fast");
    },
  custom(){
      this.value3 = this.value1;
      this.show4 = true;
      this.show2 = !this.show2;
      $(".foot").slideDown("fast");
      $("div.side").slideUp("fast");
      $(".side div").addClass("default");
      $(".side li").removeClass("default");
    },
    quit(){
      this.isShow = !this.isShow;     
    },
    cancel(){
      $(".foot").slideUp("fast");
      $("div.side").slideDown("fast");
      this.show1 = true;
      this.show4 = false;
      this.show2 = !this.show2;
    },
    confirm(){
      $(".foot").slideUp("fast");
      this.news = [];
      this.show4 = false;
      this.show1 = false;
      this.value1 = this.value3;
      this.value2 = this.value4;
      this.showding = true;
      this.getInfo(this.pageSize, this.pageNo,this.Status,this.value1,this.value2,this.matter);
    },
    bill(index){
      this.colorid = index;
      if(index==0){
        this.news = [];
        this.Status = "04";
        this.showding = true;
        this.getInfo(this.pageSize, this.pageNo,this.Status,this.value1,this.value2,this.matter);
      }else if(index==1){
        this.news = [];
        this.Status = "05";
        this.showding = true;
        this.getInfo(this.pageSize, this.pageNo,this.Status,this.value1,this.value2,this.matter);
      }else if(index==2){
        this.news = [];
        this.Status = "01";
        this.showding = true;
        this.getInfo(this.pageSize, this.pageNo,this.Status,this.value1,this.value2,this.matter);
      }
    },
    saveDate(){
        this.colorid = 2;
        this.news = [];
        this.Status = "01";
        this.showding = true;
        this.getInfo(this.pageSize, this.pageNo,this.Status,this.value1,this.value2,this.matter);
    },
    client(){
      $("div.side").slideUp("fast");
      $(".anchor").slideToggle("fast");
      this.show3 = !this.show3;
      this.show1 = false;
      this.show2 = true;
    },
    keydown(index){
        $(".anchor_ul li").eq(index).addClass("anchor_color").siblings().removeClass("anchor_color");
    },
    dele(){
      $(".anchor").slideUp("fast");
      this.show3 = !this.show3;
    },
    konw(){
      $(".anchor").slideUp("fast");
      this.show3 = !this.show3;
      this.clientele = $(".anchor_color").text();
      this.matter = $(".anchor_color").attr("patk");
      this.news = [];
      this.showding = true;
      this.getInfo(this.pageSize, this.pageNo,this.Status,this.value1,this.value2,this.matter); 
    },
    initial(){
      JAnalytics.onPageStart({'pageName': '销售单'});
       if(this.render){
        this.pageSize= 20;
        this.pageNo= 1;
        this.colorid = 0;
        this.Status="04";
        this.value1= "";
        this.value2= "";
        this.matter="";
        this.news = [];
        this.clientele = "全部客户";
        $(".side li").eq(0).addClass("default").siblings().removeClass("default");
        $(".anchor_ul li").eq(0).addClass("anchor_color").siblings().removeClass("anchor_color");
        this.getTime();
        this.getInfo(this.pageSize, this.pageNo,this.Status,this.value1,this.value2,this.matter);
       }
    }
  },
  beforeRouteEnter(to, from, next){
    if(from.path == "/home/workbench"){
        next(vm=>{
          vm.initial();
        })
    }else{
       next();
    }
      
  }
}
</script>
<style scoped>
.sare_time {
  background: #fff;
  margin:0.8rem 0;
}
.vux-header {
  background: #4284d9;
}
.sare_ul{
  position: relative;
  padding-left: 1.1rem;
}
.sare_ul i{
  font-size: 2rem;
  color: #4d86ce;
}
  .sare_two span:nth-child(2){
  float: right;
  margin-right: 1.2rem;
  font-size: 1.1rem;
  color: #d80404;
  margin-top: -0.3rem;
}
.sare_one span{
  position: absolute;
  font-size: 1rem;
  top:1rem;
}
.sare_two{
  height: 1.3rem;
  margin-top: -.5rem;
  margin-bottom: .5rem;
  font-size: 0.9rem;
}
.sare_three{
  border-top: 1px solid #F6F6F6;
  font-size: 0.9rem;
  color: #adadad;
  padding: .5rem 0;
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
.yo-scroll {
  top: 137px !important;
}
.ol_quit{
  height: 3rem;
  margin-top:49px;
  display: flex;
  justify-content: center;
  background: #fff;
  padding: 0 2rem;
}
.ol_quit li{
  display: inline-block;
  width: 33%;
  text-align: center;
  box-sizing: border-box;
  line-height: 3rem;
  font-size: 1rem;
}
.ol_line span{
  box-sizing: border-box;
  border-bottom: 2px solid #0296fa;
  color:#0296fa;
  padding-bottom: .6rem;
}
.quit_time{
  height: 3rem;
  background: #fff;
  border-top:1px solid #f8f8f9;
}
.quit_time>span:nth-child(1){
  font-size: 0.9rem;
  color: #333;
  line-height: 3rem;
  margin-left: 1.6rem;
}
.quit_time>span:nth-child(2){
  float: right;
  font-size: 0.9rem;
  color: #333;
  line-height: 46px;
  margin-right: 1.6rem;
}
.side {
  width: 100%;
  position: absolute;
  display: none;
  top: 143px;
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
.foot{
  height: 300px;
  display: none;
  width: 100%;
  position: fixed;
  bottom: 0;
  background: #fff;
  z-index: 1100;
}
.foot ul{
  display: flex;
  justify-content: center;
}
.foot li{
  display: inline-block;
  width: 50%;
  text-align: center;
  box-sizing: border-box;
  padding: 0px 40px 5px;
}
.foot li div:nth-child(1){
  font-size: 12px;
  color: #ccc;
}
.foot li div:nth-child(2){
   color: #999;
}
.cover,.covs {
  position: fixed;
  top: 143px;
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
.last{
  position: absolute;
  bottom:0;
  width: 100%;
  display: flex;
  height: 50px;
  line-height: 50px;
  justify-content: center;
  border-top: 1px solid #e9e9e9;
  background: #fff;
}
.last span{
  display: inline-block;
  width: 50%;
  text-align: center;

}
.line div:nth-child(1){
  color: #a8a8a8 !important;
}
.line div:nth-child(2){
   border-bottom: 2px solid #2e8ae6;
   box-sizing: border-box;
  padding-bottom: 10px;
  color: #000 !important;
}
.anchor{
  background: #f5f3f9;
  width: 100%;
  position: absolute;
  top: 143px;
  z-index: 200;
  height: 28rem;
  display: none;
}
.anchor_ul{
  margin-top:16px;
  margin-left: 1.6rem;
  font-size: 14px;
  height: 24rem;
  overflow: auto;
}
.anchor_ul li{
  line-height: 32px;
}
.anchor_color,.anchor_col{
  color: #0296fa!important;
}
/*.anchor_p{
  position: fixed;
  top: 159px;
  right: 16px;
}
.anchor_p>a{
  display: block;
  font-size: 0.6rem;
  transform:scale(0.8);
  height: 15px;
  width: 15px;
  border-radius: 50%;
  color: #666;
  text-align: center;
  line-height: 15px;
}*/
/*.back_color{
  background: #4284d9;
  color: #fff !important;
  
}*/
/*.quit{
  top:49px;
  width: 100%;
  position: fixed;
  justify-content: center;
  background: #fff;
  border-bottom:1px solid #ccc;
}
.quit li{
  display: inline-block;
  width: 24%;
  text-align: center;
  padding: 1rem 0;
}
.active{
  border-bottom:2px solid #2e8ae6;
}*/
</style>

