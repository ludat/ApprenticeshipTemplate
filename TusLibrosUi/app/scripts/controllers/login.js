'use strict';

/**
 * @ngdoc function
 * @name tusLibrosUiApp.controller:LoginCtrl
 * @description
 * # LoginCtrl
 * Controller of the tusLibrosUiApp
 */
angular.module('tusLibrosUiApp')
    .controller('LoginController', function LoginController($scope, $location, CartService) {
        $scope.username = '1';
        $scope.password = 'password';

        $scope.createCart = function createCart(username, password) {
            return CartService.createCart(
                username, password
            ).then(function (cartId) {
                $location.path('/carts/' + cartId);
            });
        };

        $scope.createCart = function createCart(username, password) {
            return CartService.createCart(
                username, password
            ).then(function (cartId) {
                $location.path('/carts/' + cartId);
            });
        }
    });
