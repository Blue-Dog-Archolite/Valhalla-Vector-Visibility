angular.module('valhalla').controller 'FlightPlansController', \
['$scope', 'flightPlans', '$rootScope', \
($scope, flightPlans, $rootScope) ->

  $scope.flight_plans = flightPlans

]
