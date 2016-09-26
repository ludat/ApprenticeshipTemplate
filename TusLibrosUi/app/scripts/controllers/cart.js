'use strict';

/**
 * @ngdoc function
 * @name tusLibrosUiApp.controller:CartCtrl
 * @description
 * # CartCtrl
 * Controller of the tusLibrosUiApp
 */
angular.module('tusLibrosUiApp')
    .controller('CartController', function ($scope, $location, BooksService, cart) {
        $scope.cart = cart;

        $scope.updateBooks = function updateBooks() {
            return BooksService.getBooks()
                .then(function (books) {
                    $scope.books = books;
                })
        };

        $scope.checkout = function checkout() {
            if ($scope.cart.content.length === 0) {
                alert("You can't checkout an empty cart");
            } else {
                $location.path('/carts/' + cart.id + '/checkout');
            }
        };

        $scope.addBook = function addBook(book, amount) {
            $scope.cart.addBook({book: book, amount: amount});
        };

        $scope.updateBooks();
    });
