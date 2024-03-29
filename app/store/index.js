import $cookies from "cookie-universal-nuxt"
export const state = () => ({
  drawer: true,
  styles: {
    beforeLogin: {
      appBarHeight: 56
    }
  },
  current: {
    project: null
  },
  projects: [
    { id: 1, name: 'MyProject01', updatedAt: '2020-04-01T12:00:00+09:00' },
    { id: 2, name: 'MyProject02', updatedAt: '2020-04-05T12:00:00+09:00' },
    { id: 3, name: 'MyProject03', updatedAt: '2020-04-03T12:00:00+09:00' },
    { id: 4, name: 'MyProject04', updatedAt: '2020-04-04T12:00:00+09:00' },
    { id: 5, name: 'MyProject05', updatedAt: '2020-04-01T12:00:00+09:00' }
  ]
})

export const getters = {}

export const mutations = {
  setCurrentProject (state, payload) {
    state.current.project = payload
  }
}

export const actions = {
  getCurrentProject ({ state, commit }, params) {
    const currentProject = state.projects.find(project => project.id === Number(params.id))
    commit('setCurrentProject', currentProject)
  },
  async nuxtServerInit ({commit}, context) {
    const data = context.app.$cookies.get('tenant-manegement') || []
    if ("user" in data){
      commit('user/setIsSignIn', data.user.isSignIn)
      commit ('user/setHeaders', data.user.headers)
    }
  }
}
