import Vue from 'vue'
export const state = () => ({
  tenantGroups: [],
  errors: {}
})

export const getters = {
  getTenantGroups: state => {
    return state.tenantGroups
  },
  getErrors: state => {
    return state.errors
  }
}

export const mutations = {
  setTenantGroups(state, payload) {
    state.tenantGroups = payload
  },
  setTenantGroup(state, payload) {
    const id = payload.id
    const targetTenantGroupID = state.tenantGroups.findIndex((tenantGroup) => tenantGroup.id === id)
    if (targetTenantGroupID　!== -1) {
      Vue.set(state.tenantGroups, targetTenantGroupID, payload)
    } else {
      state.tenantGroups.push(payload)
    }
  },
  deleteTenantGroup(state, payload){
    const id = payload.id
    const targetTenantGroupID = state.tenantGroups.findIndex((tenantGroup) => tenantGroup.id === id)
    state.tenantGroups.splice(targetTenantGroupID, 1)
  },
  setErrors(state, payload){
    state.errors = payload
  }
}

export const actions = {
  async tenantGroups_road({ commit }) {
    await this.$axios.get('/api/v1/tenant_groups')
    .then((response) => {
      const tenantGroups = response.data
      commit('setTenantGroups', tenantGroups)
    })
  },
  async tenantGroupCreate({ commit }, data) {
    await this.$axios.post('/api/v1/tenant_groups', data)
    .then((response) => {
      const tenantGroup= response.data
      commit('setTenantGroup', tenantGroup)
    })
    .catch((error) => {
      if (error.response.data.errors) {
        const error_messagees = error.response.data.errors
        commit('setErrors', error_messagees )
      }
    })
  },
  async tenantGroupUpdate({commit},data) {
    await this.$axios.put(`/api/v1/tenant_groups/${data.id}`, data)
    .then((response) =>{
      const tenantGroup= response.data
      commit('setTenantGroup', tenantGroup)
    })
    .catch((error) => {
      if (error.response.data.errors) {
        const error_messagees = error.response.data.errors
        commit('setErrors', error_messagees )
      }
    })
  },
  async tenantGroupDelete({commit},data) {
    await this.$axios.delete(`/api/v1/tenant_groups/${data.id}`)
    .then((response) =>{
      const tenantGroup= response.data
      commit('deleteTenantGroup', tenantGroup)
    })
    .catch((error) => {
      console.log(error.response)
    })
  },
}