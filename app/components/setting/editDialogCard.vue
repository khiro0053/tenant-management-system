<template>
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
            <template v-if="groupShow">
              <v-col
                  <v-select
                  v-for="(value, key, index) in relatedItemLabel" :key="`first-${index}`"
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
    showKeys: Array,
    relatedItems: Array,
    relatedItemLabel: Object,
    groupShow:{
      type: Boolean,
      required: true,
    }
  },
  methods: {
    close(){
      this.$emit("close-click")
    },
    save(){
      this.$emit("save-click", this.editedItem)
    },
    selectRelatedItem(event) {
      this.$emit("select-related-item", event)
    }
  }
}
</script>