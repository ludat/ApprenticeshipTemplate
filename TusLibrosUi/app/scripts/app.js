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
            .when('/purchases', {
                templateUrl: 'views/purchases.html',
                controller: 'PurchasesController',
                resolve: {
                    purchases: function (UserService, $http) {
                        return UserService.currentUser()
                            .then(function (user) {
                                return $http.get(
                                    'http://localhost:3000/users/' + user.username + '/purchases',
                                    {params: {password: user.password}}
                                );
                            })
                            .then(function (response) {
                                return response.data;
                            })
                        ;
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
