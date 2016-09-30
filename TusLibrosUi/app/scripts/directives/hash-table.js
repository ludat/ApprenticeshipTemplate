'use strict';

/**
 * @ngdoc directive
 * @name tusLibrosUiApp.directive:hashTable
 * @description
 * # hashTable
 */
angular.module('tusLibrosUiApp')
    .directive('hashTable', function (_) {
        return {
            templateUrl: 'views/hash-table.html',
            restrict: 'E',
            scope: {
                mappings: '=mappings',
                content: '=content'
            },
            link: function (scope, element, attrs, controller, transcludeFn) {
                console.log(score.mappings);
                scope.headers = _.keys(scope.mappings);
                scope.accessors = _.values(scope.mappings);
            }
        };
    })
    .filter('get', function(_) {
        return function(input, accessor) {
            return _.get(input, accessor);
        };
    })
;
