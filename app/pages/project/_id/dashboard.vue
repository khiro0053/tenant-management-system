<template>
  <logged-in-container #my-content>
    <template>
      <v-data-table
        :headers="headers"
        :items="TenantItems"
        sort-by="calories"
        class="elevation-1"
      >
        <template v-slot:top>
          <v-toolbar
            flat
          >
            <v-toolbar-title>施設一覧</v-toolbar-title>
            <v-divider
              class="mx-4"
              inset
              vertical
            ></v-divider>
            <v-spacer></v-spacer>
            <v-dialog
              v-model="dialog"
              max-width="500px"
            >
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  color="primary"
                  dark
                  class="mb-2"
                  v-bind="attrs"
                  v-on="on"
                >
                  新規作成
                </v-btn>
              </template>
              <v-card>
                <v-card-title>
                  <span class="text-h5">{{ formTitle }}</span>
                </v-card-title>

                <v-card-text>
                  <v-container>
                    <v-row>
                      <v-col
                        cols="12"
                        sm="6"
                        md="4"
                      >
                        <v-text-field
                          v-model.trim ="editedItem.name"
                          label="施設名"
                        ></v-text-field>
                      </v-col>
                      <v-col
                        cols="12"
                        sm="6"
                        md="4"
                      >
                        <v-text-field
                          type="number"
                          v-model.number="editedItem.capacity"
                          label="定員数"
                        ></v-text-field>
                      </v-col>
                      <v-col
                        cols="12"
                        sm="6"
                        md="4"
                      >
                        <v-text-field
                          type="number"
                          v-model.number="editedItem.target_number_of_residents"
                          label="目標入居者数"
                        ></v-text-field>
                      </v-col>
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
                    @click="save"
                  >
                    保存
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
            <v-dialog v-model="dialogDelete" max-width="500px">
              <v-card>
                <v-card-title class="text-h5">
                "{{editedItem.name}}" 本当に削除してもよろしいですか?
                </v-card-title>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn color="blue darken-1" text @click="closeDelete">キャンセル</v-btn>
                  <v-btn color="blue darken-1" text @click="deleteItemConfirm">OK</v-btn>
                  <v-spacer></v-spacer>
                </v-card-actions>
              </v-card>
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
        <template v-slot:no-data>
          <v-btn
            color="primary"
            @click="initialize"
          >
            リセット
          </v-btn>
        </template>
      </v-data-table>
    </template>
  </logged-in-container>
</template>

<script>
export default {
  name: "dashboard",
  async middleware ({store}) {
    return await store.dispatch('tenant/tenants_road')
  },
  validate({store}) {
    return !!store.state.tenant.tenants
  },
  data: () => ({
    dialog: false,
    dialogDelete: false,
    headers: [
      {
        text: '施設名',
        align: 'start',
        sortable: false,
        value: 'name',
      },
      { text: '定員数', value: 'capacity' },
      { text: '目標入居者数', value: 'target_number_of_residents' },
      { text: '編集・削除', value: 'actions', sortable: false },
    ],
    desserts: [],
    editedIndex: -1,
    editedItem: {
      name: '',
      capacity: 0,
      target_number_of_residents: 0,
      area_id: 1
    },
    defaultItem: {
      name: '',
      capacity: 0,
      target_number_of_residents: 0,
      area_id: 1
    },
  }),
  computed: {
    TenantItems: {
       get() {
         return this.$store.getters['tenant/getTenants']
       }
    },
    formTitle () {
      return this.editedIndex === -1 ? '新規作成' : '編集'
    },
  },
  watch: {
    dialog (val) {
      val || this.close()
    },
    dialogDelete (val) {
      val || this.closeDelete()
    },
  },
  created () {
    this.$store.dispatch('tenant/tenants_road')
  },
  methods: {
    editItem (item) {
      this.editedIndex = this.TenantItems.indexOf(item)
      this.editedItem = Object.assign({}, item)
      this.dialog = true
    },
    deleteItem (item) {
      this.editedIndex = this.TenantItems.indexOf(item)
      this.editedItem = Object.assign({}, item)
      this.dialogDelete = true
    },
    deleteItemConfirm () {
      this.$store.dispatch('tenant/tenantDelete',this.editedItem)

      this.closeDelete()
    },
    close () {
      this.dialog = false
      this.$nextTick(() => {
        this.editedItem = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      })
    },
    closeDelete () {
      this.dialogDelete = false
      this.$nextTick(() => {
        this.editedItem = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      })
    },
    save () {
      if (this.editedIndex > -1) {
        //更新
        this.$store.dispatch('tenant/tenantUpdate',this.editedItem)
      } else {
        //新規作成
        this.$store.dispatch('tenant/tenantCreate',this.editedItem)
      }
      this.close()
    },
  }
}
</script>