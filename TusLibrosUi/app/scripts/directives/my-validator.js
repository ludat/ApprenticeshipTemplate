'use strict';

angular.module('tusLibrosUiApp')
  .directive('MyValidator', function () {
    return {
      template: 'views/my-validator.html',
      restrict: 'E',
      link: function postLink(scope, element, attrs) {
        element.text('this is the MyValidator directive');
      }
    };
  });
