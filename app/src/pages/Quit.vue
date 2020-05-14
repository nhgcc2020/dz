<template>
  <div>
    <div class="x-header">
      <back-header>
        <p class="title">切换企业</p>
      </back-header>
    </div>
    <div class="big_first">
      <div @click="quit(l.comKey,l.comType)" class="login_img" v-for="(l,index) in list.data" key="index">
        <img v-if="l.comLogoPath !==''" :src="l.comLogoPath | image" alt="">
        <img v-if="l.comLogoPath ==''" src="../assets/font-awesome/image/login.jpeg" alt="">
        <p class="company_name p">
          <span v-cloak>{{l.comName | firm}}</span>
          <br>
          <span v-cloak>{{l.comShortname}}</span>
        </p>
        <span v-show="list.currentCom == l.comKey" class="now">当前企业</span>
      </div>
      <div @click="exhibition" style="font-size:14px;color:#2e8ae6;line-height:40px;text-align:center;overflow:hidden;">企业和个人版有啥区别 <i style="font-size:30px;position:relative;top:7px;" class="iconfont">&#xe6b8;</i></div>
      <div class="error_tips">正在切换...</div>
      <div v-show="show" class="popup">
        <ul style="overflow:hidden;">
          <li><i @click="close" style="float:right;font-size:30px;margin-right:5px;color:#a0a0a0;" class="iconfont">&#xe6a0;</i></li>
          <li style="font-size:1.3rem;margin-top:20%;text-align:center;">个人版和企业版区别</li>
          <li style="margin-top:12%;padding-left:10%;">
            <img class="popup_img" src="../assets/font-awesome/image/person.png" alt="">
            <span style="display:inline-block;margin-left:9px;position:relative;top:-5px;">
              <p >个人版</p>
              <p style="font-size:0.8rem;color:#999;">作为易对账推广大使，邀请朋友使用</p>
            </span>
          </li>
          <li style="margin-top:8%;padding-left:10%;">
            <img class="popup_img" src="../assets/font-awesome/image/login.jpeg" alt="">
            <span style="display:inline-block;margin-left:8px;position:relative;top:-5px;">
              <p>企业版</p>
              <p style="font-size:0.8rem;color:#999;">可销售开单记账、派工、报价等</p>
            </span>
          </li>
          <li style="margin-top:8%;color:#eb6877;text-align:center;font-size:0.8rem;">企业版需电脑访问 www.yiduizhang.com 登录开通</li>
          <li @click="close" style="position:absolute;bottom:0;height:3.4rem;width:100%;text-align:center;line-height:3.4rem;font-size:1.1rem;color:#2e8ae6;border-top:1px solid #e4e4e4;">我知道了</li>
        </ul>
      </div>
      <div class="cover"></div>
      <div v-show="show" class="over"></div>
    </div>
  </div>
</template>
<script>
import BackHeader from '../common/BackHeader'
import address from '../url.js'
import $ from 'jquery';
export default {
  components: {
    BackHeader
  },
  data() {
    return {
      list: [],
      show: false
    }
  },
  created() {
    this.getInfo();
  },
  methods: {
    getInfo() {
      var _this = this
      this.axios.get(address.quit + localStorage.getItem('token'))
        .then(function (data) {
          _this.list = data.data
        })
        .catch(err => {

        })

    },
    quit(key,type) {
       $(".error_tips").fadeIn(250)
       $(".cover").fadeIn(250)
      var _this = this
      var params = "comKey="+key;
      this.axios.post(address.qute + localStorage.getItem('token'), params)
        .then(function (data) {
          localStorage.setItem('token', data.data.token);
          localStorage.setItem('currentTab', 'Workbench')
          setTimeout(function () {
            if(type==2){
                _this.$router.push('/generalize');
                $(".cover").hide();
            }else{
               _this.$router.push('/home/workbench');
              $(".cover").hide();
            }
          }, 500);
        })
        .catch(err => {

        })
    },
    exhibition(){
      this.show = true;
    },
    close(){
      this.show = false;
    }
  }
}
</script>
<style scoped>
.login_img {
  margin: 0.6rem auto;
  padding: 0 1rem;
  height: 3.5rem;
  background: #fff;
  line-height: 3.5rem;
  z-index: 400;
}
.login_img img {
  width: 2.5rem;
  height: 2.5rem;
  border-radius: 50%;
  float: left;
  margin-top: 0.5rem;
}

.p {
  display: inline-block;
  font-size: .8rem;
}

.company_name {
  font-size: 1rem;
  margin-top: 0.5rem;
  margin-left: 0.5rem;
  line-height: normal;
}

.company_name span:nth-child(3) {
  color: #4f4f4f;
  font-size: .9rem;
}

.vux-header {
  background: #4284d9;
}

.now {
  float: right;
  font-size: 0.8rem;
  color: #f8542e;
}
.error_tips {
  position: fixed;
  height: 4rem;
  line-height: 4rem;
  top: 50%;
  width: 70%;
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
.cover {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    opacity: 0.2;
    z-index: 500;
    background: #fff;
    display: none;
}
.over{
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    opacity: 0.5;
    z-index: 500;
    background: #000;
    /*display: none;*/
}
.popup{
  position: fixed;
  top: 20%;
  left: 7%;
  height: 25rem;
  width: 86%;
  background: #fff;
  border-radius: 10px;
  z-index: 1000;
}
.popup_img{
  height: 2.6rem;
  width: 2.6rem;
  border-radius: 50%;
  background: #eef3fa;
}
</style>