angular.module('valhalla').controller 'EditFlightPlanController', \
['$scope', 'flightPlan', 'FlightPlanService', '$state', 'sharedMessagesService', \
($scope, flightPlan, FlightPlanService, $state, sharedMessagesService) ->

  $scope.flight_plan = flightPlan

  $scope.lat_long_regex =
    /^(\w{3}|[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?))$/

  $scope.save = ->
    $scope.isDisabled = true
    response = FlightPlanService.create($scope.flight_plan)

    response.$promise
      .then (data) ->
        sharedMessagesService.send_alert('Flight Plan Saved!')
        $scope.isDisabled = false
        $state.go('flight_plan', {id: data.id})
      .catch (response) ->
        sharedMessagesService.send_error('Flight Plan Failed to Save!')
        console.log(response)
        $scope.isDisabled = false
]
