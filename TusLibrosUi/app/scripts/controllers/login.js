'use strict';

/**
 * @ngdoc function
 * @name tusLibrosUiApp.controller:LoginCtrl
 * @description
 * # LoginCtrl
 * Controller of the tusLibrosUiApp
 */
angular.module('tusLibrosUiApp')
    .controller('LoginController', function LoginController($scope, $location, ngToast, CartService) {
        $scope.username = '1';
        $scope.password = 'password';

        $scope.createCart = function createCart(username, password) {
            new CartService.new({clientId: username, password: password})
                .then(function (cart) {
                    $location.path('/carts/' + cart.id);
                })
                .catch(function (error) {
                    ngToast.danger(error);
                })
            ;
        };
    });
