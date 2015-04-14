angular.module('valhalla').controller 'EditFlightPlanController', \
['$scope', 'flightPlan', 'FlightPlanService', '$state', 'sharedMessagesService', \
($scope, flightPlan, FlightPlanService, $state, sharedMessagesService) ->


  $scope.flight_plan = flightPlan

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
