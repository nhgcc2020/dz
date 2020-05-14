<template>
  <div>
    <div class="x-header">
      <back-header>
        <p class="title">设计派工</p>
      </back-header>
    </div>
    <div class="big_first">
        <div style="background: #fff;">
        <router-link tag="div" class="stylist" :to="'/stylist/'+$route.params.salesNo" replace>
            <div style="flex:1;">设计师</div>
            <div><span v-if="n.status==1" v-for="(n,index) in millwright" key="index" style="display:inline-block;line-height:30px;width:30px;border-radius:50%;background:#4284d9;font-size:12px;text-align:center;color:#fff;margin-top:10px;margin-right:10px;">{{n.taskUserName | spenderName}}</span><span style="position:relative;margin-right:10px;" v-if="n.status==2" v-for="(n,index) in millwright" key="index">
                <span style="display:inline-block;line-height:30px;width:30px;border-radius:50%;background:#15bc83;font-size:12px;text-align:center;color:#fff;margin-top:10px;">{{n.taskUserName | spenderName}} </span>
                <span style="display:inline-block;width:27px;height:14px;position: absolute;font-size:10px;top:-15px;left:20px;color:#15bc83;border:1px solid #15bc83;border-radius:7px;line-height:15px;text-align:center;z-index:99;background:#fff;">完工</span>
                </span>
                <i style="line-height:50px;font-size:14px;color:#999;" class="iconfont">&#xe68b;</i></div>
       </router-link>
       <textarea class="nvarchar" type="text" placeholder="请填写任务说明" v-model="explaintext"></textarea>
       </div>
       <img class="sculpture" src="../assets/font-awesome/image/reconciliation.jpg" alt="">
       <p class="message">派活后，设计师就可以登录PC</p>
       <p class="message">派工--我的设计任务，查看属于自己的任务啦</p>
    </div>
    <div class="but">
        <button @click="construction">保存</button>
    </div>
  </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import address from '../url.js';
import $ from 'jquery';
import { mapState, mapGetters } from 'vuex';
export default {
  computed: mapState(['tasklist','exmessage']),
  components: {
    BackHeader
  },
  data() {
    return {
        millwright:[],
        explaintext:""
    }
  },
  created() {
    setTimeout(function() {
        if(this.tasklist==""){
            this.getInfo();
        }else{
            this.millwright = this.tasklist;
        }
        this.explaintext = this.exmessage;
    }.bind(this), 100);
  },
  methods: {
    getInfo(){
        var params = "taskNo=" + this.$route.params.salesNo;
            this.axios.post(address.tasking + localStorage.getItem('token'), params)
                .then(data => {
                    this.millwright = data.data.doingTaskEmployee;
                    this.$store.commit('milllist', data.data);
                })
                .catch(err => {

                })
      },
     construction(){
        var employeeId = [];
        for(var i=0;i<this.millwright.length;i++){
            employeeId.push(this.millwright[i].taskEmployeeId);
        }
        var params = "taskNo=" + this.$route.params.salesNo + "&taskDesc=" + this.explaintext + "&taskEmployeeId="+employeeId.join(",");
            this.axios.post(address.preserve + localStorage.getItem('token'), params)
                .then(data => {
                    if(data.data.code==1){
                        this.$router.replace("/design");
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
.stylist{
    display: flex;
    font-size: 14px;
    color: #000;
    line-height: 50px;
    margin-left: 25px;
    box-sizing: border-box;
    padding-right:21px;
    border-bottom: 1px solid #f9f9f9;
}
.nvarchar{
    border: none;
    outline: none;
    width: 100%;
    height: 100px;
    box-sizing: border-box;
    padding: 15px 15px 15px 25px;
    font-size: 14px;
    color: #999;
    resize : none;
    line-height:1.5;
}
.sculpture{
    display: block;
    width: 80px;
    height: 80px;
    border:2px solid #999;
    border-radius: 50%;
    margin: 70px auto 24px;
}
.message{
    text-align: center;
    font-size: 14px;
    color:#999;
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
</style>

