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
                controller: 'CartController',
                resolve: {
                    cart: function (CartService, $route) {
                        return CartService.get($route.current.params.cartId);
                    }
                }
            })
            .when('/carts/:cartId/checkout', {
                templateUrl: 'views/checkout.html',
                controller: 'CartCheckoutController',
                resolve: {
                    cart: function (CartService, $route) {
                        return CartService.get($route.current.params.cartId);
                    }
                }
            })
            .otherwise({
                redirectTo: '/login'
            });
    })
