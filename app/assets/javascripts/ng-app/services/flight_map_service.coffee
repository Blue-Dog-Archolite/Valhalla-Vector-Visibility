angular.module('valhalla').service 'FlightMapService',
[() ->

  flight_path = (flight_path) ->
    ll_path = []
    for point in flight_path.forecast
      adding = {latitude: parseFloat(point.latitude), longitude: parseFloat(point.longitude)}
      ll_path.push(
        adding
      )
    ll_path

  flight_path_map = (flight) ->
    origin = flight_path(flight)[0]
    {
      center:  origin,
      zoom: 4
    }

  {
    flight_path_map
    flight_path
  }
]
