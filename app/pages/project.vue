<template>
  <nuxt-child />
</template>

<script>
export default {
  name: "project",
  async middleware ({ params, store }) {
    return await store.dispatch('getCurrentProject', params)
  },
  validate ({ store }) {
    return !!store.state.current.project
  }
}
</script>