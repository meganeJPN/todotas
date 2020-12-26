import Vue from 'vue/dist/vue.esm.js'
import Router from './router/router'
import Header from './components/header.vue'
import Footer from './components/footer.vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import locale from 'element-ui/lib/locale/lang/ja'
import {Table} from 'element-ui-2.6.3'

Vue.use(ElementUI, { locale })
Vue.component(Table.name, Table)
Vue.config.productionTip = false;

var app = new Vue({
  router: Router,
  el: '#app',
  components: {
    'navbar': Header,
     'navbar-footer': Footer,
  },
  
});