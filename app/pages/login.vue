<template>
  <bef-login-card #form-card-content>
    <v-form
      ref="form"
      v-model="isValid"
    >
      <user-form-email
        :email.sync="params.auth.email"
        no-validation
      />
      <user-form-password
        :password.sync="params.auth.password"
        no-validation
      />
      <v-card-actions>
      <!-- パスワードリセットページは仮で＃を入力。将来的には修正する。 -->
        <nuxt-link
          to="#"
          class="body-2 text-decoration-none"
        >
          パスワードをお忘れですか?
        </nuxt-link>
      </v-card-actions>
      <v-card-text class="px-0">
        <v-btn
          :disabled="!isValid || loading"
          :loading="loading"
          block
          color="myblue"
          class="white--text"
          @click="login"
        >
          ログインする
        </v-btn>
      </v-card-text>
    </v-form>
  </bef-login-card>
</template>

<script>
export default {
  layout: 'beforeLogin',
  auth: false,
  data () {
    return {
      isValid: false,
      loading: false,
      params: { auth: {email: '', password: '' }}
    }
  },
  mounted() {
    let ridirectPath = this.$cookies.get('ridirectPath') || []
    if (ridirectPath.length){

      this.$store.commit('route/setRememberRoute', ridirectPath)
    }
  },
  methods: {
    async login (from, route){
      this.loading = true
      await this.$store.dispatch('user/login', this.params.auth)
      this.loading = false
    　this.$router.push(this.$store.state.route.rememberRoute)
    }
  }
}
</script>