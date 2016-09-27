'use strict';

/**
 * @ngdoc function
 * @name tusLibrosUiApp.controller:CheckoutCtrl
 * @description
 * # CheckoutCtrl
 * Controller of the tusLibrosUiApp
 */
angular.module('tusLibrosUiApp')
    .controller('CartCheckoutController', function cartCheckoutController($scope, $location, cart) {
        $scope.number = '';
        $scope.expirationDate = '';
        $scope.owner = '';

        $scope.checkout = function checkout(number, expirationDate) {
            return cart.checkout({ccn: number, cced: expirationDate})
                .then(function () {
                    $location.path('/login');
                })
                .catch(function (response) {
                    alert(response.data.error);
                });
        };
    });
