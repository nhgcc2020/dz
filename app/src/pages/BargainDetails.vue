<template>
  <div>
    <div class="x-header">
      <back-header>
        <p class="title">详情</p>
      </back-header>
    </div>
    <div class="big_first">
      <div class="header">
        <span v-if="news.signDate" style="flex:1;">签约日期：{{news.signDate}}</span>
        <span v-if="!news.signDate" style="flex:1;color:#ccc;">签约日期：无</span>
        <span>销售代表：{{news.salesName}}</span>
      </div>
      <div class="businessName">
        <p style="display:flex;margin-top:3px;">
          <i style="font-size:30px;color:#999;" class="iconfont">&#xe723;</i>&nbsp;
          <span style="font-size:14px;color:#333;display:inline-flex;align-items:center;">{{news.projectTypeDesc}}</span>
        </p>
        <p style="display:flex;padding-right:22px;margin-top:-15px;">
          <i style="font-size:30px;color:#999;" class="iconfont">&#xe70c;</i>&nbsp;
          <span style="font-size:14px;color:#999;flex:1;display:inline-flex;align-items:center;">{{news.partnerShortname}}</span>
           <i v-if="(/^1[34578]\d{9}$/.test(news.contactTel))" style="font-size:30px;color:#4284d9;" class="iconfont" @click="callphone(news.contactTel)">&#xe683;</i>
        </p>
        <p class="item_p">
          合同日期： {{news.startDate}} - {{news.endDate}}
        </p>
      </div>
      <ul v-if="news.status==01" class="money">
        <li :class="{flamcolor:news.contractMoney!=0}">
          <span>&nbsp;&nbsp; 签约金额</span>
          <span>{{news.contractMoney | filmoney}}</span>
        </li>
        <li :class="{flamcolor:news.actualContractMoney!=0}">
          <span>&nbsp;&nbsp; 实际金额</span>
          <span>{{news.actualContractMoney | filmoney}}</span>
        </li>
        <li :class="{flamcolor:news.returnedContractMoney!=0}">
          <span>&nbsp;&nbsp; 回款金额</span>
          <span>{{news.returnedContractMoney | filmoney}}</span>
        </li>
        <li v-if="news.waitforContractMoney!=0">
          <span style="font-size:14px;color:#000;">待回款金额</span>
          <span style="font-size:18px;color:#eb6877;">{{news.waitforContractMoney | filmoney}}</span>
        </li>
        <li v-if="news.waitforContractMoney==0">
          <span style="font-size:14px;">待回款金额</span>
          <span style="font-size:18px;">0.00</span>
        </li>
      </ul>
      <ul v-if="news.status!=01" class="money">
        <li :class="{flamcolor:news.contractMoney!=0}">
          <span>&nbsp;&nbsp; 签约金额</span>
          <span>{{news.contractMoney | filmoney}}</span>
        </li>
        <li :class="{flamcolor:news.actualContractMoneyy!=0}">
          <span>&nbsp;&nbsp; 实际金额</span>
          <span>{{news.actualContractMoney | filmoney}}</span>
        </li>
        <li v-if="news.returnedContractMoney!=0">
          <span style="font-size:14px;color:#000;">已回款金额</span>
          <span style="font-size:18px;color:#eb6877;">{{news.returnedContractMoney | filmoney}}</span>
        </li>
        <li v-if="news.returnedContractMoney==0">
          <span style="font-size:14px;">已回款金额</span>
          <span style="font-size:18px;">0.00</span>
        </li>
      </ul>
      <div v-if="chitchat.length==0" class="record">
         <router-link tag="p" :to="'/recordbargin/'+$route.params.contractNo">
          <i class="iconfont" style="font-size:30px;color:#999;position:absolute;top:0px;">&#xe6ee;</i>
          <span style="margin-left:35px;">跟进记录</span>
          <i class="iconfont" style="float:right;font-size:14px;color:#ccc;">&#xe68b;</i>
        </router-link>
        <p>可让销售或跟进人发布商机最新进展情况，方便参与者了解</p>
      </div>
      <div v-if="chitchat.length!=0" class="record">
        <router-link tag="p" :to="'/recordbargin/'+$route.params.contractNo">
          <i class="iconfont" style="font-size:30px;color:#4284d9;position:absolute;top:0px;">&#xe6ee;</i>
          <span style="margin-left:35px;">跟进记录</span>
          <i class="iconfont" style="float:right;font-size:14px;color:#ccc;">&#xe68b;</i>
        </router-link>
        <ul>
          <li v-for="(c,index) in chitchat">
            <span style="color:#4284d9;">{{c.chatEmployeeName | spenderName}}：</span>{{c.chatContent | chitcount}}</li>
        </ul>
      </div>
      <div v-if="plans.length==0" class="project">
        <p>
          <i class="iconfont" style="font-size:30px;color:#999;position:absolute;top:0px;">&#xe701;</i>
          <span style="margin-left:35px;">回款计划</span>
        </p>
        <p style="text-align:center;color:#ccc;font-size:12px;line-height:40px;position:relative;top:-10px;">
          <i class="iconfont" style="font-size:26px;position:relative;top:5px;">&#xe6e7;</i> 无计划</p>
      </div>
      <div v-if="plans.length!=0" class="substance">
        <p>
          <i class="iconfont" style="font-size:30px;color:#f26628;position:absolute;top:0px;">&#xe701;</i>
          <span style="margin-left:35px;">回款计划</span>
        </p>
        <div v-for="p in plans">
          <span>{{p.planReturnDate}}&#x3000;
            <span v-for="d in p.planRemindContactName" class="people">{{d | spenderName}}</span>
          </span>
          <span>{{p.planReturnMoney | filmoney}}</span>
        </div>
      </div>
      <div v-if="invioces.length==0" class="project">
        <p>
          <i class="iconfont" style="font-size:30px;color:#999;position:absolute;top:0px;">&#xe6d3;</i>
          <span style="margin-left:35px;">开票记录</span>
        </p>
        <p style="text-align:center;color:#ccc;font-size:12px;line-height:40px;position:relative;top:-10px;">
          <i class="iconfont" style="font-size:26px;position:relative;top:5px;">&#xe6e7;</i> 无开票</p>
      </div>
      <div v-if="invioces.length!=0" class="substance">
        <p>
          <i class="iconfont" style="font-size:30px;color:#f26628;position:absolute;top:0px;">&#xe6d3;</i>
          <span style="margin-left:35px;">开票记录</span>
        </p>
        <div v-for="v in invioces">
          <span>{{v.invoiceDate}}&#x3000;
            <span class="people">{{v.drawerName | spenderName}}</span>
          </span>
          <span>{{v.invoiceMoney | filmoney}}</span>
        </div>
      </div>
      <div v-if="returnMoneys.length==0" class="project">
        <p>
          <i class="iconfont" style="font-size:30px;color:#999;position:absolute;top:0px;">&#xe67a;</i>
          <span style="margin-left:35px;">回款记录</span>
        </p>
        <p style="text-align:center;color:#ccc;font-size:12px;line-height:40px;position:relative;top:-10px;">
          <i class="iconfont" style="font-size:26px;position:relative;top:5px;">&#xe6e7;</i> 无回款</p>
      </div>
      <div v-if="returnMoneys.length!=0" class="substance">
        <p>
          <i class="iconfont" style="font-size:30px;color:#f26628;position:absolute;top:0px;">&#xe67a;</i>
          <span style="margin-left:35px;">回款记录</span>
        </p>
        <div v-for="r in returnMoneys">
          <span>{{r.returnDate}}&#x3000;
            <span class="people">{{r.payeeName | spenderName}}</span>
          </span>
          <span>{{r.returnMoney | filmoney}}</span>
        </div>
      </div>
      <ul class="ul_fore">
        <li>合同状态 :&nbsp;&nbsp;
          <span style="color:#f26628;">{{news.status | contractStatus}}</span>
        </li>
        <li style="border-bottom:1px solid #f9f9f9;padding-bottom:10px;">合同单号 :&nbsp;&nbsp; {{news.contractNo}}</li>
        <li>客户签约 :&nbsp;&nbsp; {{news.partnerSignerName}}</li>
        <li>我方签约 :&nbsp;&nbsp; {{news.ourSignerName}}</li>
        <li>关联商机 :&nbsp;&nbsp;
          <p class="relevance">
            <span v-for="p in news.oppoNo">{{p}}</span>
          </p>
        </li>
        <li>制单时间 :&nbsp;&nbsp; {{news.createTime}}</li>
      </ul>
      <div style="text-align: center;padding:1rem 0;color:#ccc;font-size:.8rem;">——我是有底线的——</div>
      <div class="release">
        <i class="iconfont">&#xe6ee;</i>
        <input type="text" placeholder="填写最新的进展情况" v-model="chatcount">
        <span @click="announce">发布</span>
      </div>
      <div class="cover"></div>
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
import BackHeader from '../common/BackHeader';
import $ from 'jquery';
import address from '../url.js';
export default {
  components: {
    BackHeader
  },
  data() {
    return {
      news: "",
      chitchat: "",
      plans: "",
      invioces: "",
      returnMoneys: "",
      chatcount: "",
      show1:false,
      showding:true
    }
  },
  created() {
    this.getInfo();
  },
  methods: {
    getInfo() {
      this.axios.get(address.Bargaindetails + localStorage.getItem('token') + "&contractNo=" + this.$route.params.contractNo)
        .then(data => {
          this.news = data.data.contract;
          this.news.oppoNo = this.news.oppoNo.split(',');
          this.plans = data.data.plans;
          for (var i = 0; i < this.plans.length; i++) {
            this.plans[i].planRemindContactName = this.plans[i].planRemindContactName.split('、')
          }
          this.invioces = data.data.invioces;
          this.returnMoneys = data.data.returnMoneys;
          this.showding = false;
        })
        .catch(err => {

        })
      this.axios.get(address.chatbargain + localStorage.getItem('token') + "&contractNo=" + this.$route.params.contractNo + "&page=1&rows=2")
        .then(data => {
          this.chitchat = data.data.rows;
        })
        .catch(err => {

        });
    },
    announce() {
      if(this.chatcount){
        this.axios.post(address.chatbargainsave + localStorage.getItem('token'), { "oppoNo": this.$route.params.contractNo, "chatContent": this.chatcount }, { headers: { 'Content-Type': 'application/json' } })
        .then(data => {
          if (data.data.code == 1) {
            $(".error_tips").html("发布成功").fadeIn(250).delay(800).fadeOut(250);
            this.chatcount = "";
            this.axios.get(address.chatbargain + localStorage.getItem('token') + "&contractNo=" + this.$route.params.contractNo + "&page=1&rows=2")
              .then(data => {
                this.chitchat = data.data.rows;
              })
              .catch(err => {

              });
          }
        })
        .catch(err => {
          
        })
      }else{
        $(".error_tips").html("内容不能为空").fadeIn(250).delay(800).fadeOut(250);
      }
      
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
    }
  }
}
</script>
<style scoped>
.big_first {
  overflow: hidden;
}

