<template>
  <div>
    <div class="x-header">
      <x-header class="head_img" :left-options="{showBack: false}" v-cloak><img v-if="imgs ==''" class="herder_img" src="../../assets/font-awesome/image/login.jpeg" alt=""> <img v-if="imgs !==''" class="herder_img" :src="imgs | image" alt=""> {{datanum.comShortname}}
        <router-link @click.native="Enter" style="color:#fff" slot="right" to="/quit">切换</router-link>
      </x-header>
    </div>
    <div class="big_first">
      <div class="sell public">
        <div>
          <span><span style="display:inline-block;width:4px;height:16px;background:#4284d9;position:relative;top:3px;"></span> 散单销售</span>
        </div>
        <ul>
          <router-link tag="li" to="/adressbook">
            <i class="iconfont" style="color:#4FC3C3;font-size: 2.7rem;">&#xe712;</i>
            <p>客户</p>
            
          </router-link>
          <router-link  tag="li" to="/sareport">
            <i class="iconfont" style="color:#EB6877;">&#xe710;</i>
            <p>销售单</p>
            <div style="height:0.75rem" v-show="Sone !==0" class="daiduizhang" v-cloak>{{Sone}}</div>
          </router-link>
          <router-link tag="li" to="/sdaishoukuan">
            <i class="iconfont" style="color:#EB6877;">&#xe716;</i>
            <p>对账收款</p>
            <div style="height:0.75rem" v-show="Stwo !==0" class="daishoukuan" v-cloak>{{Stwo}}</div>
          </router-link>
           <router-link tag="li" to="">
          
          </router-link>
         
        </ul>
      </div>
      <div style="border-top:1px solid #f0f0f0;"></div>
      <div class="sell public">
        <div>
          <span><span style="display:inline-block;width:4px;height:16px;background:#4284d9;position:relative;top:3px;"></span> 外部协作</span>
        </div>
        <ul>
           <router-link tag="li" to="/supplier">
            <i class="iconfont" style="color:#4FC3C3;">&#xe6c3;</i>
            <p>服务商</p>
            
          </router-link>
         <router-link tag="li" @click.native="developed" to="">
            <i class="iconfont" style="color:#4285d9;">&#xe6f8;</i>
            <p>外协加工</p>
           
          </router-link>
           <router-link tag="li" @click.native="developed" to="">
            <i class="iconfont" style="color:#4285d9;">&#xe6ff;</i>
            <p>外协安装</p>
           
          </router-link>
           <router-link tag="li" to="">
            
          </router-link>
        </ul>
      </div>
      <div style="border-top:1px solid #f0f0f0;"></div>
      <div class="sell public">
        <div>
          <span><span style="display:inline-block;width:4px;height:16px;background:#4284d9;position:relative;top:3px;"></span> 内部派工</span>
        </div>
        <ul>
           <router-link tag="li" @click.native="stockpile" to="/design">
            <i class="iconfont" style="color:#FEA219;">&#xe6fb;</i>
            <p>设计</p>
            <div style="height:0.75rem" v-show="Design !==0" class="daiduizhang" v-cloak>{{Design}}</div>
          </router-link>
           <router-link tag="li"  to="/fabrication">
            <i class="iconfont" style="color:#FEA219;">&#xe715;</i>
            <p>制作</p>
            <div style="height:0.75rem" v-show="working !==0" class="daiduizhang" v-cloak>{{working}}</div>
          </router-link>
           <router-link tag="li" to="">
           
          </router-link>
           <router-link tag="li" to="">
            
          </router-link>
        </ul>
      </div>
      <div v-if="datanum.industryId=='1B'||datanum.industryId=='1C'" style="border-top:1px solid #f0f0f0;"></div>
      <div v-if="datanum.industryId=='1B'||datanum.industryId=='1C'" class="sell public">
        <div>
          <span><span style="display:inline-block;width:4px;height:16px;background:#4284d9;position:relative;top:3px;"></span> CRM项目</span>
        </div>
        <ul>
           <router-link tag="li" :to="'/business/'+'01'">
            <i class="iconfont" style="color:#ff6600;font-size:2rem;">&#xe724;</i>
            <p>商机</p>
            <div v-show="Oone !=0" class="duizhang" v-cloak>{{Oone}}</div>
          </router-link>
          <router-link tag="li" :to="'/business/'+'02'">
            <i class="iconfont" style="color:#ff6600;">&#xe71f;</i>
            <p>需求报价</p>
            <div v-show="Otwo !=0" class="duizhang" v-cloak>{{Otwo}}</div>
          </router-link>
           <router-link tag="li" :to="'/business/'+'03'">
            <i class="iconfont" style="color:#ff6600;font-size:2.5rem;">&#xe6c8;</i>
            <p>谈判</p>
            <div v-show="Othree !=0" class="duizhang" v-cloak>{{Othree}}</div>
          </router-link>
           <router-link tag="li" to="/bargain">
            <i class="iconfont" style="color:#ff6600;font-size:2.5rem;">&#xe723;</i>
            <p>合同</p>
            <div v-show="Cone !=0" class="duizhang" v-cloak>{{Cone}}</div>
          </router-link>
        </ul>
      </div>
      <div style="border-top:1px solid #f0f0f0;"></div>
      <div class="sell public">
        <div>
          <span><span style="display:inline-block;width:4px;height:16px;background:#4284d9;position:relative;top:3px;"></span> 采购订货</span>
        </div>
        <ul>
           <router-link tag="li" to="/supplier">
            <i class="iconfont" style="color:#4FC3C3;">&#xe6c3;</i>
            <p>供应商</p>
            
          </router-link>
          <router-link tag="li" to="/syreport">
            <i class="iconfont" style="color:#4284D9;">&#xe698;</i>
            <p>采购单</p>
            <div v-show="Pone !==0" class="duizhang" v-cloak>{{Pone}}</div>
          </router-link>
           <router-link tag="li" to="/sydaifukuan">
            <i class="iconfont" style="color:#4284D9;">&#xe717;</i>
            <p>对账付款</p>
            <div v-show="Ptwo !==0" class="daifukuan" v-cloak>{{Ptwo}}</div>
          </router-link>
           <router-link tag="li" to="">
           
          </router-link>
        </ul>
      </div>
      <div style="border-top:1px solid #f0f0f0;"></div>
      <div class="sell public">
        <div>
          <span><span style="display:inline-block;width:4px;height:16px;background:#4284d9;position:relative;top:2px;"></span> 财务管理</span>
        </div>
        <ul>
          <router-link tag="li" to="/salaryaccount">
            <i class="iconfont" style="color:#8d9fb5;font-size: 2.2rem;">&#xe702;</i>
            <p>工资</p>
          </router-link>
          <router-link tag="li" to="/dayaccount">
            <i class="iconfont" style="color:#8d9fb5;font-size: 2.2rem;">&#xe6be;</i>
            <p>费用</p>
          </router-link>
          
           <router-link tag="li" to="/prepaid">
            <i class="iconfont" style="color:#8d9fb5;">&#xe704;</i>
            <p>预存款</p>
          </router-link>
           <router-link tag="li"  to="">

          </router-link>
        </ul>
      </div>
      <div class="foot">
        <i class="iconfont">&#xe6ed;</i> 到底了
      </div>
    </div>
    <div class="error_tips">程序猿正在玩命开发中，敬请期待 !</div>
  </div>
