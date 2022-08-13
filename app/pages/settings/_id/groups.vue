<template>
  <logged-in-container #my-content>
    <data-table
     :headers="headers"
     :toolbarTitle="toolbarTitle"
     :items="items"
     @create-click="createItem"
     @edit-click="editItem"
     @delete-click="deleteItem"
     @close-click="close"
     @closeDelete-click="closeDelete"
     @save-click="save"
     @deleteItemConfirm="deleteItemConfirm"
     :data-table-edit-dialog="editDialogShow"
     :data-table-delete-dialog="deleteDialogShow"
     :form-title="formTitle"
     :dialog-label="dialogLabel"
     :edited-item="editedItem"
     :errors="errors"
     :showKeys="showKeys"
     :groupShow="groupShow"
    />
  </logged-in-container>

</template>

<script>
export default {
  name: "groups",
  data () {
    return {
      headers: [
        { text: 'グループ名', align: 'start', value: 'name',},
        { text: '編集・削除', value: 'actions', sortable: false }
      ],
      dialogLabel: {
        name:'グループ名',
      },
      toolbarTitle: "グループ一覧",
      editDialogShow: false,
      deleteDialogShow: false,
      editedIndex: -1,
      editedItem: {
        name: ''
      },
      defaultItem: {
        name: ''
      },
      showKeys:['name'],
      groupShow: false,
    }
  },
  computed: {
    items: {
       get() {
         return this.$store.getters['tenantGroup/getTenantGroups']
       }
    },
    errors: {
      get() {
         return this.$store.getters['tenantGroup/getErrors']
       }
    },
    formTitle () {
      return this.editedIndex === -1 ? '新規作成' : '編集'
    },
  },
  created () {
    this.$store.dispatch('tenantGroup/tenantGroups_road'),
    this.clearError()
  },
  watch: {
    editDialogShow(val) {
      val || this.close()
    },
    deleteDialogShow (val) {
      val || this.closeDelete()
    }
  },
  methods: {
    createItem(){
      this.editDialogShow = true
    },
    editItem (item) {
      this.editedIndex = this.items.indexOf(item)
      this.editedItem = Object.assign({}, item)
      this.editDialogShow = true
    },
    deleteItem (item) {
      this.editedIndex = this.items.indexOf(item)
      this.editedItem = Object.assign({}, item)
      this.deleteDialogShow= true
    },
    close () {
      this.editDialogShow = false
      this.$nextTick(() => {
        this.editedItem = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      })
    },
    closeDelete () {
      this.deleteDialogShow = false
      this.$nextTick(() => {
        this.editedItem = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      })
    },
    save (item) {
      if (this.editedIndex > -1) {
        //更新
        this.$store.dispatch('tenantGroup/tenantGroupUpdate',item)
      } else {
        //新規作成
        item["tenant_group_id"] = this.editedItem["tenant_group_id"]
        this.$store.dispatch('tenantGroup/tenantGroupCreate',item)
      }
      this.close()
    },
    deleteItemConfirm () {
      this.$store.dispatch('tenantGroup/tenantGroupDelete',this.editedItem)
      this.closeDelete()
    },
    clearError() {
      this.$store.commit('tenantGroup/setErrors', {})
　　},
  }
}
</script>