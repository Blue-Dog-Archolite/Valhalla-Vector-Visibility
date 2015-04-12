angular.module('valhalla').service 'AuthService', ['Auth', (Auth) ->
  console.log('AuthService')
  console.log(Auth.isAuthenticated())

  log_in_user = (credentials) ->
    console.log('logging ya in')
    console.log(Auth.currentUser())
    Auth.login(credentials).then ((user) ->
      console.log user
    ), (error) ->
      console.log 'wat the shit'

  log_out_user = () ->
    Auth.logout().then ((oldUser) ->
      console.log('logged out')
    ), (error) ->
      console.log('shit')
      console.log(error)

  isAuthenticated = () ->
    Auth.isAuthenticated()

  current_user = () ->
    if isAuthenticated()
      Auth.currentUser()
    else
      null

  {
    log_out_user
    log_in_user
    current_user
    isAuthenticated
  }
]
