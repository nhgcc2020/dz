<template>
  <div>
    <div class="x-header">
      <back-header>
        <p class="title">{{title}}</p>
      </back-header>
    </div>
    <div class="big_first" style="padding-bottom:200px;">
        <ul class="big_one">
            <li @click="handling" style="border:none;">经办人<i class="iconfont">&#xe68b;</i><span v-if="!responsible" style="color:#ccc;">未选择</span><span v-if="responsible">{{responsible}}</span></li>
            <li @click="payment">付款方式<i class="iconfont">&#xe68b;</i><span>{{payType | pattern}}</span></li>
            <li @click="datetime">付款日期<i class="iconfont">&#xe68b;</i><span>{{value}}</span></li>
            <li>费用说明<input class="enter" id="ipt" type="text" placeholder="如某员工xx月出差报销" v-model="explain"></li>
            <li ><i class="iconfont">&#xe6f4;</i>费用明细<span style="margin-right:0;color:#ee6877;font-size:14px;font-family: 'arial';">{{uldate | summation}}</span><span style="margin-right:4px;">合计：</span></li>
        </ul>
        <ul v-for="(n,index) in uldate" key="index" class="big_two">
            <li>明细描述<input class="enter" id="ipt" type="text" placeholder="如5月20日加班餐费" v-model="n.describe"></li>
            <li>明细金额<input class="enter" id="ipt" type="number" placeholder="0.00" v-model="n.money" style="color:#ee6877;font-size:14px;font-family: 'arial';"></li>
            <li @click="particulars(index)">明细分类<i class="iconfont">&#xe68b;</i><span v-if="!n.classify" style="color:#ccc;" >未选择</span><span v-if="n.classify" :property="n.expenseType">{{n.classify}}</span></li>
        </ul>
        <div class="add">添加明细行 <span><i @click="addto" class="iconfont">&#xe6a5;</i></span></div>
    </div>
    
    <div class="but">
        <button @click="construction">修改保存</button>
    </div>
    <div class="general">
        <p v-for="(n,index) in pattern" key="index" @click="choseOne(n.contacterId,n.contacterName)">{{n.contacterName}}</p>
    </div>
    <div class="generalPerson">
        <p v-for="(n,index) in operator" key="index" @click="choseTwo(n.employeeId,n.realName)" >{{n.realName}}</p>
    </div>
    <div class="detail">
        <p v-for="(n,index) in category" key="index" @click="choseThree(n.typeCode,n.typeDesc)">{{n.typeDesc}}</p>
    </div>
    <div class="foot">
        <ul style="width:100%;position:absolute;top:10px;z-index:1000;background:#fff;">
          <li>
            <div >付款时间</div>
            <div style="color:#000;border-bottom:2px solid #4284d9;">{{value1}}</div>
          </li>
        </ul>
        <datetime-view  v-model="value1"></datetime-view>
        <div class="last"><span @click="cancel()" style="color:#999999;">取消</span><span @click="confirm()">确定</span></div>
    </div>
    <div class="error_tips"></div>
    <div v-show="show" @click="disappear" class="cover"></div>
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
        responsible:"",
        explain:"",
        value:"",
        value1:"",
        show:false,
        uldate:[{"describe":"","money":"","classify":"","expenseType":""}],
        operator:[],
        spenderKey:"",
        pattern:[{"contacterId": "1", "contacterName": "现金"}, {
                "contacterId": "2",
                "contacterName": "银行转账"
            }, {"contacterId": "3", "contacterName": "信用卡"}, {
                "contacterId": "4",
                "contacterName": "支付宝"
            }, {"contacterId": "5", "contacterName": "微信钱包"}, {"contacterId": "6", "contacterName": "其他"}],
        payType:"1",
        category:[],
        index:"",
        accountType:"",
        expenType:"",
        pathAddress:"",
        title:"",
    }
  },
  created() {
    if(this.$route.params.expenseType==0){
        this.accountType = "01";
        this.expenType = 0;
        this.pathAddress = "/dayaccount";
        this.title = "修改日常费用";
    }else{
        this.accountType = "02";
        this.expenType = 1;
        this.pathAddress = "/salaryaccount";
        this.title = "修改工资费用";
    }
    this.getInfo();
  },
  methods: {
    getInfo() {
    var _this = this;
    var params = "&expenseType="+this.expenType+"&expenseNo="+this.$route.params.expenseNo;
    this.axios.post(address.updateaccount + localStorage.getItem('token'),params)
        .then(function (data) {
           _this.responsible = data.data.data.spenderName;
           _this.spenderKey  = data.data.data.spenderKey;
           _this.value = data.data.data.payDate;
           _this.payType = data.data.data.payType;
           _this.explain = data.data.data.expenseExplain;
           _this.uldate  =[];
           for(var i=0; i<data.data.data.details.length;i++){
                var arr1 = {};
                arr1.describe = data.data.data.details[i].expenseDesc;
                arr1.expenseType = data.data.data.details[i].expenseType;
                arr1.classify = data.data.data.details[i].expenseTypeDesc;
                arr1.money = data.data.data.details[i].money;
                _this.uldate.push(arr1);
           }
        })
        .catch(err => {
            
        })  
    this.axios.get(address.operator + localStorage.getItem('token'))
        .then(function (data) {
            _this.operator = data.data.data;
        })
        .catch(err => {
            
        })
    var paramsObject = "&settingClass="+this.accountType;
    this.axios.post(address.classify + localStorage.getItem('token'),paramsObject)
        .then(function (data) {
            _this.category = data.data;
        })
        .catch(err => {
            
        })  
    },
    datetime(){
        this.value1 = this.value;
        this.show = true;
         $(".foot").slideDown("fast");
    },
    cancel(){
        this.show = false;
        $(".foot").slideUp("fast");
    },
    confirm(){
        this.show = false;
        $(".foot").slideUp("fast");
        this.value = this.value1;
    },
    payment(){
        this.show = true;
        $(".general").slideDown("fast");
    },
    disappear(){
        this.show = false;
        $(".general").slideUp("fast");
        $(".foot").slideUp("fast");
        $(".generalPerson").slideUp("fast");
        $(".detail").slideUp("fast");
    },
    addto(){
        this.uldate.push({"describe":"","money":"","classify":"","expenseType":""})
    },
    choseOne(e,r){
        this.show = false;
        $(".general").slideUp("fast");
        this.payType = e;
    },
     choseTwo(e,r){
        this.show = false;
        this.spenderKey = e;
        this.responsible = r;
        $(".generalPerson").slideUp("fast");

    },
     choseThree(e,r){
        this.show = false;
        $(".detail").slideUp("fast");
        this.uldate[this.index].classify = r;
        this.uldate[this.index].expenseType = e;
    },
    handling(){
        this.show = true;
        $(".generalPerson").slideDown("fast");
    },
    particulars(i){
        this.show = true;
        $(".detail").slideDown("fast");
        this.index = i;
    },
    construction(){
        if(this.responsible==""){
             $(".error_tips").html("请填写经办人").fadeIn(250).delay(500).fadeOut(250);
              return false;
        }else if(this.uldate[0].describe==""){
            $(".error_tips").html("请填写费用描述").fadeIn(250).delay(500).fadeOut(250);
                return false;
            }
        var _this = this;
        var params = {};
        params.expenseNo = this.$route.params.expenseNo;
        params.spenderName = this.responsible;
        params.spenderKey = this.spenderKey;
        params.payType = this.payType;
        params.payDate = this.value;
        params.expenseExplain = this.explain;
        params.expenseType = this.expenType;
        params.details = [];
        for(var i=0;i<this.uldate.length;i++){
            var atttr  = {};
            if(this.uldate[i].money!=""&&this.uldate[i].describe==""){
                $(".error_tips").html("请填写明细描述").fadeIn(250).delay(500).fadeOut(250);
                return false;
            }
            atttr.expenseDesc = this.uldate[i].describe;
            atttr.expenseType = this.uldate[i].expenseType;
            atttr.expenseTypeDesc = this.uldate[i].classify;
            atttr.money = this.uldate[i].money;
            params.details.push(atttr);
        }
        this.axios.post(address.update + localStorage.getItem('token'),params)
        .then(function (data) {
           if(data.data.code == 1){
                 _this.$router.go(-1);
           }
        })
        .catch(err => {
            
        }) 
    }
  }
}
</script>
<style scoped>
@media only screen and (max-height: 560px) {
  .but{
      display: none;
  }
}
@media only screen and (min-height: 561px) {
  .but{
      display: block;
  }
}
.big_one,.big_two{
    font-size: 0.9rem;
    color: #000;
    background: #fff;
}
.big_one li{
    padding-right:1.3rem; 
    margin-left:1.2rem;
    height: 50px;
    line-height: 50px;
    border-top:1px solid #f9f9f9;
}
.big_one li:last-child{
    border: none;
    height: 38px;
    line-height: 38px;
    background: #f6f6f6;
    margin: 0;
    font-size: 12px;
    color:#999;
}
.big_one li:last-child i{
    float: left;
    font-size: 28px;
    color: #999;
    margin:0 5px 0 1.2rem ;
}
.big_one i,.big_two i{
    float: right;
    color:#ccc;
    font-size: 14px;
}
.big_one li span,.big_two span{
    float: right;
    margin-right: 1.1rem;
}
.enter{
    height: 45px;
    border: none;
    margin-left:1.2rem;
    margin-bottom: 4px;
    width: 70%;
    font-size: 0.9rem;
    box-sizing: border-box;
}
.big_two{
    margin-bottom:10px;
}
.big_two li{
    margin-left:1.2rem;
    padding-right:1.3rem;
    height: 50px;
    line-height: 50px;
    border-bottom:1px solid #f2f2f2;
}
.big_two li:last-child{
    border: 0;
}
.add{
    margin-top:15px;
    text-align: center;
    font-size: 0.9rem;
}
.add span{
    position: relative;
    display: inline-block;
    width: 20px;
    height: 20px;
    background: #4284d9;
    text-align: center;
    line-height: 20px;
    border-radius: 50%;
    top:2px;
    left: 8px;
}
.add span i{
    color: #fff;
    font-size: 20px;
}
.but{
    position: fixed;
    bottom: 0;
    height: 69px;
    width: 100%;
    background: #fff;
}
.but button{
    display: block;
    width: 94%;
    margin: 11px auto;
    background: #4284d9;
    color:#fff;
    height: 48px;
    border: none;
    font-size: 1rem;
    outline: none;
}
.general,.generalPerson,.detail{
    overflow: auto;
}
.general p,.generalPerson p,.detail p{
    height: 50px;
    width: 100%;
    line-height: 50px;
    text-align: center;
    border-bottom: 1px solid #f8f8f9;
}
.foot,.general,.generalPerson,.detail{
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
</style>

