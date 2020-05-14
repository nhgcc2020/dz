<template>
  <div class="abcd">
    <div class="x-header">
      <back-header>
        <p class="title">修改订单</p>
      </back-header>
    </div>
    <div class="big_first" style="padding-bottom:69px;">
        <ul class="big_one">
            <li @click="handling" style="border:none;"><div style="flex:1">客户</div><div><span v-if="!responsible" style="color:#ccc;">未选择</span><span v-if="responsible">{{responsible}}</span><i class="iconfont">&#xe68b;</i></div></li>
            <li @click="datetime"><div style="flex:1">销售日期</div><div><span>{{value}}</span><i class="iconfont">&#xe68b;</i></div></li>
            <li><input style="margin:0;" class="enter" type="text" placeholder="散单业务概述" v-model="caseDesc"></li>
        </ul>
        <div class="fill"></div>
        <div class="detail" ><div style="flex:1"><i class="iconfont">&#xe6f4;</i>业务明细</div><div><span style="margin-right:6px;">合计：</span><span style="margin-right:0;color:#ee6877;font-size:14px;font-family: 'arial';" id="dM">{{uldate | totalMoney}}</span></div></div>
        <ul v-for="(n,index) in uldate" key="index" class="big_two">
            <li>业务内容<input class="enter" type="text" placeholder="例：背景板" v-model="n.businessDesc"></li>
            <li class="acreage"><span>长（米）<input type="number" placeholder="0.00" v-model="n.length" style="font-size:14px;font-family: 'arial';"></span><span>宽（米）<input type="number" placeholder="0.00" v-model="n.width" style="font-size:14px;font-family: 'arial';"></span></li>
            <li>数量<input class="enter" type="number" placeholder="0" v-model="n.quantity" style="font-size:14px;font-family: 'arial';"></li>
            <li>单价<input class="enter" type="number" placeholder="0.00" v-model="n.unitPrice" style="color:#ee6877;font-size:14px;font-family: 'arial';"><div style="width:61px;color:#999999;text-align:right;">数量计价</div></li>
            <li class="add"><div style="flex:1;"><span @click="remove(index)" style="font-size:12px;color:#ccc;"><i style="font-size:20px;" class="iconfont">&#xe6f1;</i>&nbsp;<span style="position:relative;top:-2px;">删除</span></span><span @click="addto(index)" style="font-size:12px;color:#4284d9;margin-left:18px;"><i style="font-size:20px;color:#4284d9;" class="iconfont">&#xe69d;</i>&nbsp;<span style="position:relative;top:-2px;">新增</span></span></div> <div style="font-size:12px;color:#999;">小计：<span style="margin-left:6px;color:#ee6877;font-size:14px;font-family: 'arial';">{{n.totalPrice | filmoney}}&nbsp;</span></div></li>
        </ul>
    </div>
    
    <div class="but">
        <button @click="construction" :disabled="disabled" :class="{butcor:disabled}">存为草稿</button>
    </div>
    <div class="client">
        <p v-for="(n,index) in operator" key="index" @click="chose(n.partnerKey,n.partnerShortname,n.contacterId,n.contacterName)" >{{n.partnerShortname}}</p>
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
import { DatetimeView, XButton, Popup, TransferDom } from 'vux';
import bus from '../bus.js';
import address from '../url.js';
import $ from 'jquery';
export default {
  components: {
    BackHeader,DatetimeView, XButton, Popup
  },
  directives: {
    TransferDom
  },
  data() {
    return {
        disabled:false,
        responsible:"",
        caseDesc:"",
        value:"",
        value1:"",
        show:false,
        uldate:[],
        operator:[],
        index:"",
        comKey:"",
        scrollY:"",
        saleOrder:"",
        contacterId:"",
        contacterName:""
    }
  },
  created() {
    this.getTime();
    this.getInfo();
  },
  mounted() {
      window.addEventListener('scroll', this.menu)
    },
  watch: {
      uldate: {
      handler: function (newVal) {
        for(var i=0;i<newVal.length;i++){
          newVal[i].totalPrice = newVal[i].quantity * newVal[i].unitPrice;
      }
      },
      deep: true
    }
  },
  methods: {
      menu(){
        this.scrollY = document.body.scrollTop || document.documentElement.scrollTop;
        if(this.scrollY>140){
            $(".detail").addClass("fixation");
            $(".fill").show();

        }else{
            $(".detail").removeClass("fixation");
            $(".fill").hide();
        }
      },
      getTime() {
      var _this = this;
      var time = new Date();
      var year = time.getFullYear();
      var month = time.getMonth()+1;
      var day = time.getDate();
      if(month<10){
        month = "0" + month;
      }
      if(day>=10){
        this.value = year + "-" + month + "-" + day;
      }else{
        this.value = year + "-" + month + "-0" + day;
      }
      var params = "type=1&page=1&rows=30&searchKey=";
      this.axios.post(address.addressbook + localStorage.getItem('token'), params)
          .then(data => {
              this.operator = data.data;
          })
          .catch(err => {
              
          })
   
    },
   getInfo() {
      var params = "salesNo=" + this.$route.params.salesNo;
      this.axios.post(address.particulars + localStorage.getItem('token'), params)
        .then(data => {
            for(var i = 0;i<data.data.details.length;i++){
                data.data.details[i].createTime = null;
                data.data.details[i].creator = "";
            }
            this.uldate = data.data.details;
            this.saleOrder = data.data.saleOrder;
            this.responsible = data.data.saleOrder.partnerShortname;
            this.comKey = data.data.saleOrder.partnerKey;
            this.value = data.data.saleOrder.orderDate;
            this.caseDesc = data.data.saleOrder.caseDesc;
            this.contacterId = data.data.saleOrder.contactId;
            this.contacterName = data.data.saleOrder.contactName;
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
    disappear(){
        this.show = false;
        $(".foot").slideUp("fast");
        $(".client").slideUp("fast");
    },
    remove(i){
       if(this.uldate.length==1){
        $(".error_tips").html("至少保留一条明细行").fadeIn(250).delay(500).fadeOut(250);
       }else{
        this.uldate.splice(i,1);
       }
    },
    addto(i){
        this.uldate.splice(i+1,0,{"businessDesc":"","length":"","width":"","unitPrice":"","quantity":"","totalPrice":0,"priceWay": "02","priceWayDesc": "按数量"});
         // this.uldate.splice(i+1,0,{"additionalPrice":0,"additionalService":"","businessDesc":"","businessType":"00","categoryId":"","colorSize":0,"createTime":"","creator":"","groupBusinessDesc":"","isDel":"0","isUrgent":"0","isValid":"1","itemNo":1,"length":"","orderStatus":"01","orderStatusDesc":"","pairsNum":0,"preferential":0,"priceWay":"02","priceWayDesc":"按数量","quantity":"","remarks":"","requirements":"","salesNo":"","salesOrderDate":null,"specification":"","totalArea":"","totalPrice":0,"uid":"","unit":"","unitPrice":"","width":"","workingProcedure":"","workingStatus":""});
        document.documentElement.scrollTop= this.scrollY+200;
        document.body.scrollTop= this.scrollY+200; 
    },
    chose(e,r,id,name){
        this.show = false;
        $(".client").slideUp("fast");
        this.responsible = r;
        this.comKey = e;
        this.contacterId = id;
        this.contacterName = name;
    },
    handling(){
        this.show = true;
        $(".client").slideDown("fast");
    },
    construction(){
        if(!this.comKey){
            $(".error_tips").html("请选择客户信息").fadeIn(250).delay(500).fadeOut(250);
        } else if(!this.uldate[0].businessDesc&&!this.uldate[0].length&&!this.uldate[0].width&&!this.uldate[0].quantity&&!this.uldate[0].unitPrice){
            $(".error_tips").html("至少填写一条明细行").fadeIn(250).delay(500).fadeOut(250);
        }else{
        this.disabled = true;
        this.saleOrder.changedTime = null;
        this.saleOrder.createTime = null;
        this.saleOrder.contactId = this.contacterId;
        this.saleOrder.contactName = this.contacterName;
        this.saleOrder.discount = "";
        this.saleOrder.discountRate = "";
        this.saleOrder.preferential = "";
        this.saleOrder.partnerShortname = this.responsible;
        this.saleOrder.partnerKey = this.comKey;
        this.saleOrder.orderDate = this.value;
        this.saleOrder.caseDesc = this.caseDesc;
        this.saleOrder.price = $("#dM").text();
        this.saleOrder.totalPrice = $("#dM").text();
        this.saleOrder.salesNo = this.$route.params.salesNo;
        this.saleOrder.orderStatus = "01";
         this.axios.post(address.billingAmend + localStorage.getItem('token'), { "salesOrder": this.saleOrder, "details": this.uldate }, { headers: { 'Content-Type': 'application/json' } })
          .then(data => {
            if(data.data.status == '1'){
                $(".error_tips").html("修改成功").fadeIn(250).delay(500).fadeOut(250);
                setTimeout(function() {
                    this.$router.go(-1);
                    bus.$emit('save');
                }.bind(this), 1000);
            }
          })
          .catch(err => {

          })
        } 
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
.big_one li,.detail{
    display: flex;
    padding-right:1.3rem; 
    margin-left:1.2rem;
    height: 50px;
    line-height: 50px;
    border-top:1px solid #f9f9f9;
}
.fill{
    height: 38px;
    display: none;
}
.detail{
    border: none;
    height: 38px;
    line-height: 38px;
    background: #f6f6f6;
    margin: 0;
    font-size: 12px;
    color:#999;
}
.detail i{
    float: left;
    font-size: 28px;
    color: #999;
    margin:0 5px 0 1.2rem ;
}
.fixation{
  width: 95%;
  position: fixed;
  top:46px;
  z-index: 999;
}
.big_one i,.big_two i{
    color:#ccc;
    font-size: 14px;
}
.big_one li span{
    margin-right: 1.1rem;
}
.enter{
    border: none;
    margin-left:1.2rem;
    width: 65%;
    font-size: 0.9rem;
}
.big_two{
    margin-bottom:10px;
}
.big_two li{
    display: flex;
    margin-left:1.2rem;
    padding-right: 1.3rem;
    height: 50px;
    line-height: 50px;
    border-bottom:1px solid #f9f9f9;
}
.big_two li:last-child{
    border: 0;
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
.but .butcor{
   background: #999999; 
}
.client{
    overflow: auto;
}
.client p{
    height: 50px;
    width: 100%;
    line-height: 50px;
    text-align: center;
    border-bottom: 1px solid #f8f8f9;
}
.acreage{
    display: flex;
}
.acreage span{
   display: inline-block;
   width: 50%;
} 
.acreage input{
   width: 50%;
   border: none;
   margin-left:1.2rem;
}
.add{
  display: flex;
  height: 38px!important;
  line-height: 38px!important;
}
.foot,.client{
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

