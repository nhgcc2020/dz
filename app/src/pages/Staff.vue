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
                        <p style="color:#333;">海大星</p>
                        <p style="color:#666;">13027795894</p>
                        <p style="color:#999; font-size:0.8rem;">2017-10-16</p>
                    </span>
                    <span @click="examine" style="display:inline-block;height:2rem;width:56px;background:#2e8ae6;color:#fff;font-size:0.9rem;text-align:center;line-height:30px;border-radius:5px;margin-top:2.6rem;">审批</span>
                </li>
                <li>
                    <span>
                        <p style="color:#333;">海大星</p>
                        <p style="color:#666;">13027795894</p>
                        <p style="color:#999; font-size:0.8rem;">2017-10-16</p>
                    </span>
                    <span style="margin-top:4.6rem;font-size:0.8rem;color:#ff9900;">由刘久平拒绝</span>
                </li>
                <li>
                    <span>
                        <p style="color:#333;">海大星</p>
                        <p style="color:#666;">13027795894</p>
                        <p style="color:#999; font-size:0.8rem;">2017-10-16</p>
                    </span>
                    <span style="margin-top:4.6rem;font-size:0.8rem;color:#44ae80;">由刘久平同意</span>
                </li>
            </ul>
            <div v-show="show" class="popup">
                <ul style="overflow:hidden;">
                    <li><i @click="refuse" style="float:right;font-size:2rem;color:#999;margin-right:0.4rem;margin-top:-0.2rem;" class="iconfont">&#xe6a0;</i> </li>
                   <li style="text-align:center;font-size:1.2rem;color:#333;margin-top:60px;">海大星</li>
                   <li style="text-align:center;font-size:0.9rem;color:#999;margin-top:5px;">申请加入你的公司</li>
                   <li style="text-align:center;font-size:1.2rem;color:#eb7766;margin-top:40px;">赶快审核，让他为公司效力</li>
                   <li style="text-align:center;font-size:0.8rem;color:#ff9900;margin-top:30px;"><i style="font-size:1.4rem;position:relative;top:0.2rem;" class="iconfont">&#xe6bc;</i>如同意，别忘登录电脑为员工设置权限</li>
                   <li style="position:absolute;bottom:0;height:54px;border-top:1px solid #e4e4e4;width:100%;">
                        <span @click="refuse" style="display:inline-block;width:49%;text-align:center;line-height:54px;border-right:1px solid #e4e4e4;color:#999;">拒绝申请</span>
                        <span @click="consent" style="display:inline-block;width:49%;text-align:center;line-height:54px;color:#2e8ae6;">同意申请</span>
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
            show:false,
        }
    },
    created() {
        this.getInfo();
    },
    methods: {
        getInfo() {
            //hou tai yo
        },
        refuse(){
            this.show = false;
        }, 
        consent(){
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
.over{
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
.popup{
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
