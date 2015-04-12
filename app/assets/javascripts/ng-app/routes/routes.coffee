angular.module('valhalla.routes', ['ui.router']).config \
['$stateProvider', '$urlRouterProvider', '$urlMatcherFactoryProvider', '$locationProvider', \
($stateProvider, $urlRouterProvider, $urlMatcherFactoryProvider, $locationProvider) ->
  $stateProvider
    .state 'home',
      url: '/'
      templateUrl: 'home.html'
      controller: 'HomeCtrl'
    .state 'dashboard',
      abstract: 'true'
      url: '/dashboard'
      templateUrl: 'dashboard/layout.html'
    .state 'dashboard.one',
      parent: 'dashboard'
      url: ''
      templateUrl: 'dashboard/one.html'
    .state 'dashboard.two',
      parent: 'dashboard'
      url: '/two'
      templateUrl: 'dashboard/two.html'
    .state 'dashboard.three',
      parent: 'dashboard'
      url: '/three'
      templateUrl: 'dashboard/three.html'

   $urlRouterProvider.otherwise('/')
   $locationProvider.html5Mode(true)
]
