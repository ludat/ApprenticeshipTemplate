'use strict';

angular.module('tusLibrosUiApp')
    .controller('LoginController', function LoginController($scope, $location, ngToast, UserService, CartService) {
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

        $scope.showPurchases = function (username, password) {
            UserService.login(username, password);
            $location.path('/purchases');
        };
    });
