<template>
    <div>
        <div class="x-header">
            <back-header>
                <p class="title">{{header}}</p>
                <p class="save" @click="save">保存</p>
            </back-header>
        </div>
        <div class="big_first">
            <div v-if="header!=='区域'" class="only">
                <input type="text" :value="meta2" v-model="meta2">
            </div>
            <x-address v-if="header=='区域'" class="address" :title="title2" v-model="value2" raw-value :list="addressData" value-text-align="left" placeholder="请选择地址"></x-address>
        </div>
        <div class="must">必填项</div>
    </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import address from '../url.js';
import $ from 'jquery';
import bus from '../bus.js';
import { XAddress, ChinaAddressV3Data } from 'vux'
export default {
    components: {
        BackHeader,
        XAddress
    },
    data() {
        return {
            header: "",
            meta: "",
            meta2: "",
            addressData: ChinaAddressV3Data,
            value2: [],
            title2: '',
            partKey: ""
        }
    },
    created() {
        this.getInfo();
    },
    methods: {
        getInfo() {
            var _this = this
            this.partKey = this.$route.params.partnerKey;
            this.header = this.$route.params.userId;
            this.meta = this.$route.params.message;
            this.meta2 = this.partKey[this.meta]
            if (this.header == '区域') {
                _this.value2 = [_this.meta[0], _this.meta[1], _this.meta[2]]
            }
            setTimeout(function () {
                $("input[type=text]").focus();
            }, 500);

        },
        save() {
            var _this = this;
            // _this.value2 = [_this.partKey.partnerProvince, _this.partKey.partnerCity, _this.partKey.partnerCountry]
            if (_this.header == '区域') {
                var params = { "partnerProvince": _this.value2[0], "partnerCity": _this.value2[1], "partnerCountry": _this.value2[2], "partnerKey": _this.partKey.partnerKey }
                this.axios.post(address.amend + localStorage.getItem('token'), params, {
                    headers: {
                        'Content-Type': 'application/json;charset=UTF-8'
                    }
                })
                    .then(function (data) {
                        _this.partKey.partnerProvince = _this.value2[0];
                        _this.partKey.partnerCity = _this.value2[1];
                        _this.partKey.partnerCountry = _this.value2[2];
                        _this.$store.commit('reserve', _this.partKey);
                        _this.$router.go(-1);
                        bus.$emit('back');
                    })
                    .catch(err => {

                    })
            } else {
                if (_this.partKey.partnerAttrValue == '公司' && _this.meta == 'partnerShortname' && _this.meta2 == "" || _this.partKey.partnerAttrValue == '公司' && _this.meta == 'partnerName' && _this.meta2 == "") {
                    $(".must").fadeIn(250).delay(2000).fadeOut(250)
                } else if (_this.partKey.partnerAttrValue == '个人' && _this.meta == 'contacterName' && _this.meta2 == "" || _this.partKey.partnerAttrValue == '个人' && _this.meta == 'tel1' && _this.meta2 == "") {

                } else {
                    var params = { "partnerKey": _this.partKey.partnerKey, "contacterId": _this.partKey.contacterId };
                    params[_this.meta] = _this.meta2
                    this.axios.post(address.amend + localStorage.getItem('token'), params, {
                        headers: {
                            'Content-Type': 'application/json;charset=UTF-8'
                        }
                    })
                        .then(function (data) {
                            _this.partKey[_this.meta] = _this.meta2;
                            _this.$store.commit('reserve', _this.partKey);
                            _this.$router.go(-1);
                            bus.$emit('back');
                        })
                        .catch(err => {

                        })
                }

            }


        }
    }
}
</script>
<style scoped>
.address {
    background: #fff;
    margin-top: 2rem;
}

.only {
    background: #fff;
    margin-top: 2rem;
    padding: .5rem 1rem;
}

.only input {
    border: none;
    width: 100%;
    height: 2rem;
    outline: none;
    caret-color: #2e8ae6;
}
@media only screen and (max-height: 560px) {
.must {
    position: absolute;
    width: 30%;
    height: 3rem;
    background: #000;
    color: #fff;
    opacity: 0.8;
    border-radius: 5px;
    text-align: center;
    line-height: 3rem;
    top: 68.5%;
    left: 35%;
    right: 35%;
    display: none;
}}
@media only screen and (min-height: 561px) {
.must {
    position: absolute;
    width: 30%;
    height: 3rem;
    background: #000;
    color: #fff;
    opacity: 0.8;
    border-radius: 5px;
    text-align: center;
    line-height: 3rem;
    top: 35%;
    left: 35%;
    right: 35%;
    display: none;
}}
</style>
