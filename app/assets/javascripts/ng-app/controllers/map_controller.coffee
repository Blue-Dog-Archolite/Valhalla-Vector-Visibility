angular.module('valhalla').controller 'MapController',['$scope', 'Auth', \
($scope, Auth) ->

  $scope.map = { center: { latitude: -50, longitude: 20 }, zoom: 8 }

  $scope.path = [
    { latitude: -50, longitude: 20 },
    { latitude: -50, longitude: 20.1 },
    { latitude: -50.1, longitude: 20 },
    { latitude: -50.1, longitude: 20.1 }
  ]

]
