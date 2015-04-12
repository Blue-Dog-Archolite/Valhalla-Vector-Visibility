angular.module('valhalla').controller 'AuthController',['$scope', 'AuthService', ($scope, AuthService) ->
  console.log('AuthController')
  console.log(AuthService.isAuthenticated())

  $scope.log_in_user = (user_credentials) ->
    user = AuthService.current_user()
    console.log('user is' + user)

    user = AuthService.log_in_user(user_credentials)
    console.log('user is now' + user)

]
