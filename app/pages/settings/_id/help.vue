<template>
  <logged-in-container #my-content>
    {{ $store.state.current.project }}
  </logged-in-container>
</template>

<script>
export default {
  name: "help"
}
</script>