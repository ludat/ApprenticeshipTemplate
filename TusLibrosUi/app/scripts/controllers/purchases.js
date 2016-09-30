'use strict';

angular.module('tusLibrosUiApp')
    .controller('PurchasesController', function ($scope, purchases) {
        $scope.purchases = purchases;
    })
;
