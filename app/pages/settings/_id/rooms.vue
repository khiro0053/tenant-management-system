<template>
  <logged-in-container #my-content>
    <data-table
     :headers="headers"
     :toolbarTitle="toolbarTitle"
     :items="items"
     :searchInput.sync="searchInput"
     @create-click="createItem"
     @edit-click="editItem"
     @delete-click="deleteItem"
     @close-click="close"
     @closeDelete-click="closeDelete"
     @save-click="save"
     @deleteItemConfirm="deleteItemConfirm"
     @select-related-item="selectRelatedItem"
     :data-table-edit-dialog="editDialogShow"
     :data-table-delete-dialog="deleteDialogShow"
     :form-title="formTitle"
     :dialog-label="dialogLabel"
     :edited-item="editedItem"
     :errors="errors"
     :showKeys="showKeys"
     :relatedItems="relatedItems"
     :relatedItemLabel="relatedItemLabel"
     :dropDownItem="dropDownItem"
     :groupShow="groupShow"
    />
  </logged-in-container>

</template>

<script>
export default {
  name: "rooms",
  data () {
    return {
      headers: [
        {
          text: '居室名',
          align: 'start',
          value: 'name',
        },
        { text: '定員数', value: 'seating_capacity' },
        { text: '施設名', value: 'tenant[name]' },
        { text: '編集・削除', value: 'actions', sortable: false },
      ],
      dialogLabel: {
        name:'居室名',
        seating_capacity:'定員',
        tenant:'施設名'
      },
      toolbarTitle: "居室一覧",
      editDialogShow: false,
      deleteDialogShow: false,
      editedIndex: -1,
      editedItem: {
        name: '',
        seating_capacity: 0,
        tenant_id: 0,
        tenant: {
          id: 0,
          name: ''
        }
      },
      defaultItem: {
        name: '',
        seating_capacity: 0,
        tenant_id: 0,
        tenant: {
          id: 0,
          name: ''
        }
      },
      showKeys:['name', 'seating_capacity'],
      relatedItemLabel:{tenant:'施設'},
      searchInput: "",
      groupShow: true
    }
  },
  computed: {
    items: {
       get() {
         return this.$store.getters['room/getRooms']
       }
    },
    relatedItems: {
       get() {
         return this.$store.getters['tenant/getTenants']

       }
    },
    dropDownItem: {
      get() {
        return this.$store.getters['tenant/getTenantNames']
      }
    },
    errors: {
      get() {
         return this.$store.getters['room/getErrors']
       }
    },
    formTitle () {
      return this.editedIndex === -1 ? '新規作成' : '編集'
    },
  },
  created () {
    this.$store.dispatch('tenant/tenants_road'),
    this.$store.dispatch('room/rooms_road'),
    this.clearError()
  },
  watch: {
    editDialogShow(val) {
      val || this.close()
    },
    deleteDialogShow (val) {
      val || this.closeDelete()
    },
    searchInput: function(){
      console.log(`変更がありました。${ this.searchInput }`)
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
    selectRelatedItem(relatedItem) {
      this.editedItem["tenant"] = relatedItem
      this.editedItem["tenant_id"] = relatedItem.id
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
        this.$store.dispatch('room/roomUpdate',item)
      } else {
        //新規作成
        item["tenant_id"] = this.editedItem["tenant"]["id"]
        this.$store.dispatch('room/roomCreate',item)
      }
      this.close()
    },
    deleteItemConfirm () {
      this.$store.dispatch('room/roomDelete',this.editedItem)
      this.closeDelete()
    },
    clearError() {
      this.$store.commit('room/setErrors', {})
　　},
  }
}
</script>