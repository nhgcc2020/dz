<template>
	<div class="footerlists">
		<tabbar>
			<tabbar-item selected link="/generalize/award">
				<span slot="label" class="iconfont">&#xe6c6;</span>
				<span slot="label">我要推广</span>
			</tabbar-item>
			<tabbar-item>
				<span slot="label"></span>
				<span slot="label"></span>
			</tabbar-item>
			<tabbar-item link="/generalize/selft">
				<span slot="label" class="iconfont">&#xe672;</span>
				<span slot="label">我的</span>
			</tabbar-item>
		</tabbar>
		<router-view></router-view>
	</div>
</template>

<script>
import { Tabbar, TabbarItem } from 'vux'
export default {
	data() {
		return {
			
		}

	},
	components: {
		Tabbar,
		TabbarItem
	},
	created() {
		this.getInfo();
	},
	methods: {
		getInfo(){
             this.$router.push('/generalize/award');
			//  
        }
	}

}
</script>

<style scoped>
* {
	box-sizing: border-box;
}

.weui-tabbar {
	background: white;
}

.weui-bar__item_on p span {
	color: #0081ff!important;
}

.weui-tabbar__label span {
	display: block;
}

.weui-tabbar__label span:first-child {
	font-size: 22px;
	margin-top: 8px;
}
.weui-tabbar__label span:last-child {
	position: relative;
	bottom: 15px;
	font-size: 0.7rem;
}

.vux-tabbar-simple .weui-tabbar__label .iconfont {
	line-height: normal !important;
}

.weui-tabbar {
	position: fixed;
}

.vux-header {
	background: #4284d9;
}
.weui-tabbar__item.vux-tabbar-simple{
	height: 52px;
	line-height: 52px;
}
</style>