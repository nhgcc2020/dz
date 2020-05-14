<template>
    <div>
        <div class="x-header">
            <back-header>
                <p class="title">{{news.partnerShortname }}</p>
            </back-header>
        </div>
        <div class="big_first">
            <div class="header">
                <span>
                    <i v-if="names=='Adressbook'" class="iconfont">&#xe69b;</i>
                    <i v-if="names=='Supplier'" class="iconfont">&#xe6c3;</i>
                </span>
                <span>
                    <div>{{news.partnerShortname}}</div>
                    <div style="color:#8e8e8e;font-size:.9rem;">{{news.contacterName | kong}}</div>
                </span>
                <span v-if="show">
                    <i v-if="showtwo" style="font-size:20px;position:relative;top:0.05rem;" class="iconfont">&#xe6f3;</i>&nbsp;{{news.statusValue}}...</span>
                <span style="color:#699de0;border:1px solid #699de0;padding:.3rem 0.4rem;line-height:1rem;height:1rem;margin-top:4%;" v-if="!show" @click="invite">邀请加为好友</span>
            </div>
            <ul v-if="news.partnerAttr=='1'">
                <router-link v-if="news.statusValue=='待邀请'" tag="li" :to="{ name: 'amend', params: { userId: '企业简称',message:'partnerShortname',partnerKey:news }}">
                    <span>简称</span>
                    <span>{{news.partnerShortname | message }}</span>
                    <i class="iconfont">&#xe68b;</i>
                </router-link>
                <li v-if="news.statusValue!=='待邀请'">
                    <span>简称</span>
                    <span>{{news.partnerShortname | message }}</span>
                    <i></i>
                </li>
                <router-link v-if="news.statusValue=='待邀请'" tag="li" :to="{ name: 'amend', params: { userId: '企业全称',message:'partnerName',partnerKey:news}}">
                    <span>全称</span>
                    <span>{{news.partnerName | message }}</span>
                    <i class="iconfont">&#xe68b;</i>
                </router-link>
                <li v-if="news.statusValue!=='待邀请'">
                    <span>全称</span>
                    <span>{{news.partnerName | message }}</span>
                    <i></i>
                </li>
                <router-link v-if="news.statusValue=='待邀请'" tag="li" :to="{ name: 'amend', params: { userId: '联系人',message:'contacterName',partnerKey:news }}">
                    <span>联系人</span>
                    <span>{{news.contacterName | content}}</span>
                    <i class="iconfont">&#xe68b;</i>
                </router-link>
                <li v-if="news.statusValue!=='待邀请'">
                    <span>联系人</span>
                    <span>{{news.contacterName | content}}</span>
                    <i></i>
                </li>
    
                <li v-if="news.statusValue=='待邀请'" style="position:relative;">
                    <span>手机</span>
                    <span>{{news.tel1 | content }}</span>
                    <i id="call" v-if="(/^1[34578]\d{9}$/.test(news.tel1))" @click="callphone(news.tel1)" class="iconfont">&#xe683;</i>
                    <router-link class="iconfont" tag="i" :to="{ name: 'amend', params: { userId: '手机',message:'tel1',partnerKey:news }}">&#xe68b;</router-link>
                </li>
    
                <li v-if="news.statusValue!=='待邀请'" style="position:relative;">
                    <span>手机</span>
                    <span>{{news.tel1 | content }}</span>
                    <i id="call" v-if="(/^1[34578]\d{9}$/.test(news.tel1))" @click="callphone(news.tel1)" class="iconfont">&#xe683;</i>
                    <i></i>
                </li>
                <router-link tag="li" :to="{ name: 'amend', params: { userId: '区域',message: district1,partnerKey:news }}">
                    <span>区域</span>
                    <span>{{district | content}}</span>
                    <i class="iconfont">&#xe68b;</i>
                </router-link>
                <router-link tag="li" :to="{ name: 'amend', params: { userId: '地址',message:'partnerAddress',partnerKey:news }}">
                    <span>地址</span>
                    <span>{{news.partnerAddress | content}}</span>
                    <i class="iconfont">&#xe68b;</i>
                </router-link>
                <router-link tag="li" :to="{ name: 'amend', params: { userId: '助记码',message: 'mnemonicCode',partnerKey:news }}">
                    <span>助记码</span>
                    <span>{{news.mnemonicCode | content}}</span>
                    <i class="iconfont">&#xe68b;</i>
                </router-link>
            </ul>
            <ul v-if="news.partnerAttr=='2'">
                <router-link v-if="news.statusValue=='待邀请'" tag="li" :to="{ name: 'amend', params: { userId: '联系人',message: 'contacterName',partnerKey:news }}">
                    <span>联系人</span>
                    <span>{{news.contacterName | content}}</span>
                    <i class="iconfont">&#xe68b;</i>
                </router-link>
                <li v-if="news.statusValue!=='待邀请'">
                    <span>联系人</span>
                    <span>{{news.contacterName | content}}</span>
                    <i></i>
                </li>
                <li v-if="news.statusValue=='待邀请'" style="position:relative;">
                    <span>手机</span>
                    <span>{{news.tel1 | content}}</span>
                    <i id="call" v-if="(/^1[34578]\d{9}$/.test(news.tel1))" @click="callphone(news.tel1)" class="iconfont">&#xe683;</i>
                    <router-link class="iconfont" tag="i" :to="{ name: 'amend', params: { userId: '手机',message:'tel1',partnerKey:news }}">&#xe68b;</router-link>
                </li>
                <li v-if="news.statusValue!=='待邀请'" style="position:relative;">
                    <span>手机</span>
                    <span>{{news.tel1 | content}}</span>
                    <i id="call" v-if="(/^1[34578]\d{9}$/.test(news.tel1))" @click="callphone(news.tel1)" class="iconfont">&#xe683;</i>
                    <i></i>
                </li>
                <router-link tag="li" :to="{ name: 'amend', params: { userId: '助记码',message: 'mnemonicCode',partnerKey:news }}">
                    <span>助记码</span>
                    <span>{{news.mnemonicCode | content}}</span>
                    <i class="iconfont">&#xe68b;</i>
                </router-link>
            </ul>
            <div v-show="showthree" class="cover"></div>
            <div v-show="showthree" class="alart">
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
import BackHeader from '../common/BackHeader';
import address from '../url.js';
import city from '../china_city.js';
import $ from 'jquery';
import { mapState, mapGetters } from 'vuex';
export default {
    components: {
        BackHeader
    },
    data() {
        return {
            news: "",
            Province: "",
            City: "",
            Country: "",
            district: "",
            district1: [],
            show: true,
            showone: true,
            showtwo: false,
            showthree:false,
            phone:"",
            iconfont:false
        }
    },
    created() {
        this.getInfo();
    },
    computed: mapState(['counts', 'names', 'nums']),
    methods: {
        getInfo() {
            var _this = this
            setTimeout(function () {
                _this.news = _this.nums;
                if (_this.news.statusValue == '邀请中' || _this.news.statusValue == '申请中') {
                    _this.showtwo = true;
                };
                // if (_this.news.allTotalPrice == '0.00' || _this.news.allTotalPrice == "" && _this.news.allReceivablesMoney == '0.00' || _this.news.allReceivablesMoney == "") {
                //     _this.showone = false;
                // };
                if (_this.news.statusValue == '待邀请' && _this.news.partnerAttrValue == '公司') {
                    _this.show = false;
                };
                $.each(city.ProvinceJson, function (key, val) {
                    if (val.provinceId == _this.news.partnerProvince) {
                        _this.Province = val.provinceName;
                    }
                });
                $.each(city.CityJson, function (key, val) {
                    if (val.provinceId == _this.news.partnerProvince && val.cityId == _this.nums.partnerCity) {
                        _this.City = val.cityName;
                    }
                });
                $.each(city.CountryJson, function (key, val) {
                    if (val.cityId == _this.news.partnerCity && val.countryId == _this.nums.partnerCountry) {
                        _this.Country = val.countryName;
                    }
                });
                _this.district = _this.Province + " " + _this.City + " " + _this.Country;
                _this.district1 = [_this.Province, _this.City, _this.Country]
            }, 100);
        },
        invite() {
            this.$router.push('/invite')
        },
        callphone(tel) {
            this.showthree = true;
            this.phone = tel;
        },
        none() {
            this.showthree = false;
        },
        know() {
            window.location.href = 'tel:' + this.phone;
            this.showthree = false;
        }
    }
}
</script>
<style scoped>
.header {
    background: #fff;
    padding: .7rem 0rem .7rem 1rem;
}

