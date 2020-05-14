<template>
  <header>
    <span  @click="back">
      <i class="iconfont">&#xe68c;</i><span class="goback">返回</span>
    </span>
    <slot></slot>
  </header>
</template>

<script>
 import bus from '../bus.js'
  export default{
      methods: {
          back() {
            bus.$emit('back');
          }
      }
  }
</script>

<style scoped>
  header{
    height:46px;
    background:#4284d9;
    position:fixed;
    left:0;
    right:0;
    top:0;
    z-index:100;
    padding:0px 15px 0 10px;
    color:#fff;
    line-height:46px;
    font-size:16px;
  }
  header>span{
    float: left;
    color:#fff;
    font-size: 14px;
  }
  .iconfont{
    font-size: 20px;
    float: left;
  }
  .sare{
    position: absolute;
    font-size: 25px;
    color: #fff;
    top:0px;
    right:15px;
  }
   .remember{
    position: absolute;
    color: #fff;
    top:0px;
    right:15px;
    font-size: 14px;
  }
  .save{
    position: absolute;
    font-size: 14px;
    color: #fff;
    top:0px;
    right:15px;
  }
  .state{
    position: absolute;
    font-size: 14px;
    color: #fff;
    top:0px;
    right:15px;
  }
  .title{
    width: 50%;
    margin: 0 auto;
    text-align: center;
  }
  .goback{
    float: left;
  }
</style>
