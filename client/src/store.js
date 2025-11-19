/* 데이터 관리가 필요한 것들 여기에 담는다. 
npm install vuex@next --save; */

import {createStore} from 'vuex'
import persistedstate from 'vuex-persistedstate'; 

const store = createStore({
    state() {
        return {
            user: {}
        }
    },
    mutations: {
        user(state, data) {
            state.user = data;
        }
    },
    //카카오 자동 로그인이 지속(리프레쉬)
    plugins: [
        persistedstate({
            paths:['user']
        })
    ]
});

export default store;