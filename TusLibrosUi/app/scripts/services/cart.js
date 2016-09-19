'use strict';

/**
 * @ngdoc service
 * @name tusLibrosUiApp.user
 * @description
 * # user
 * Service in the tusLibrosUiApp.
 */
angular.module('tusLibrosUiApp')
    .service('CartService', function CartService($http) {
        this.createCart = function createCart(username, password) {
            return $http.post('http://localhost:3000/carts', {clientId: username, password: password})
                .then(function (response) {
                    return response.data.id
                });
        };

        this.addBook = function addBook(cartId, isbn) {
            return $http.post('http://localhost:3000/carts/' + cartId + '/add_book', {
                bookIsbn: isbn,
                bookQuantity: 1
            })
        }
    });
