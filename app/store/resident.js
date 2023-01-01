import Vue from 'vue'
export const state = () => ({
  residents: [],
  careLevelList: ['自立','要支援１','要支援２','要介護１','要介護２', '要介護３', '要介護４', '要介護５' ],
  errors: {}
})

export const getters = {
  getResidents: state => {
    console.log(JSON.stringify(state.residents))
    return state.residents
  },
  getCareLevelList: state => {
    return state.careLevelList
  },
  getErrors: state => {
    return state.errors
  }
}

export const mutations = {
  setResidents(state, payload) {
    state.residents = payload
    console.log(JSON.stringify(state.residents))
  },
  setResident(state, payload) {
    const id = payload.id
    const targetResidentID = state.residents.findIndex((resident) => resident.id === id)
    if (targetResidentID　!== -1) {
      Vue.set(state.residents, targetResidentID, payload)
    } else {
      state.residents.push(payload)
    }
  },
  deleteResident(state, payload){
    const id = payload.id
    const targetResidentID = state.residents.findIndex((resident) => resident.id === id)
    state.residents.splice(targetResidentID, 1)
  },
  setErrors(state, payload){
    state.errors = payload
  }
}

export const actions = {
  async residents_road({ commit }) {
    await this.$axios.get('/api/v1/residents')
    .then((response) => {
      const residents = response.data
      commit('setResidents', residents)
    })
  },
  async residentCreate({ commit }, data) {
    await this.$axios.post('/api/v1/residents', data)
    .then((response) => {
      const resident = response.data
      commit('setResident', resident)
    })
    .catch((error) => {
      if (error.response.data.errors) {
        const error_messagees = error.response.data.errors
        commit('setErrors', error_messagees )
      }
    })
  },
  async residentUpdate({commit},data) {
    await this.$axios.put(`/api/v1/residents/${data.id}`, data)
    .then((response) =>{
      const resident = response.data
      commit('setResident', resident)
    })
    .catch((error) => {
      if (error.response.data.errors) {
        const error_messagees = error.response.data.errors
        commit('setErrors', error_messagees )
      }
    })
  },
  async residentDelete({commit},data) {
    await this.$axios.delete(`/api/v1/residents/${data.id}`)
    .then((response) =>{
      const resident = response.data
      commit('deleteResident', resident)
    })
    .catch((error) => {
      console.log(error.response)
    })
  },
}