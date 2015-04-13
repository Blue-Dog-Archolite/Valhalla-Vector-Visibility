angular.module('valhalla').service 'FlightPlanService', \
['$resource', \
($resource) ->

  FlightPlan = $resource '/api/flight_plans/:id', {id: '@id'}

  query = ->
    FlightPlan.query()

  fetch = (id) ->
    FlightPlan.get({id: id})

  create = (flight_plan) ->
    FlightPlan.save({flight_plan: flight_plan})

  {
    query
    fetch
    create
  }
]
