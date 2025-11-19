import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import mixins from './mixins'
import store from './store'
import VueRouter from 'vue-router';
import VueDaumPostcode from 'vue-daum-postcode'
//뷰스윗알럿
import VueSweetalert2 from 'vue-sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
//카로셋
import carousel from 'vue-owl-carousel';
//부트스트랩 정의
import 'bootstrap'
import 'bootstrap/dist/css/bootstrap.min.css'

//css
import './css/styleCustom.css'

createApp(App).use(router).mixin(mixins).use(store).use(VueSweetalert2).use(VueDaumPostcode).use(VueRouter).use(carousel).mount('#app');
window.Kakao.init("495352afc7ad2c6c24b84ba29e9f9488");  //자바스크립트 키