@valhalla = angular.module('valhalla', [
  #  'generalRouter'
])

@vahalla.config(['$routeProvider', ($routerProvider)
  $routeProvider.
    otherwise({
      templateUrl: "<%= asset_path('angular/templates/module/review.html')%>"
      controller: 'HomeCtrl'
    })
])
