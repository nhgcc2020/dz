<template>
  <div>
    <div>
      <div class="login_img">
        <div>
          <img style="border-radius: 50%;" v-if="news.comLogoPath !==''" :src="news.comLogoPath | image" alt="">
          <img style="border-radius: 50%;" v-if="news.comLogoPath ==''" src="../../assets/font-awesome/image/seft.png" alt="">
        </div>
        <p class="company_name">
          {{news.realName}}
        </p>
      </div>
      <div class="second">
        <router-link tag="span" to="/personal">
          <i class="iconfont">&#xe672;</i>账户</router-link>
        <span @click="hint">
          <i class="iconfont">&#xe6b8;</i>教程</span>
      </div>
      <div @click="award" class="image">
        <span>
          <img src="../../assets/font-awesome/image/person.png" alt="">
        </span>
        <span>
          <p style="font-size:1rem;margin-top:.5rem;">成为易对账推广大使</p>
          <p style="font-size:.8rem;">在家也能赚小钱</p>
        </span>
        <span>
          <p style="width:4.7rem;height:1.6rem;text-align:center;line-height:1.6rem;background:#fdb94e;border-radius: 2rem;color:#fff;font-size:.8rem;margin-top:1.4rem;">了解详情</p>
        </span>
      </div>
      <router-link class="firm" tag="div" to="/basic">
        <i class="iconfont color" style="font-size:1.4rem;">&#xe6d0;</i>
        <p style="margin-left:.6rem;">当前公司</p>
        <i class="iconfont many" style="color:#ccc;">&#xe68b;</i>
        <span class="cut_child">
          <span v-cloak>{{news.comName | firm}}</span>
        </span>
      </router-link>
      <router-link class="cut" tag="div" to="/quit" style="position:relative;border-top:1px solid #F6F6F6;">
        <i class="iconfont color" style="font-size:1.4rem;">&#xe6dd;</i>
        <p style="margin-left:.6rem;">切换公司</p>
        <i class="iconfont" style="position: absolute;right:1.1rem;color:#ccc;">&#xe68b;</i>
      </router-link>
      <router-link @click.native="hint" tag="div" to="" class="cut" style="margin-top:.7rem;">
        <i class="iconfont color" style="color:#ff9918;">&#xe6bb;</i>
        <p>消息设置</p>
        <i class="iconfont many">&#xe68b;</i>
      </router-link>
      <div class="cut">
        <i class="iconfont color" style="color:#ff9918;">&#xe681;</i>
        <p>版本</p>
        <span class="cut_child" style="margin-right: 1rem;">
          {{versions}}
        </span>
      </div>
      <div class="foot">
        <img src="../../assets/font-awesome/image/logo.png">
      </div>
    </div>
    <div class="error_tips">努力开发中，敬请期待</div>
  </div>
</template>

<script>
import { Actionsheet, TransferDom } from 'vux';
import address from '../../url.js';
import $ from 'jquery';
export default {
  directives: {
    TransferDom
  },
  components: {
    Actionsheet
  },
  data() {
    return {
      news: "",
      versions: ""

    }
  },
  created() {
    this.getInfo();
  },
  methods: {
    getInfo() {
      // console.log(localStorage.getItem('token'))
      // this.$router.push('/login');
      // 
      var _this = this
      this.axios.get(address.personal + localStorage.getItem('token'))
        .then(function (data) {
          if (data.data.code == -1) {
            _this.$router.push('/login');
          } else {
            _this.news = data.data.data;
          }
        })
        .catch(err => {

        })
      cordova.getAppVersion.getVersionNumber().then(function (version) {
        _this.versions = version;
      });
    },
    hint() {
      $(".error_tips").fadeIn(250).delay(500).fadeOut(250)
    },
    award() {
      var _this = this;
      this.axios.get(address.quit + localStorage.getItem('token'))
        .then(function (data) {
          $.each(data.data.data, function (i, n) {
            if (n.comType == 2) {
              var params = "comKey=" + n.comKey;
              _this.axios.post(address.qute + localStorage.getItem('token'), params)
                .then(function (data) {
                  localStorage.setItem('token', data.data.token);
                  _this.$router.push('/generalize');
                })
                .catch(err => {
                })
            }
          })
        })
        .catch(err => {

        })
    }
  }
}
</script>
<style scoped>
.login_img {
  padding-top: 37px;
  padding-left: 20px;
  height: 5.8rem;
  /*background: #fff;*/
  line-height: 5rem;
  border-bottom: 1px solid #F6F6F6;
}

.login_img>div {
  width: 3.9rem;
  height: 3.9rem;
  float: left;
  margin-top: 0.5rem;
  border-radius: 50%;
  border: 1px solid #1e88e5;
  padding: .2rem;
  box-sizing: border-box;
  overflow: hidden;
}

.login_img>div>img {
  width: 100%;
  height: 100%;
}

.many {
  float: right !important;
  color: #ccc;
}

p {
  display: inline-block;
  font-size: 1rem;
}

.company_name {
  font-size: 1.1rem;
  margin-left: 1rem;
  font-family: "幼圆";
  color: #333;
}

.company_name span:nth-child(3) {
  color: #4f4f4f;
  font-size: .9rem;
}

.color {
  color: #0081ff;
  font-size: 1.6rem;
}

.firm {
  line-height: 3rem;
  margin-top: .7rem;
  height: 3rem;
  background: #fff;
  padding: 0 1.1rem;
  border-top: 1px solid #F6F6F6;
}

.firm .color {
  float: left;
}

.firm p {
  margin-left: .5rem;
  float: left;
}

.cut {
  line-height: 3rem;
  height: 3rem;
  background: #fff;
  padding: 0 1.1rem;
  border-bottom: 1px solid #F6F6F6;
}

.cut .color {
  float: left;
}

.cut p {
  margin-left: .5rem;
  float: left;
}

.cut_child {
  float: right;
  font-size: 0.9rem;
  font-family: "幼圆";
  color: #999;
  height: 3rem;
}

.vux-header {
  background: #fff;
  padding: 0 !important;
}

.second {
  background: #fff;
  height: 2.9rem;
  line-height: 2.5rem;
  display: flex;
  justify-content: center;
}

.second>span {
  display: inline-block;
  width: 50%;
  text-align: center;
  color: #4284d9;
  font-size: .9rem;
}

.second>span>i {
  position: relative;
  font-size: 1.8rem;
  top: .3rem;
}

.image {
  height: 4.4rem;
  background: #ff5555;
  display: flex;
  justify-content: center;
}

.image>span:nth-child(1) {
  display: inline-block;
  width: 27%;
  text-align: right;
}

.image>span:nth-child(2) {
  display: inline-block;
  width: 45%;
  text-align: center;
  color: #fff;
}

.image>span:nth-child(3) {
  display: inline-block;
  width: 28%;
  text-align: center;
}

.image img {
  margin-top: 0.7rem;
  height: 3.5rem;
  width: 3.5rem;
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

.foot {
  position: fixed;
  bottom: 4rem;
  width: 100%;
  z-index: -1;
}

.foot>img {
  display: block;
  width: 10rem;
  height: 3rem;
  margin: 0 auto;
}
</style>