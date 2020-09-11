<template>
  <div id="tenants-container">
    <ul>
      <li v-for="tenant in tenants" v-bind:key="tenant.id">
        <div>{{tenant.name}}</div>
        <div>{{tenant.target_number_of_residents}}</div>
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import axios from "axios";
import { Vue, Component } from "vue-property-decorator";
@Component
export default class TenantsContainer extends Vue {
  tenants: String[] = [];
  async mounted(): Promise<void> {
    await this.fetchTenants();
  }
  async fetchTenants(): Promise<void> {
    await axios.get("/api/v1/tenants").then(response => {
      response.data.map((tenant: any) => {
        this.tenants.push(tenant);
      });
    });
  }
}
</script>