@aquaticsApp = angular.module 'aquaticsApp', ['ngResource']

@aquaticsApp.factory 'Certs', ['$resource', ($resource) ->
  $resource '/certifications_api.json'
]

@aquaticsApp.controller 'CertsCtrl', ['$scope', '$log', 'Certs',
  ($scope, $log, Certs) ->
    $scope.$log = $log
    $scope.sorter =
      value: 'firstName'

    response = Certs.get (data) ->
      $scope.certNames = response.certification_names
      $scope.certs = response.certifications
      $scope.users = response.users
]
