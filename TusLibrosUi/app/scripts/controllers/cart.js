'use strict';

/**
 * @ngdoc function
 * @name tusLibrosUiApp.controller:CartCtrl
 * @description
 * # CartCtrl
 * Controller of the tusLibrosUiApp
 */
angular.module('tusLibrosUiApp')
    .controller('CartController', function ($scope, $location, $routeParams, BooksService, ) {
        $scope.cartId = $routeParams.cartId;
        $scope.books = [];
        $scope.cartContent = [];

        $scope.updateBooks = function updateBooks() {
            return BooksService.getBooks()
                .then(function (books) {
                    $scope.books = books;
                })
        };

        $scope.updateCartContent = function updateCartContent() {
            return CartService.getContent($scope.cartId)
                .then(function (cartContent) {
                    $scope.cartContent = cartContent;
                })
                .catch(function (error) {
                    $location.path('/login');
                });
        };

        $scope.checkout = function checkout() {
            if ($scope.cartContent.length === 0) {
                alert("You can't checkout an empty cart");
            } else {
                $location.path('/carts/' + $scope.cartId + '/checkout');
            }
        };

        $scope.addBook = function addBook(isbn) {
            CartService.addBook($scope.cartId, isbn);
        };

        $scope.updateBooks();
        $scope.updateCartContent();
    });
