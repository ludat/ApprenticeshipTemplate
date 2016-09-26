'use strict';

/**
 * @ngdoc service
 * @name tusLibrosUiApp.user
 * @description
 * # user
 * Service in the tusLibrosUiApp.
 */
angular.module('tusLibrosUiApp')
    .factory('Cart', function ($http) {
        return function (attrs) {
            var self = this;
            angular.merge(self, attrs);

            self.remoteAddBook = function remoteAddBook(book) {
                return $http.post('http://localhost:3000/carts/' + self.id + '/addBook', book)
            };

            self.updateContent = function updateContent() {
                return $http.get('http://localhost:3000/carts/' + self.id + '/books')
                    .then(function (response) {
                        self.content = response.data;
                    })
            };

            self.localAddBook = function localAddBook(aBook) {
                var orders = self.content.filter(function (order) {
                    return order.book.isbn === aBook.book.isbn;
                });

                if (orders.length === 0) {
                    self.content.push(aBook)
                } else {
                    orders[0].amount += aBook.amount;
                }

            };

            self.addBook = function addBook(book) {
                // self.remoteAddBook.then(self.updateContent);
                self.remoteAddBook(book).then(function () {
                    self.localAddBook(book)
                });
            };

            self.empty = function empty() {
                return self.content.length === 0;
            };

            self.checkout = function checkout(creditCard) {
                return $http.post('http://localhost:3000/carts/' + self.id + '/checkout', creditCard)
            }
        };
    })
    .service('CartService', function CartService($http, Cart) {
        this.new = function createCart(credentials) {
            return $http.post('http://localhost:3000/carts', credentials)
                .then(function makeACart(response) {
                    return new Cart(response.data);
                })
        };

        this.get = function getCart(id) {
            return $http.get('http://localhost:3000/carts/' + id)
                .then(function makeACart(response) {
                    return new Cart(response.data);
                })
        };
    });
