angular.module('valhalla').service 'FlightMapService',
['sharedMessagesService', (sharedMessagesService) ->

  @path = null

  flight_path = (flight_path) ->
    return @path if @path
    ll_path = []
    for point in flight_path.forecast
      adding = {latitude: parseFloat(point.latitude), longitude: parseFloat(point.longitude)}
      ll_path.push(
        adding
      )
    @path = ll_path

  flight_path_map = (flight) ->
    sharedMessagesService.send_alert('Loading Flight Plan..')
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
