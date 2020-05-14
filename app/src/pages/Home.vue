<template>
	<div class="footerlists">
		<tabbar>
			<tabbar-item :class="{'weui-bar__item_on':currentTab== 'Workbench'}" @on-item-click="choose('Workbench')" link="/home/workbench">
				<span slot="icon" class="iconfont">&#xe66b;</span>
				<span slot="label">工作台</span>
			</tabbar-item>
			<tabbar-item :class="{'weui-bar__item_on':currentTab== 'Report'}" @on-item-click="choose('Report')" link="/home/report">
				<span slot="icon" class="iconfont">&#xe6de;</span>
				<span slot="label">报表</span>
			</tabbar-item>
			<tabbar-item :class="{'weui-bar__item_on':currentTab== 'User'}" @on-item-click="choose('User')" link="/home/user">
				<span slot="icon" class="iconfont">&#xe672;</span>
				<span slot="label">我的</span>
			</tabbar-item>
		</tabbar>
		<router-view></router-view>
	</div>
</template>

<script>
import { Tabbar, TabbarItem } from 'vux';
import address from '../url.js';
export default {
	data() {
		return {
			currentTab: localStorage.getItem('currentTab') || 'Workbench',
			numbers: "6"
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
		choose(ids) {
			if (ids == 'Report') {
				var _this = this
				this.axios.post(address.total + localStorage.getItem('token'))
					.then(function (data) {
						_this.$store.commit('stockpile', { "Sumx": data.data.SumReceivablesMoney, "total04x": data.data.totalPrice04, "total07x": data.data.totalPrice07 });
					})
					.catch(err => {

					})
			}
			this.currentTab = ids;
			localStorage.setItem('currentTab', ids);
		},
		getInfo() {
			if (localStorage.getItem('currentTab')) {

			} else {
				localStorage.setItem('currentTab', 'Workbench');
			}
			// JAnalytics.onPageStart({'pageName': 'home.vue'});
		},
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

.iconfont {
	font-size: 25px;
}

.weui-tabbar__label span:last-child {
	/*position: relative;
	bottom: 0px;*/
	font-size: 0.8rem;
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
</style>