import Vue from 'vue'
export const state = () => ({
  rooms: [],
  errors: {}
})

export const getters = {
  getRooms: state => {
    return state.rooms
  },
  getErrors: state => {
    return state.errors
  }
}

export const mutations = {
  setRooms(state, payload) {
    state.rooms = payload
  },
  setRoom(state, payload) {
    const id = payload.id
    const targetRoomID = state.rooms.findIndex((room) => room.id === id)
    if (targetRoomID　!== -1) {
      Vue.set(state.rooms, targetRoomID, payload)
    } else {
      state.rooms.push(payload)
    }
  },
  deleteRoom(state, payload){
    const id = payload.id
    const targetRoomID = state.rooms.findIndex((room) => room.id === id)
    state.rooms.splice(targetRoomID, 1)
  },
  setErrors(state, payload){
    state.errors = payload
  }
}

export const actions = {
  async rooms_road({ commit }) {
    await this.$axios.get('/api/v1/rooms')
    .then((response) => {
      const rooms = response.data
      commit('setRooms', rooms)
    })
  },
  async roomCreate({ commit }, data) {
    await this.$axios.post('/api/v1/rooms', data)
    .then((response) => {
      const room = response.data
      commit('setRoom', room)
    })
    .catch((error) => {
      if (error.response.data.errors) {
        const error_messagees = error.response.data.errors
        commit('setErrors', error_messagees )
      }
    })
  },
  async roomUpdate({commit},data) {
    await this.$axios.put(`/api/v1/rooms/${data.id}`, data)
    .then((response) =>{
      const room = response.data
      commit('setRoom', room)
    })
    .catch((error) => {
      if (error.response.data.errors) {
        const error_messagees = error.response.data.errors
        commit('setErrors', error_messagees )
      }
    })
  },
  async roomDelete({commit},data) {
    await this.$axios.delete(`/api/v1/rooms/${data.id}`)
    .then((response) =>{
      const room = response.data
      commit('deleteRoom', room)
    })
    .catch((error) => {
      console.log(error.response)
    })
  },
}