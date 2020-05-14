<template>
    <div>
        <div class="x-header">
            <back-header>
                <p class="title">我的供应商</p>
            </back-header>
        </div>
        <div class="big_first">
            <router-link tag="div" @click.native="hunt('Supplier')" to="/seek" class="seek">
                <i class="iconfont ">&#xe6df;</i>&nbsp;搜索</router-link>
            <ul class="ul_two">
                <li v-for="(n,index) in news" key="index">
                    <span>
                        <i class="iconfont">&#xe6c3;</i>
                    </span>
                    <span>
                        <div class="partnerName">{{n.partnerShortname}}</div>
                        <div class="phone">{{n.contacterName | kong}}
                            <span v-if="(/^1[34578]\d{9}$/.test(n.tel1))" class="iconfont" @click="callphone(n.tel1)">&#xe683;</span>
                        </div>
                    </span>
                    <router-link @click.native="jump(n,'Supplier')" tag="div" to="/friend" style="position:absolute; top:0;height:90%;width:100%;z-index:100;background: transparent;"></router-link>
                </li>
            </ul>
            <div v-show="show" class="cover"></div>
            <div v-show="show" class="alart">
                <p>确定要打电话吗？</p>
                <p>
                    <span class="none" @click="none">取消</span>
                    <span class="know" @click="know">确定</span>
                </p>
            </div>
            <div v-if="showding" class="la-timer" style="position: absolute;top:45%;left:45%;">
                <div></div>
            </div>
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
            news: "",
            isActive: true,
            type: 1,
            show: false,
            phone: "",
            iconfont: false,
            showding: true
        }
    },
    created() {
        this.getInfo(this.type);
    },
    methods: {
        getInfo(type) {
            var _this = this
            var params = "type=" + type + "&page=1&rows=30&searchKey=";
            this.axios.post(address.supplier + localStorage.getItem('token'), params)
                .then(function (data) {
                    _this.showding = false
                    _this.news = data.data
                })
                .catch(err => {

                })
        },
        wait() {
            this.type = 0;
            this.isActive = false;
            this.news = "";
            this.getInfo(this.type);
        },
        jump(n, b) {
            this.$store.commit('reserve', n);
            this.$store.commit('minus', b);
        },
        hunt(b) {
            this.$store.commit('minus', b);
        },
        callphone(tel) {
            this.show = true;
            this.phone = tel;
        },
        none() {
            this.show = false;
        },
        know() {
            window.location.href = 'tel:' + this.phone;
            this.show = false;
        }
    }
}
</script>
<style scoped>
.picture span {
    position: relative;
    top: -0.3rem;
}

.vux-header {
    background: #4284d9;
}

/*.quit {
    display: flex;
    justify-content: center;
    background: #fff;
}

.quit span {
    display: inline-block;
    width: 50%;
    text-align: center;
    padding: .8rem 0rem;
    color: #8e8e8e;
    margin: 0 2rem;
}

.quit .active {
    color: #000;
    border-bottom: 2px solid #4d86ce;
}*/

.seek {
    text-align: center;
    background: #fff;
    margin: .5rem .8rem;
    padding: .3rem 0;
    font-size: 0.9rem;
    color: #8e8e8e;
}

.seek i {
    position: relative;
    top: 0.1rem;
    font-size: 1.2rem;
}

.ul_two li i {
    font-size: 2.5rem;
    color: #fff;
}

.ul_two li>span:nth-child(2) {
    display: inline-block;
    width: 80%;
    margin-left: 0.5rem;
}

.ul_two li {
    position: relative;
    background: #fff;
    padding: 1rem 0rem 1px 1rem;
}

.ul_two li>span:nth-child(1) {
    display: inline-block;
    background: #4fa8ea;
    width: 3rem;
    height: 3rem;
    border-radius: 50%;
    line-height: 3rem;
    text-align: center;
    position: relative;
    top: -.3rem;
}

.phone {
    color: #8e8e8e;
    font-size: .9rem;
    padding-bottom: .5rem;
    border-bottom: 1px solid #f2f2f3;
    z-index: 10;
}

.phone>span {
    position: absolute;
    left: 85%;
    color: #518edc;
    font-size: 28px;
    top: 18%;
    z-index: 1000;
}

.cover {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    opacity: 0.2;
    z-index: 500;
    background: #000;
}

.alart {
    position: fixed;
    top: 33%;
    width: 83%;
    margin: 0 auto;
    left: 9%;
    right: 9%;
    background: #fff;
    border-radius: 0.5rem;
    z-index: 1100;
    font-size: 1.2rem;
}

.know {
    padding: .8rem 0;
    display: inline-block;
    width: 48%;
    text-align: center;
}

.none {
    padding: .8rem 0;
    display: inline-block;
    width: 48%;
    text-align: center;
    border-right: 1px solid #F6F6F6;
}

.alart p:nth-child(1) {
    text-align: center;
    padding: 2rem 0;
}

.alart p:nth-child(2) {
    text-align: center;
    color: #4284d9;
    border-top: 1px solid #F6F6F6;
}
</style>
