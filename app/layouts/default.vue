<template>
  <v-app>
    <logged-in-header />
    <v-main>
      <nuxt />
    </v-main>
  </v-app>
</template>

<script>
export default {
  name: "default",
  middleware: 'authenticator'
}
</script>