</template>
<script>
import { XHeader, Actionsheet, TransferDom } from 'vux';
import address from '../../url.js';
import $ from 'jquery';
import { mapState, mapGetters } from 'vuex';
export default {
  directives: {
    TransferDom
  },
  components: {
    XHeader,
    Actionsheet
  },
  data() {
    return {
      datanum: "",
      Sone: 0,
      Stwo: 0,
      Pone: 0,
      Ptwo: 0,
      imgs:"",
      Design:0,
      Oone:0,
      Otwo:0,
      Othree:0,
      Cone:0,
      working:0
    }
  },
  created() {
    this.getInfo();
  },
  destroyed(){
    JAnalytics.onPageEnd({'pageName': '工作台'});
  },
  methods: {
    getInfo() {
      var _this = this
      this.axios.get(address.basic + localStorage.getItem('token'))
        .then(function (data) {
         _this.imgs =  data.data.data.comLogoPath;
        })
        .catch(err => {

        })
      this.axios.get(address.workbench + localStorage.getItem('token'))
        .then(function (data) {
          if(data.data.code==-1){
             _this.$router.push('/login');
          }else{
            _this.datanum = data.data
          $.each(data.data.todo, function (key, val) {
            if (val.orderType == 'S' && val.orderStatus == '04') {
              _this.Sone = val.orderCount;
            } else if (val.orderType == 'S' && val.orderStatus == '07') {
              _this.Stwo = val.orderCount;
            } else if (val.orderType == 'P' && val.orderStatus == '04') {
              _this.Pone = val.orderCount;
            } else if (val.orderType == 'P' && val.orderStatus == '09') {
              _this.Ptwo = val.orderCount;
            } else if(val.orderType == 'DESIGN'){
              _this.Design = val.orderCount;
            } else if(val.orderType == 'OPPO' && val.orderStatus == '01'){
              _this.Oone = val.orderCount;
            } else if(val.orderType == 'OPPO' && val.orderStatus == '02'){
              _this.Otwo = val.orderCount;
            } else if(val.orderType == 'OPPO' && val.orderStatus == '03'){
              _this.Othree = val.orderCount;
            }else if(val.orderType == 'CONTRACT' && val.orderStatus == '01'){
              _this.Cone = val.orderCount;
            }else if(val.orderType == 'WORKING' && val.orderStatus == '5'){
              _this.working = val.orderCount;
            }
          });
          }
        })
        .catch(err => {

        })
        JAnalytics.onPageStart({'pageName': '工作台'});
    },
  developed(){
    $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
  },
  stockpile(){
         this.$store.commit('cache', { "status": "", "clientele": "", "startTime": "", "endTime": "","index1":"","index2":"","index3":"","partnerKey":"" });
        }
}
}
</script>
<style scoped>
html {
  font-family: "微软雅黑";
}

