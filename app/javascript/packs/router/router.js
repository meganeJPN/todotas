import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import Index from '../components/index.vue'
import User from '../components/user.vue'
import Signup from '../components/users/signup.vue'
import Login from '../components/users/login.vue'
import Account from '../components/users/account.vue'
import Edit from '../components/users/edit.vue'
import axios from 'axios';

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: Index },
    { path: '/user', component: User },
    { path: '/users/signup', component: Signup,meta: {
      isPublic: true
    } },
    { path: '/users/login', component: Login,meta: {
      isPublic: true
    } },
    { path: '/users/account', component: Account },
    { path: '/users/edit', component: Edit },
  ],
})

router.beforeEach((to, from , next)=>{
  if (to.matched.some(page => page.meta.isPublic)) {
    next();
  }else{
  axios.get('/v1/auth/validate_token', {
    headers: {
      'access-token': localStorage.getItem('access-token'),
      uid: localStorage.getItem('uid'),
      client: localStorage.getItem('client'),
    },
  }).then((response)=>{
    next()
  },
  (error) =>{
    next('/users/login')
  }
  );
  }
});

export default router
