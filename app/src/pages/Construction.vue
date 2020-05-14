<template>
    <div>
        <div class="x-header">
            <back-header><p class="title">创建生意伙伴</p></back-header>
        </div>
        <div class="big_first">
            <div class="button">
                <span @click="qiye" :class="{firent:isFirent}">企业</span>
                <span @click="geren" :class="{firent:!isFirent}">个人</span>
            </div>
            <div class="line"></div>
            <ul class="add_friend">
                <li class="active" v-if="show">
                    <form class="mui-input-group">
                        <p>
                            <i></i>企业全称</p>
                        <div class="mui-input-row">
                            <input type="text" class="mui-input-clear" placeholder="请输入20字以内的企业名称">
                        </div>
                        <p>
                            <i></i>企业简称</p>
                        <div class="mui-input-row">
                            <input type="text" class="mui-input-clear" placeholder="请输入8字以内的企业简称">
                        </div>
                        <p>真实姓名</p>
                        <div class="mui-input-row">
                            <input type="text" class="mui-input-clear" placeholder="请输入伙伴姓名">
                        </div>
                        <p>手机号码</p>
                        <div class="mui-input-row">
                            <input type="text" class="mui-input-clear" placeholder="请输入联系电话">
                        </div>
                        <p>助记代码</p>
                        <div class="mui-input-row">
                            <input type="text" class="mui-input-clear" placeholder="请填写便于记忆的助记代码，便于查找客户订单">
                        </div>
                        <p>合作级别</p>
                        <p class="mui-radio mui-left">
                            <input name="partnerLevel" type="radio" value="1">
                            <label for="jibie1">重点伙伴</label>
                        </p>
                        <p class="mui-radio mui-left">
                            <input name="partnerLevel" type="radio" value="2" checked>
                            <label for="jibie2">普通伙伴</label>
                        </p>
                        <p class="mui-radio mui-left">
                            <input name="partnerLevel" type="radio" value="3">
                            <label for="jibie3">零散合作</label>
                        </p>
                        <button type="button" class="save_friend_com">创建伙伴</button>
                        <!--<button type="button" class="save_friend1_com" onclick="create_partner_com(2)">创建并发送邀请短信</button>-->
                    </form>
                </li>
                <li v-if="!show">
                    <form class="mui-input-group">
                        <p>
                            <i></i>真实姓名</p>
                        <div class="mui-input-row">
                            <input type="text" class="mui-input-clear" placeholder="请输入伙伴姓名">
                        </div>
                        <p>
                            <i></i>手机号码</p>
                        <div class="mui-input-row">
                            <input type="text" class="mui-input-clear" placeholder="请输入联系电话">
                        </div>
                        <p>助记代码</p>
                        <div class="mui-input-row">
                            <input type="text" class="mui-input-clear" placeholder="请填写便于记忆的助记代码，便于查找客户订单">
                        </div>
                        <p>合作级别</p>
                        <p class="mui-radio mui-left">
                            <input name="partnerLevel_per" type="radio" value="1">
                            <label for="jibie4">重点伙伴</label>
                        </p>
                        <p class="mui-radio mui-left">
                            <input name="partnerLevel_per" type="radio" value="2" checked>
                            <label for="jibie5">普通伙伴</label>
                        </p>
                        <p class="mui-radio mui-left">
                            <input name="partnerLevel_per" type="radio" value="3">
                            <label for="jibie6">零散合作</label>
                        </p>
                        <button type="button" class="save_friend_com">创建伙伴</button>
                    </form>
                </li>
            </ul>
        </div>
    </div>
</template>
<script>
import BackHeader from '../common/BackHeader'
export default {
    components: {
       BackHeader
    },
    data() {
        return {
            isFirent:true,
            show:true
        }
    },
    methods: {
        qiye(){
            this.isFirent = true;
            this.show = true;
        },
        geren(){
            this.isFirent = false
            this.show = false;
        }
    }
}
</script>
<style scoped>
.button {
    background: #d7e5f1;
    border-radius: 2rem;
    margin: 1rem 2rem;
    display: flex;
    justify-content: center;
}

.button span {
    display: inline-block;
    width: 50%;
    text-align: center;
    padding: .3rem 0;
    font-size: .9rem;
}
.firent {
    border-radius: 2rem;
    background: #007acc;
    color: #fff;
}

.line {
    border-bottom: 1px solid #ccc;
}
.add_friend{
    padding: 0 1rem;
}
.mui-input-group p i{
    display: inline-block;
    width: .2rem;
    height: .2rem;
    border-radius: 50%;
    background: red;
    margin-right: 0.5rem;
}
.mui-input-group p{
    padding: 0.3rem 0;
    font-size: 0.9rem;
}
.mui-input-clear{
    width: 90%;
    height: 2rem;
    padding: 0 1rem;
    border: 1px solid #e0e0e0;
}
.mui-input-row{
    border: none;
    border-color: #f8f8f8;
}
.mui-left input{
 float: left;
 height: 1.5rem;
}
.save_friend_com{
    display: block;
    width: 90%;
    margin: 0 auto;
    border-radius: 4rem;
    background: #3879d9;
    color: #fff;
    border: none;
    height: 1.5rem;
}
.vux-header {
  background: #4284d9;
}
</style>
