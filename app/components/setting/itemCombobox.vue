<template>
  <v-combobox
    :items="dropDownItem"
    :label="comboboxLabel"
    dense
    solo
    outlined
    :search-input.sync="_searchInput"
  ></v-combobox>
</template>

<script>
export default {
  name: "itemCombobox",
  props: {
    dropDownItem: Array,
    searchInput: String,
    comboboxLabel: String,
  },
  computed:{
    _searchInput: {
      get() {
        return this.searchInput
      },
      set(newVal) {
        return this.$emit('update:searchInput', newVal)
      }
    }
  }
}
</script>