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
            return $http.post('http://localhost:3000/carts', {
                clientId: username,
                password: password
            })
                .then(function (response) {
                    return response.data.id;
                });
        };


        this.getContent = function getContent(cartId) {
            return $http.get('http://localhost:3000/carts/' + cartId + '/books')
                .then(function (response) {
                    return response.data;
                });
        };

        this.addBook = function addBook(cartId, isbn) {
            return $http.post('http://localhost:3000/carts/' + cartId + '/addBook', {
                bookIsbn: isbn,
                bookQuantity: 1
            });
        };

        this.checkout = function checkout(cartId, creditCardNumber, creditCardExpirationDate) {
            return $http.post('http://localhost:3000/carts/' + cartId + '/checkout', {
                cco: 'roberto',
                ccn: creditCardNumber,
                cced: creditCardExpirationDate
            });
        };
    });