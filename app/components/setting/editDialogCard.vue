<template>
  <v-card>
    <v-card-title>
      <span class="text-h5">{{ formTitle }}</span>
    </v-card-title>
    <v-card-text>
      <v-container>
        <v-row>
         <div v-for="(value, key, index) in editedItem" :key="index">
            <v-col
              v-if="key != 'id'"
              cols="12"
              sm="6"
              md="4"
            >
              <v-text-field
                v-model.trim="editedItem[key]"
                :label="dialogLabel[key]"
              >
              </v-text-field>
            </v-col>
          </div>
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
  },
  methods: {
    close(){
      this.$emit("close-click")
      console.log("dialog close")
    },
    save(){
      this.$emit("save-click")
    }
  }
}
</script>