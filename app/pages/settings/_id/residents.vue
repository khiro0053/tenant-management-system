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
        <v-combobox
          :items="dropDownItem"
          label="絞り込み条件"
          dense
          solo
          outlined
          :search-input.sync="_searchInput"
        ></v-combobox>
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
                        <item-select-form
                         :edited-item="editedItem"
                         :select-items="careLevelList"
                         :group-show="groupShow"
                         :select-item-label="selectItemLabel"
                         @select-item="selectItem"
                         @close="close"
                        />
                        <template v-if="groupShow">
                          <v-col
                              <v-select
                              v-for="(value, key, index) in relatedItemLabel" :key="`first-${index}`"
                              v-model="editedItem[key]"
                              :items="relatedItems"
                              item-text="name"
                              item-value="id"
                              @change="selectItem($event, key)"
                              :label="value"
                              return-object
                              outlined
                            ></v-select>
                          </v-col>
                        </template>
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
        { text: '介護度', value: 'care_level' },
        { text: '入院状況', value: 'is_hospitalized' },
        { text: '施設名', value: 'tenant[name]' },
        { text: '編集・削除', value: 'actions', sortable: false },
      ],
      dialogLabel: {
        last_name:'姓',
        first_name:'名',
        care_level:'介護度',
        is_hospitalized:'入院状況',
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
        tenant: {
          id: 0,
          name: ''
        }
      },
      showKeys:['last_name','first_name', 'is_hospitalized' ],
      relatedItemLabel:{tenant:'施設'},
      selectItemLabel:{care_level:'介護度'},
      selectItemProps: [
        { ItemKey: 'tenant', label: '施設', itemText: 'name', itemValue: 'id'},
        { ItemKey: 'care_level', label: '介護度', itemText: 'text', itemValue: 'text'}
      ],
      searchInput: "",
      groupShow: true
    }
  },
  computed: {
    items: {
       get() {
         return this.$store.getters['resident/getResidents']
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
    careLevelList: {
      get() {
        return this.$store.getters['resident/getCareLevelList']
      }
    },
    errors: {
      get() {
         return this.$store.getters['resident/getErrors']
       }
    },
    ...mapGetters({
      tenantFormData: 'tenant/getTenants'
    }),
    formTitle () {
      return this.editedIndex === -1 ? '新規作成' : '編集'
    },
  },
  mounted() {
    console.log(this.tenantFormData)
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
      this.editedItem[key] = selectItem
      //外部キーがある場合は以下の処理も行う
      if (selectItem.constructor　=== Object && 'id' in selectItem  ){
        this.editedItem[key + '_id'] = selectItem.id
      }
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
        this.$store.dispatch('resident/residentUpdate',item)
      } else {
        //新規作成
        item["tenant_id"] = this.editedItem["tenant"]["id"]
        this.$store.dispatch('resident/residentCreate',item)
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