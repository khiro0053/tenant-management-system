import Vue from "vue/dist/vue.esm.js";
import VueRouter from "vue-router";
import TenantsContainer from "../container/TenantsContainer.vue";

Vue.use(VueRouter);

export default new VueRouter({
  mode: "history",
  routes: [{ path: "/", component: TenantsContainer }]
});