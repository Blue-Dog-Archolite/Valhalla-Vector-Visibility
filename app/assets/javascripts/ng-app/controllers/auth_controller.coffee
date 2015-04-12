angular.module('valhalla').controller 'AuthController',['$scope', 'AuthService', ($scope, AuthService) ->
  console.log('AuthController')
  console.log(AuthService.isAuthenticated())

  $scope.log_in_user = (user) ->
    console.log(user)

    console.log('fuck off')
    credentials =
      email: 'rmeyer@halbrek.com'
      password: 'faa11639'

    user = AuthService.current_user()
    console.log('user is' + user)

    user = AuthService.log_in_user(credentials)
    console.log('user is now' + user)

]
