'use strict';

/**
 * @ngdoc function
 * @name tusLibrosUiApp.controller:CheckoutCtrl
 * @description
 * # CheckoutCtrl
 * Controller of the tusLibrosUiApp
 */
angular.module('tusLibrosUiApp')
    .controller('CartCheckoutController', function ($scope, $location, _, ngToast, cart) {
        $scope.number = '';
        var currentYear = new Date().getFullYear();
        $scope.years = _.range(currentYear, currentYear + 10);
        $scope.months = _.range(1, 12 + 1);

        $scope.checkout = function checkout(number, expirationDate) {
            return cart.checkout({
                ccn: number,
                cced: expirationDate.year + '/' + expirationDate.month
            })
                .then(function () {
                    ngToast.create('Cart purchased successfully');
                    $location.path('/login');
                })
                .catch(function (error) {
                    ngToast.danger(error);
                })
            ;
        };
    });
