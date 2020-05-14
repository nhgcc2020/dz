<template>
  <div style="overflow: hidden;">
    <div class="x-header">
      <back-header>
        <p class="title">日常账本</p>
        <router-link tag="p" class="remember" :to="'/newaccount/'+'日常账本'"><i class="iconfont" style="font-size:25px;float:left;">&#xe6a1;</i>&nbsp;记一笔</router-link>
      </back-header>
    </div>
    <div class="quit_time">
      <span @click="client" :class="{ anchor_col: !show3 }">{{clientele | character}}<i v-if="show3" class="iconfont" style="font-size:14px;margin-left:4px;color:#999;">&#xe68d;</i><i v-if="!show3" class="iconfont" style="font-size:14px;margin-left:4px;color:#4284d9;">&#xe68e;</i></span><span @click="select" :class="{ anchor_col: !show2 }"><span>{{value1}}</span> - <span>{{value2}}</span><i v-if="show2" class="iconfont" style="font-size:14px;margin-left:4px;color:#999;">&#xe68d;</i><i v-if="!show2" class="iconfont" style="font-size:14px;margin-left:4px;color:#4284d9;">&#xe68e;</i></span>
    </div>
    <div class="aggregate"><span>总合计：</span><span>{{total}}</span></div>
    <div class="anchor">
      <ul class="anchor_ul">
        <li patk="" class="anchor_color" @click="keydown(0)">全部分类</li>
        <li v-for="(n,index) in newsone" key="index" @click="keydown(index+1)" :patk="n.typeCode">{{n.typeDesc}}</li>
      </ul>
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
    <v-scroll :on-refresh="onRefresh" :on-infinite="onInfinite" :dataList="scrollData">
        <div class="sare_time" v-for="(n,index) in newsmessgae" key="index">
        <div>
          <ul class="sare_ul">
            <router-link tag="li" :to="{ name: 'update', params: {'expenseType':'0','expenseNo':n[0].expenseNo}}" class="sare_one" v-cloak><span>{{n[0].payDate}}</span><span>{{n[0].spenderName | spenderName}}</span><i class="iconfont" style="color:#999;font-size:14px;">&#xe68b;</i><span>&yen; {{n[0].payType | pattern}}</span></router-link>
            <li v-if="n[0].expenseExplain!=''" class="sare_two" v-cloak><span>{{n[0].expenseExplain}}</span></li>
            <li v-if="n[0].expenseExplain==''" class="sare_two" v-cloak><span>无费用说明</span></li>
            <li v-for="(p,index) in n" key="index" class="sare_three" v-cloak><span>{{p.expenseDesc}}</span><span :class="{fontColor:p.expenseTypeDesc=='未分类'}">{{p.expenseTypeDesc}}</span><span>{{p.money | money}}</span><span style="display:inline-block;clear: both;"></span></li>
            <li class="sare_fore" v-cloak><span style="display:inline-block;width:50%;"></span><span>合计：</span><span>{{n[0].totalMoney | money}}</span></li>
          </ul>
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
      newsmessgae:[],
      scrollTop: 0,
      pageSize: 20,
      pageNo: 1,
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
      Detail:"",
      total:0.00,
      clientele:"全部分类",
      scrollData: {
        noFlag: false //暂无更多数据显示
      }
    }
  },
  created() {
    this.getTime();
    this.getInfo(this.pageSize, this.pageNo,this.value1,this.value2,this.Detail);
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
       var params = "&settingClass=01";
          this.axios.post(address.classify + localStorage.getItem('token'),params)
                .then(function (data) {
                   if(data.data.length == 0){
                      $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
                    }
                    _this.newsone = data.data;
                })
                .catch(err => {
                  // 
                })  
    },
    getInfo(pageSize, pageNo,startTime,endTime,Detail) {
      var _this = this;
      var params = "pageSize="+pageSize+"&pageNo="+pageNo+"&expenseType=0&startTime="+startTime+"&endTime="+endTime+"&expenseTypeDetail="+Detail;
      this.axios.post(address.dayaccount + localStorage.getItem('token'), params)
        .then(function (data) {
          _this.showding = false;
           _this.totalPage = data.data.totalPage;
          _this.news = _this.news.concat(data.data.rows);
          if (_this.news.length == 0) {
            $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
            _this.total="0.00";
          }else{
             _this.total=0.00;
              for(var j=0;j<_this.news.length;j++){
              _this.total += _this.news[j].money;
           }
            _this.total = _this.fmoney(_this.total,2);
          }
          var expenseNo = _this.news[0].expenseNo;
          var arr = [];
          for(var i = 0;i<_this.news.length;i++){
            if(_this.news[i].expenseNo==expenseNo){
              arr.push(_this.news[i]);
            }else{
               _this.newsmessgae.push(arr);
               arr = [];
               expenseNo = _this.news[i].expenseNo;
                arr.push(_this.news[i]);
            }
          }
           _this.newsmessgae.push(arr);
        })
        .catch(err => {

        })
    },
    onRefresh(done) {
      this.showding = true;
      this.newsmessgae = [];
      this.news = [];
      this.pageSize = 20;
      this.pageNo = 1;
      this.getInfo(this.pageSize, this.pageNo,this.value1,this.value2,this.Detail);
      done(); // call done
    },
    onInfinite(done) {
      this.pageNo++;
      this.pageSize = 20;
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
         this.getInfo(this.pageSize, this.pageNo,this.value1,this.value2,this.Detail);
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
        _this.newsmessgae = [];
        _this.news = [];
        _this.getInfo(_this.pageSize, _this.pageNo,_this.value1,_this.value2,_this.Detail);
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
      this.newsmessgae = [];
      this.show4 = false;
      this.show1 = false;
      this.value1 = this.value3;
      this.value2 = this.value4;
      this.showding = true;
      this.getInfo(this.pageSize, this.pageNo,this.value1,this.value2,this.Detail);
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
        $(".anchor").slideUp("fast");
        this.show3 = !this.show3;
        this.clientele = $(".anchor_color").text();
        this.Detail = $(".anchor_color").attr("patk");
        this.news = [];
        this.newsmessgae = [];
        this.showding = true;
        this.getInfo(this.pageSize, this.pageNo,this.value1,this.value2,this.Detail); 
    },
     fmoney(s, n) //s:传入的float数字 ，n:希望返回小数点几位  
        {
            n = n > 0 && n <= 20 ? n : 2;
            s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
            var l = s.split(".")[0].split("").reverse(),
                r = s.split(".")[1];
            var t = "";
            for (var i = 0; i < l.length; i++) {
                t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
            }
            return t.split("").reverse().join("") + "." + r;
        }
  }
}
</script>
<style scoped>
.sare_time {
  background: #fff;
  margin:0.6rem 0;
}
.vux-header {
  background: #4284d9;
}
.sare_ul{
  position: relative;
  padding-left: 1.2rem;
  overflow: hidden;
}
.sare_one{
  height: 46px;
  line-height: 46px;
  border-bottom:1px solid #f8f8f9;
}
.sare_one span:nth-child(1){
  font-size: 0.9rem;
  color: #000;
}
.sare_one span:nth-child(2){
  display: inline-block;
  height: 30px;
  width: 30px;
  border-radius: 50%;
  background: #73b1e4;
  line-height: 30px;
  color: #fff;
  font-size: 12px;
  text-align: center;
  margin-left:10px;
}
.sare_one span:nth-child(4){
  float: right;
  color: #fea219;
  height: 26px;
  line-height: 26px;
  font-size: 0.7rem; 
  margin-top:9px;
  padding: 2px 6px 0 8px;
  border: 1px solid #fea219;
  border-radius: 3px;
  margin-right: 12px;
  
}
.sare_one i{
  float: right;
  margin-right: 1rem;
}
.sare_two{
    margin-top: 5px;
    font-size: 0.8rem;
    color: #000;
}
.sare_three{
    margin-top: 13px;
}
.sare_three span:nth-child(1){
    font-size: 0.8rem;
    color: #000;
    float: left;
    width: 50%;
}
.sare_three span:nth-child(2){
    float: left;
    margin-left: 2rem;
    color: #15bc83;
    font-size: 0.8rem;
}
.sare_three span:nth-child(3){
    float: right;
    margin-right: 1.2rem;
    font-size: 0.8rem;
    font-family: 'arial';
}
.fontColor{
  color: #999!important;
}
.sare_fore{
    height: 46px;
    line-height: 46px;
    border-top:1px solid #f8f8f9;
    margin-top:6px;
}
.sare_fore span:nth-child(2){
     margin-left: 2rem;
     color: #999;
     font-size: 0.8rem;
}
.sare_fore span:nth-child(3){
    float: right;
    margin-right: 1.2rem;
    color: #ee6877;
    font-size: 1rem;
    font-family: 'arial';
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
  top: 140px !important;
}
.quit_time{
  margin-top:46px;
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
.aggregate{
    position: relative;
    height: 52px;
    text-align: center;
    background: #fff;
    border-top:1px solid #f8f8f9;
    border-bottom:1px solid #f2f2f2;
    z-index: 199;
}
.aggregate span:nth-child(1){
    position: relative;
    top:-2px;
    display: inline-block;
    color: #333;
    font-size: .9rem;
    line-height: 40px;
    margin-right:15px;
}
.aggregate span:nth-child(2){
     display: inline-block;
     font-size: 1.4rem;
     line-height: 52px;
     color: #eb6877;
     font-family: 'arial';
}
.side {
  width: 100%;
  position: absolute;
  display: none;
  top: 97px;
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
  top: 97px;
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
  background: #fff;
  width: 100%;
  position: absolute;
  top: 97px;
  z-index: 200;
  height: 300px;
  display: none;
}
.anchor_ul{
  font-size: 16px;
  height: 300px;
  overflow: auto;
  text-align: center;
}
.anchor_ul li{
  line-height: 50px;
}
.anchor_color,.anchor_col{
  color: #0296fa!important;
}

</style>

