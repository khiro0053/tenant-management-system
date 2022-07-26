<template>
  <v-card>
    <v-card-title>
      <span class="text-h5">{{ formTitle }}</span>
    </v-card-title>
    <v-card-text>
      <v-container>
        <v-row>
            <v-col
              v-for="(value, key, index) in showItem" :key="`first-${index}`"
              cols="12"
              sm="6"
              md="4"
            >
              <v-text-field
                v-model.trim="showItem[key]"
                :label="dialogLabel[key]"
              >
              </v-text-field>
            </v-col>
            <template v-if="groupShow">
              <v-col
                  <v-select
                  v-for="(value, key, index) in relatedItemLabel" :key="`second-${index}`"
                  v-model="editedItem[key]"
                  :items="relatedItems"
                  item-text="name"
                  item-value="id"
                  @change="selectRelatedItem($event)"
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
</template>

<script>
export default {
  props: {
    dialogLabel: {
      type: Object,
      required: true
    },
    formTitle:{
      type: String,
      required: true,
    },
    editedItem:{
      type: Object,
      required: true,
    },
    omitKeys: Array,
    relatedItems: Array,
    relatedItemLabel: Object,
    groupShow:{
      type: Boolean,
      required: true,
    }
  },
  computed: {
    showItem() {
     let showItem = Object.assign({}, this.editedItem)
     for (let omitKey of this.omitKeys){
       delete showItem[omitKey]
     }
     return showItem
    }
  },
  methods: {
    close(){
      this.$emit("close-click")
    },
    save(){
      this.$emit("save-click", this.showItem)
    },
    selectRelatedItem(event) {
      this.$emit("select-related-item", event)
    }
  }
}
</script>