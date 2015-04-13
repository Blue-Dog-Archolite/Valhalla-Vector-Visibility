angular.module('valhalla').controller 'FlightPlansController', \
['$scope', 'flightPlans', \
($scope, flightPlans) ->

  $scope.flight_plans = flightPlans

]
