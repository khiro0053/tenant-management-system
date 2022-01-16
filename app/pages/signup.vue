<template>
  <bef-login-card #form-card-content>
    <v-form
      ref="form"
      v-model="isValid"
    >
      <user-form-name
        :name.sync="params.user.name"
      />
      <user-form-email
        :email.sync="params.user.email"
      />
      <user-form-password
        :password.sync="params.user.password"
      />
      <v-btn
        :disabled="!isValid || loading"
        :loading="loading"
        block
        color="myblue"
        class="white--text"
        @click="signup"
      >
        登録する
      </v-btn>
    </v-form>
  </bef-login-card>
</template>

<script>
export default {
  layout: 'beforeLogin',
  data () {
    return {
      isValid: false,
      loading: false,
      params: { user: { name: '', email: '', password: '', company_id: '1' } }
    }
  },
  methods: {
    async signup () {
      this.loading = true
      await this.$store.dispatch('user/signup',this.params.user)
      this.loading = false
      window.location.href = '/'
    }
  }
}
</script>