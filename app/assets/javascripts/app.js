var app = angular.module('app', []);

app.controller('AppCtrl', ['$scope', '$rootScope', '$http', function($scope, $rootScope, $http) {
    $scope.loaded = false;

    $scope.loadOffers = function(request) {
        $scope.errors = {};
        $http.get('/offers.json', {params: request}).
            success(function(data, status, header) {
                $scope.message = data.message;
                $scope.offers = data.offers;
                $scope.loaded = true;
            }).
            error(function(data, status) {
                $scope.errors = data;
            }
        );
    };

    $scope.submitValue = function() {
        if ($rootScope.loading === true) {
            return 'Loading ...';
        } else {
            return 'Load offers';
        }
    };
}]);

$(document).on('ready page:load', function() {
    angular.bootstrap(document, ['app']);
});