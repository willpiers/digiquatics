@aquaticsApp.controller 'CertsCtrl', ['$scope', 'Certs',
  @CertsCtrl = ($scope, Certs) ->
    $scope.sorter =
      value: 'firstName'

    Certs.get (data) ->
      $scope.certNames = data.certification_names
      $scope.users = data.users
]
