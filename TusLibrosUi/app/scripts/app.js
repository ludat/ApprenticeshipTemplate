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
        'ngTouch',
        'ngToast'
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
            })
        ;
    })
    .constant('_', window._)
    .constant('CARTS_URL', 'http://localhost:3000/carts/')
    .constant('BOOKS_URL', 'http://localhost:3000/books/')
    .config(function (ngToastProvider) {
        ngToastProvider.configure({
            verticalPosition: 'top',
            horizontalPosition: 'left'
        });
    })
;
