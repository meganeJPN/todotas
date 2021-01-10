<template>
  <!-- header - end -->

  <el-header style="text-align: right; font-size: 12px">
    <el-dropdown>
      <i class="el-icon-menu" style="margin-right: 15px"></i>
      <el-dropdown-menu slot="dropdown">
        <el-dropdown-item
          ><router-link to="/">todotas</router-link></el-dropdown-item
        >

        <el-dropdown-item
          ><router-link to="/user">ユーザー情報</router-link></el-dropdown-item
        >
        <!-- <el-dropdown-item
          ><router-link to="/users/signup"
            >サインアップ</router-link
          ></el-dropdown-item
        >
        <el-dropdown-item
          ><router-link to="/users/login"
            >ログイン</router-link
          ></el-dropdown-item
        > -->
        <el-dropdown-item
          ><el-button type="text" @click="signOut">ログアウト</el-button></el-dropdown-item
        >
      </el-dropdown-menu>
    </el-dropdown>
  </el-header>
</template>

<script>
import axios from 'axios';
import { reject } from 'lodash';

export default {
  data: function() {
    return {
     
    };
  },
  mounted: function() {},
  methods: {
    signOut: function(){
      axios.delete('/v1/auth/sign_out',{
        headers: {
            'access-token': localStorage.getItem('access-token'),
            uid: localStorage.getItem('uid'),
            client: localStorage.getItem('client'),
          },
      }).then((response)=>{
        this.$router.push('/users/login') 
      },
      (error) => {
        this.$router.push('/users/login') 
      }
      );
    },
  },
};
</script>

<style>
.el-header {
  background-color: #b3c0d1;
  color: #333;
  line-height: 60px;
  position: fixed;
  width: 100%;
  top: 0;
  z-index: 50;
}
.hamburger_btn {
  position: fixed; /*常に最上部に表示したいので固定*/
  right: 0;
  width: 70px;
  height: 72px;
  cursor: pointer;
  z-index: 50;
}

.hamburger_btn .line {
  position: absolute;
  top: 0;
  left: 20px;
  width: 32px;
  height: 2px;
  background: #333333;
  text-align: center;
}

.hamburger_btn .line_01 {
  top: 16px;
  transition: 0.4s ease;
}
.hamburger_btn .line_02 {
  top: 26px;
  transition: 0.4s ease;
}
.hamburger_btn .line_03 {
  top: 36px;
  transition: 0.4s ease;
}

.btn_line01 {
  transform: translateY(10px) rotate(-45deg);
  transition: 0.4s ease;
}
.btn_line02 {
  transition: 0.4s ease;
  opacity: 0;
}
.btn_line03 {
  transform: translateY(-10px) rotate(45deg);
  transition: 0.4s ease;
}

/*サイドバー*/
.menu-enter-active,
.menu-leave-active {
  transition: opacity 0.4s;
}
.menu-enter,
.menu-leave-to {
  opacity: 0;
}
.menu-leave,
.menu-enter-to {
  opacity: 1;
}

.menu li {
  list-style: none;
  line-height: 1;
  padding: 1rem;
}
.menu {
  background-color: rgba(197, 197, 197, 0.671);
  z-index: 30;
  padding: 2rem 1rem;
  position: fixed;
  width: 20rem;
  height: 80rem;
  top: 0;
  right: 0;
}
.menu a {
  color: rgb(66, 66, 66);
  text-decoration: none;
  font-size: 1.2rem;
  padding: 0 2rem;
}
.menu ul {
  margin: 1rem;
  padding: 0;
}
</style>
