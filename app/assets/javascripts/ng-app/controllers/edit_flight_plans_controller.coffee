angular.module('valhalla').controller 'EditFlightPlanController', \
['$scope', 'flightPlan', 'FlightPlanService', \
($scope, flightPlan, FlightPlanService) ->

  $scope.flight_plan = flightPlan

  $scope.save = ->
    console.log($scope.flight_plan)
    response = FlightPlanService.create($scope.flight_plan)

    response.$promise
      .then (data) ->
        console.log(data)
      .catch (response) ->
        console.log(response)
]
