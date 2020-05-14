<template>
  <div>
    <div class="x-header">
      <back-header>
        <p class="title">销售单列表</p>
      </back-header>
    </div>
    <v-scroll :on-refresh="onRefresh" :on-infinite="onInfinite" :dataList="scrollData">
      <div>
        <div class="sare_time" v-for="(n,index) in news" key="index">
          <router-link tag="div" :to="'/particulars/'+ n.salesNo">
            <ul class="sare_ul">
              <li class="sare_one" v-cloak>
                <i class="iconfont">&#xe69b;</i>&nbsp;&nbsp;
                <span>{{n.partnerShortname}}</span>
              </li>
              <li class="sare_two" v-cloak>
                <span>{{n.orderDate}}</span>
                <span>{{(n.totalPrice).toFixed(2)}}</span>
              </li>
              <li class="sare_three" v-cloak>{{n.caseDesc | casedesc}}</li>
            </ul>
          </router-link>
        </div>
      </div>
    </v-scroll>
    <div v-if="showding" class="la-timer" style="position: absolute;top:45%;left:45%;">
                <div></div>
            </div>
    <div class="error_tips">没有数据...</div>
  </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import address from '../url.js';
import $ from 'jquery';
import VScroll from '../common/VScroll';
import { mapState, mapGetters } from 'vuex';
export default {
  computed: mapState(['message']),
  components: {
    BackHeader, VScroll
  },
  data() {
    return {
      news: [],
      scrollTop: 0,
      pageSize: 20,
      pageNo: 1,
      totalPage: "",
      showding:true,
      scrollData: {
        noFlag: false //暂无更多数据显示
      }
    }
  },
  created() {
    this.getInfo(this.pageSize, this.pageNo);
  },
  methods: {
    getInfo(pageSize, pageNo) {
      var _this = this
      var params = "pageSize="+pageSize+"&pageNo="+pageNo+"&orderStatus=04&isSynchro=1&startTime="+this.message.startTime+"&endTime="+this.message.endTime+"&partnerKey="+this.message.partnerKey;
      this.axios.post(address.report + localStorage.getItem('token'), params)
        .then(function (data) {
          _this.showding = false;
          if (data.data.data.length == 0) {
            $(".error_tips").fadeIn(250).delay(500).fadeOut(250)
          }
          _this.totalPage = data.data.totalPage
          _this.news = _this.news.concat(data.data.data)
        })
        .catch(err => {

        })
    },
     onRefresh(done) {
      this.news = [];
      this.pageSize = 20;
      this.pageNo = 1;
      this.getInfo(this.pageSize, this.pageNo);

      done(); // call done

    },
    onInfinite(done) {
      this.pageNo++;
      this.pageSize = 10;
      let more = this.$el.querySelector('.load-more')
        if (this.totalPage<this.pageNo) {
          more.style.display = 'none'; //隐藏加载条
          //走完数据调用方法
          this.scrollData.noFlag = true;
          setTimeout(function() {
          this.scrollData.noFlag = false;
          }.bind(this), 1000);
        } else {
          this.getInfo(this.pageSize, this.pageNo);
          more.style.display = 'none'; //隐藏加载条
        }
      
      done();
    }
    // <ul class="quit">
    //     <li @click="quitlist(0)">全部</li>
    //     <li @click="quitlist(1)">待对账</li>
    //     <li @click="quitlist(2)">已对账</li>
    //     <li class="active" @click="quitlist(3)">草稿箱</li>
    //   </ul>
    // quitlist(num){
    //   $(".quit li").eq(num).addClass("active").siblings().removeClass("active")
    // }
  }
}
</script>
<style scoped>
.sare_time {
  background: #fff;
  margin: 0.8rem auto;
}
.vux-header {
  background: #4284d9;
}
.sare_ul{
  position: relative;
  padding-left: 1.1rem;
}
.sare_ul i{
  font-size: 2rem;
  color: #4d86ce;
}
.sare_two span:nth-child(2){
  float: right;
  margin-right: 1.2rem;
  font-size: 1.1rem;
  color: #d80404;
  margin-top: -0.3rem;
}
.sare_one span{
  position: absolute;
  font-size: 1rem;
  top:1rem;
}
.sare_two{
  height: 1.3rem;
  margin-top: -.5rem;
  margin-bottom: .5rem;
  font-size: 0.9rem;
}
.sare_three{
  border-top: 1px solid #F6F6F6;
  font-size: 0.9rem;
  color: #adadad;
  padding: .5rem 0;
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
/*.quit{
  top:49px;
  width: 100%;
  position: fixed;
  justify-content: center;
  background: #fff;
  border-bottom:1px solid #ccc;
}
.quit li{
  display: inline-block;
  width: 24%;
  text-align: center;
  padding: 1rem 0;
}
.active{
  border-bottom:2px solid #2e8ae6;
}*/
</style>

