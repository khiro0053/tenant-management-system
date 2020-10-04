<template>
  <div>
<p>TypeScriptを使ったAPI通信 </p>
		<ul>
      <li v-for="tenant in tenants" v-bind:key="tenant.id">
        <div>{{tenant.name}}</div>
        <div>{{tenant.target_number_of_residents}}</div>
      </li>
		</ul>
  </div>
</template>

<script lang="ts">
import { Vue, Component } from "nuxt-property-decorator";
import { Context } from '@nuxt/types';

@Component
export default class Tenants extends Vue {
  async asyncData ({$axios}: Context){
    const res = await $axios.$get(`/api/v1/tenants`);
    return { tenants: res };
  }
}
</script>
