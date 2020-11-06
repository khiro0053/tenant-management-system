<template>
  <v-app>
    <app-bar />
    <v-sheet>
      <v-container
        fluid
        :style="{ maxWidth: '1280px' }"
      >
        <v-row
          v-for="(menu, i) in menus"
          :key="`menu-${i}`"
        >
          <v-col cols="12">
            <div :is="`${menu.title}`" />
          </v-col>
        </v-row>
      </v-container>
    </v-sheet>
  </v-app>
</template>

<script>

import Products from '~/components/welcome/Products'


export default {
  components: {
    Products,
  },
  data () {
    return {
      menus: [
        { title: 'products', subtitle: '他にはない優れた機能の数々' },
      ]
    }
  }
}
</script>