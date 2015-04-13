angular.module('valhalla').service 'FlightMapService',
[() ->
  map = { center: { latitude: -50, longitude: 20 }, zoom: 8 }

  path = [
    { latitude: -50, longitude: 20 },
    { latitude: -50, longitude: 20.1 },
    { latitude: -50.1, longitude: 20 },
    { latitude: -50.1, longitude: 20.1 }
  ]

  {
    map
    path
  }
]
