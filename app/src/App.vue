<template>
  <div id="app">
    <transition v-on:enter="enter" :name="slide">
      <keep-alive>
        <router-view style="background: #f8f8f8;" v-if="$route.meta.keepAlive"></router-view>
      </keep-alive>
    </transition>
    <transition v-on:enter="enter" :name="slide">
      <router-view style="background: #f8f8f8;" v-if="!$route.meta.keepAlive"></router-view>
    </transition>
    <div class="coverbig"></div>
    <div class="error_ti">请检查网络</div>
  </div>
</template>

<script>
import bus from './bus.js';
import $ from 'jquery';
export default {
  name: 'app',
  data() {
    return {
      slide: "slide"
    }
  },
  mounted() {
    bus.$on('back', this.callback);
    this.BackKeyDown();
  },
  methods: {
    callback(i) {
      var _this = this;
      this.slide = "slide-back";
      if (i == 2) {
        this.$router.go(-2);
      } else if(this.$route.path.indexOf("tasking") > 0){
        this.$router.replace("/design");
      }else if(this.$route.path.indexOf("stylist")>0){
        this.$router.replace("/tasking/"+this.$route.params.salesNo);
      }else{
        this.$router.go(-1);
      }
      setTimeout(function () {
        _this.slide = "slide";
      }, 500);
      // JAnalytics.onPageEnd({'pageName': 'home.vue'});
    },
    BackKeyDown() {
      var _this = this
      document.addEventListener("backbutton", onBackKeyDown, false);
      document.addEventListener("offline", onOffline, false);
      function onBackKeyDown(e) {
        if (_this.$route.path.indexOf("home") > 0) {
          navigator.app.exitApp();
        } else {
          e.preventDefault();
          _this.callback();
        }
      };
      function onOffline() {
        $(".error_ti").fadeIn(250).delay(500).fadeOut(250)
      }
    },
    enter() {
      $(".coverbig").fadeIn(100).delay(100).fadeOut(90);
    }
  }
}
$(function () {
  new function () {
    var _self = this;
    _self.height = 1300; // 设置默认最大宽度
    _self.fontSize = 32; // 默认字体大小
    _self.heightProportion = function () {
      var p = (document.body && document.body.clientHeight || document.getElementsByTagName("html")[0].offsetHeight) / _self.height; return p > 1 ? 1 : p < 0.5 ? 0.5 : p;
    };
    _self.changePage = function () {
      document.getElementsByTagName("html")[0].setAttribute("style", "font-size:" + _self.heightProportion() * _self.fontSize + "px !important");
    }
    _self.changePage();
    window.addEventListener('resize', function () { _self.changePage(); }, false);
  };
})
</script>

<style lang="less">
@import '~vux/src/styles/reset.less';

body {
  background-color: #fbf9fe;
}

#app {
  height: 100%;
}

.slide-enter {
  transform: translate3d(100%, 0, 0);
}

.slide-back-enter {
  transform: translate3d(0, 0, 0);
}




// *********************************************
.slide-enter-active {
  transition: all .3s linear;
  will-change: transform;
  height: 100%;
  width: 100%;
  top: 0;
  position: fixed;
  backface-visibility: hidden;
  z-index: 100000;
}

.slide-leave-active {
  transition: all .3s linear; // transform: translateX(-80%);
  will-change: transform;
  height: 100%;
  width: 100%;
  top: 0;
  opacity: 0;
  position: fixed;
  backface-visibility: hidden;
  z-index: -1;
}

.slide-back-leave-active {
  transform: translateX(100%);
  transition: all .3s linear;
  will-change: transform;
  height: 100%;
  width: 100%;
  top: 0;
  position: fixed;
  backface-visibility: hidden;
  z-index: 100000;
}


// slide-back-leave-active slide-back-leave-to
// footerlists slide-back-enter-active slide-back-enter-to
// footerlists slide-leave-active slide-leave-to
// slide-enter-active slide-enter-to
.slide-back-enter-active {
  transition: all .3s linear;
  will-change: transform;
  height: 100%;
  width: 100%;
  top: 0; // opacity: 0;
  position: fixed;
  backface-visibility: hidden;
  z-index: -1;
}


// *******************************************************
.error_ti {
  position: fixed;
  height: 4rem;
  line-height: 4rem;
  top: 40%;
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

.coverbig {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 110%;
  opacity: 0.2;
  z-index: 80;
  display: none;
  background: #000;
}
</style>


