<template>
  <div>
    <div class="x-header">
      <back-header>
        <p class="title">{{order.partnerShortname}}</p>
      </back-header>
    </div>
    <div class="big_first">
      <div class="meter">
          <span style="flex:1;">
              <p style="margin-top:10px;">订单日期：{{order.orderDate}}</p>
              <p style="color:#999;">销售单号：{{order.salesNo}}</p>
          </span>
          <span v-if="order.status=='5'" style="display:inline-flex;align-items:center;font-size:16px;">加工制作中</span>
          <span v-if="order.status=='2'" style="display:inline-flex;align-items:center;font-size:16px;">已完工</span>
      </div>
      <ul class="ul_count">
            <li style="display:flex;">
                <div style="flex:1;">
                    <p style="position:relative;height:35px;line-height:35px;margin-top:10px;">
                        <i style="font-size:30px;position:absolute;top:0px;color:#ff9900;" class="iconfont">&#xe6f7;</i>
                        <span style="margin-left:34px;color:#666;">加工明细</span>
                    </p>
                </div>
            </li>
            <li v-for="(n,index) in news" key="index" style="border-bottom:1px solid #f9f9f9;">
                <p v-if="n.businessDesc" style="margin:10px 0;">{{n.businessDesc}}</p>
                <p v-if="!n.businessDesc" style="margin:10px 0;color:#ccc;">无业务内容</p>
                <p style="display:flex;font-size:12px;color:#999;margin-bottom:10px;"><span v-if="n.requirements" style="flex:1;">{{n.requirements}}&nbsp;&nbsp;&nbsp;<span v-if="n.isUrgent=='1'" style="color:#eb6877;">急</span></span><span v-if="!n.requirements" style="flex:1;color:#ccc;">无制作说明&nbsp;&nbsp;&nbsp;<span v-if="n.isUrgent=='1'" style="color:#eb6877;">急</span></span><span>{{n.specification}}&nbsp;x{{n.quantity}}</span></p>
                <p v-if="n.status=='5'" style="text-align:right;font-size:12px;color:#ff9900;margin-bottom:10px;">{{n.workingProcedure | wltype}}&#x3000; 制作中</p>
                <p v-if="n.status=='2'" style="text-align:right;font-size:12px;color:#01a09a;margin-bottom:10px;">{{n.workingProcedure | wltype}}&#x3000; 已完工</p>
                <p v-if="n.status=='C'" style="text-align:right;font-size:12px;color:#ccc;margin-bottom:10px;">{{n.workingProcedure | wltype}}&#x3000; 已作废</p>
            </li>
        </ul> 
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
        news:"",
        order:""
    }
  },
  created() {
    this.getInfo();
  },
  methods: {
    getInfo() {
            this.axios.get(address.FabricationDetails + localStorage.getItem('token') + "&taskNo=" + this.$route.params.taskNo)
                .then(data => {
                    this.news = data.data.details;
                    this.order = data.data.order;
                })
                .catch(err => {

                })
    }
  }
}
</script>
<style scoped>
.big_first {
  overflow: hidden;
}
.meter{
    display: flex;
    height: 70px;
    background: #fff;
    font-size: 12px;
    padding: 0 22px;
    color:#333;
    margin-bottom: 10px;
}
.meter p{
    display: inline-flex;
    height: 25px;
    align-items: center;
}
.ul_count {
    box-sizing: border-box;
    padding-left: 22px;
    background: #fff;
    overflow: hidden;
}
.ul_count li {
    box-sizing: border-box;
    padding-right: 22px;
    font-size: 14px;
    overflow: hidden;
}
</style>