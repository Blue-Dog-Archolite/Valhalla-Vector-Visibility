angular.module('valhalla').controller 'EditFlightPlanController', \
['$scope', 'flightPlan', 'FlightPlanService', '$state', \
($scope, flightPlan, FlightPlanService, $state) ->

  $scope.flight_plan = flightPlan

  $scope.save = ->
    console.log("Flight plan")
    console.log($scope.flight_plan)
    response = FlightPlanService.create($scope.flight_plan)

    response.$promise
      .then (data) ->
        $state.go('flight_plan', {id: data.id})
      .catch (response) ->
        console.log(response)
]
