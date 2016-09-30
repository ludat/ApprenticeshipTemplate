'use strict';

angular.module('tusLibrosUiApp')
    .service('UserService', function ($location, ngToast) {
        var self = this;

        self._currentUser = null;

        self.currentUser = function () {
            if (self._currentUser == null) {
                ngToast.danger('You haven\'t logged in yet');
                $location.path('/login');
                return Promise.reject();
            } else {
                return Promise.resolve(self._currentUser);
            }
        };

        self.login = function (username, password) {
            self._currentUser = {
                username: username,
                password: password
            };
            return Promise.resolve();
        };
    });