.header {
  display: flex;
  height: 46px;
  align-items: center;
  color: #01a09a;
  font-size: 14px;
  background: #fff;
  box-sizing: border-box;
  padding: 0 22px;
  border-bottom: 1px solid #f2f2f2;
}

.money {
  background: #fff;
  box-sizing: border-box;
  padding: 8px 22px 13px 22px;
  border-top: 1px solid #f2f2f2;
  margin-bottom: 10px;
}

.money li {
  display: flex;
  color: #ccc;
  margin-top: 5px;
}

.money li span:nth-child(1) {
  flex: 1;
  font-size: 12px;
}

.money li span:nth-child(2) {
  font-size: 14px;
  font-family: 'arial';
}

.money .flamcolor {
  color: #999;
}

.ul_fore {
  margin-top: 0.7rem;
  background: #fff;
  padding-left: 1.2rem;
  padding-bottom: 0.5rem;
}

.ul_fore li i {
  font-size: 1.5rem;
}

.ul_fore li {
  font-size: 12px;
  padding-top: 10px;
  color: #999;
}

.relevance {
  display: inline-flex;
  width: 75%;
  justify-content: flex-start;
  flex-wrap: wrap;
}
.relevance span{
  display: inline-block;
  width: 50%;
}
.relevance span:nth-child(2n){
  text-align: right;
}
.record,
.project,
.substance {
  box-sizing: border-box;
  padding: 0 22px;
  background: #fff;
  margin-bottom: 10px;
  position: relative;
  overflow: hidden;
}

