angular.module('valhalla.routes', ['ui.router']).config \
['$stateProvider', '$urlRouterProvider', '$urlMatcherFactoryProvider', '$locationProvider', \
($stateProvider, $urlRouterProvider, $urlMatcherFactoryProvider, $locationProvider) ->
  $stateProvider
    .state 'user_login',
      controller: 'AuthController'
      url: '/user_login'
      templateUrl: 'users/login.html'

    .state 'flight_plans',
      abstract: 'true'
      url: '/flight_plans'
      templateUrl: 'flight_plans/layout.html'

    .state 'flight_plans.index',
      parent: 'flight_plans'
      url: ''
      templateUrl: 'flight_plans/index.html'
      controller: 'FlightPlansController'
      resolve:
        flightPlans: (FlightPlanService) ->
          FlightPlanService.query().$promise

    .state 'flight_plan',
      parent: 'flight_plans'
      url: '/{id:int}'
      templateUrl: 'flight_plans/show.html'
      controller: 'FlightPlanController'
      resolve:
        flightPlan: (FlightPlanService, $stateParams) ->
          FlightPlanService.fetch($stateParams.id).$promise

    .state 'flight_plans.new',
      parent: 'flight_plans'
      url: '/new'
      templateUrl: 'flight_plans/form.html'
      controller: 'EditFlightPlanController'
      resolve:
        flightPlan: -> {}

   $urlRouterProvider.otherwise('/flight_plans')
   $locationProvider.html5Mode(true)
]
