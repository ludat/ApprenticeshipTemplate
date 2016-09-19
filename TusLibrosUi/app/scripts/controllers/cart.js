'use strict';

/**
 * @ngdoc function
 * @name tusLibrosUiApp.controller:CartCtrl
 * @description
 * # CartCtrl
 * Controller of the tusLibrosUiApp
 */
angular.module('tusLibrosUiApp')
    .controller('CartController', function ($scope, $routeParams, CartService) {
        $scope.cartId = $routeParams.cartId;
        $scope.addBook = function addBook(isbn) {
            console.log('I added a book' + isbn + 'to the cart (lies nothing but lies)');
            CartService.addBook($scope.cartId, isbn);
        }
    });
