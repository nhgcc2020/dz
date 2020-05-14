<template>
  <div>
    <div class="x-header">
      <back-header>
        <p class="title">企业基本信息</p>
      </back-header>
    </div>
    <div class="big_first">
      <div class="login_img">
        <img v-if="news.comLogoPath !==''" :src="news.comLogoPath | image" alt="">
        <img v-if="news.comLogoPath ==''" src="../assets/font-awesome/image/login.jpeg" alt="">
        <p class="company_name">
          <span v-cloak>{{news.comName}}</span>
          <br>
          <span v-cloak>{{news.comShortname}}</span>
          <span v-cloak>{{news.comId}}</span>
        </p>
      </div>
      <ul class="list">
        <li>所有行业
          <span v-cloak>{{news.industryValue}}</span>
        </li>
        <li>内部邀请码
          <span v-cloak>{{news.withinComId}}</span>
        </li>
        <li>企业类型
          <span v-cloak>{{news.comType | type}}</span>
        </li>
        <li>企业 QQ
          <span v-cloak>{{news.comQQ}}</span>
        </li>
        <li>企业电话
          <span v-cloak>{{news.comTel}}</span>
        </li>
        <li>地区
          <span v-cloak>{{comProvince}} {{comCity}}</span>
        </li>
        <li>地址
          <span v-cloak>{{news.comAddress}}</span>
        </li>
      </ul>
       <div v-if="showding" class="la-timer" style="position: absolute;top:45%;left:45%;">
                <div></div>
      </div>
    </div>
  </div>
</template>
<script>
import BackHeader from '../common/BackHeader'
import address from '../url.js'
import city from '../china_city.js'
import $ from 'jquery';
export default {
  components: {
    BackHeader
  },
  data() {
    return {
      news: "",
      comCity:"",
      comProvince:"",
      showding:true
    }
  },
  created() {
    this.getInfo();
  },
  methods: {
    getInfo() {
      var _this = this
      this.axios.get(address.basic + localStorage.getItem('token'))
        .then(function (data) {
          _this.showding = false;
          _this.news = data.data.data;
            $.each(city.ProvinceJson, function (key, val) {
              if (val.provinceId == data.data.data.comProvince) {
                _this.comProvince = val.provinceName;
              }
            });
            $.each(city.CityJson, function (key, val) {
              if (val.provinceId == data.data.data.comProvince && val.cityId == data.data.data.comCity) {
                _this.comCity = val.cityName;
              }
            });
        })
        .catch(err => {

        })
    }
  }
}
</script>
<style scoped>
.login_img {
  padding: 0 1rem;
  height: 3.5rem;
  background: #fff;
  line-height: 3.5rem;
  margin: 1rem auto;
}

.login_img img {
  width: 2.5rem;
  height: 2.5rem;
  border-radius: 50%;
  float: left;
  margin-top: 0.5rem;
  margin-left: 1rem;
}

.company_name {
  font-size: 1rem;
  padding-top: .5rem;
  padding-left: 4.2rem;
  line-height: normal;
}

.company_name span:nth-child(3) {
  color: #4f4f4f;
  font-size: .9rem;
}

.company_name span:nth-child(4) {
  color: #4f4f4f;
  font-size: .9rem;
}

.list li {
  background: #fff;
  font-size: 1rem;
  border-bottom: 1px solid #F6F6F6;
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

.vux-header {
  background: #4284d9;
}
</style>
