angular.module('valhalla.routes', ['ui.router']).config \
['$stateProvider', '$urlRouterProvider', '$urlMatcherFactoryProvider', '$locationProvider', \
($stateProvider, $urlRouterProvider, $urlMatcherFactoryProvider, $locationProvider) ->
  $stateProvider
    .state 'home',
      url: '/'
      templateUrl: 'home.html'
      controller: 'HomeCtrl'
    .state 'user_login',
      controller: 'AuthController'
      url: '/user_login'
      templateUrl: 'users/login.html'
    .state 'default_map',
      url: '/maps'
      templateUrl: 'maps/default.html'


    .state 'flight_plans',
      abstract: 'true'
      url: '/flight_plans'
      templateUrl: 'flight_plans/layout.html'
  #      controller: 'FlightPlansController'
    .state 'flight_plans.index',
      parent: 'flight_plans'
      url: ''
      templateUrl: 'flight_plans/show.html'
    .state 'flight_plans.new',
      parent: 'flight_plans'
      url: '/new'
      templateUrl: 'flight_plans/form.html'
      controller: 'EditFlightPlanController'
      resolve:
        flightPlan: -> {}

   $urlRouterProvider.otherwise('/')
   $locationProvider.html5Mode(true)
]
