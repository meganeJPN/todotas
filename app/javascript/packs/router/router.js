import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import Index from '../components/index.vue'
import User from '../components/user.vue'
import Signup from '../components/users/signup.vue'
import Login from '../components/users/login.vue'
import Account from '../components/users/account.vue'
import Edit from '../components/users/edit.vue'


Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: Index },
    { path: '/user', component: User },
    { path: '/users/signup', component: Signup },
    { path: '/users/login', component: Login },
    { path: '/users/account', component: Account },
    { path: '/users/edit', component: Edit },
  ],
})