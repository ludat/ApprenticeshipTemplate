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

        $scope.submit = function submit(username, password) {
            return CartService.createCart(
                username, password
            ).then(function (cartId) {
                console.log(cartId);
                $location.path('/carts/' + cartId);
            });
        }
    });
