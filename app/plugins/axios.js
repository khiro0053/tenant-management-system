export default ({ store, $axios }) => {
  $axios.interceptors.request.use((config) => {
    const headers = store.getters['user/getHeaders']
    Object.keys(headers).forEach(function (key){
      const value = headers[key]
      config.headers[key] = value
    })
    return config
  })
  // リクエストログ
  $axios.onRequest((config) => {
    console.log(config)
  })
  // レスポンスログ
  $axios.onResponse((config) => {
    console.log(config)
  })
  // エラーログ
  $axios.onError((e) => {
    console.log(e.response)
  })
 }