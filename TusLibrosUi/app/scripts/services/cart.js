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
        // AngularJS will instantiate a singleton by calling "new" on this function
        this.createCart = function createCart(username, password) {
            console.log('mas cosas');
            return $http.post('http://localhost:3000/carts', {clientId: username, password: password});
        }
    });
