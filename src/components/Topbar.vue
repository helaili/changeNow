<template>
  <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect">
    <el-submenu index="users">
      <template slot="title">Login</template>
      <el-menu-item key="user" v-bind:index="user" v-for="(user, index) in users">{{user}}</el-menu-item>
    </el-submenu>
    <el-menu-item index="processingCenter" v-if="isProcessingCenterEnabled">Processing Center</el-menu-item>
    <el-menu-item index="calculator">Calculator</el-menu-item>
    <el-menu-item index="userList">Users</el-menu-item>
    <el-menu-item index="2"><a href="https://www.ele.me" target="_blank">Orders</a></el-menu-item>
    <el-menu-item index="flipper"><a href="http://localhost:3000/flipper/features" target="_blank">Flipper</a></el-menu-item>
    <el-menu-item index="swagger"><a href="http://127.0.0.1:54704/#!/" target="_blank">Swagger</a></el-menu-item>
  </el-menu>
</template>

<script>
  export default {
    data () {
      return {
        activeIndex: 'users',
        isProcessingCenterEnabled: false,
        users: ['helaili', 'alain', 'darth', 'obiwan', 'octocat']
      }
    },
    methods: {
      handleSelect (key, keyPath) {
        if (keyPath[0] === 'users') {
          var currentUser = key
          this.isFeatureEnabled('processingCenter', currentUser, 'isProcessingCenterEnabled')
        } else if (keyPath[0] === 'calculator') {
          this.$router.push({name: 'CalculatorView'})
        } else if (keyPath[0] === 'userList') {
          this.$router.push({name: 'UsersView'})
        }
      }, // tag::isFeatureEnabled[]
      isFeatureEnabled: function (feature, actor, flag) {
        this.$http.post('/flipper/enabled', {
          actor: actor,
          feature: feature
        }).then((res) => {
          console.log(res.data)
          var jsonRes = res.data
          this[flag] = jsonRes.enabled
        }, (error) => {
          console.log(error)
        })
      } // end::isFeatureEnabled[]
    },
    computed: {

    }
  }
</script>
