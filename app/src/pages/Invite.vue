<template>
    <div>
        <div class="x-header">
            <back-header>
                <p class="title">邀请加为好友</p>
            </back-header>
        </div>
        <div class="big_first">
            <div class="picture">
                <p><i class="iconfont">&#xe6c8;</i></p>
                <div>成为好友，记/对账相互同步</div>
                <span>给客户开销售单，对方可登陆易对账通过采购查看</span>
            </div>
            <ul>
                <li>1.发送邀请短信</li>
                <li>2.对方通过短信注册易对账</li>
                <li>3.成为好友</li>
            </ul>
            <div class="last">
                <p>{{news.partnerShortname}}</p>
                <p>手机号<input type="text" :value="count" v-model="count" placeholder="请输入手机号"></p>
            </div>
            <div class="hint"><i class="iconfont">&#xe6bc;</i>发送邀请后如对方注册成功，手机号将无法修改</div>
            <div class="sent"><button @click="sent">发送邀请短信</button></div>
            <div class="error_tips"></div>
        </div>
    </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import $ from 'jquery';
import address from '../url.js';
import bus from '../bus.js';
import { mapState, mapGetters } from 'vuex';
export default {
    computed: mapState(['nums']),
    components: {
        BackHeader
    },
    data() {
        return {
            news: "",
            count:""
        }
    },
    created() {
        this.getInfo();
    },
    methods: {
        getInfo() {
            var _this = this;
            setTimeout(function() {
                _this.news = _this.nums;
                _this.count = _this.nums.tel1;
            }, 100);
        },
        sent(){
            var _this = this;
            var params = "partnerKey="+ this.news.partnerKey+"&phone="+this.count
            var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
            if(this.count==""||this.count==null){
                $(".error_tips").html('手机号码不能为空').fadeIn(250).delay(500).fadeOut(250);
            }else if(!myreg.test(this.count)){
                $(".error_tips").html('手机号码不正确').fadeIn(250).delay(500).fadeOut(250);
            }else{
            this.axios.post(address.invite + localStorage.getItem('token'),params)
             .then(function(data) {
               if(data.data.code==1){
                   _this.news.tel1 = _this.count;
                   _this.news.statusValue = "邀请中"
                    $(".error_tips").html('邀请成功<br>等待对方注册').fadeIn(250).delay(500).fadeOut(250);
                    _this.$store.commit('reserve', _this.news);
                    setTimeout(function(){
                        _this.$router.go(-1);
                    },1000)
               }else if(data.data.code==0){
                    $(".error_tips").html('无法邀请<br>该手机用户已注册').fadeIn(250).delay(500).fadeOut(250);
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
.picture{
    background: #fff;
    overflow: hidden;
}
.picture p {
    width: 4rem;
    height: 4rem;
    border-radius: 50%;
    background: #7dc67d;
    margin: 2rem auto;
    line-height: 4rem;
    text-align: center;
}
.picture p i{
    font-size: 4rem;
    color: #fff;
}
.picture>div{
    text-align: center;
    font-size: 1.2rem;
    margin-top:-.5rem;
}
.picture>span{
    display: inline-block;
    width: 100%;
    text-align: center;
    color: #8e8e8e;
    font-size: 0.9rem;
    margin-bottom: 2rem;
}
ul{
    background: #f5f5f9;
    padding: 1rem 1.5rem;
}
ul li{
    color: #44ae80;
    font-size: .9rem;
}
.last{
    background:#fff;
    font-size:1.1rem;
}
.last>p:nth-child(1){
    padding:0.5rem;
    text-align:center;
}
.last>p:nth-child(2){
    padding:0.5rem;
    margin-left: 1rem;
    font-size: 0.9rem;
    border-top:1px solid #F6F6F6;
}
.last>p>input{
    border:none;
    outline:none;
    margin-left: 3rem;
    font-size: 0.9rem;
}
.hint>i{
    position: relative;
    font-size: 1.4rem;
    top: .2rem;
}
.hint{
    font-size: .9rem;
    color: #8e8e8e;
    text-align: center;
    padding: 1rem;
    height: 4rem;
}
.sent{
    width: 100%;
     position: fixed;
     z-index:1000;
     bottom: 10px;
}
.big_first button{
    display: block;
    width:90%;
    height:2.5rem;
    background: #44ae80;
    border: none;
    color: #fff;
    border-radius: 5px;
    font-size: 1rem;
    outline:none;
    margin: 0 auto;
    
}
.error_tips {
  position: absolute;
  padding: 1rem 0;
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
