<template>
  <div style="height:100%;">
    <div class="x-header">
      <back-header>
        <p class="title">跟进记录</p>
      </back-header>
    </div>
    <div class="big_first">
    <div class="follow">
      <div style="flex:1;">跟进人</div>
      <div class="person">
        <span v-for="(t,index) in trail" key="index">{{t.realName | spenderName}}</span>
      </div>
    </div>
    <v-scroll :on-refresh="onRefresh" :on-infinite="onInfinite" :dataList="scrollData">
      <ul class="chitchat">
        <li v-for="(n,index) in news" key="index">
          <p>
            <span style="flex:1;font-size:14px;color:#4284d9;">{{n.chatEmployeeName}}</span>
            <span style="color:#999;font-size:12px;">{{n.createTime}}</span>
          </p>
          <p>{{n.chatContent}}</p>
        </li>
      </ul>
    </v-scroll>
    </div>
    <div class="release">
      <i class="iconfont">&#xe6ee;</i>
      <input type="text" placeholder="填写最新的进展情况" v-model="chatcount">
      <span @click="announce">发布</span>
    </div>
    <div class="error_tips">没有数据...</div>
  </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import $ from 'jquery';
import VScroll from '../common/VScroll';
import address from '../url.js';
export default {
  components: {
    BackHeader, VScroll
  },
  data() {
    return {
      news: [],
      pageSize: 20,
      pageNo: 1,
      totalPage: "",
      chatcount: "",
      trail:[],
      iSchat:false,
      scrollData: {
        noFlag: false //暂无更多数据显示
      }
    }
  },
  created() {
    this.getPeople();
    this.getInfo(this.pageNo, this.pageSize,);
  },
  methods: {
    getPeople(){
      this.axios.get(address.partbargin + localStorage.getItem('token') + "&contractNo=" + this.$route.params.contractNo)
       .then(data => {
          this.trail = data.data.data;
       })
       .catch(err => {

       })
    },
    getInfo(page, rows) {
      this.axios.get(address.chatbargain + localStorage.getItem('token') + "&contractNo=" + this.$route.params.contractNo + "&page=" + page + "&rows=" + rows)
        .then(data => {
          this.totalPage = data.data.totalPage;
          if(this.iSchat){
              this.news = data.data.rows;
          }else{
            this.news = this.news.concat(data.data.rows);
          }
        })
        .catch(err => {

        });
    },
    onRefresh(done) {
      this.news = [];
      this.pageSize = 20;
      this.pageNo = 1;
      this.getInfo(this.pageNo, this.pageSize);
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
        this.getInfo(this.pageNo, this.pageSize);
        more.style.display = 'none'; //隐藏加载条
      }
      done();
    },
    announce() {
      if(this.chatcount){
        this.axios.post(address.chatbargainsave + localStorage.getItem('token'), { "oppoNo": this.$route.params.contractNo, "chatContent": this.chatcount }, { headers: { 'Content-Type': 'application/json' } })
        .then(data => {
          if (data.data.code == 1) {
            $(".error_tips").html("发布成功").fadeIn(250).delay(800).fadeOut(250);
            this.chatcount = "";
            this.iSchat = true;
            this.getInfo(this.pageNo, this.pageSize);
          }
        })
        .catch(err => {
            // console.log(err) 
        })
      }else{
        $(".error_tips").html("内容不能为空").fadeIn(250).delay(800).fadeOut(250);
      }
    }
  }
}

</script>
<style scoped>
.big_first {
  background: #fff;
}

.follow {
  display: flex;
  height: 50px;
  align-items: center;
  box-sizing: border-box;
  margin-left: 22px;
  padding-right: 22px;
  border-bottom: 1px solid #f2f2f2;
}

.follow div:nth-child(1) {
  font-size: 14px;
  color: #000;
}

.person span {
  display: inline-flex;
  height: 30px;
  width: 30px;
  border-radius: 50%;
  background: #01a09a;
  font-size: 12px;
  color: #fff;
  align-items: center;
  justify-content: center;
  margin-left: 5px;
}

.chitchat {
  box-sizing: border-box;
  padding: 0 22px;
}

.chitchat li p:nth-child(1) {
  display: flex;
  margin-top: 23px;
}

.chitchat li p:nth-child(2) {
  color: #666;
  font-size: 14px;
  margin-top: 2px;
  line-height: 28px;
}

.release {
  position: fixed;
  width: 100%;
  height: 50px;
  background: #fff;
  bottom: 0;
  border-top: 1px solid #f2f2f2;
  z-index: 999;
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

.yo-scroll {
  top: 96px !important;
  bottom: 50px !important;
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