.record p:nth-child(1),
.project p:nth-child(1),
.substance p:nth-child(1) {
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

.substance>div {
  display: flex;
  font-size: 12px;
  color: #999;
  align-items: center;
  margin-bottom: 10px;
}

.substance>div>span:nth-child(1) {
  flex: 1;
}

.substance>div>span:nth-child(2) {
  font-size: 14px;
  font-family: 'arial';
}
.people {
  display: inline-flex;
  width: 26px;
  height: 26px;
  justify-content: center;
  box-sizing: border-box;
  padding: 6px 0;
  border-radius: 50%;
  border: 1px solid #f2f2f2;
  font-size: 10px;
  margin-right: 6px;
}
.release {
  position: fixed;
  width: 100%;
  height: 50px;
  background: #fff;
  bottom: 0;
  border-top: 1px solid #f2f2f2;
  align-content: flex-start;
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
.businessName {
  overflow: hidden;
  box-sizing: border-box;
  padding-left: 22px;
  background: #fff;
}
.item_p {
  display: flex;
  padding-right: 22px;
  height: 42px;
  align-items: center;
  font-size: 12px;
  color: #999;
  justify-content: flex-end;
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
.know{
    padding: .8rem 0;
    display: inline-block;
    width: 48%;
    text-align: center;
}
.none{
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