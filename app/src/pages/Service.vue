<template>
    <div>
        <div class="x-header">
            <back-header>
                <p class="title">选择服务</p>
            </back-header>
        </div>
        <div class="big_first">
            <div class="decipher">
                <i style="font-size:44px;" class="iconfont">&#xe670;</i><span>当前目录 : 写真</span>
            </div>
            <ul class="choices">
                <li><div style="flex:1;">标准写真</div><span>170.90</span></li>
                <li><div style="flex:1;">写真好板</div><span>171.90</span></li>
                <li><div style="flex:1;">写真体育</div><span>172.90</span></li>
                <li><div style="flex:1;">写真安尔碘</div><span>173.90</span></li>
                <li><div style="flex:1;">写真影集</div><span>174.90</span></li>
                <li><div style="flex:1;">写真喷绘</div><span>175.90</span></li>
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
        // 
        }
    }
}
</script>
<style scoped>
.decipher{
    height: 76px;
    line-height: 76px;
    padding: 0 26px;
    box-sizing: border-box;
    font-size: 14px;
    color: #999;
    background: #fff;
    overflow: hidden;
    text-align: center;
    border-bottom: 1px solid #f2f2f2;
}
.decipher>span{
    position: relative;
    top:-10px;
    left:9px;
}
.choices{
    background: #fff;
    color: #000;
}
.choices>li{
    display: flex;
    line-height: 50px;
    margin-left: 26px;
    box-sizing: border-box;
    padding-right: 26px;
    border-bottom: 1px solid #f9f9f9;
}
.choices span{
    color:#999;
    font-size: 14px;
}
</style>
