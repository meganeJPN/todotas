<template>
<div>
<el-card class="box-card login">

  <div slot="header" class="clearfix center">
    <span>Login</span>
  </div>

  <el-form ref="form" :model="form" label-width="80px" label-position="top">
    </el-form-item>
      <el-form-item label="Email">
      <el-input v-model="form.email"></el-input>
    </el-form-item>
    </el-form-item>
      <el-form-item label="Password">
      <el-input type="password" v-model="form.password" show-password></el-input>
    </el-form-item>
    <el-form-item>
      <el-button style="float: right" type="primary" @click="signIn">Login</el-button>
    </el-form-item>
  </el-form>
  <div class="center">
    <router-link to="/users/signup">
      <el-button type="text">New User? Sign Up Here</el-button>
    </router-link>
  </div>
</el-card>
</div>
</template>
<style>
.box-card {
  width: 480px;
}

.login {
  position: relative;
  top: 100px;
  right: 0px;
  bottom: 0px;
  left: 0px;
  margin: auto;
}
.center {
  text-align: center;
}
</style>
<script>
import axios from 'axios';
import { reject } from 'lodash';

export default {
  data: function() {
    return {
       form: {
        email: '',
        password: ''
      }
    };
  },
  mounted: function() {
   
  },
  methods: {
  signIn: function(){
    console.log("サインインだよ")
      if(!this.form.email || !this.form.password) return;
      axios.post('/v1/auth/sign_in',{
        email: this.form.email,
        password: this.form.password,
      }).then((response)=>{
        localStorage.setItem('access-token', response.headers['access-token'])
        localStorage.setItem('client', response.headers.client)
        localStorage.setItem('uid', response.headers.uid)
        localStorage.setItem('token-type', response.headers['token-type'])
        this.$router.push('/') 
      },
      (error) => {
        for (let i =0; i<error.response.data.errors.length; i++){
          this.$message.error(error.response.data.errors[i]);
          }
      }
      );
    },
  },
};
</script>
