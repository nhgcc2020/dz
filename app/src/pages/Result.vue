<template>
    <div>
        <div class="x-header">
            <back-header>
                <p class="title">搜索结果</p>
                <p class="save" @click="save">取消</p>
            </back-header>
        </div>
        <div class="big_first">
            <ul class="ul_two">
                <li v-for="(n,index) in news" key="index" v-if="n.partnerKey!=='temp-customer'">
                    <span>
                        <i v-if="names=='Adressbook'" class="iconfont">&#xe69b;</i>
                        <i v-if="names=='Supplier'" class="iconfont">&#xe6c3;</i>
                    </span>
                    <span>
                        <div class="partnerName">{{n.partnerShortname}}</div>
                        <div class="phone">{{n.contacterName | kong}}
                            <span v-if="(/^1[34578]\d{9}$/.test(n.tel1))" class="iconfont" @click="callphone(n.tel1)">&#xe683;</span>
                        </div>
                    </span>
                    <router-link @click.native="jump(n)" tag="div" to="/friend" style="position:absolute; top:0;height:90%;width:100%;z-index:100;background: transparent;"></router-link>
                </li>
            </ul>
            <div v-if="hide" class="picture">
                <p>
                    <i class="iconfont">&#xe6df;</i>
                </p>
                <p>未搜索到相关信息</p>
            </div>
            <div v-show="show" class="cover"></div>
            <div v-show="show" class="alart">
                <p>确定要打电话吗？</p>
                <p>
                    <span class="none" @click="none">取消</span>
                    <span class="know" @click="know">确定</span>
                </p>
            </div>
        </div>
    </div>
</template>
<script>
import BackHeader from '../common/BackHeader'
import address from '../url.js';
import bus from '../bus.js';
import { mapState, mapGetters } from 'vuex';
export default {
    computed: mapState(['alone', 'names', 'numbers']),
    components: {
        BackHeader
    },
    data() {
        return {
            news: "",
            show: false,
            phone:"",
            hide: false
        }
    },
    created() {
        this.getInfo();
    },
    methods: {
        getInfo() {
            var _this = this;
            setTimeout(function () {
                var login_name = encodeURI(encodeURI(_this.alone));
                var params = "type=1&page=1&rows=30&searchKey=" + login_name;
                if (_this.numbers) {
                    _this.news = [_this.numbers];
                    _this.$store.commit('result', '')
                } else {
                    if (_this.names == 'Adressbook') {
                        _this.axios.post(address.addressbook + localStorage.getItem('token'), params)
                            .then(function (data) {
                                _this.news = data.data;
                                if (data.data.length == 0) {
                                    _this.hide = true;
                                }
                            })
                            .catch(err => {

                            })
                    } else {
                        _this.axios.post(address.supplier + localStorage.getItem('token'), params)
                            .then(function (data) {
                                _this.news = data.data
                                if (data.data.length == 0) {
                                    _this.hide = true;
                                }
                            })
                            .catch(err => {

                            })
                    }
                }
            }, 100);
        },
        save() {
            bus.$emit('back','2');
            this.$store.commit('seek', '');
        },
        jump(n) {
            this.$store.commit('reserve', n)
            // localStorage.setItem('news',a);
            // console.log(a)
        },
         callphone(tel){
            this.show = true;
            this.phone = tel;
        },
        none(){
            this.show = false;
        },
        know(){
            window.location.href = 'tel:' + this.phone;
            this.show = false;
        }
    }
}
</script>
<style scoped>
.ul_two li>span:nth-child(1) {
    display: inline-block;
    background: #4fa8ea;
    width: 3rem;
    height: 3rem;
    border-radius: 50%;
    line-height: 3rem;
    text-align: center;
}

.ul_two li i {
    font-size: 2.5rem;
    color: #fff;
}
.picture>p:nth-child(1) {
    width: 7rem;
    height: 7rem;
    border-radius: 50%;
    background: #e4e4e4;
    text-align: center;
    line-height: 7rem;
    margin: 1rem auto;
}

.picture i {
    font-size: 4rem;
    color: #fff;
}

.picture {
    font-size: 0.8rem;
    width: 35%;
    margin: 10rem auto;
    color: #8e8e8e;
    text-align: center;
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
     .phone {
        color: #8e8e8e;
        font-size: .9rem;
        padding-bottom: 0.5rem;
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
.know{
    padding: .8rem 0;
    display: inline-block;
    width: 48%;
    text-align: center;
}
.none{
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
