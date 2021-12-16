<template>
  <logged-in-container #my-content>
    <v-row justify="center">
      <v-col
        cols="12"
        :sm="container.sm"
        :md="container.md"
      >
        <v-card-title>
          施設一覧
        </v-card-title>
        <v-data-table
          :headers="tenantHeaders"
          :items="TenantItems"
          :items-per-page="5"
          class="elevation-1"
        >
          <template v-slot:item.name="props">
            <v-edit-dialog
              :return-value="props.item.name"
              @save="save"
              @cancel="cancel"
              @open="open"
              @close="close"
            >
              {{ props.item.name }}
              <template v-slot:input>
                <v-text-field
                  slot="input"
                  :value="props.item.name"
                  :rules="[max25chars]"
                  label="Edit"
                  single-line
                  counter
                  @change="updateTenant({tenant:{ id: props.item.id, name: $event }})"
                ></v-text-field>
              </template>
            </v-edit-dialog>
          </template>
          <template v-slot:item.capacity="{ item }">
            <v-chip
              :color="getColor(item.capacity)"
              dark
            >
              {{ item.capacity }}
            </v-chip>
          </template>
          <template v-slot:item.edit="{item}">
            <v-btn
              small
              color="error"
              @click="deleteItem(item)"
            >
              編集
            </v-btn>
          </template>
        </v-data-table>
      </v-col>
    </v-row>
  </logged-in-container>
</template>

<script>
export default {
  name: "tenants",
  async middleware ({store}) {
    return await store.dispatch('tenant/tenants_road')
    console.log("aaaa")
  },
  validate({store}) {
    return !!store.state.tenant.tenants
  },
  data () {
    return{
      container: {
        sm: 10,
        md: 8
      },
      max25chars: v => v.length <= 25 || '文字数が多すぎます',
      tenantHeaders: [
        {
          text: '施設名',
          width: 150,
          value: 'name'
        },
        {
          text: '定員数',
          width: 150,
          value: 'capacity'
        },
        {
          text: '目標入居者数',
          width: 150,
          value: 'target_number_of_residents'
        },
        {
          text: '編集',
          width: 100,
          value: 'edit',
          sortable:false
        }
      ]
    }
  },
  created (){
    this.$store.dispatch('tenant/tenants_road')
  },
  computed: {
    TenantItems: {
       get() {
         return this.$store.getters['tenant/getTenants']
       }
    }
  },
  methods: {
    getColor (capacity) {
      if (capacity > 149) return 'red'
      else if (capacity > 99) return 'orange'
      else return 'green'
    },
    deleteItem (item) {
    const index = this.tenantItems.indexOf(item)
    confirm('ガチで削除しますか') && this.tenantItems.splice(index, 1)
    },
    save (val) {
      console.log("保存")
      this.snack = true
      this.snackColor = 'success'
      this.snackText = 'Data saved'
    },
    cancel () {
      this.snack = true
      this.snackColor = 'error'
      this.snackText = 'Canceled'
    },
    open () {
      this.snack = true
      this.snackColor = 'info'
      this.snackText = 'Dialog opened'
    },
    close () {
      console.log('Dialog closed')
    },
    updateTenant(val)　{
      this.$store.dispatch('tenant/tenantUpdate', val)
    }
  }
}
</script>