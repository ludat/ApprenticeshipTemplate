'use strict';

describe('Controller: PurcharsesCtrl', function () {

  // load the controller's module
  beforeEach(module('tusLibrosUiApp'));

  var PurcharsesCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    PurcharsesCtrl = $controller('PurcharsesCtrl', {
      $scope: scope
      // place here mocked dependencies
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(PurcharsesCtrl.awesomeThings.length).toBe(3);
  });
});
