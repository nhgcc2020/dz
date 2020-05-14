
import Vue from 'vue'
import Router from 'vue-router'
import Home from '../pages/Home'
import Workbench from '../pages/home/Workbench'
import Award from '../pages/generalize/Award'
Vue.use(Router)
var a = (localStorage.getItem('token'))? "home/"+localStorage.getItem('currentTab'):"Login";
export default new Router({
  routes: [
    {
      path: "/home",
      component: Home,
      children:[{
      path:'workbench',
      component:Workbench
    },
    {
      path:'report',
      component:resolve =>{
        require(['../pages/home/Report'],resolve)
      }
    },
    {
      path:'user',
      component:resolve =>{
        require(['../pages/home/User'],resolve)
      }
    }]
  },
  {
      path: "/generalize",
      component:resolve =>{
        require(['../pages/Generalize'],resolve)
      },
      children:[{
      path:'award',
      component:Award
    },
    {
      path:'selft',
      component:resolve =>{
        require(['../pages/generalize/Selft'],resolve)
      }
    }]
    },
    {
      path:"/login",
      component:resolve =>{
        require(['../pages/Login'],resolve)
      }
    },
     {
      path:"/personal",
      component:resolve =>{
        require(['../pages/Personal'],resolve)
      }
    },
     {
      path:"/basic",
      component:resolve =>{
        require(['../pages/Basic'],resolve)
      }
    },
     {
      path:"/quit",
      component:resolve =>{
        require(['../pages/Quit'],resolve)
      }
    },
    {
      path:"/sareport",
      component:resolve =>{
        require(['../pages/Sareport'],resolve)
      },
      meta: { keepAlive: true }
    },
    {
      path:"/sdaishoukuan",
      component:resolve =>{
        require(['../pages/Sdaishoukuan'],resolve)
      },
      meta: { keepAlive: true }
    },
    {
      path:"/sydaifukuan",
      component:resolve =>{
        require(['../pages/Sydaifukuan'],resolve)
      },
      meta: { keepAlive: true }
    },
     {
      path:"/adressbook",
      component:resolve =>{
        require(['../pages/Adressbook'],resolve)
      }
    },
    {
      path:"/client",
      component:resolve =>{
        require(['../pages/Client'],resolve)
      }
    },
     {
      path:"/supplier",
      component:resolve =>{
        require(['../pages/Supplier'],resolve)
      }
    },
     {
      path:"/syreport",
      component:resolve =>{
        require(['../pages/Syreport'],resolve)
      },
      meta: { keepAlive: true }
    },
     {
      path:"/particulars/:salesNo",
      component:resolve =>{
        require(['../pages/Particulars'],resolve)
      }
    },
     {
      path:"/particularsDraft/:salesNo",
      component:resolve =>{
        require(['../pages/Particularsdraft'],resolve)
      }
    },
    {
      path:"/syreportDetails/:salesNo",
      component:resolve =>{
        require(['../pages/SyreportDetails'],resolve)
      }
    },
    {
      path:"/sorderchecking/:salesNo",
      component:resolve =>{
        require(['../pages/Sorderchecking'],resolve)
      }
    },
    {
      path:"/porderchecking/:salesNo",
      component:resolve =>{
        require(['../pages/Porderchecking'],resolve)
      }
    },
    {
      path:"/porderchase/:salesNo",
      component:resolve =>{
        require(['../pages/Porderchase'],resolve)
      }
    },
    {
      path:"/construction",
      component:resolve =>{
        require(['../pages/Construction'],resolve)
      }
    },
    {
      path:"/friend",
      component:resolve =>{
        require(['../pages/Friend'],resolve)
      }
    },
    {
      path:"/amend",
      name: 'amend',
      component:resolve =>{
        require(['../pages/Amend'],resolve)
      }
    },
    {
      path:"/result",
      component:resolve =>{
        require(['../pages/Result'],resolve)
      }
    },
    {
      path:"/seek",
      component:resolve =>{
        require(['../pages/Seek'],resolve)
      }
    },
    {
      path:"/invite",
      component:resolve =>{
        require(['../pages/Invite'],resolve)
      }
    },
    {
      path:"/flow",
      component:resolve =>{
        require(['../pages/Flow'],resolve)
      }
    },
    {
      path:"/tendency",
      component:resolve =>{
        require(['../pages/Tendency'],resolve)
      }
    },
    {
      path:"/reconciliation",
      component:resolve =>{
        require(['../pages/Reconciliation'],resolve)
      }
    },
    {
      path:"/remind",
      component:resolve =>{
        require(['../pages/Remind'],resolve)
      }
    },
    {
      path:"/staff",
      component:resolve =>{
        require(['../pages/Staff'],resolve)
      }
    },
    {
      path:"/apply",
      component:resolve =>{
        require(['../pages/Apply'],resolve)
      }
    },
    {
      path:"/gathering",
      component:resolve =>{
        require(['../pages/Gathering'],resolve)
      }
    },
     {
      path:"/statistics",
      component:resolve =>{
        require(['../pages/Statistics'],resolve)
      }
    },
    {
      path:"/sdaitijiao",
      component:resolve =>{
        require(['../pages/Sdaitijiao'],resolve)
      }
    },
    {
      path:"/sdaishoukuanone",
      component:resolve =>{
        require(['../pages/Sdaishoukuanone'],resolve)
      }
    },
    {
      path:"/dayaccount",
      component:resolve =>{
        require(['../pages/Dayaccount'],resolve)
      }
    },
    {
      path:"/salaryaccount",
      component:resolve =>{
        require(['../pages/Salaryaccount'],resolve)
      }
    },
    {
      path:"/newaccount/:salesNo",
      component:resolve =>{
        require(['../pages/Newaccount'],resolve)
      }
    },
     {
      path:"/returned",
      component:resolve =>{
        require(['../pages/Returned'],resolve)
      }
    },
    { 
      path:"/updateaccount",
      name: 'update',
      component:resolve =>{
        require(['../pages/Updateaccount'],resolve)
      }
    },
     {
      path:"/margin",
      component:resolve =>{
        require(['../pages/Margin'],resolve)
      }
    },
    {
      path:"/design",
      component:resolve =>{
        require(['../pages/Design'],resolve)
      }
    },
    {
      path:"/tasking/:salesNo",
      component:resolve =>{
        require(['../pages/Tasking'],resolve)
      }
    },
    {
      path:"/stylist/:salesNo",
      component:resolve =>{
        require(['../pages/Stylist'],resolve)
      }
    },
     {
      path:"/billing",
      component:resolve =>{
        require(['../pages/Billing'],resolve)
      }
    },
    {
      path:"/billingAmend/:salesNo",
      component:resolve =>{
        require(['../pages/BillingAmend'],resolve)
      }
    },
    {
      path:"/category",
      component:resolve =>{
        require(['../pages/Category'],resolve)
      }
    },
     {
      path:"/service",
      component:resolve =>{
        require(['../pages/Service'],resolve)
      }
    },
    {
      path:"/prepaid",
      component:resolve =>{
        require(['../pages/Prepaid'],resolve)
      }
    },
    {
      path:"/prestore",
      name: 'prest',
      component:resolve =>{
        require(['../pages/Prestore'],resolve)
      }
    },
    {
      path:"/business/:salesNo",
      component:resolve =>{
        require(['../pages/Business'],resolve)
      },
      meta: { keepAlive: true }
    },
    {
      path:"/businessDetails/:oppoNo",
      component:resolve =>{
        require(['../pages/BusinessDetails'],resolve)
      }
    },
    {
      path:"/record/:oppoNo",
      component:resolve =>{
        require(['../pages/Record'],resolve)
      }
    },
    {
      path:"/bargain",
      component:resolve =>{
        require(['../pages/Bargain'],resolve)
      },
      meta: { keepAlive: true }
    },
    {
      path:"/bargainDetails/:contractNo",
      component:resolve =>{
        require(['../pages/BargainDetails'],resolve) 
      }
    },
    {
      path:"/recordbargin/:contractNo",
      component:resolve =>{
        require(['../pages/Recordbargin'],resolve) 
      }
    },
    {
      path:"/fabrication",
      component:resolve =>{
        require(['../pages/Fabrication'],resolve) 
      },
      meta: { keepAlive: true }
    },
     {
      path:"/fabricationDetails/:taskNo",
      component:resolve =>{
        require(['../pages/FabricationDetails'],resolve) 
      }
    },
    {
      path:"*",
      redirect: a  
    }
  ]
})
