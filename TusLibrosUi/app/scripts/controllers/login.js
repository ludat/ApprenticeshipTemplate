'use strict';

/**
 * @ngdoc function
 * @name tusLibrosUiApp.controller:LoginCtrl
 * @description
 * # LoginCtrl
 * Controller of the tusLibrosUiApp
 */
angular.module('tusLibrosUiApp')
    .controller('LoginController', function LoginController($scope, $location, Cart) {
        $scope.username = '1';
        $scope.password = 'password';

        $scope.createCart = function createCart(username, password) {
            var cart = new Cart({clientId: $scope.username, password: $scope.password});
            return cart.$save().then(function (cart) {
                $location.path('/carts/' + cart.id)
            });
        };
    });
