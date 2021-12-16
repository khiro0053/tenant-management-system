<template>
  <v-card>
    <v-card-title class="text-h5">
    "{{editedItem.name}}" を本当に削除してもよろしいですか?
    </v-card-title>
    <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn color="blue darken-1" text @click="closeDelete()">キャンセル</v-btn>
      <v-btn color="blue darken-1" text @click="deleteItemConfirm()">OK</v-btn>
      <v-spacer></v-spacer>
    </v-card-actions>
  </v-card>
</template>

<script>
export default {
  props: {
    editedItem:{
      type: Object,
      required: true,
    },
  },
  methods: {
    closeDelete(){
      this.$emit("closeDelete-click")
    },
    deleteItemConfirm(){
      this.$emit("deleteItemConfirm-click")
    }
  }
}
</script>