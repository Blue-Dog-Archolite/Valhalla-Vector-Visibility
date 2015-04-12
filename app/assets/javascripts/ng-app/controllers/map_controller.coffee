angular.module('valhalla').controller 'MapController',['$scope', 'Auth', \
($scope, Auth) ->

  $scope.map = { center: { latitude: 45, longitude: -73 }, zoom: 8 }
]
