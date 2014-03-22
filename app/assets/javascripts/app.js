var app = angular.module('app', ['ngProgress']);

/* Add interceptors for loading signalization and loading bar controls */
app.config(['$httpProvider', function($httpProvider) {
    $httpProvider.interceptors.push(function($q, $rootScope) {
        return {
            'request': function(config) {
                $rootScope.loading = true;
                $rootScope.$broadcast('event:startLoading');
                return config || $q.when(config);
            },
            'response': function(response) {
                $rootScope.$broadcast('event:endLoading');
                $rootScope.loading = false;
                return response || $q.when(response);
            },
            'responseError': function(rejection) {
                $rootScope.$broadcast('event:endLoading');
                $rootScope.loading = false;
                return $q.reject(rejection);
            }
        };
    });
}]);

/* Loader service - responsible for showing loding bar durring requests */
app.service('loader', ['$rootScope', 'ngProgress', function($rootScope, ngProgress) {
    $rootScope.$on("event:startLoading", function(){
        ngProgress.start();
    });
    $rootScope.$on("event:endLoading", function(){
        ngProgress.stop();
        ngProgress.complete();
    });
}]);

app.controller('AppCtrl', ['$scope', '$rootScope', '$http', 'loader', function($scope, $rootScope, $http, loader) {
    $scope.loaded = false;

    /* Load offers */
    $scope.loadOffers = function(request) {
        $scope.resetValues();
        $http.get('/offers.json', {params: request}).
            success(function(data, status, header) {
                $scope.message = data.message;
                $scope.offers = data.offers;
                $scope.loaded = true;
            }).
            error(function(data, status) {
                $scope.responseError = data.message;
                $scope.errors = data;
            }
        );
    };

    /* Reset scope variables */
    $scope.resetValues = function() {
        $scope.errors = {};
        $scope.message = null;
        $scope.responseError = null;
        $scope.offers = {};
    }

    /* Show loading on submit button during a request */
    $scope.submitValue = function() {
        if ($rootScope.loading === true) {
            return 'Loading ...';
        } else {
            return 'Load offers';
        }
    };
}]);

/* Bootstrap the application manually for greater controll */
$(document).on('ready page:load', function() {
    angular.bootstrap(document, ['app']);
});