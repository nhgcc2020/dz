<template>
  <div>
    <div class="x-header">
      <back-header>
        <p class="title">客户销售统计</p>
        <p class="state" @click="explain">报表说明</p>
      </back-header>
    </div>
    <div class="searching">
      <p @click="select">
        <i style="color:#6c6d6d;font-size:20px;position:relative;top:1px;" class="iconfont">&#xe6a6;</i>
        <span>{{value1}}</span>
        <i style="color:#2e8ae6;" class="iconfont">&#xe68d;</i>
      </p>
      
      <div class="seek">
        <input @input="change" type="text" v-model="point" placeholder="输入企业简称 或 助记码 搜索客户">
        <i class="iconfont">&#xe6df;</i>
        <p @click="abolish" class="cancel">取消</p>
        <div v-show="show3">
          <span @click="client(l.partnerShortname,l.partnerKey)" v-for="(l,index) in newsone" key="index">{{l.partnerShortname}}</span>
        </div>
      </div>
    </div>
      <div class="overall">
        <span style="margin-top:24px;width:49%;">
            <p style="font-size:14px;color:#999;">订单金额</p>
            <p style="font-size:20px;color:#ee6877;">&yen; {{price}}</p>
        </span>
        <span style="margin-top:28px;width:2%; border-left:2px solid #f2f2f2;height:47px;"></span>
        <span style="margin-top:17px;padding-left:45px;box-sizing: border-box;text-align:left;width:49%;">
            <p style="font-size:14px;color:#999;">下单客户  &nbsp;<span style="font-size:20px;color:#ee6877;">{{totalRows}}</span> </p>
            <p style="font-size:14px;color:#999;">订单笔数  &nbsp;<span style="font-size:20px;color:#ee6877;">{{sumTotalPriceAll.orderNum}}</span></p>
        </span>
    </div>
    <div v-show="show" class="alart">
                <p><i style="font-size:30px;color:#ffb047;position:relative;top:5px;" class="iconfont">&#xe687;</i>&nbsp;报表说明</p>
                <p>销售单生成即计入统计(作废不计入)
                    <br>根据订单日期（非制单时间）归入所属月份</p>
                <p @click="know">我知道了</p>
            </div>
    <div @click="screen" class="cell-title">
    <span style="float:right;width:20px;height:20px;line-height:6px;margin-top:20px;margin-left:5px;"><i style="color:#2e8ae6;font-size:12px;display:block;" :class="{'iconfont':true,'screen-icon':icon}">&#xe68e;</i><i style="color:#2e8ae6;font-size:12px;" :class="{'iconfont':true,'screen-icon':!icon}">&#xe68d;</i></span><span>客户销售排行</span><span class="title-r">订单金额</span>
    </div>
    <v-scroll :on-refresh="onRefresh" :on-infinite="onInfinite" :dataList="scrollData">
      <div>
        <div class="sare_time" v-for="(n,index) in news" key="index">
          <div>
            <ul class="sare_ul">
              <li class="sare_one" v-cloak>
                <div class="indexes" style="font-size:20px;position:relative;top:-10px;margin:0 30px 0 15px;">{{index+1}}</div>
                <div>
                  <p>{{n.partnerName}}</p>
                  <p><span style="color:red; font-size:18px;">{{n.sumTotalPrice | money}}</span>&#x3000;<span style="color:#989898;">{{n.orderNum}}笔 (订单)</span></p>
                </div>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </v-scroll>
    <div class="foot">
        <ul style="width:100%;position:absolute;top:10px;z-index:1000;background:#fff;">
          <li>
            <div >订单日期</div>
            <div style="color:#000;">{{value2}}</div>
          </li>
        </ul>
        <datetime-view format="YYYY-MM" v-model="value2"></datetime-view>
        <div class="last"><span @click="cancel()" style="color:#999999;">取消</span><span @click="confirm()">确定</span></div>
    </div>
    <div v-if="showding" class="la-timer" style="position: absolute;top:45%;left:45%;">
                <div></div>
            </div>
    <div class="error_tips">没有数据...</div>
    <div v-show="show1" @click="disappear" class="cover"></div>
  </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import { DatetimeView, XButton, Popup, TransferDom } from 'vux'
