<template>
  <div>
    <div class="x-header">
      <back-header>
        <p class="title">营业毛利</p>
      </back-header>
    </div>
    <div class="searching">
      <p @click="select">
        <i style="color:#ccc;font-size:20px;position:relative;top:1px;right:5px;" class="iconfont">&#xe6a6;</i>
        <span style="color:#333;">{{value1}}</span>
        <i style="color:#ccc;" class="iconfont">&#xe68d;</i>
      </p>
    </div>
      <div class="overall">
        <P>月盈利</P>
        <P>&yen; {{total}}&nbsp;<span>盈</span></P>
    </div>
    <div class="messages">
      <ul style="border-top:1px solid #f3f5fa;">
          <li><span style="background:#ff3f05;">销售</span><span :class="{moneyColor:count.salesTotalPrice!='0.00'}">+ {{count.salesTotalPrice}}</span></li>
          <li><span style="background:#2e8ae6;">外协</span><span :class="{moneyColor:false}">- 0.00</span></li>
          <li><span style="background:#2e8ae6;">采购</span><span :class="{moneyColor:count.purchaseTotalPrice!='0.00'}">- {{count.purchaseTotalPrice}}</span></li>
          <li><span style="background:#15bc83;">日常</span><span :class="{moneyColor:count.expenseDailyTotalPrice!='0.00'}">- {{count.expenseDailyTotalPrice}}</span></li>
          <li><span style="background:#15bc83;">工资</span><span :class="{moneyColor:count.expenseSalaryTotalPrice!='0.00'}">- {{count.expenseSalaryTotalPrice}}</span></li>
      </ul>
    </div>
    <div class="foot">
        <ul style="width:100%;position:absolute;top:10px;z-index:1000;background:#fff;">
          <li>
            <div >日期</div>
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
      value1: "",
      value2: "",
      time: "",
      year: "",
      month: "",
      showding:false,
      show1: false,
      count:{},
      total:""
    }
  },
  created() {
    this.getTime();
    this.getInfo(this.value1);
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
    getInfo(value1) {
      var _this = this;
      var params = "orderDate="+value1
      this.axios.post(address.margin + localStorage.getItem('token'), params)
        .then(function (data) {
            if(data.data == null){
                $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
                _this.count = {"expenseDailyTotalPrice":"0.00","expenseSalaryTotalPrice":"0.00","purchaseTotalPrice":"0.00","salesTotalPrice":"0.00"}
                _this.total = "0.00";
                $(".overall p span").css("background","#ff3f05").text("盈");
                $(".overall p").eq(1).css("color","#eb6877");
            }else{
                 _this.count.expenseDailyTotalPrice = _this.fmoney(data.data.expenseDailyTotalPrice,2);
                 _this.count.expenseSalaryTotalPrice = _this.fmoney(data.data.expenseSalaryTotalPrice,2); 
                 _this.count.purchaseTotalPrice = _this.fmoney(data.data.purchaseTotalPrice,2);
                 _this.count.salesTotalPrice = _this.fmoney(data.data.salesTotalPrice,2);
                 var totalPrice = data.data.salesTotalPrice-(data.data.purchaseTotalPrice+data.data.expenseSalaryTotalPrice+data.data.expenseDailyTotalPrice);
                 _this.total = _this.fmoney(totalPrice,2);
                 if(totalPrice<0){
                    $(".overall p").eq(1).css("color","#15bc83");
                    $(".overall p span").css("background","#15bc83").text("亏");
                 }else{
                     $(".overall p").eq(1).css("color","#eb6877");
                     $(".overall p span").css("background","#ff3f05").text("盈");
                 }
            }
        })
        .catch(err => {
            
        })
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
      this.getInfo(this.value1);
    },
    disappear(){
      $(".foot").slideUp("fast");
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
.vux-header {
    background: #4284d9;
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
    background: #fff;
    padding-top: 46px;
}
.searching>p {
    height: 50px;
    text-align: center;
    line-height: 50px;
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
    height: 91px;
    background: #fff;
    overflow: hidden;
    border-top:1px solid #e7e7e7;
}
.overall p:nth-child(1){
    text-align: center;
    font-size: 14px;
    color:#000;
    margin-top:14px;
}
.overall p:nth-child(2){
    position: relative;
    text-align: center;
    font-size: 24px;
    color:#eb6877;
    font-family: "arial";
}
.overall span{
    position: absolute;
    font-size: 12px;
    top:0px;
    color:#fff;
    display: inline-block;
    height:20px;
    width: 20px;
    line-height: 20px;
    border-radius: 50%;
    background: #ff3f05;
    border: 2px solid #f2f2f2;
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
.messages {
    background: #fff;
}
.messages ul li{
    margin-left:1.5rem;
    padding-right:1.2rem;
    height: 78px;
    line-height: 78px;
    border-bottom: 1px solid #f9f9f9;
}
.messages ul li span:nth-child(1){
    display: inline-block;
    height: 52px;
    width: 52px;
    border-radius: 50%;
    text-align: center;
    line-height: 52px;
    margin-top:13px;
    color:#fff;
    font-size: 14px;
}
.messages ul li span:nth-child(2){
    float: right;
    color:#999;
    font-size: 20px;
    font-family: "arial";
}
.messages ul li .moneyColor{
    color: #666!important;
}
</style>

