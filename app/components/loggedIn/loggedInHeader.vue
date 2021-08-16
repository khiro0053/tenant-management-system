<template>
  <div>
    <logged-in-nav-drawer
      :drawer.sync="drawer"
    />
    <logged-in-app-bar #nav-icon>
      <v-app-bar-nav-icon
        @click="drawer = !drawer"
      />
    </logged-in-app-bar>
  </div>
</template>

<script>
export default {
  data () {
    return {
      drawer: null
    }
  }
}
</script>