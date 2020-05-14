<template>
    <div>
        <div class="x-header">
            <back-header>
                <p class="title">员工加入</p>
            </back-header>
        </div>
        <div class="big_first">
            <ul class="join">
                <li>
                    <span>
                        <p style="color:#333;">深圳易订货</p>
                        <p style="color:#666;">李大锤 13027795894</p>
                        <p style="color:#999; font-size:0.8rem;">2017-10-16</p>
                    </span>
                    <span @click="examine" style="display:inline-block;height:2rem;width:56px;background:#2e8ae6;color:#fff;font-size:0.9rem;text-align:center;line-height:30px;border-radius:5px;margin-top:2.6rem;">同意</span>
                </li>
                <li>
                    <span>
                        <p style="color:#333;">深圳易订货</p>
                        <p style="color:#666;">李大锤 13027795894</p>
                        <p style="color:#999; font-size:0.8rem;">2017-10-16</p>
                    </span>
                    <span @click="examine" style="display:inline-block;height:2rem;width:56px;background:#2e8ae6;color:#fff;font-size:0.9rem;text-align:center;line-height:30px;border-radius:5px;margin-top:2.6rem;">同意</span>
                </li>
                <li>
                    <span>
                        <p style="color:#333;">深圳易订货</p>
                        <p style="color:#666;">李大锤 13027795894</p>
                        <p style="color:#999; font-size:0.8rem;">2017-10-16</p>
                    </span>
                    <span style="margin-top:4.6rem;font-size:0.8rem;color:#44ae80;">已由刘久平同意</span>
                </li>
            </ul>
            <div v-show="show" class="popup">
                <ul style="overflow:hidden;">
                    <li>
                        <i @click="refuse" style="float:right;font-size:2rem;color:#999;margin-right:0.4rem;margin-top:-0.2rem;" class="iconfont">&#xe6a0;</i>
                    </li>
                    <li style="text-align:center;font-size:1.2rem;color:#333;margin-top:60px;">深圳易订货</li>
                    <li style="text-align:center;font-size:0.9rem;color:#999;margin-top:15px;">申请成为你的好友</li>
                    <li style="text-align:center;font-size:1.2rem;color:#eb7766;margin-top:10px;">
                        <img style="width:200px;height:90px;" src="../assets/font-awesome/image/interflow.png">
                    </li>
                    <li style="text-align:center;font-size:1.2rem;color:#36d1af;">成为好友，双方账单互查互看</li>
                    <li style="position:absolute;bottom:0;height:54px;border-top:1px solid #e4e4e4;width:100%;">
                        <span @click="refuse" style="display:inline-block;width:49%;text-align:center;line-height:54px;border-right:1px solid #e4e4e4;color:#999;">取消</span>
                        <span @click="consent" style="display:inline-block;width:49%;text-align:center;line-height:54px;color:#2e8ae6;">同意申请</span>
                    </li>
                </ul>
            </div>
            <div v-show="show1" class="popup">
                <ul style="overflow:hidden;">
                    <li>
                        <i @click="refuse" style="float:right;font-size:2rem;color:#999;margin-right:0.4rem;margin-top:-0.2rem;" class="iconfont">&#xe6a0;</i>
                    </li>
                    <li style="text-align:center;font-size:1.2rem;color:#333;margin-top:60px;">如果对方也是你的客户</li>
                    <li style="text-align:center;font-size:0.9rem;color:#999;margin-top:15px;">请为他选择一个报价级别</li>
                    <li style="text-align:center;font-size:1.3rem;color:#eb7766;margin-top:40px;">级别和服务报价有关，别选错</li>
                    <li style="text-align:center;margin-top:40px;">&#x3000;
                        <input style="position:relative;top:3px;width:1rem;height:1rem;" type="radio" id="one" value="one" v-model="picked">
                        <label for="one">优惠价</label>&#x3000;
                        <input style="position:relative;top:3px;width:1rem;height:1rem;" type="radio" id="two" value="two" v-model="picked">
                        <label for="two">标准价</label>&#x3000;
                        <input style="position:relative;top:3px;width:1rem;height:1rem;" type="radio" id="three" value="three" v-model="picked">
                        <label for="three">零售价</label>&#x3000;
                        <li style="position:absolute;bottom:0;height:54px;border-top:1px solid #e4e4e4;width:100%;">
                            <span @click="refuse" style="display:inline-block;width:49%;text-align:center;line-height:54px;border-right:1px solid #e4e4e4;color:#999;">忽略</span>
                            <span @click="confirm" style="display:inline-block;width:49%;text-align:center;line-height:54px;color:#2e8ae6;">确定</span>
                        </li>
                </ul>
            </div>
            <div v-show="show" class="over"></div>
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
            show: false,
            show1: true,
            picked:"two"
        }
    },
    created() {
        this.getInfo();
    },
    methods: {
        getInfo() {
            // 
        },
        refuse() {
            this.show = false;
            this.show1 = false;
        },
        consent() {
            this.show1 = true;
        },
        confirm() {
            this.show1 = false;
            this.show = false;
        },
        examine() {
            this.show = true;
        }
    }
}
</script>
<style scoped>
.join li {
    height: 7.2rem;
    background: #fff;
    border-top: 1px solid #f2f2f2;
    padding: 0 1.1rem;
}

.join li>span:nth-child(1) {
    display: inline-block;
    margin-top: 1rem;
}

.join li>span:nth-child(2) {
    float: right;
}

.join li>span>p {
    line-height: 1.7rem;
}

.over {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    opacity: 0.6;
    z-index: 500;
    background: #000;
    /*display: none;*/
}

.popup {
    position: fixed;
    top: 20%;
    left: 7%;
    height: 25rem;
    width: 86%;
    background: #fff;
    border-radius: 10px;
    z-index: 1000;
}
</style>
