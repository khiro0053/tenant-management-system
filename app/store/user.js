export const state = () => ({
  isSignIn: false,
  headers: {},
})

export const getters = {
  getIsSignIn: state => state.isSignIn,
  getHeaders: state => state.headers
}

export const mutations = {
  setHeaders(state, headers) {
      state.headers = headers
  },
  setIsSignIn(state, isSignIn) {
    state.isSignIn = isSignIn
  }
}

export const actions = {
  async signup({ commit }, params) {
    await this.$axios.post('/api/v1/auth', params)
    .then((response) => {
      const headers = response.headers
      const loginInfoHeaders = {
        'access-token': headers['access-token'],
         client: headers.client,
         uid: headers.uid,
         expiry: headers.expirty,
        'token-type': headers['token-type']
      }

      commit('setHeaders', loginInfoHeaders)
      commit ('setIsSignIn', true)
    })
    .catch(error => {
        console.log(error);
    });
  },
  async login({ commit }, params) {
    await this.$axios.post('/api/v1/auth/sign_in', params)
    .then((response) => {
      const headers = response.headers
      const loginInfoHeaders = {
        'access-token': headers['access-token'],
         client: headers.client,
         uid: headers.uid,
         expiry: headers.expirty,
        'token-type': headers['token-type']
      }

      commit('setHeaders', loginInfoHeaders)
      commit ('setIsSignIn', true)
    })
    .catch(error => {
        console.log(error);
    });
  },
  logout ({ commit }) {
    commit('setIsSignIn', false)
  },
}
