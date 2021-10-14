import * as Cookies from 'js-cookie'
export default async ({ store, route, redirect, app }) => {
  // トップページかつユーザーが存在しない場合、何もしない(layouts/welcome.vue表示のため)
  if (route.name === 'index' &&  store.getters['user/getIsSignIn'] == false){
    return false
  }
  if (store.getters['user/getIsSignIn'] == false){
    await app.$cookies.set('ridirectPath',{ name: route.name, params: route.params } , {
      path: '/',
      maxAge: 60 * 60 * 24 * 7
    })
    return redirect('/login')
  }
}