.public>div {
  padding: .4rem  1rem 0;
  color:#999;
}
.public ul {
  width: 95%;
  display: flex;
  justify-content: center;
  margin: 1rem auto;
  text-align: center;
}
/*#onlysell{
  margin: 0;
  width: 100%;
  border-bottom: 1px solid #f2f2f2;
}
#onlysell li{
  padding: .5rem 0;
  width: 25%;
  border-right: 1px solid #f2f2f2;
}
#onlysell>li>span{
  display: inline-block;
  height: 4rem;
  width: 4rem;
  line-height: 4rem;
  border-radius: 50%;
  color: #CCC;
  background: #f2f2f2;
  font-size: 0.9rem;
  margin-top:.2rem;
}
#onlysell>li i{
   font-size: 2.5rem;
   height: 2.8rem;
   width: 2.8rem;
   line-height: 2.8rem;
}*/
.public li {
  position: relative;
  display: inline-block;
  width: 25%;
}

.public li div {
  font-size: 0.9rem;
  position: absolute;
  top: -.5rem;
  padding: .2rem;
  left: 65%;
  background: #ff5151;
  min-width: 0.8rem;
  height: .8rem;
  border-radius: 1rem;
  line-height: .9rem;
  color: #fff;
  text-align: center;
}

.public li p {
  font-size: 0.9rem;
  color: #333;
}

.public li i {
  display: inline-block;
  font-size: 2.4rem;
  color: #4FA8EA;
  border-radius: 50%;
  height: 2.7rem;
  width: 2.7rem;
  line-height: 2.7rem;
  text-align: center;
}
.empty {
  height: 4.6rem;
}
.herder_img{
  height: 26px;
  width: 26px;
  border-radius: 50%;
  margin-top:4px;
  margin-right:14px;
  float: left;
}
.error_tips {
  position: absolute;
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
  font-size: 14px;
}
.vux-header {
  background: #4284d9;
}
.foot{
  font-size: 14px;
  color: #ccc;
  text-align: center;
  margin-bottom: 10px;
}
.foot i{
  position: relative;
  top:5px;
  font-size: 30px;
}
</style>
