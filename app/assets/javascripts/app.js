var app = angular.module('app', []);

app.controller('AppCtrl', ['$scope', function($scope) {
    console.log('I work!');
}]);

$(document).on('ready page:load', function() {
    angular.bootstrap(document, ['app']);
});