.header>span {
    display: inline-block;
}

.header>span:nth-child(1) {
    width: 3rem;
    height: 3rem;
    border-radius: 50%;
    background: #4fa8ea;
    text-align: center;
}

.header>span:nth-child(1) i {
    font-size: 2.5rem;
    color: #fff;
    line-height: 3rem;
}

.header>span:nth-child(2) {
    position: relative;
    margin-left: .5rem;
    top: 0.2rem;
}

.header>span:nth-child(3) {
    float: right;
    height: 3rem;
    line-height: 3rem;
    margin-right: 1rem;
    font-size: .9rem;
    color: #44ae80;
}

/*.headerchild {
    width: 100%;
    padding: 1rem 0;
    border: 1px solid #f2f2f3;
    background: #fff;
}

.headerchild>p {
    width: 100%;
}

.headerchild>p:nth-child(2) {
    color: #8e8e8e;
}

.headerchild>p>span {
    display: inline-block;
    width: 49%;
    text-align: center;
}*/

ul {
    background: #fff;
    margin-top: 1rem;
}

ul li {
    display: flex;
    justify-content: center;
    padding: 0.7rem 0rem .6rem 0;
    border-bottom: 1px solid #f2f2f3;
    font-size: .9rem;
    margin-left: 1rem;
}

ul li>span:nth-child(1) {
    display: inline-block;
    width: 20%
}

ul li>span:nth-child(2) {
    display: inline-block;
    width: 70%;
    padding-left: 3rem;
}

ul li>i {
    display: inline-block;
    text-align: right;
    margin-right: 1rem;
    width: 10%;
    font-weight: 900;
    color: #adadad;
    font-size: 0.9rem;
}

ul li span:nth-child(2) {
    color: #8e8e8e;
}
.header>span:nth-child(2) {
        position: relative;
        margin-left: .5rem;
        top: 0.2rem;
    }
#call {
        font-weight: normal;
        font-size: 28px;
        position: absolute;
        z-index: 1000;
        color: #518edc;
        top: 0%;
        left: 60%;
    }

.cover {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 110%;
    opacity: 0.2;
    z-index: 500;
    background: #000;
}

.alart {
    position: absolute;
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
