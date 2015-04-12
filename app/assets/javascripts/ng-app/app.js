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
        key: 'AIzaSyCDhdipeSFjmkk0lSMeSqYER3aAe6XI3Wc',
        v: '3.17',
        libraries: 'weather,geometry,visualization'
    });
});
