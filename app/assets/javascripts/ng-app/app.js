angular
  .module('valhalla', [
    'ngAnimate',
    'ui.router',
    'templates',
    'Devise',
    'valhalla.routes',
    'uiGmapgoogle-maps'
  ])
  .config(function(uiGmapGoogleMapApiProvider) {
    uiGmapGoogleMapApiProvider.configure({
        //    key: 'your api key',
        v: '3.17',
        libraries: 'weather,geometry,visualization'
    });
});
