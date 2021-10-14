export const state = () => ({
  rememberRoute: {
    name: 'index',
    params: {}
  }
})

export const getters = {}

export const mutations = {
  setRememberRoute (state, payload) {
    state.rememberRoute = payload
  }
}
export const actions = {
  // ログイン前にアクセスしたルートを記憶する
  getRememberRoute ({ commit }, route) {
    route = route || { name: 'index', params: {} }　
    commit('setRememberRoute', { name: route.name, params: route.params })
  }
}
