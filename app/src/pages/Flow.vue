<template>
  <div>
    <div class="x-header">
      <back-header>
        <p class="title">奖励规则</p>
      </back-header>
    </div>
    <div class="big_first">
      <div>
        <p style="text-align:center;font-size:1.1rem;margin-bottom:1rem;">—邀请奖励流程—</p>
        <p>1.分享邀请链接给朋友（微信或QQ皆可） <br>
           2.朋友通过邀请链接的活动页面注册易对账企业账号  <br>
           3.朋友登录易对账后成为付费用户，即为有效邀请，可获得奖金
        </p>
        <p style=";font-size:1.1rem;text-align:center;border-top:1px solid #ccc;margin:1rem 0;padding-top:1rem;">—对账大使推广返现奖励规则—</p>
        <p>&#x3000;&#x3000;每邀请一个朋友注册易对账的企业账号并成为付费用户，邀请人即可获得100元现金奖励；超过5个（从第6个开始），每邀请成功一位可获得200元奖励。
          <br>
    &#x3000;&#x3000;多邀多得不设上限，邀请后不设时间限制，长期有效。
        </p>
      </div>
    </div>
  </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import $ from 'jquery';
export default {
  components: {
    BackHeader
  },
  data() {
    return {

    }
  },
  created() {
    this.getInfo();
  },
  methods: {
    getInfo() {

    }
  }
}
</script>
<style scoped>
.big_first>div{
  padding: 1rem; 
}
/**/
</style>
