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
     @select-group="selectGroup"
     :data-table-edit-dialog="editDialogShow"
     :data-table-delete-dialog="deleteDialogShow"
     :form-title="formTitle"
     :dialog-label="dialogLabel"
     :edited-item="editedItem"
     :errors="errors"
     :omitKeys="omitKeys"
     :groups="groups"
     :groupShow="groupShow"
    />
  </logged-in-container>

</template>

<script>
export default {
  name: "tenants",
  data () {
    return {
      headers: [
        {
          text: '施設名',
          align: 'start',
          value: 'name',
        },
        { text: '定員数', value: 'capacity' },
        { text: '目標入居者数', value: 'target_number_of_residents' },
        { text: 'グループ', value: 'tenant_group[name]' },
        { text: '編集・削除', value: 'actions', sortable: false },
      ],
      dialogLabel: {
        name:'施設名',
        capacity:'定員数',
        target_number_of_residents:'目標入居者',
        tenant_group:'グループ'

      },
      toolbarTitle: "施設一覧",
      editDialogShow: false,
      deleteDialogShow: false,
      editedIndex: -1,
      editedItem: {
        name: '',
        capacity: 0,
        target_number_of_residents: 0,
        tenant_group_id: 0,
        tenant_group: {
          id: 0,
          name: ''
        }
      },
      defaultItem: {
        name: '',
        capacity: 0,
        target_number_of_residents: 0,
        tenant_group_id: 0,
        tenant_group: {
          id: 0,
          name: ''
        }
      },
      omitKeys:['id','tenant_group', 'tenant_group_id'],
      groupShow: true
    }
  },
  computed: {
    items: {
       get() {
         return this.$store.getters['tenant/getTenants']
       }
    },
    groups: {
       get() {
         return this.$store.getters['tenantGroup/getTenantGroups']
       }
    },
    errors: {
      get() {
         return this.$store.getters['tenant/getErrors']
       }
    },
    formTitle () {
      return this.editedIndex === -1 ? '新規作成' : '編集'
    },
  },
  created () {
    this.$store.dispatch('tenant/tenants_road'),
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
    selectGroup(group) {
      this.editedItem["tenant_group"] = group
      this.editedItem["tenant_group_id"] = group.id
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
        for (let key of this.omitKeys){
          item[key] = this.editedItem[key]
        }
        this.$store.dispatch('tenant/tenantUpdate',item)
      } else {
        //新規作成
        item["tenant_group_id"] = this.editedItem["tenant_group"]["id"]
        this.$store.dispatch('tenant/tenantCreate',item)
      }
      this.close()
    },
    deleteItemConfirm () {
      this.$store.dispatch('tenant/tenantDelete',this.editedItem)
      this.closeDelete()
    },
    clearError() {
      this.$store.commit('tenant/setErrors', {})
　　},
  }
}
</script>