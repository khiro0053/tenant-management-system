<template>
  <v-data-table
    :headers="headers"
    :items="items"
    class="elevation-1"
  >
    <template v-slot:top>
      <validation-error
        :errors="errors"
       />
      <v-toolbar
        flat
      >
        <v-toolbar-title>{{toolbarTitle}}</v-toolbar-title>
        <v-divider
          class="mx-4"
          inset
          vertical
        ></v-divider>

        <v-spacer></v-spacer>
        <v-btn
          color="primary"
          dark
          class="mb-2"
          @click="createItem"
        >
           新規作成
        </v-btn>
          <v-dialog
            v-model="dataTableEditDialog"
            max-width="500px"
            @click:outside="close"
          >
            <edit-dialog-card
             :dialog-label="dialogLabel"
             :form-title="formTitle"
             :edited-item="editedItem"
             :omitKeys="omitKeys"
             :groups="groups"
             :groupShow="groupShow"
             @close-click="close"
             @save-click="save"
             @select-group="selectGroup"
            />
          </v-dialog>
          <v-dialog
            v-model="dataTableDeleteDialog"
            max-width="500px"
            @click:outside="close"
          >
            <delete-dialog-card
            :edited-item="editedItem"
            @closeDelete-click="closeDelete"
            @deleteItemConfirm-click="deleteItemConfirm"
            />
          </v-dialog>
      </v-toolbar>
    </template>
    <template v-slot:item.actions="{ item }">
      <v-icon
        small
        class="mr-2"
        @click="editItem(item)"
      >
        mdi-pencil
      </v-icon>
      <v-icon
        small
        @click="deleteItem(item)"
      >
        mdi-delete
      </v-icon>
    </template>
  </v-data-table>
</template>

<script>
export default {
  name: "componentsDataTable",
  async middleware ({store}) {
    return await store.dispatch('tenant/tenants_road')
  },
  validate({store}) {
    return !!store.state.tenant.tenants
  },
  props: {
    headers: {
      type: Array,
      required: true,
    },
    toolbarTitle:{
      type: String,
      required: true,
    },
    items:{
      type: Array,
      required: true,
    },
    dataTableEditDialog:{
      type: Boolean,
      required: true,
    },
    dataTableDeleteDialog:{
      type: Boolean,
      required: true,
    },
    formTitle:{
      type: String,
      required: true,
    },
    dialogLabel:{
      type: Object,
      required: true,
    },
    editedItem:{
      type: Object,
      required: true,
    },
    errors: Object,
    omitKeys: Array,
    groups: Array,
    groupShow:{
      type: Boolean,
      required: true,
    }
  },
  methods: {
    createItem () {
      this.$emit("create-click")
    },
    editItem (item) {
      this.$emit("edit-click", item)
    },
    deleteItem (item) {
      this.$emit("delete-click", item)
    },
    deleteItemConfirm () {
      this.$emit("deleteItemConfirm")
    },
    close () {
      this.$emit("close-click")
    },
    closeDelete () {
      this.$emit("closeDelete-click")
    },
    save (item) {
      this.$emit("save-click", item)
    },
    selectGroup(event) {
      this.$emit("select-group", event)
    }
  }
}
</script>