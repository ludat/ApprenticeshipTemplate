'use strict';

/**
 * @ngdoc service
 * @name tusLibrosUiApp.book
 * @description
 * # book
 * Service in the tusLibrosUiApp.
 */
angular.module('tusLibrosUiApp')
    .service('BooksService', function ($http) {
        this.getBooks = function getBooks() {
            return $http.get('http://localhost:3000/books')
                .then(function (response) {
                    return response.data;
                })
                .catch(function (response) {
                    return Promise.reject(response.data.error);
                })
            ;
        };
    });
