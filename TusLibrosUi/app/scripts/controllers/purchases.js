'use strict';

angular.module('tusLibrosUiApp')
    .controller('PurchasesController', function ($scope, purchases) {
        console.log(purchases);
        $scope.purchases = purchases;
    })
;
