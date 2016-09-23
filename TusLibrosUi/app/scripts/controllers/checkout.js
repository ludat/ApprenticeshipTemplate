'use strict';

/**
 * @ngdoc function
 * @name tusLibrosUiApp.controller:CheckoutCtrl
 * @description
 * # CheckoutCtrl
 * Controller of the tusLibrosUiApp
 */
angular.module('tusLibrosUiApp')
    .controller('CartCheckoutController', function cartCheckoutController($scope, $location, CartService, cartId) {
        $scope.cartId = cartId;
        $scope.number = '';
        $scope.expirationDate = '';
        $scope.owner = '';

        $scope.checkout = function checkout(number, expirationDate) {
            return CartService.checkout($scope.cartId, number, expirationDate)
                .then(function (response) {
                    console.log(response);
                    $location.path('/login');
                })
                .catch(function (response) {
                    console.log(response);
                    alert(response.data.error);
                })
        }
    });
