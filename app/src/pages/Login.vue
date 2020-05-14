
<template>
  <div style="overflow: hidden;">
    <div class="first">
      <div class="header_one">
        <img src="../assets/font-awesome/image/denglu.png" alt="">
      </div>
      <group class="grpSec" style="background-color:transparent;">
        <x-input name="userId" placeholder="输入手机号" keyboard="number" :max="11" v-model="user"></x-input>
        <x-input name="password" type="password" placeholder="输入登录密码" v-model="password"></x-input>
      </group>
      <div>
        <x-button @click.native="gologin">登录</x-button>
        <x-button @click.native="register">注册</x-button>
      </div>
    </div>
    <div class="numberone">
      <div class="explain">体验更多强大功能，请通过电脑登录</div>
      <div class="explain_two">
        <a href="https://www.yiduizhang.com" style="color:#26c807;">
          <i class="iconfont" style="position:relative;top:.2rem;">&#xe6cf;</i> www.yiduizhang.com</a>
      </div>
    </div>
    <div class="prompt">密码错误</div>
    <div class="floot">Copyright@2016 上海仁石科技有限公司</div>
  </div>
</template>
<script>
import { XInput, Group, XButton, Cell } from 'vux'
import querystring from 'querystring'
import ajax from '../assets/ajax.js'
import $ from 'jquery'
import address from '../url.js'
export default {
  data() {
    return {
      user: "",
      password: "",
      show: false
    }
  },
  components: {
    XInput, Group, XButton, Cell
  },
  created() {
    JAnalytics.onPageStart({'pageName': '登录页'});
  },
  destroyed() {
    JAnalytics.onPageEnd({'pageName': '登录页'});
  },
  methods: {
    gologin() {
      if (this.user == "") {
        this.show = true
        $(".prompt").text('请输入手机号！').fadeIn(250).delay(500).fadeOut(250)
      } else if (this.password == "") {
        this.show = true
        $(".prompt").text('请输入密码！').fadeIn(250).delay(500).fadeOut(250)
      } else {
        // 18516772416
        var params = "userId=" + this.user + "&password=" + this.password;
        // params.append('userId', this.user);
        // 

        // params.append('password', this.password);
        this.axios.post(address.login, params)
          .then(data => {
            if (data.data.code == 5) {
              localStorage.setItem('token', data.data.token);
              this.$router.push('/home/workbench');
            } else {
              this.show = true
              $(".prompt").text("用户名或密码错误！").fadeIn(250).delay(500).fadeOut(250)
            }
          })
          .catch(err => {
            // console.log(err)
          })

        // $.post(address.login,{userId:this.user,password:this.password})
        // .done(function (data) {
        //   debugger;
        //   
        //   }else{
        //      jump.show = true
        //     $(".prompt").text("用户名或密码错误请重新输入！")
        //   }
        // })
        // .fail(function(err){
        //      console.log(err)

        // })
      }
    },
    register() {
      window.location.href = 'http://www.yiduizhang.com';
      // cordova.InAppBrowser.open('http://www.yiduizhang.com','_blank', 'location=no,toolbar=yes,toolbarposition=top,closebuttoncaption=关闭')
    }
  }
}
</script>
<style scoped>
@media only screen and (max-height: 560px) {
  .floot,.numberone {
    display: none;
  }
}

.first {
  margin: 0 2rem;
  position: relative;
}

.header_one {
  text-align: center;
  margin-top: 19%;
  height: 8.8rem;
}

.header_one img {
  width: 13rem;
  height: 8.7rem;
}

.weui-cell {
  border-color: transparent;
  font-size: 0.9rem;
  padding: 6%;
}

.weui-cell:nth-child(2) {
  padding: 7% 6%;
  font-size: 0.9rem;
}

.weui-cell:before {
  left: 0;
  color: #f1f1f1;
}

.weui-btn_default {
  margin: 13% auto 4%;
  background: #4d86ce;
  color: #fff;
  border-radius: .3rem;
  font-size: 0.9rem;
  height: 3.1rem;
}

.weui-btn_default:nth-child(2) {
  background: #fff;
  color: #4d86ce;
  border-radius: .3rem;
  border: 1px solid #4d86ce;
}

.weui-btn:after {
  border: none;
}

.clue {
  height: 3rem;
}

.prom {
  display: inline-block;
  line-height: 3rem;
}

.prom i {
  float: left;
  font-size: 1.3rem;
  color: red;
}

.prompt {
  position: absolute;
  top: 30%;
  height: 4rem;
  line-height: 4rem;
  width: 40%;
  left: 30%;
  right: 30%;
  background: #3c3c3c;
  text-align: center;
  border-radius: .5rem;
  padding: 0.5rem;
  display: none;
  color: #F6F6F6;
  font-size: 0.8rem;
}

.floot {
  position: fixed;
  width: 80%;
  text-align: center;
  bottom: 8px;
  font-size: 0.5rem;
  left: 10%;
  right: 10%;
  color: #adadad;
}

.explain {
  text-align: center;
  font-size: 0.8rem;
  color: #999;
}

.explain_two {
  text-align: center;
  color: #26c807 !important;
  font-size: .8rem;
  margin-top: .3rem;
}
.numberone{
  width: 100%;
  position: fixed;
  bottom:6%;
  z-index: -1;
}
</style>

