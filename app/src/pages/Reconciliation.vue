<template>
  <div>
    <div class="x-header">
      <back-header>
        <p class="title">待对账</p>
      </back-header>
    </div>
    <div class="searching">
      <p @click="select">
        <span>{{value1}}</span> - <span>{{value2}}</span>
        <i style="color:#2e8ae6;" class="iconfont">&#xe68d;</i>
      </p>
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
        <div @click="custom" style="height:50px;line-height:50px;text-align:center;border-top:1px solid #e9e9e9;">自定义时间</div>
      </div>
      <div class="seek">
        <input @input="change" type="text" v-model="point" placeholder="输入企业简称 或 助记码 搜索客户">
        <i class="iconfont">&#xe6df;</i>
        <p @click="abolish" class="cancel">取消</p>
        <div v-show="show3">
          <span @click="client(l.partnerShortname,l.partnerKey)" v-for="(l,index) in newsone" key="index">{{l.partnerShortname}}</span>
        </div>
      </div>
    </div>
    <div @click="screen" class="cell-title">
    <span style="float:right;width:20px;height:20px;line-height:6px;margin-top:20px;margin-left:5px;"><i style="color:#2e8ae6;font-size:12px;display:block;" :class="{'iconfont':true,'screen-icon':icon}">&#xe68e;</i><i style="color:#2e8ae6;font-size:12px;" :class="{'iconfont':true,'screen-icon':!icon}">&#xe68d;</i></span><span>待对账客户</span><span class="title-r">订单金额</span>
    </div>
    <v-scroll :on-refresh="onRefresh" :on-infinite="onInfinite" :dataList="scrollData">
      <div>
        <div class="sare_time" v-for="(n,index) in news" key="index">
          <router-link @click.native="relation(n.partnerKey)" tag="div" to="/Sdaitijiao">
            <ul class="sare_ul">
              <li class="sare_one" v-cloak>
                <div>
                  <p>{{n.partnerName}}</p>
                  <p><span style="color:red; font-size:18px;">{{n.totalPrice04 | money}}</span>&#x3000;<span style="color:#989898;">{{n.orderCount}}笔</span></p>
                </div>
                  <i class="sare-r iconfont"> &#xe68b;</i>
              </li>
              <li class="sare_two" v-cloak>
              
              </li>
              <li class="sare_three" v-cloak></li>
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
    <div v-show="show1" @click="select" class="cover"></div>
    <div v-show="show2" @click="cancel" class="covs"></div>
  </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import { DatetimeView, XButton, Popup, TransferDom } from 'vux'
