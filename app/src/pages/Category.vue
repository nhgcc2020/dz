<template>
    <div>
        <div class="x-header">
            <back-header>
                <p class="title">选择服务类目</p>
            </back-header>
        </div>
        <div class="big_first">
            <div class="decipher">
                <p style="margin-top:17px;">这边是你通过电脑端录入的服务报价</p>
                <p>开单时选用，系统会将物料、价格、计价直接填充到订单中</p>
            </div>
            <ul class="choices">
                <router-link tag="li" to="/service"><div style="flex:1;">写真</div><i class="iconfont">&#xe68b;</i></router-link>
                <li><div style="flex:1;">户外</div><i class="iconfont">&#xe68b;</i></li>
                <li><div style="flex:1;">喷绘</div><i class="iconfont">&#xe68b;</i></li>
                <li><div style="flex:1;">展架易拉宝</div><i class="iconfont">&#xe68b;</i></li>
                <li><div style="flex:1;">平板UV</div><i class="iconfont">&#xe68b;</i></li>
            </ul>
        </div>  
    </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import address from '../url.js';
import $ from 'jquery';
import bus from '../bus.js';
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
.decipher{
    height: 76px;
    padding: 0 26px;
    box-sizing: border-box;
    font-size: 12px;
    color: #999;
    background: #fff;
    overflow: hidden;
    border-bottom: 1px solid #f2f2f2;
}
.choices{
    background: #fff;
}
.choices>li{
    display: flex;
    line-height: 50px;
    margin-left: 26px;
    box-sizing: border-box;
    padding-right: 26px;
    border-bottom: 1px solid #f9f9f9;
}
.choices i{
    color:#ccc;
}
</style>
