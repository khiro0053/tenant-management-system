import colors from 'vuetify/es5/util/colors'

export default {
  srcDir: 'app/',
  // Global page headers (https://go.nuxtjs.dev/config-head)
  server: {
    port: 8000, // デフォルト: 3000
    host: '127.0.0.1', // デフォルト: localhost,
    timing: false
  },
  env: {
    baseUrl: process.env.BASE_URL || 'http://localhost:3000'
  },

  head: {
    titleTemplate: '%s - tenant-management-system',
    title: 'tenant-management-system',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' },
    ],
    link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }],
  },

  // Global CSS (https://go.nuxtjs.dev/config-css)
  css: [
    '~/assets/sass/main.scss'
  ],

  // Plugins to run before rendering page (https://go.nuxtjs.dev/config-plugins)
  plugins: [
    'plugins/axios.js',
    'plugins/myInject.js',
    'plugins/cookie-storage.js'
  ],

  // Auto import components (https://go.nuxtjs.dev/config-components)
  components: true,

  // Modules for dev and build (recommended) (https://go.nuxtjs.dev/config-modules)
  buildModules: [
    // https://go.nuxtjs.dev/typescript
    '@nuxt/typescript-build',
    // https://go.nuxtjs.dev/vuetify
    '@nuxtjs/vuetify',
  ],

  // Modules (https://go.nuxtjs.dev/config-modules)
  modules: [
    '@nuxtjs/axios',
    'nuxt-i18n',
    'cookie-universal-nuxt'
  ],

  axios: {
    baseURL: 'http://localhost:3000', // Used as fallback if no runtime config is provided
    credentials: true
  },

  publicRuntimeConfig: {
    appName: process.env.APP_NAME // 環境変数からアプリ名取得
  },

  // Vuetify module configuration (https://go.nuxtjs.dev/config-vuetify)
  vuetify: {
    // 開発環境でcustomVariablesを有効にするフラグ
    // Doc: https://vuetifyjs.com/ja/customization/a-la-carte/
    treeShake: true,
    customVariables: ['~/assets/sass/variables.scss'],
    theme: {
      themes: {
        light: {
          primary: '4080BE',
          info: '4FC1E9',
          success: '44D69E',
          warning: 'FEB65E',
          error: 'FB8678',
          background: 'f6f6f4',
          myblue: '1867C0'
        }
      }
    }
  },
  i18n: {
    strategy: 'no_prefix',
    locales: ['ja', 'en'],
    defaultLocale: 'ja',
    // Doc: https://kazupon.github.io/vue-i18n/api/#properties
    vueI18n: {
      fallbackLocale: 'ja',
      // silentTranslationWarn: true,
      silentFallbackWarn: true,
      messages: {
        ja: require('./locales/ja.json'),
        en: require('./locales/en.json')
      }
    }
  },
  // Build Configuration (https://go.nuxtjs.dev/config-build)
  build: {},
  vue: {
    config: {
      productionTip: true,
      devtools: true
    }
  }
}
