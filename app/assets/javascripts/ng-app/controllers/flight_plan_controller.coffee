angular.module('valhalla').controller 'FlightPlanController', \
['$scope', 'flightPlan', \
($scope, flightPlan) ->

  $scope.flight_plan = flightPlan

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
