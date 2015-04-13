angular.module('valhalla').controller 'FlightPlanController', \
['$scope', 'FlightPlanService', \
($scope, FlightPlanService) ->

  $scope.flight_plans = {} #FlightPlanService.query()

]
