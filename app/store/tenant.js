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
  }
}

export const actions = {
  async tenants_road({ commit }) {
    await this.$axios.get('/api/v1/tenants')
    .then((response) => {
      const tenants = response.data
      commit('setTenants', tenants)
    })
  }
}