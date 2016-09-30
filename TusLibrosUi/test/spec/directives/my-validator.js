'use strict';

describe('Directive: MyValidator', function () {

  // load the directive's module
  beforeEach(module('tusLibrosUiApp'));

  var element,
    scope;

  beforeEach(inject(function ($rootScope) {
    scope = $rootScope.$new();
  }));

  it('should make hidden element visible', inject(function ($compile) {
    element = angular.element('<-my-validator></-my-validator>');
    element = $compile(element)(scope);
    expect(element.text()).toBe('this is the MyValidator directive');
  }));
});
