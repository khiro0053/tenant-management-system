<template>
 <div>
  <v-col
      <v-select
      v-for="itemFormProp in itemFormProps" :key="itemFormProp.key"
      v-model="editedItem[itemFormProp.itemKey]"
      :items="selectItems"
      :item-text="itemFormProp.itemText"
      :item-value="itemFormProp.itemValue"
      @change="selectItem($event, itemFormProp.itemKey)"
      :label="itemFormProp.label"
      return-object
      outlined
    ></v-select>
  </v-col>
</div>
</template>
<script>
export default {
  name: "objectSelectForm",
  props: {
    editedItem:{
      type: Object,
      required: true,
    },
    selectItems: Array,
    itemFormProps: Array,
  },
  methods: {
    selectItem(event, key) {
      console.log('id' in event )
      this.$emit("select-item", event, key)
    }
  }
}
</script>