import address from '../url.js';
import $ from 'jquery';
import VScroll from '../common/VScroll';
export default {
  components: {
    BackHeader, VScroll,DatetimeView, XButton, Popup
  },
  directives: {
    TransferDom
  },
  data() {
    return {
      news: [],
      newsone: [],
      sumTotalPriceAll:"",
      totalRows:"",
      price:"",
      scrollTop: 0,
      pageSize: 20,
      pageNo: 1,
      totalPage: "",
      value1: "",
      value2: "",
      time: "",
      year: "",
      month: "",
      sort:"desc",
      point:"",
      partnerKey:"ALL",
      showding:true,
      icon: true,
      show: false,
      show1: false,
      show3: false,
      scrollData: {
        noFlag: false //暂无更多数据显示
      }
    }
  },
  created() {
    this.getTime();
    this.getInfo(this.pageSize, this.pageNo,this.sort,this.value1,this.partnerKey);
  },
  methods: {
    getTime() {
      this.time = new Date();
      this.year = this.time.getFullYear();
      if(this.time.getMonth() == 0){
        this.month = 12;
        this.year = this.time.getFullYear()-1;
      }else if(this.time.getMonth()>9){
        this.month = this.time.getMonth();
      }else{
        this.month = "0"+this.time.getMonth();
      }
      this.value1 = this.year + "-" + this.month;
      this.value2 = this.value1;
    },
    getInfo(pageSize, pageNo,sort,value1,partnerKey) {
      var _this = this;
      var params = "pageSize=" + pageSize + "&pageNo=" + pageNo + "&year="+value1.split("-")[0]+"&month="+value1.split("-")[1]+"&order="+sort+"&partnerKey="+partnerKey;
      this.axios.post(address.statistics + localStorage.getItem('token'), params)
        .then(function (data) {
          _this.showding = false;
          if (data.data.rows.length == 0) {
            $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
          }
          _this.totalPage = data.data.total;
          _this.news = _this.news.concat(data.data.rows);
          _this.sumTotalPriceAll = data.data.sumTotalPriceAll;
          _this.price = _this.fmoney(data.data.sumTotalPriceAll.sumTotalPrice, 2);
          _this.totalRows = data.data.totalRows;
        })
        .catch(err => {
            
        })
    },
    onRefresh(done) {
      this.news = [];
      this.pageSize = 20;
      this.pageNo = 1;
      this.getInfo(this.pageSize, this.pageNo,this.sort,this.value1,this.partnerKey);
      done(); // call done 
    },
    onInfinite(done) {
      this.pageNo++;
      this.pageSize = 1;
      let more = this.$el.querySelector('.load-more')
      if (this.totalPage < this.pageNo) {
        more.style.display = 'none'; //隐藏加载条
        //走完数据调用方法
        this.scrollData.noFlag = true;
        setTimeout(function () {
          this.scrollData.noFlag = false;
        }.bind(this), 1000);
      } else {
        this.getInfo(this.pageSize, this.pageNo,this.sort,this.value1,this.partnerKey);
        more.style.display = 'none'; //隐藏加载条
      }
      done();
    },
    select() {
      this.show1 = true;
      $(".foot").slideDown("fast");
    },
    cancel(){
      $(".foot").slideUp("fast");
      this.show1 = false;

    },
    confirm(){
      this.show1 = false;
      this.value1 = this.value2;
      $(".foot").slideUp("fast");
      this.news = [];
      this.getInfo(this.pageSize, this.pageNo,this.sort,this.value1,this.partnerKey);
    },
    screen(){
      this.icon = !this.icon;
      if(this.icon){
        this.news = [];
        this.sort = "desc";
        this.getInfo(this.pageSize, this.pageNo,this.sort,this.value1,this.partnerKey);
      }else{
        this.news = [];
        this.sort = "asc";
        this.getInfo(this.pageSize, this.pageNo,this.sort,this.value1,this.partnerKey);
      }
    },
    change(){
      var _this = this;
        clearTimeout(this.serachtimer);
        this.serachtimer = setTimeout(function() {
          var login_name = encodeURI(encodeURI(this.point));
          var params = "type=1&page=1&rows=30&searchKey="+login_name;
          this.axios.post(address.addressbook + localStorage.getItem('token'),params)
                .then(function (data) {
                    if(data.data.length == 0){
                      $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
                    }
                    _this.show3 = true;
                    _this.newsone = data.data;
                })
                .catch(err => {

                })
        }.bind(this), 500);
    },
    client(partnerShortname,partnerKey){
        this.show3 = false;
        this.point = partnerShortname;
        this.partnerKey = partnerKey;
        this.news = [];
        this.getInfo(this.pageSize, this.pageNo,this.sort,this.value1,this.partnerKey);
    },
    abolish(){
        this.news = [];
        $("input[type=text]").blur();
        this.point = "";
        this.show3 = false;
        this.partnerKey = "ALL";
        this.getInfo(this.pageSize, this.pageNo,this.sort,this.value1,this.partnerKey);
    },
    disappear(){
      $(".foot").slideUp("fast");
      this.show1 = false;
    },
    explain(){
        this.show = true;
        this.show1 = true;
    },
    know(){
        this.show = false;
        this.show1 = false;
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
  border-bottom: 1px solid #F6F6F6;
}
.vux-header {
  background: #4284d9;
}
.sare_ul {
  position: relative;
  height: 6rem;
}
.sare_ul li {
  padding-top: 1.5rem;
  position:relative;
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
.searching {
  position: relative;
  background: #f2f2f7;
  padding-top: 49px;
}
.searching>p {
  height: 50px;
  text-align: center;
  line-height: 50px;
}
.seek {
  height: 40px;
  position: relative;
}

.seek i {
  font-size: 20px;
  color: #cccccc;
  position: absolute;
  top: 0;
  left: 7%;
}
.seek .cancel{
  position: absolute;
  top: 4%;
  right: 8%;
  color: #479efd;
}
.seek input {
  display: block;
  width: 90%;
  margin: 0 auto;
  border: none;
  border-radius: 30px;
  height: 30px;
  padding-left: 18%;
  box-sizing: border-box;
}
.seek div{
  position: absolute;
  z-index: 2000;
  background: #fff;
  top:2.5rem;
  width: 100%;
  max-height: 300px;
  overflow: auto;
}
.seek span{
  display: block;
  line-height: 50px;
  text-align: center;
  border-bottom:1px solid #e9e9e9;
}
.yo-scroll {
  top: 302px !important;
}
.default {
  color: #509ce8;
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
.cell-title{
  line-height: 50px;
  background: #fff;
  padding: 0 1rem 0;
  border-bottom: 1px solid #e7e7e7;
}
.title-r{
  float: right;
}
.sare-r{
  color:#cccccc;
   position: absolute;
   top:2rem;
  right:1rem;
  
}
.screen-icon{
  color: #cdcdcd !important;
}
.overall{
    height: 100px;
    display: flex;
    justify-content: center;
    background: #fff;
    margin-bottom: 12px;
}
.overall>span{
    display: inline-block;
    text-align: center;
}
.sare_one div{
    display: inline-block;
}
.cover{
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0.2;
  z-index: 100;
  background: #000;
}
.indexes:nth-child(1),.indexes:nth-child(2),.indexes:nth-child(3){
    color:#f4bd21;
}
.alart {
    position: absolute;
    top: 35%;
    width: 70%;
    margin: 0 auto;
    left: 15%;
    right: 15%;
    background: #fff;
    border-radius: 0.5rem;
    z-index: 1100;
}

.alart p:nth-child(1) {
    text-align: center;
}

.alart p:nth-child(2) {
    font-size: 0.8rem;
    padding: 1rem;
}

.alart p:nth-child(3) {
    padding: 0.5rem 0;
    text-align: center;
    color: #4284d9;
    border-top: 1px solid #ccc;
}
</style>

