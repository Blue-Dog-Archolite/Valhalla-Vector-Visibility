angular.module('valhalla').controller 'FlightPlanController', \
['$scope', 'flightPlan', 'FlightMapService', \
($scope, flightPlan, FlightMapService) ->

  $scope.flight_plan = flightPlan


  $scope.map = FlightMapService.flight_path_map($scope.flight_plan)

  $scope.path = FlightMapService.flight_path($scope.flight_plan)

  $scope.origin_marker = {
    id: 'origin-'+$scope.flight_plan.id,
    coords: {latitude: $scope.path[0].latitude ,longitude: $scope.path[0].longitude}
  }

  $scope.destination_marker = {
    id: 'dest-'+$scope.flight_plan.id,
    coords: {latitude: $scope.path.slice(-1)[0].latitude ,longitude: $scope.path.slice(-1)[0].longitude}
  }

  $scope.table = [
    { call: 'time',                 label: 'Time'},
    { call: 'latitude',             label: 'Latitude'},
    { call: 'longitude',            label: 'Longitude'},
    { call: 'summary',              label: 'Summary'},
    { call: 'precipIntensity',      label: 'Percipitatin Intencity'},
    { call: 'precipProbability',    label: 'Percipitation Chance'},
    { call: 'temperature',          label: 'Temp'},
    { call: 'apparentTemperature',  label: 'Feels Like'},
    { call: 'dewPoint',             label: 'Dew Point'},
    { call: 'humidity',             label: 'Humidity'},
    { call: 'windSpeed',            label: 'Wind Speed'},
    { call: 'windBearing',          label: 'Wind Bearing'}
  ]

]
