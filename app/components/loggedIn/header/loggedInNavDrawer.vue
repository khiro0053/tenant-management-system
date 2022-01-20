<template>
  <v-navigation-drawer
    v-model="setDrawer"
    app
    clipped
    mobile-breakpoint="960"
  >
    <v-list>
      <v-list-item
        v-for="(nav, i) in navMenus"
        :key="`nav-${i}`"
        :to="$my.settingsLinkTo($route.params.id, nav.name)"
      >
        <v-list-item-icon>
          <v-icon v-text="nav.icon" />
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-title>
            {{ $my.pageTitle(nav.name) }}
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-divider />
    </v-list>
  </v-navigation-drawer>
</template>

<script>
export default {
  props: {
    drawer: {
      type: Boolean,
      default: null
    }
  },
  data () {
    return {
      navMenus: [
        { name: 'settings-id-groups', icon: 'mdi-view-dashboard' },
        { name: 'settings-id-tenants', icon: 'mdi-view-compact' },
        { name: 'settings-id-pages', icon: 'mdi-image' },
        { name: 'settings-id-settings', icon: 'mdi-cog' },
        { name: 'settings-id-help', icon: 'mdi-help-circle' }
      ]
    }
  },
  computed: {
    setDrawer: {
      get () { return this.drawer },
      set (val) { return this.$emit('update:drawer', val) }
    }
  }
}
</script>