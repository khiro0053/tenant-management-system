<template>
  <v-app>
    <app-bar
      :menus="menus"
      :img-height="imgHeight"
    />
    <v-img
      id="scroll-top"
      dark
      src="https://picsum.photos/id/20/1920/1080?blur=5"
      gradient="to top right, rgba(19,84,122,.6), rgba(128,208,199,.9)"
      :height="imgHeight"
    >
      <v-row
        align="center"
        justify="center"
        :style="{ height: `${imgHeight}px` }"
      >
        <v-col
          cols="12"
          class="text-center"
        >
          <h1 class="display-1 mb-4">
            入居者管理の見える化
          </h1>
          <h4
            class="subheading"
            :style="{ letterSpacing: '5px' }"
          >
            介護に特化した入居者管理ツール
          </h4>
        </v-col>
      </v-row>
    </v-img>
    <v-sheet>
      <v-container
        fluid
        :style="{ maxWidth: '1280px' }"
      >
        <v-row
          v-for="(menu, i) in menus"
          :key="`menu-${i}`"
        >
      <v-col
        :id="menu.title"
        cols="12"
      >
        <v-card flat>
          <v-card-title class="justify-center display-1">
            {{ $t(`menus.${menu.title}`) }}
          </v-card-title>
          <v-card-text class="text-center">
            {{ menu.subtitle }}
          </v-card-text>
        </v-card>
      </v-col>
          <v-col cols="12">
            <div :is="`${menu.title}`" />
          </v-col>
        </v-row>
      </v-container>
    </v-sheet>
    <before-login-footer /> <!-- フッター -->
  </v-app>
</template>

<script>

import Products from '~/components/welcome/Products'
import About from '~/components/welcome/About'
import Contact from '~/components/welcome/Contact'

export default {
  components: {
    Products,
    About,
    Contact,
  },
  data () {
    return {
      imgHeight: 500,
      menus: [
        { title: 'about', subtitle: '他にはない優れた機能の数々' },
        { title: 'products', subtitle: '他にはない優れた機能の数々' },
        { title: 'contact', subtitle: '他にはない優れた機能の数々' },
      ]
    }
  }
}
</script>