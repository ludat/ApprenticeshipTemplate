'use strict';

/**
 * @ngdoc overview
 * @name tusLibrosUiApp
 * @description
 * # tusLibrosUiApp
 *
 * Main module of the application.
 */
angular
    .module('tusLibrosUiApp', [
        'ngAnimate',
        'ngCookies',
        'ngResource',
        'ngRoute',
        'ngSanitize',
        'ngTouch'
    ])
    .config(function ($routeProvider) {
        $routeProvider
            .when('/login', {
                templateUrl: 'views/login.html',
                controller: 'LoginController'
            })
            .when('/carts/:cartId', {
                templateUrl: 'views/cart.html',
                controller: 'CartController'
            })
            .when('/carts/:cartId/checkout', {
                templateUrl: 'views/checkout.html',
                controller: 'CartCheckoutController',
                resolve: {
                    cartId: function ($route) {
                        //TODO I should create an object cart
                        return $route.current.params.cartId;
                    }
                }
            })
            .otherwise({
                redirectTo: '/login'
            });
    });
