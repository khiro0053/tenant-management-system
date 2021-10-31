import Vue from 'vue'
export const state = () => ({
  tenants2: [
    { id: 1, name: 'イエローライフ', capacity: '50' },
    { id: 2, name: 'シルバーライフ', capacity: '20' },
    { id: 3, name: 'レッドライフ', capacity: '30' },
    { id: 4, name: 'ブルーライフ', capacity: '25' },
    { id: 5, name: 'オレンジライフ', capacity: '10' }
  ],
  tenants: {},
})

export const getters = {
  getTenants: state => {
    return state.tenants
  },
  getTenants2: state => {
    return state.tenants2
  }
}

export const mutations = {
  setTenants(state, tenants) {
    state.tenants = tenants
  },
  setTenant(state, updateTenant) {
    const id = updateTenant.id
    const targetTenantID = state.tenants.findIndex((tenant) => tenant.id === id)
    Vue.set(state.tenants, targetTenantID, updateTenant)
    console.log(state.tenants[targetTenantID])
  }
}

export const actions = {
  async tenants_road({ commit }) {
    await this.$axios.get('/api/v1/tenants')
    .then((response) => {
      const tenants = response.data
      commit('setTenants', tenants)
    })
  },
  async tenantsUpdate({commit},data) {
    await this.$axios.put(`/api/v1/tenants/${data.tenant.id}`, data)
    .then((response) =>{
      const tenant = response.data
      commit('setTenant', tenant)
    })
    .catch((error) => {
      console.log(error)
    })
  }
}