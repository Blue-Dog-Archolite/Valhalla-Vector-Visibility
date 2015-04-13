angular.module('valhalla').controller 'FlightPlanController', \
['$scope', 'FlightPlanService', 'flightPlan', \
($scope, FlightPlanService, flightPlan) ->

  $scope.flight_plan = flightPlan

  console.log('FPC: flightPlan')
  console.log($scope.flight_plan)

]
