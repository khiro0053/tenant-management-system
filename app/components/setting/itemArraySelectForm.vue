<template>
 <div>
  <v-col
      <v-select
      v-for="itemFormProp in itemFormProps"
      v-model="editedItem[itemFormProp.itemKey]"
      :items="selectItems"
      @change="selectItem($event, itemFormProp.itemKey)"
      :label="itemFormProp.label"
      outlined
    ></v-select>
  </v-col>
</div>
</template>
<script>
name: "arraySelectForm"
export default {
  props: {
    editedItem:{
      type: Object,
      required: true,
    },
    selectItems: Array,
    itemFormProps: Array,
  },
  methods: {
    selectItem(event, itemKey) {
      this.$emit("select-item", event, itemKey)
    }
  }
}
</script>