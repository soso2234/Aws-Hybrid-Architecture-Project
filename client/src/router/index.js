import { createRouter, createWebHistory } from 'vue-router'
import ProductList from '../views/ProductList.vue'
import ProductDetail from '../views/ProductDetail.vue'
import ProductCreate from '../views/ProductCreate.vue'
import SalesList from '../views/SalesList.vue'
import ImageInsert from '../views/ImageInsert.vue'
import ProductUpdate from '../views/ProductUpdate.vue'
import buyCart from '../views/buyCart.vue'
import orderDetail from '../views/orderDetail.vue'
import zipCode from '../views/zipCode.vue'
import zipCode2 from '../views/zipCode2.vue'
import userOderDetail from '../views/userOderDetail.vue'
import indexList from '../views/indexList.vue'
import orderDetailTobuy from '../views/orderDetailTobuy.vue'
const routes = [
  {
    path: '/',
    name: 'home',
    component: indexList
  },
  {
    path: '/list',
    name: 'ProductList',
    component: ProductList
  },
  {
    path: '/detail',
    name: 'productDetail',
    component: ProductDetail
  },
  {
    path: '/create',
    name: 'ProductCreate',
    component: ProductCreate
  },
  {
    path: '/sales',
    name: 'SalesList',
    component: SalesList
  },
  {
    path: '/image_insert',
    name: 'ImageInsert',
    component: ImageInsert
  },
  {
    path: '/update',
    name: 'ProductUpdate',
    component: ProductUpdate
  },
  {
    path: '/cart',
    name: 'buyCart',
    component: buyCart
  },
  {
    path: '/orderDetail',
    name: 'orderDetail',
    component: orderDetail
  },
  {
    path: '/orderDetail/:id/:code',
    name: 'orderDetail2',
    component: orderDetail
  },
  {
    path: '/orderDetailTobuyNow/:productid',
    name: 'orderDetailTobuyNow',
    component: orderDetailTobuy
  },  
  {
    path: '/orderDetail/:id/:code/:productid',
    name: 'orderDetailFromZipcode',
    component: orderDetailTobuy
  },    
  {
    path: '/zipCode',
    name: 'zipCode',
    component: zipCode
  },
  {
    path: '/zipCode/:id',
    name: 'zipCodeFromOrderDatailTobuy',
    component: zipCode2
  },  
  {
    path: '/userOderDetail',
    name: 'userOderDetail',
    component: userOderDetail
  }
]

// 함수 추가 전 기본
// const router = createRouter({
//   history: createWebHistory(process.env.BASE_URL),
//   routes
// })

// 함수 추가 후
const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
  // (화면 이동 시, 상단으로 이동)
  scrollBehavior(){
    return { top: 0 }
  },
});

export default router
