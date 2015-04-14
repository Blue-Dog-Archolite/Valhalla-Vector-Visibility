angular.module('valhalla').controller 'AuthController',
['$scope', 'Auth', \
($scope, Auth) ->

  log_out_user = () ->
    # According to DeviseModal and Devise angular
    # this is the correct call. However, it appears
    # that I am not correctly calling the service binding
    Auth.logout()

  {
    log_out_user
  }
]