import address from '../url.js';
import $ from 'jquery';
import VScroll from '../common/VScroll';
import { mapState, mapGetters } from 'vuex';
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
      scrollTop: 0,
      pageSize: 20,
      pageNo: 1,
      totalPage: "",
      value1: "",
      value2: "",
      time: "",
      year: "",
      month: "",
      month1:"",
      days1: "",
      days2:"",
      sort:"desc",
      day:"",
      value3:"",
      value4:"",
      point:"",
      index:"1",
      partnerKey:"ALL",
      showding:true,
      icon: true,
      show1: false,
      show2: false,
      show3: false,
      show4: false,
      isShow: true,
      scrollData: {
        noFlag: false //暂无更多数据显示
      }
    }
  },
  created() {
    this.getTime();
    this.getInfo(this.pageSize, this.pageNo, this.value1, this.value2,this.sort,this.partnerKey);
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
    },
    getInfo(pageSize, pageNo,value1,value2,sort,partnerKey) {
      var _this = this;
      var params = "pageSize=" + pageSize + "&pageNo=" + pageNo + "&orderStatus=04&startTime="+value1+"&endTime="+value2+"&order="+sort+"&partnerKey="+partnerKey;
      this.axios.post(address.branch + localStorage.getItem('token'), params)
        .then(function (data) {
          _this.showding = false;
          if (data.data.rows.length == 0) {
            $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
          }
          _this.totalPage = data.data.total;
          _this.news = _this.news.concat(data.data.rows);
        })
        .catch(err => {
            
        })
    },
    onRefresh(done) {
      this.news = [];
      this.pageSize = 20;
      this.pageNo = 1;
      this.getInfo(this.pageSize, this.pageNo, this.value1, this.value2,this.sort,this.partnerKey);
      done(); // call done
    },
    onInfinite(done) {
      this.pageNo++;
      this.pageSize = 20;
      let more = this.$el.querySelector('.load-more')
      if (this.totalPage < this.pageNo) {
        more.style.display = 'none'; //隐藏加载条
        //走完数据调用方法
        this.scrollData.noFlag = true;
        setTimeout(function () {
          this.scrollData.noFlag = false;
        }.bind(this), 1000);
      } else {
        this.getInfo(this.pageSize, this.pageNo, this.value1, this.value2,this.sort,this.partnerKey);
        more.style.display = 'none'; //隐藏加载条
      }
      done();
    },
    select() {
      this.show1 = !this.show1;
      var _this = this;
      $("div.side").slideToggle("fast");
    },
    chose(index){
          var _this = this;
          this.index = index;
         $("div.side").slideUp("fast");
         _this.show1 = false;
        $(".side li").eq(index).addClass("default").siblings().removeClass("default");
        $(".side div").removeClass("default");
        switch (index) {
          case 0:
            _this.value1 = "2017-01-01";
            _this.value2 = _this.year+"-12-31";
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
        _this.news = [];
        _this.getInfo(_this.pageSize,_this.pageNo,_this.value1,_this.value2,_this.sort,_this.partnerKey);
    },
    quit(){
      this.isShow = !this.isShow;    
    },
    custom(){
      this.value3 = this.value1;
      this.show2 = true;
      this.show4 = true;
      $(".foot").slideDown("fast");
      $("div.side").slideUp("fast");
      this.show1 = false;
      $(".side div").addClass("default");
      $(".side li").removeClass("default");
    },
    cancel(){
      $(".foot").slideUp("fast");
      this.show2 = false;
      $("div.side").slideDown("fast");
      this.show1 = true;
      this.show4 = false;
    },
    confirm(){
      $(".foot").slideUp("fast");
      this.show2 = false;
      this.show4 = false;
      this.value1 = this.value3;
      this.value2 = this.value4;
      this.news = [];
      this.getInfo(this.pageSize, this.pageNo, this.value1, this.value2,this.sort,this.partnerKey);
    },
    screen(){
      this.icon = !this.icon;
      if(this.icon){
        this.news = [];
        this.sort = "desc";
        this.getInfo(this.pageSize, this.pageNo, this.value1, this.value2,this.sort,this.partnerKey);
      }else{
        this.news = [];
        this.sort = "asc";
        this.getInfo(this.pageSize, this.pageNo, this.value1, this.value2,this.sort,this.partnerKey);
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
                  //  
                })
        }.bind(this), 500);
    },
    client(partnerShortname,partnerKey){
        this.show3 = false;
        this.point = partnerShortname;
        this.partnerKey = partnerKey;
        this.news = [];
        this.getInfo(this.pageSize, this.pageNo, this.value1, this.value2,this.sort,this.partnerKey);
    },
    relation(p){
        this.$store.commit('time', {"startTime":this.value1,"endTime":this.value2,"partnerKey":p});
    },
    abolish(){
        this.news = [];
        $("input[type=text]").blur();
        this.point = "";
        this.show3 = false;
        this.partnerKey = "ALL";
        this.getInfo(this.pageSize, this.pageNo, this.value1, this.value2,this.sort,this.partnerKey);
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
  padding-left: 1.1rem;
  height: 6rem;
}
.sare_ul li {
  padding-top: 1.5rem;
  position:relative;
}
.sare_two span:nth-child(2) {
  float: right;
  margin-right: 1.2rem;
  font-size: 1.1rem;
  color: #d80404;
  margin-top: -0.3rem;
}
.sare_two {
  height: 1.3rem;
  margin-top: -.5rem;
  margin-bottom: .5rem;
  font-size: 0.9rem;
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
@media screen and (max-width: 320px){
  .seek input {
  padding-left: 10%!important;
  
}
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
  top: 190px !important;
}
.side {
  width: 100%;
  position: absolute;
  display: none;
  top: 100px;
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
.default {
  color: #509ce8;
}
.cover,.covs {
  position: fixed;
  top: 100px;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0.2;
  z-index: 100;
  background: #000;
}
.covs{
  top: 0px;
   z-index: 1000;
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
   font-size: 0.9rem;
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
</style>

