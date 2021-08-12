<template>
  <div />
</template>
<script>
export default {
  async middleware ({ store, redirect, from }) {
    await store.dispatch('user/logout')
    if (from.name !== 'index') { return redirect('/') }
  },
  layout: 'logout',
  beforeCreate () {
    this.$router.replace('/')
  }
}
</script>