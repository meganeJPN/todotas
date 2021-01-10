<template>
  <div>
    <el-card class="box-card login">
      <div slot="header" class="clearfix">
        <span>SIGN UP</span>
      </div>
      <el-form
        ref="form"
        :model="form"
        :rules="rules"
        label-width="180px"
        label-position="top"
      >
        <el-form-item label="name">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="Email">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="Password" prop="pass">
          <el-input
            type="password"
            v-model="form.password"
            show-password
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="Confirm Password" prop="confirm_password">
          <el-input
            type="password"
            v-model="form.confirm_password"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item>
          <el-button style="float: right" type="primary" @click="onSubmit"
            >Sign up</el-button
          >
        </el-form-item>
      </el-form>
      <div class="center">
        <router-link to="/users/login">
          <el-button type="text">Have account? Log In</el-button>
        </router-link>
      </div>
    </el-card>
  </div>
</template>
<style scoped>
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
    var validatePass = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('Please input the password'));
      } else {
        if (this.form.confirm_password !== '') {
          this.$refs.form.validateField('confirm_password');
        }
        callback();
      }
    };
    var validatePass2 = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('Please input the password again'));
      } else if (value !== this.form.password) {
        callback(new Error("Two inputs don't match!"));
      } else {
        callback();
      }
    };
    return {
      form: {
        name: '',
        password: '',
        confirm_password: '',
      },
      rules: {
        pass: [{ validator: validatePass, trigger: 'blur' }],
        confirm_password: [{ validator: validatePass2, trigger: 'blur' }],
      },
    };
  },
  mounted: function() {},
  methods: {
    signUp: function(){
      if(!this.form.name || !this.form.password || !this.form.confirm_password) return;
      
    },
  },
};
</script>
