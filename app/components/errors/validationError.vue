<template>
  <div v-if="validationErrors.length > 0" >
    <v-alert
      type="error"
      dense
      outlined
      text
    >
      <li v-for="(value, index) in validationErrors" :key="index">{{value}}</li>
    </v-alert>
  </div>
</template>

<script>
export default {
  props: {
    errors: Object
  },
  computed: {
    validationErrors() {
      let errors = Object.values(this.errors)
      errors = errors.flat()
      return errors
    }
  }
}
</script>