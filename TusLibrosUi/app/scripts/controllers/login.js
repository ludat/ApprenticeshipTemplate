'use strict';

/**
 * @ngdoc function
 * @name tusLibrosUiApp.controller:LoginCtrl
 * @description
 * # LoginCtrl
 * Controller of the tusLibrosUiApp
 */
angular.module('tusLibrosUiApp')
    .controller('LoginCtrl', function LoginController($scope, CartService) {
        $scope.username = '123456';
        $scope.password = '';

        $scope.submit = function submit(username, password) {
            console.log('cosas');
            CartService.createCart(username, password).then(function (cartId) {
                console.log(cartId)
            });
        }
    });
