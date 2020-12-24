import Vue from 'vue/dist/vue.esm.js'
import Router from './router/router'
import Header from './components/header.vue'
import Footer from './components/footer.vue'
import VueMaterial from 'vue-material'
import 'vue-material/dist/vue-material.css';

Vue.use(VueMaterial)
Vue.config.productionTip = false;

var app = new Vue({
  router: Router,
  el: '#app',
  components: {
    'navbar': Header,
     'navbar-footer': Footer,
  },
});
