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
        console.log(cart);

        $scope.updateBooks = function updateBooks() {
            return BooksService.getBooks()
                .then(function (books) {
                    $scope.books = books;
                })
        };

        $scope.updateCartContent = function updateCartContent() {
            return CartService.getContent($scope.cartId)
                .then(function (cartContent) {
                    $scope.cart.content = content;
                })
                .catch(function (error) {
                    alert(error);
                    $location.path('/login');
                });
        };

        $scope.checkout = function checkout() {
            if ($scope.cart.content.length === 0) {
                alert("You can't checkout an empty cart");
            } else {
                $location.path('/carts/' + $scope.cartId + '/checkout');
            }
        };

        $scope.addBook = function addBook(isbn) {
            $scope.cart.$addBook({isbn: isbn});
        };

        $scope.updateBooks();
        // $scope.updateCartContent();
    });
