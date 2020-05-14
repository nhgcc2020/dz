<template>
    <div>
        <div class="x-header">
            <back-header>
                <p class="title">个人中心</p>
            </back-header>
        </div>
        <div class="big_first">
            <div class="header_img">
                <span v-cloak>{{news.realName}}</span>
                <img v-if="news.comLogoPath !==''" :src="news.comLogoPath | image" alt="">
                <img v-if="news.comLogoPath ==''" src="../assets/font-awesome/image/login.jpeg" alt="">
            </div>
            <ul class="list">
                <li>昵称
                    <span v-cloak>{{news.nickName}}</span>
                </li>
                <li>手机号码
                    <span v-cloak>{{news.userId}}</span>
                </li>
                <li>备用手机
                    <span v-cloak>{{news.telBak}}</span>
                </li>
                <li>联系QQ
                    <span v-cloak>{{news.qq}}</span>
                </li>
                <li>电子邮件
                    <span v-cloak>{{news.email}}</span>
                </li>
                <li>所在地
                    <span v-cloak>{{nowProvince}} {{nowCity}} {{nowCountry}}</span>
                </li>
                <li>家乡
                    <span v-cloak>{{localProvince}} {{localCity}} {{localCountry}}</span>
                </li>
            </ul>
            <div class="quit" @click="drop">退出登录</div>
        </div>
        <div v-show="show" class="cover"></div>
        <div v-show="show" class="alart">
            <p>确定要退出吗？</p>
            <p>
                <span class="none" @click="none">取消</span>
                <span class="know" @click="know">确定</span>
            </p>
        </div>
    </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import address from '../url.js';
import city from '../china_city.js';
import $ from 'jquery';
export default {
    components: {
        BackHeader
    },
    data() {
        return {
            show: false,
            news: "",
            localProvince:"",
            localCity:"",
            localCountry:"",
            nowProvince:"",
            nowCity:"",
            nowCountry:""
        }
    },
    created() {
        this.getInfo();
    },
    methods: {
        getInfo() {
            var _this = this
            this.axios.get(address.personal + localStorage.getItem('token'))
                .then(function (data) {
                    _this.news = data.data.data
                    $.each(city.ProvinceJson, function (key, val) {
                        if (val.provinceId == data.data.data.localProvince) {
                            _this.localProvince = val.provinceName;
                        }
                    });
                    $.each(city.CityJson, function (key, val) {
                        if (val.provinceId == data.data.data.localProvince && val.cityId == data.data.data.localCity) {
                            _this.localCity = val.cityName;
                        }
                    });
                    $.each(city.CountryJson, function (key, val) {
                        if (val.cityId == data.data.data.localCity && val.countryId == data.data.data.localCountry) {
                            _this.localCountry = val.countryName;
                        }
                    });
                    $.each(city.ProvinceJson, function (key, val) {
                        if (val.provinceId == data.data.data.nowProvince) {
                            _this.nowProvince = val.provinceName;
                        }
                    });
                    $.each(city.CityJson, function (key, val) {
                        if (val.provinceId == data.data.data.nowProvince && val.cityId == data.data.data.nowCity) {
                            _this.nowCity = val.cityName;
                        }
                    });
                    $.each(city.CountryJson, function (key, val) {
                        if (val.cityId == data.data.data.nowCity && val.countryId == data.data.data.nowCountry) {
                            _this.nowCountry = val.countryName;
                        }
                    });
                })
                .catch(err => {

                })
        },
        drop() {
            $(".cover").fadeIn("slow")
            $(".alart").fadeIn("slow")
            this.show = true;
        },
        know() {
            var _this = this
            this.axios.get(address.droplogin + localStorage.getItem('token'))
                .then(function (data) {
                    _this.$router.push('/login')
                    if (data.data.code == 7) {
                        localStorage.removeItem('currentTab');
                        localStorage.removeItem('token');
                    } else {

                    }
                })
                .catch(err => {

                })
        },
        none() {
            this.show = false;
        }
    }
}
</script>
<style scoped>
.header_img {
    height: 3.5rem;
    background: #fff;
    margin: 0.8rem auto;
    padding: 0 1rem;
    line-height: 3.5rem;
}

.header_img img {
    margin-top: 0.5rem;
    height: 2.5rem;
    width: 2.5rem;
    border-radius: 50%;
    float: right;
}

.list li {
    background: #fff;
    font-size: 1rem;
    border-bottom: 1px solid #f6f6f6;
    padding: .5rem 0 .5rem 1rem;
}

.list li span {
    float: right;
    margin-right: 1rem;
    color: #4f4f4f;
}

.list li:last-child {
    border: none;
}

.quit {
    height: 2.5rem;
    background: #fff;
    margin-top: 1rem;
    font-size: 1rem;
    line-height: 2.5rem;
    text-align: center;
}

.vux-header {
    background: #4284d9;
}

.vux-header .vux-header-left .vux-header-back {
    color: #fff;
}

.x-header .vux-header>.vux-header-left>.left-arrow:before {
    border-color: #fff !important;
    border: 1px solid #ccc;
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
    /**/
}
</style>
