angular.module('valhalla').service 'FlightMapService',
[() ->
  map = { center: { latitude: 41, longitude: -87 }, zoom: 8 }

  path = [
    { latitude: 41.8781136,  longitude: -87.6297982},
    { latitude: 42.22349874488544,  longitude: -89.52040335668643},
    { latitude: 42.537507047059684,  longitude: -91.43085411777912},
    { latitude: 42.81947275857554,  longitude: -93.35962226226566},
    { latitude: 43.06878326683364,  longitude: -95.30503140714421},
    { latitude: 43.28488488805788,  longitude: -97.26526563109444},
    { latitude: 43.46728831814785,  longitude: -99.23838068783566},
    { latitude: 43.61557362114451,  longitude: -101.22231772713342},
    { latitude: 43.72939463988212,  longitude: -103.21491935516711},
    { latitude: 43.80848272227686,  longitude: -105.21394778033391},
    { latitude: 43.85264967003454,  longitude: -107.21710471031643},
    { latitude: 43.86178983397667,  longitude: -109.22205259617874},
    { latitude: 43.835881301046285,  longitude: -111.22643676378038},
    { latitude: 43.77498614147834,  longitude: -113.2279079355278},
    { latitude: 43.679249709537295,  longitude: -115.22414462890836},
    { latitude: 43.6187102,  longitude: -116.2146068}
  ]

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
      zoom: 8
    }


  {
    flight_path_map
    flight_path
  }
]
