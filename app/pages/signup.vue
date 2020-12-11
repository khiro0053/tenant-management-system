<template>
  <bef-login-card #form-card-content>
    <v-form
      v-model="isValid"
    >
      <user-form-name />
      <user-form-email />
      <user-form-password />
      <v-btn
        :disabled="!isValid"
        block
        color="myblue"
        class="white--text"
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
      params: { user: { name: '', email: '', password: '' } }
    }
  }
}
</script>