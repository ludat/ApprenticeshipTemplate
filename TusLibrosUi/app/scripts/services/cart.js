'use strict';

/**
 * @ngdoc service
 * @name tusLibrosUiApp.user
 * @description
 * # user
 * Service in the tusLibrosUiApp.
 */
angular.module('tusLibrosUiApp')
    .factory('Cart', function (CARTS_URL, $http) {
        return function (attrs) {
            var self = this;
            angular.merge(self, attrs);

            self.remoteAddBook = function remoteAddBook(book) {
                return $http
                    .post(CARTS_URL + self.id + '/addBook', book)
                    .catch(function (response) {
                        return Promise.reject(response.data.error);
                    })
                ;
            };

            self.updateContent = function updateContent() {
                return $http.get(CARTS_URL + self.id + '/books')
                    .then(function (response) {
                        self.content = response.data;
                    }).catch(function (response) {
                        return Promise.reject(response.data.error);
                    })
                ;
            };

            self.localAddBook = function localAddBook(aBook) {
                var orders = self.content.filter(function (order) {
                    return order.book.isbn === aBook.book.isbn;
                });

                if (orders.length === 0) {
                    self.content.push(aBook);
                } else {
                    orders[0].amount += aBook.amount;
                }
            };

            self.addBook = function addBook(book) {
                // self.remoteAddBook.then(self.updateContent);
                self
                    .remoteAddBook(book)
                    .then(function () {
                    self.localAddBook(book);
                });
            };

            self.empty = function empty() {
                return self.content.length === 0;
            };

            self.checkout = function checkout(creditCard) {
                if (self.empty()) {
                    return Promise.reject({error: 'The cart can\'t be empty'});
                } else {
                    return $http
                        .post(CARTS_URL + self.id + '/checkout', creditCard)
                        .catch(function (response) {
                            return Promise.reject(response.data.error);
                        })
                    ;
                }
            };
        };
    })
    .service('CartService', function CartService(CARTS_URL, $http, Cart) {
        this.new = function createCart(credentials) {
            return $http.post(CARTS_URL, credentials)
                .then(function makeACart(response) {
                    return new Cart(response.data);
                })
                .catch(function (response) {
                    return Promise.reject(response.data.error);
                });
        };
        this.get = function getCart(id) {
            return $http.get(CARTS_URL + id)
                .then(function makeACart(response) {
                    return new Cart(response.data);
                })
                .catch(function (response) {
                    return Promise.reject(response.data.error);
                })
            ;
        };
    });
