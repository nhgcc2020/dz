<template>
    <div>
        <div class="x-header">
            <back-header>
                <p class="title">消息提醒设置</p>
            </back-header>
        </div>
        <div class="big_first">
          <div class="onlyone"><span>消息提醒设置</span><span style="color:#999;float:right;">已开启</span></div>
          <div style="padding-left:1rem;color:#999;font-size:0.8rem;margin-top:10px;">请打开"设置"->"通知"，找到"易对账"并允许通知。开启推送设置，可及时接收订单提醒</div>
        </div>
    </div>
</template>
<script>
import BackHeader from '../common/BackHeader'
import address from '../url.js';
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
    .onlyone{
        margin-top: 10px;
        height: 3.3rem;
        background: #fff;
        line-height: 3.3rem;
        padding: 0 1.4rem 0 1rem; 
    }
</style>
