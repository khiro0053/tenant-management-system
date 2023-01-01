<template>
  <logged-in-container #my-content>
    <v-data-table
      :headers="headers"
      :items="items"
      :search="searchInput"
      class="elevation-1"
    >
      <template v-slot:top>
        <validation-error
          :errors="errors"
        />
        <item-combobox
          :drop-down-item="dropDownItem"
          :combobox-label="comboboxLabel"
          :search-input.sync="searchInput"
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
              v-model="editDialogShow"
              max-width="500px"
              @click:outside="close"
            >
              <v-card>
                <v-card-title>
                  <span class="text-h5">{{ formTitle }}</span>
                </v-card-title>
                <v-card-text>
                  <v-container>
                    <v-row>
                        <v-col
                          v-for="showKey in showKeys" :key="showKey"
                          cols="12"
                          sm="6"
                          md="4"
                        >
                          <v-text-field
                            v-model.lazy="editedItem[showKey]"
                            :label="dialogLabel[showKey]"
                          >
                          </v-text-field>
                        </v-col>
                        <item-array-select-form
                         :edited-item="editedItem"
                         :select-items="careLevelFormData"
                         :item-form-props="careLevelFormProps"
                         @select-item="selectItem"
                         @close="close"
                        />
                        <item-object-select-form
                         :edited-item="editedItem"
                         :select-items="tenantFormData"
                         :item-form-props="tenantFormProps"
                         @select-item="selectItem"
                         @close="close"
                        />
                    </v-row>
                  </v-container>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn
                    color="blue darken-1"
                    text
                    @click="close"
                  >
                    閉じる
                  </v-btn>
                  <v-btn
                    color="blue darken-1"
                    text
                    @click="save()"
                  >
                    保存
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
            <v-dialog
              v-model="deleteDialogShow"
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
  </logged-in-container>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  name: "residents",
  data () {
    return {
      headers: [
        {
          text: '名前',
          align: 'start',
          value: 'full_name',
        },
        { text: '施設名', value: 'tenant[name]' },
        { text: '契約開始日', value: 'date_of_contract' },
        { text: '実入居日', value: 'date_of_occupancy' },
        { text: '退去日', value: 'date_of_departure' },
        { text: '契約終了日', value: 'date_of_expiry' },
        { text: '介護度', value: 'care_level' },
        { text: '入院状況', value: 'is_hospitalized' },
        { text: '編集・削除', value: 'actions', sortable: false },
      ],
      dialogLabel: {
        last_name:'姓',
        first_name:'名',
        care_level:'介護度',
        is_hospitalized:'入院状況',
        date_of_contract: '契約開始日',
        date_of_occupancy: '実入居日',
        date_of_departure: '退去日',
        date_of_expiry: '契約終了日',
        tenant:'施設名'
      },
      toolbarTitle: "入居者一覧",
      editDialogShow: false,
      deleteDialogShow: false,
      editedIndex: -1,
      editedItem: {
        lase_name: '',
        first_name: '',
        care_level: '',
        is_hospitalized: false,
        date_of_contract: '',
        date_of_occupancy: '',
        date_of_departure: '',
        date_of_expiry: '',
        tenant: {
          id: 0,
          name: ''
        }
      },
      defaultItem: {
        lase_name: '',
        first_name: '',
        care_level: '',
        is_hospitalized: false,
        date_of_contract: '',
        date_of_occupancy: '',
        date_of_departure: '',
        date_of_expiry: '',
        tenant: {
          id: 0,
          name: ''
        }
      },
      showKeys:['last_name','first_name', 'is_hospitalized','date_of_contract', 'date_of_occupancy', 'date_of_departure', 'date_of_expiry' ],
      tenantFormProps: [
        { itemKey: 'tenant', label: '施設', itemText: 'name', itemValue: 'id'},
      ],
      careLevelFormProps: [
        { itemKey: 'care_level', label: '介護度'}
      ],
      searchInput: "",
      comboboxLabel: "絞り込み条件",
      groupShow: true
    }
  },
  computed: {
    items: {
       get() {
         return this.$store.getters['resident/getResidents']
       }
    },
    dropDownItem: {
      get() {
        return this.$store.getters['tenant/getTenantNames']
      }
    },
    errors: {
      get() {
         return this.$store.getters['resident/getErrors']
       }
    },
    ...mapGetters({
      tenantFormData: 'tenant/getTenants',
      careLevelFormData: 'resident/getCareLevelList'

    }),
    formTitle () {
      return this.editedIndex === -1 ? '新規作成' : '編集'
    },
  },
  created () {
    this.$store.dispatch('tenant/tenants_road'),
    this.$store.dispatch('resident/residents_road'),
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
    selectItem(selectItem, key) {
      console.log(selectItem)
      console.log(key)
      console.log(this.editedItem)
      this.editedItem[key] = selectItem
      //外部キーがある場合は以下の処理も行う
      if (selectItem.constructor　=== Object && 'id' in selectItem  ){
        this.editedItem[key + '_id'] = selectItem.id
      }
      console.log(this.editedItem)
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
    save () {
      if (this.editedIndex > -1) {
        //更新
        this.$store.dispatch('resident/residentUpdate',this.editedItem)
      } else {
        //新規作成
        this.editedItem["tenant_id"] = this.editedItem["tenant"]["id"]
        this.$store.dispatch('resident/residentCreate',this.editedItem)
      }
      this.close()
    },
    deleteItemConfirm () {
      this.$store.dispatch('resident/residentDelete',this.editedItem)
      this.closeDelete()
    },
    clearError() {
      this.$store.commit('resident/setErrors', {})
　　},
  }
}
</script>