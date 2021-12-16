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
  errors: {}
})

export const getters = {
  getTenants: state => {
    return state.tenants
  },
  getTenants2: state => {
    return state.tenants2
  },
  getErrors: state => {
    return state.errors
  }
}

export const mutations = {
  setTenants(state, payload) {
    state.tenants = payload
  },
  setTenant(state, payload) {
    const id = payload.id
    const targetTenantID = state.tenants.findIndex((tenant) => tenant.id === id)
    if (targetTenantID　!== -1) {
      Vue.set(state.tenants, targetTenantID, payload)
    } else {
      state.tenants.push(payload)
    }
  },
  deleteTenant(state, payload){
    const id = payload.id
    const targetTenantID = state.tenants.findIndex((tenant) => tenant.id === id)
    state.tenants.splice(targetTenantID, 1)
  },
  setErrors(state, payload){
    state.errors = payload
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
  async tenantCreate({ commit }, data) {
    await this.$axios.post('/api/v1/tenants', data)
    .then((response) => {
      console.log("クリエイト")
      const tenant = response.data
      commit('setTenant', tenant)
    })
    .catch((error) => {
      if (error.response.data.errors) {
        const error_messagees = error.response.data.errors
        commit('setErrors', error_messagees )
      }
    })
  },
  async tenantUpdate({commit},data) {
    await this.$axios.put(`/api/v1/tenants/${data.id}`, data)
    .then((response) =>{
      const tenant = response.data
      commit('setTenant', tenant)
    })
    .catch((error) => {
      if (error.response.data.errors) {
        const error_messagees = error.response.data.errors
        commit('setErrors', error_messagees )
      }
    })
  },
  async tenantDelete({commit},data) {
    await this.$axios.delete(`/api/v1/tenants/${data.id}`)
    .then((response) =>{
      const tenant = response.data
      commit('deleteTenant', tenant)
    })
    .catch((error) => {
      console.log(error.response)
    })
  },
}